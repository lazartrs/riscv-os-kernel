//
// Created by os on 6/11/24.
//
#include "../h/sem.hpp"

#include "../h/memory.hpp"

uint64 Sem::sem_open(sem_t* handle,uint64 init){
    *handle = new Sem(init);
    if(*handle==nullptr) return -1;
    return 0;
}
uint64 Sem::sem_close(sem_t handle) {
    if(handle!=nullptr) {
        delete handle;
        return 0;
    }
    return -1;
}
uint64 Sem::sem_wait(sem_t handle) {
    if(handle!=nullptr) {
        if(--(handle->sem_value)<0) {
            //since kernel is not preemptive no locking is required just blocking the thread
            //we are not putting the running(syscaller) thread in Scheduler
            handle->block(TCB::previous_running_thread);
            TCB::previous_running_thread = Scheduler::get_thread();
        }
        return 0;
    }return -1;

}
uint64 Sem::sem_signal(sem_t handle) {
    if(handle!=nullptr) {
        handle->sem_value = handle->sem_value + 1;
        if(handle->sem_value<=0) {
            if(handle->blocked_queue.is_empty()==false) {
                Scheduler::put_thread(handle->blocked_queue.removeFirst());
            }
        }
        return 0;
    }return -1;
}
uint64 Sem::sem_timedwait(sem_t handle, time_t timeout) {
    return 0;
}
uint64 Sem::sem_trywait(sem_t handle) {
    if(handle!=nullptr) {
        if(handle->sem_value>=1) {
            --handle->sem_value;
            return 0;
        }
        return 1;
    }
    return -1;
}
Sem::Sem(uint64 init=1) {
    this->sem_value = init;
}

void* Sem::operator new(size_t n){
    return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    // return __mem_alloc(n);
}
void* Sem::operator new[](size_t n){
    return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    // return __mem_alloc(n);
}
void Sem::operator delete(void* addr){
    Memory::mem_free(addr);
    // __mem_free(addr);
}
void Sem::operator delete[](void* addr){
    Memory::mem_free(addr);
    // __mem_free(addr);
}
Sem::~Sem() {
    while (blocked_queue.is_empty()==false) {
            Scheduler::put_thread(blocked_queue.removeFirst());
    }
}

void Sem::block(TCB *thread) {
    this->blocked_queue.addLast(thread);
}




