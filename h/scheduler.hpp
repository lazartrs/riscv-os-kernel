//
// Created by os on 5/26/24.
//

#ifndef SCHEDULER_HPP
#define SCHEDULER_HPP
#include "../h/list.hpp"
#include "../h/tcb.hpp"


class Scheduler {
public:
    static TCB* get_thread();

    static TCB* get_interrupt_kernel_thread() {
        return ready_interrupt_kernel_threads.peekFirst();
    }
    static TCB* get_console_kernel_thread() {
        return ready_interrupt_kernel_threads.peekLast();
    }
    static void block_thread(TCB* thread);

    static void choose_next_running();

    static void remove_thread(TCB* thread);

    static void put_interrupt_thread(TCB* kernel_thread);

    static void put_thread(TCB* thread);

    static void awakening();

private:
    static List<TCB> ready_interrupt_kernel_threads;
    static List<TCB> ready_threads;
    static List<TCB> blocked_threads;
    //static List<TCB> previous_running_threads;
};



#endif //SCHEDULER_HPP
