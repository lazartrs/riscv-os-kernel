//
// Created by os on 5/17/24.
//

#include "../h/syscall_c.hpp"

#include "../h/syscall_cpp.hpp"
sem_t mutex_handle = nullptr;

void generic_syscall(uint64 a0,uint64 a1,uint64 a2,uint64 a3,uint64 a4,uint64 a5,uint64 a6,uint64 a7) {
    //generic function that receives through a0-a7 syscall args and just executes ecall
    asm volatile ("ecall");
}

void* mem_alloc(size_t size) {
    //prepare args and ecall
    uint64 num_of_blocks = size%MEM_BLOCK_SIZE==0?size/MEM_BLOCK_SIZE:size/MEM_BLOCK_SIZE+1;
    generic_syscall((uint64)SYSCALL_NUM_MEM_ALLOC,(uint64)num_of_blocks,0,0,0,0,0,0);
    return (void*)TCB::running_thread->get_context().a0;
}
int mem_free(void *addr) {
    //prepare args and ecall
    generic_syscall((uint64)SYSCALL_NUM_MEM_FREE,(uint64)addr,0,0,0,0,0,0);
    return (int)TCB::running_thread->get_context().a0;
}

int thread_create(thread_t *handle, void (*start_routine)(void *), void *arg) {
    //allocate stack
    uint64* stack = (uint64*) mem_alloc(DEFAULT_STACK_SIZE);
    generic_syscall((uint64)SYSCALL_NUM_THREAD_CREATE,(uint64)handle,(uint64)start_routine,(uint64)arg,(uint64)stack,0,0,0);
    return TCB::running_thread->get_context().a0;
}

int thread_exit() {
    //prepare args and ecall
    generic_syscall((uint64)SYSCALL_NUM_THREAD_EXIT,0,0,0,0,0,0,0);
    return (int)TCB::running_thread->get_context().a0;
}

void thread_dispatch() {
    //prepare args and ecall
    generic_syscall((uint64)SYSCALL_NUM_THREAD_DISPATCH,0,0,0,0,0,0,0);
}

int sem_open (sem_t *handle,unsigned init) {
    generic_syscall((uint64)SYSCALL_NUM_SEM_OPEN,(uint64)handle,(uint64)init,0,0,0,0,0);
    return (int)TCB::running_thread->get_context().a0;
}
int sem_close (sem_t id) {
    generic_syscall((uint64)SYSCALL_NUM_SEM_CLOSE,(uint64)id,0,0,0,0,0,0);
    return (int)TCB::running_thread->get_context().a0;
}
int sem_wait (sem_t id) {
    generic_syscall((uint64)SYSCALL_NUM_SEM_WAIT,(uint64)id,0,0,0,0,0,0);
    return (int)TCB::running_thread->get_context().a0;
}
int sem_signal (sem_t id) {
    generic_syscall((uint64)SYSCALL_NUM_SEM_SIGNAL,(uint64)id,0,0,0,0,0,0);
    return (int)TCB::running_thread->get_context().a0;
}
int sem_trywait (sem_t id) {
    generic_syscall((uint64)SYSCALL_NUM_SEM_TRYWAIT,(uint64)id,0,0,0,0,0,0);
    return (int)TCB::running_thread->get_context().a0;
}
int sem_timedwait(sem_t id,time_t timeout) {
    //to be implemented
    return 0;
}
int time_sleep (time_t) {
    //to be implemented
    return 0;
}
char getc() {
    generic_syscall((uint64)SYSCALL_NUM_GETC,0,0,0,0,0,0,0);
    char c = (char)TCB::running_thread->get_context().a0;
    return c;
}
void putc(char c) {
    generic_syscall((uint64)SYSCALL_NUM_PUTC,(uint64)c,0,0,0,0,0,0);
}




