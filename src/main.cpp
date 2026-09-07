#include "../h/scheduler.hpp"
#include "../h/tcb.hpp"
#include "../lib/mem.h"
#include "../lib/hw.h"
#include "../h/syscall_c.hpp"
#include "../h/idle.hpp"
#include "../h/memory.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"

extern "C" void userMain();

void wrapper(void*) {
    userMain();
    //thread_exit();
}

int main(){
    Memory::initialize();
    //Create main thread
    TCB* main_handle;
    uint64 status = TCB::thread_create(&main_handle,nullptr,nullptr,nullptr);
    if(status!=0) return status;//check for error

    TCB::running_thread = main_handle;
    if(main_handle == nullptr) return -1;
    main_handle->set_privileged(true);

    //Create interrupt thread
    TCB::thread_t interrupt_thread_handle=nullptr;
    uint64* stack_space = (uint64*) Memory::mem_alloc(DEFAULT_STACK_SIZE%MEM_BLOCK_SIZE==0?DEFAULT_STACK_SIZE/MEM_BLOCK_SIZE:DEFAULT_STACK_SIZE/MEM_BLOCK_SIZE+1);
    // uint64* stack_space = (uint64*) __mem_alloc(DEFAULT_STACK_SIZE);
    status = TCB::thread_create(&interrupt_thread_handle,&Riscv::interrupt_handler,nullptr,stack_space);
    if(status != 0) return status;//check for error
    interrupt_thread_handle->set_privileged(true);
    interrupt_thread_handle->set_interrupt(true);
    Scheduler::put_interrupt_thread(interrupt_thread_handle);

    TCB::thread_t console_thread_handle=nullptr;
    uint64* stack_space_console = (uint64*) Memory::mem_alloc(DEFAULT_STACK_SIZE%MEM_BLOCK_SIZE==0?DEFAULT_STACK_SIZE/MEM_BLOCK_SIZE:DEFAULT_STACK_SIZE/MEM_BLOCK_SIZE+1);
    // uint64* stack_space_console = (uint64*) __mem_alloc(DEFAULT_STACK_SIZE);
    status = TCB::thread_create(&console_thread_handle,&Riscv::interrupt_console_handler,nullptr,stack_space_console);
    if(status != 0) return status;//check for error
    console_thread_handle->set_privileged(true);
    console_thread_handle->set_interrupt(true);
    Scheduler::put_interrupt_thread(console_thread_handle);

    //Set interrupt address to interrupt routine
    Riscv::set_interrupt_address();
    Riscv::enable_interrupts();
     //putc('c');
//    char c = getc();
    //__asm__ volatile ("csrw sepc,ra");
   // putc(c);
    /* - for real test

    TCB::thread_t user_thread_handle;
    thread_create(&user_thread_handle,userMain,nullptr);
    Scheduler::put_thread(user_thread_handle);

    while(user_thread_handle->is_finished()==false) {
        thread_dispatch();

    }*/

    TCB::thread_t threads[3];

    //uint64* user_stack0 = (uint64*) __mem_alloc(DEFAULT_STACK_SIZE);
    //TCB::thread_create(&threads[0],userMain,nullptr,user_stack0);
    thread_create(&threads[0],user_idle,nullptr);
    if(threads[0] == nullptr) return -1;
    //Scheduler::put_thread(threads[0]);

    //uint64* user_stack1 = (uint64*) __mem_alloc(DEFAULT_STACK_SIZE);
    //TCB::thread_create(&threads[1],userMain,nullptr,user_stack1);
    thread_create(&threads[1],wrapper,nullptr);
    if(threads[1] == nullptr) return -1;
    //Scheduler::put_thread(threads[1]);

    //uint64* user_stack2 = (uint64*) __mem_alloc(DEFAULT_STACK_SIZE);
    //TCB::thread_create(&threads[2],userMain,nullptr,user_stack2);
    // thread_create(&threads[2],user_idle,nullptr);
    // if(threads[2] == nullptr) return -1;
    // Scheduler::put_thread(threads[2]);

    // __putc(__getc());
    // __getc();
//    putc(getc());
    while(!threads[0]->is_finished() && !threads[1]->is_finished()) {
        thread_dispatch();
        // __putc('B');__putc('a');__putc('c');__putc('k');
        // __putc('t');__putc('o');
        // __putc('M');__putc('a');__putc('i');__putc('n');__putc(' ');
    }
    // delete threads[0];
    // delete threads[1];
    //delete interrupt_thread_handle;
    //delete main_handle;
    //Riscv::halt_processor();
    return 0;
}
