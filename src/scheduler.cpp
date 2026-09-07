//
// Created by os on 5/26/24.
//

#include "../h/scheduler.hpp"

List<TCB> Scheduler::ready_threads;
List<TCB> Scheduler::ready_interrupt_kernel_threads;
List<TCB> Scheduler::blocked_threads;
//List<TCB> Scheduler::previous_running_threads;

void Scheduler::choose_next_running() {
    uint64 volatile scause = Riscv::read_scause();

    if(TCB::running_thread->is_interrupt_thread()==false) {
        //running is main or user -> next running must br interrupt thread
        TCB::previous_running_thread = TCB::running_thread;
        if(scause==SCAUSE_EXTERNAL_HARDWARE) {
            TCB::running_thread = ready_interrupt_kernel_threads.peekLast();
        }else {
            TCB::running_thread = ready_interrupt_kernel_threads.peekFirst();
        }
    }else {
        //running is interrupt or console -> if interrupt called console next running should be console,else next running should be main or user.
            if(Riscv::interrupt_level==2 && scause==SCAUSE_EXTERNAL_HARDWARE) {
                TCB::running_thread = ready_interrupt_kernel_threads.peekLast();
            }
            else if(Riscv::interrupt_level==1){
                TCB::running_thread = ready_interrupt_kernel_threads.peekFirst();
            }else if(Riscv::interrupt_level==0){
                TCB::running_thread = TCB::previous_running_thread;
            }else {
                TCB::running_thread = ready_interrupt_kernel_threads.peekFirst();
            }
    }
}

TCB *Scheduler::get_thread() {
    return ready_threads.removeFirst();
}


void Scheduler::put_interrupt_thread(TCB *kernel_thread) {
    ready_interrupt_kernel_threads.addLast(kernel_thread);
}

void Scheduler::put_thread(TCB* thread) {
    ready_threads.addLast(thread);
}

void Scheduler::remove_thread(TCB* thread) {
    ready_threads.remove(thread);
}
void Scheduler::block_thread(TCB *thread) {
    blocked_threads.addLast(thread);
}
void Scheduler::awakening() {
    if(blocked_threads.is_empty()==false) {
        for(uint64 i=0;i<blocked_threads.get_size();i++) {
            TCB* cur = blocked_threads.removeFirst();
            if(--cur->my_sleep_time==0) {
                Scheduler::put_thread(cur);
            }
            else {
                blocked_threads.addLast(cur);
            }
        }
    }
}






