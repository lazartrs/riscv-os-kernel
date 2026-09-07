//
// Created by os on 6/11/24.
//

#ifndef SEM_HPP
#define SEM_HPP
#include "../lib/hw.h"
#include "../lib/mem.h"
#include "../h/list.hpp"
#include "../h/scheduler.hpp"


class Sem {
    public:
        typedef Sem* sem_t;
    static uint64 sem_open(sem_t* handle,uint64 init_value);
    static uint64 sem_close(sem_t handle);
    static uint64 sem_wait(sem_t handle);
    static uint64 sem_signal (sem_t handle);
    static uint64 sem_timedwait(sem_t handle,time_t timeout);
    static uint64 sem_trywait(sem_t handle);

    void block(TCB* thread);

    private:
        explicit Sem(uint64 init);
        int sem_value;
        List<TCB> blocked_queue;

    void* operator new(size_t n);
    void* operator new[](size_t n);
    void operator delete(void* addr);
    void operator delete[](void* addr);

    virtual ~Sem();
};



#endif //SEM_HPP
