//
// Created by os on 5/17/24.
//

#ifndef TCB_HPP
#define TCB_HPP

#include "memory.hpp"
#include "../lib/hw.h"
#include "../lib/mem.h"
#include "../h/riscv.hpp"


class TCB {
public:

    static uint64 time_slice;

    struct Context {
        uint64 ra;
        uint64 sp;
        uint64 a0;
        uint64 a1;
        uint64 a2;
        uint64 a3;
        uint64 a4;
        uint64 a5;
        uint64 a6;
        uint64 a7;
        uint64 sepc; //just for special cases
        uint64 ret_brefore_timer;
    };

    typedef TCB* thread_t;

    static TCB* running_thread;//actual running thread(can be interrupt control thread)
    static TCB* previous_running_thread;//running thread before interrupt call(user or main)

    static uint64 thread_create(thread_t* handle, void (*start_routine)(void*), void* arg, void* stack_space);
    static void thread_dispatch();
    static uint64 thread_exit();
    static uint64 thread_sleep(time_t timer_counts);
    static void yield();
    static void context_switch(Context* old_running,Context* new_running);

    //registers a0..a7 save in regs thread->context
    static void save_syscall_parameters(TCB::Context* context);
    static void save_syscall_parameters_to_context();

    static void thread_wrapper();

    //geters and seters
    bool is_finished() const {
        return finished;
    }

    void set_finished(bool f) {
        this->finished = f;
    }
    void set_privileged(bool p) {
        this->privileged = p;
    }
    void set_interrupt(bool i) {
        this->interrupt = i;
    }
    bool is_privileged() const {
        return this->privileged;
    }
    bool is_interrupt_thread() const {
        return this->interrupt;
    }
    Context get_context() const{
        return this->context;
    }
    static void kill(TCB* thread);

    //friends
    friend class Riscv;
    friend class Sem;
    friend class Scheduler;

protected:
    //virtual void run();

private:
    TCB(void (*start_routine)(void*),void* arg, void* stack_space);

    void (*start_routine)(void*);
    void* my_arg;
    thread_t handle;
    Context context;
    uint64* stack;
    bool finished;
    bool privileged;
    bool interrupt;

    uint64 my_time_slice;
    uint64 my_sleep_time;

    virtual ~TCB() {
        Memory::mem_free(stack);
        // __mem_free(stack);
    }
    void* operator new(size_t n);
    void* operator new[](size_t n);
    void operator delete(void* addr);
    void operator delete[](void* addr);
};



#endif //TCB_HPP
