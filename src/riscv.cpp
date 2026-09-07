//
// Created by os on 5/17/24.
//


#include "../h/riscv.hpp"


#include "../h/memory.hpp"
#include "../h/syscall_c.hpp"
#include "../lib/console.h"
#include "../lib/mem.h"

uint64 Riscv::interrupt_level = 0;
uint64 Riscv::timer_count = 0;

using Body = void (*)(void*);

void Riscv::inc_interrupt_level() {
    Riscv::interrupt_level++;
}


void Riscv::fix_sepc_for_ecall() {
    uint64 volatile scause = Riscv::read_scause();
    uint64 volatile sepc = Riscv::read_sepc();
    if(scause == SCAUSE_ECALL_PIVILEGED || scause == SCAUSE_ECALL_USER){//|| scause==SCAUSE_EXTERNAL_HARDWARE) {
        sepc = sepc + 4;
        write_sepc(sepc);
    }
    // else if(scause==SCAUSE_EXTERNAL_HARDWARE) {
    //     sepc = TCB::running_thread->context.sepc;
    //     write_sepc(sepc);
    // }
}

void Riscv::sepc_for_getc() {
    __asm__ volatile ("mv %[value],ra" : [value] "=r" (TCB::running_thread->context.sepc):);
    TCB::running_thread->context.sepc = TCB::running_thread->context.sepc + 4;
}
void Riscv::save_ret_val_in_case_of_timer() {
    uint64 volatile scause = Riscv::read_scause();
    if(scause==SCAUSE_TIMER) {
        TCB::running_thread->context.a0 = TCB::running_thread->context.ret_brefore_timer;
    }
}


void Riscv::interrupt_console_handler(void* param) {
    while(true) {
        console_handler();
        //Riscv::hardware_interrupt_completed();
        Riscv::interrupt_level--;
        TCB::running_thread->set_finished(true);
        TCB::yield();
    }
}


