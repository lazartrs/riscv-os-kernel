//
// Created by os on 5/17/24.
//

#include "../h/tcb.hpp"

#include "../h/memory.hpp"
#include "../h/syscall_c.hpp"
#include "../h/scheduler.hpp"
#include "../lib/console.h"
using F = int (*)();
F f_thread_exit = thread_exit;

TCB* TCB::running_thread;
TCB* TCB::previous_running_thread;
TCB::Context* p;

uint64 TCB::time_slice = 0;

uint64 TCB::thread_create(thread_t *handle, void (*start_routine)(void *), void *arg, void *stack_space) {
    *handle = new TCB(start_routine,arg,stack_space);
    if(*handle == nullptr) return -1;
    if(start_routine != nullptr) {
        if(TCB::previous_running_thread!=nullptr) {
            Scheduler::put_thread(*handle);
        }
    }
    return 0;
}

TCB::TCB(void (*start_routine)(void *), void *arg, void* stack_space) {
    this->context = {0,0,0,0,0,0,0,0,0,0,0,0};
    this->handle = nullptr;
    this->start_routine = start_routine;
    this->my_arg = arg;
    this->finished = false;
    this->privileged = false;
    this->interrupt = false;
    this->my_time_slice = DEFAULT_TIME_SLICE;
    this->my_sleep_time = 0;

    if(stack_space!=nullptr) {
        this->stack = (uint64*) stack_space;
        this->context.sp = (uint64) (stack_space) + DEFAULT_STACK_SIZE - 1;
    }else {
        //Only main_thread has initial context already
        this->stack = nullptr;
        this->context.sp = 0;
    }

    if(start_routine != nullptr) {
        this->context.ra = (uint64)&thread_wrapper;
    }else this->context.ra = 0;
}

void TCB::thread_dispatch() {
    // only change the previous_running thread
    // yield will do the rest

    if(TCB::previous_running_thread->is_finished()==false)
        Scheduler::put_thread(TCB::previous_running_thread);
    TCB::previous_running_thread = Scheduler::get_thread();
}

uint64 TCB::thread_exit() {
    //exits caller thread -> previous_running thread(doesnt put it back in Scheduler and marks it as finished)
    TCB::previous_running_thread->set_finished(true);
    delete TCB::previous_running_thread;
    TCB::previous_running_thread = Scheduler::get_thread();
    return 0;
}
uint64 TCB::thread_sleep(time_t timer_counts) {
    TCB::previous_running_thread->my_sleep_time = timer_counts;
    Scheduler::block_thread(TCB::previous_running_thread);
    TCB::previous_running_thread = Scheduler::get_thread();
    return 0;
}


void TCB::thread_wrapper() {
    if(TCB::running_thread->is_privileged()==false)Riscv::switch_regime();
    running_thread->start_routine(running_thread->my_arg);
    TCB::running_thread->set_finished(true);
    f_thread_exit();//we are calling for syscall not directly TCB::thread_exit();
}

void TCB::yield() {

    TCB* old_running = TCB::running_thread;
    Scheduler::choose_next_running();
    TCB* new_running = TCB::running_thread;

    if(running_thread->is_privileged()==false) Riscv::prepare_sstatus_user();
    else {
        Riscv::prepare_sstatus_kernel();
    }

    context_switch(&old_running->context,&new_running->context);
    // now when ret is called in ra is correct return address
}


void TCB::save_syscall_parameters_to_context() {
    save_syscall_parameters(&TCB::running_thread->context);
}

void TCB::kill(TCB *thread) {
    Scheduler::remove_thread(thread);
    delete thread;
}


void* TCB::operator new(size_t n){
    return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    // return __mem_alloc(n);
}
void* TCB::operator new[](size_t n){
    return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    // return __mem_alloc(n);
}
void TCB::operator delete(void* addr){
    Memory::mem_free(addr);
    // __mem_free(addr);
}
void TCB::operator delete[](void* addr){
    Memory::mem_free(addr);
    // __mem_free(addr);
}