void Riscv::interrupt_handler(void* param) {
    while(true) {
        TCB::running_thread->set_finished(false);
        uint64 volatile scause = Riscv::read_scause();
        uint64 volatile syscall_num = TCB::running_thread->context.a0;
        uint64 volatile arg1 = TCB::running_thread->context.a1;
        uint64 volatile arg2 = TCB::running_thread->context.a2;
        uint64 volatile arg3 = TCB::running_thread->context.a3;
        uint64 volatile arg4 = TCB::running_thread->context.a4;
        //uint64 volatile arg5 = TCB::running_thread->context.a5;
        // uint64 volatile arg6 = TCB::running_thread->context.a6;
        // uint64 volatile arg7 = TCB::running_thread->context.a7;

        // uint64 volatile sstatus = read_sstatus();

        switch (scause) {
            case SCAUSE_TIMER:
                //__putc('T');__putc('i');__putc('m');__putc('e');__putc('r');__putc(' ');
                // timer_count++;
                // Scheduler::awakening();
                // if(timer_count==TCB::time_slice) {
                //     timer_count=0;
                //     TCB::thread_dispatch();
                // }
                // TCB::time_slice = TCB::previous_running_thread->my_time_slice;
                Riscv::software_interrupt_completed();
                break;
            case SCAUSE_EXTERNAL_HARDWARE:
                //this will never happen
                console_handler();
                Riscv::hardware_interrupt_completed();
                break;
            case SCAUSE_ILLEGAL_OPERATION:
                __putc('I');__putc('l');__putc('l');__putc('e');__putc('g');__putc('a');__putc('l');
                __putc('O');__putc('P');__putc(' ');
                Riscv::halt_processor();
                TCB::running_thread->context.a0 = (uint64)TCB::thread_exit();
                break;
            case SCAUSE_ILLEGAL_ADDRESS_READ:
                __putc('I');__putc('l');__putc('l');__putc('e');__putc('g');__putc('a');__putc('l');
                __putc('A');__putc('R');__putc(' ');
                Riscv::halt_processor();
                TCB::running_thread->context.a0 = (uint64)TCB::thread_exit();
                break;
            case SCAUSE_ILLEGAL_ADDRESS_WRITE:
                __putc('I');__putc('l');__putc('l');__putc('e');__putc('g');__putc('a');__putc('l');
                __putc('A');__putc('W');__putc(' ');
                Riscv::halt_processor();
                TCB::running_thread->context.a0 = (uint64)TCB::thread_exit();
                break;
            case SCAUSE_ECALL_USER:
            case SCAUSE_ECALL_PIVILEGED:

                //fixing the return address of ecall
                // sepc = sepc + 4;
                // write_sepc(sepc);

                switch (syscall_num) {
                    case SYSCALL_NUM_THREAD_DISPATCH:
                        TCB::thread_dispatch();
                    // if(TCB::previous_running_thread->context.ret_brefore_timer!=0)TCB::running_thread->context.a0 = TCB::previous_running_thread->context.ret_brefore_timer;//might be a problem
                        break;
                    case SYSCALL_NUM_THREAD_CREATE:
                        TCB::running_thread->context.a0 = (uint64)TCB::thread_create((TCB::thread_t*)arg1,(Body)arg2,(void*)arg3,(void*)arg4);
                    //TCB::previous_running_thread->context.ret_brefore_timer = TCB::running_thread->context.a0;
                        break;
                    case SYSCALL_NUM_THREAD_EXIT:
                        TCB::running_thread->context.a0 = (uint64)TCB::thread_exit();
                    //TCB::previous_running_thread->context.ret_brefore_timer = TCB::running_thread->context.a0;
                    // if(TCB::previous_running_thread->context.ret_brefore_timer!=0)TCB::running_thread->context.a0 = TCB::previous_running_thread->context.ret_brefore_timer;//might be a problem
                        break;
                    case SYSCALL_NUM_MEM_ALLOC:
                        TCB::running_thread->context.a0 = (uint64)Memory::mem_alloc((uint64)arg1);
                    // TCB::previous_running_thread->context.ret_brefore_timer = TCB::running_thread->context.a0;
                        // TCB::running_thread->context.a0 = (uint64)__mem_alloc((size_t)arg1);
                        break;
                    case SYSCALL_NUM_MEM_FREE:
                        TCB::running_thread->context.a0 = (uint64)Memory::mem_free((void*)arg1);
                    //TCB::previous_running_thread->context.ret_brefore_timer = TCB::running_thread->context.a0;
                        // TCB::running_thread->context.a0 = (uint64)__mem_free((void*)arg1);
                        break;
                    case SYSCALL_NUM_SEM_OPEN:
                        TCB::running_thread->context.a0 = Sem::sem_open((Sem::sem_t*)arg1,(uint64)arg2);
                    //TCB::previous_running_thread->context.ret_brefore_timer = TCB::running_thread->context.a0;
                        break;
                    case SYSCALL_NUM_SEM_CLOSE:
                        TCB::running_thread->context.a0 = Sem::sem_close((Sem::sem_t)arg1);
                    //TCB::previous_running_thread->context.ret_brefore_timer = TCB::running_thread->context.a0;
                        break;;
                    case SYSCALL_NUM_SEM_WAIT:
                        TCB::running_thread->context.a0 = Sem::sem_wait((Sem::sem_t)arg1);
                    //TCB::previous_running_thread->context.ret_brefore_timer = TCB::running_thread->context.a0;
                        break;
                    case SYSCALL_NUM_SEM_SIGNAL:
                        TCB::running_thread->context.a0 = Sem::sem_signal((Sem::sem_t)arg1);
                        //TCB::previous_running_thread->context.ret_brefore_timer = TCB::running_thread->context.a0;
                        break;
                    case SYSCALL_NUM_SEM_TIMEDWAIT:
                        break;
                    case SYSCALL_NUM_SEM_TRYWAIT:
                        TCB::running_thread->context.a0 = Sem::sem_trywait((Sem::sem_t)arg1);
                        //TCB::previous_running_thread->context.ret_brefore_timer = TCB::running_thread->context.a0;
                        break;
                    case SYSCALL_NUM_TIMESLEEP:
                        TCB::running_thread->context.a0 = TCB::thread_sleep((time_t)arg1);
                    // if(TCB::previous_running_thread->context.ret_brefore_timer!=0)TCB::running_thread->context.a0 = TCB::previous_running_thread->context.ret_brefore_timer;
                        break;
                    case SYSCALL_NUM_GETC:
                        // sstatus = read_sstatus();
                        Riscv::hardware_interrupt_enable();
                        Riscv::software_interrupt_disable();
                        TCB::running_thread->context.a0 = (uint64)__getc();
                        TCB::previous_running_thread->context.ret_brefore_timer = TCB::running_thread->context.a0;
                        break;
                    case SYSCALL_NUM_PUTC:
                        __putc((char)arg1);
                    //TCB::running_thread->context.a0 = TCB::previous_running_thread->context.ret_brefore_timer;//might be a problem
                        break;
                    default:
                        TCB::running_thread->context.a0 = -5;
                        break;
                }

                break;
            default:
                break;
        }

        Riscv::interrupt_level--;
        TCB::running_thread->set_finished(true);
        TCB::yield();
    }
    //return return_value;
}

void Riscv::halt_processor() {
    __asm__ volatile ("li t0,1048576");
    __asm__ volatile ("li t1,0x5555");
    __asm__ volatile ("sw t1,0(t0)");
}
