//
// Created by os on 5/17/24.
//

#ifndef SYSCALL_C_HPP
#define SYSCALL_C_HPP
#include "../h/tcb.hpp"
#include "../h/sem.hpp"
#include "../lib/hw.h"
#include "../lib/console.h"

#define SYSCALL_NUM_MEM_ALLOC 0x01
#define SYSCALL_NUM_MEM_FREE 0x02
#define SYSCALL_NUM_THREAD_DISPATCH 0x13
#define SYSCALL_NUM_THREAD_CREATE 0x11
#define SYSCALL_NUM_THREAD_EXIT 0x12
#define SYSCALL_NUM_SEM_OPEN 0x21
#define SYSCALL_NUM_SEM_CLOSE 0x22
#define SYSCALL_NUM_SEM_WAIT 0x23
#define SYSCALL_NUM_SEM_SIGNAL 0x24
#define SYSCALL_NUM_SEM_TIMEDWAIT 0x25
#define SYSCALL_NUM_SEM_TRYWAIT 0x26
#define SYSCALL_NUM_TIMESLEEP 0x31
#define SYSCALL_NUM_GETC 0x41
#define SYSCALL_NUM_PUTC 0x42


typedef TCB* thread_t;
typedef Sem* sem_t;

extern void* mem_alloc(size_t size);

extern int mem_free(void* addr);

extern int thread_create(thread_t* handle, void (*start_routine)(void*), void* arg);

extern int thread_exit();

extern void thread_dispatch();

extern int sem_open(sem_t* handle,unsigned init);

extern int sem_close(sem_t id);

extern int sem_wait(sem_t id);

extern int sem_signal(sem_t id);

extern int sem_timedwait(sem_t id,time_t timeout);

extern int sem_trywait(sem_t id);

extern int time_sleep (time_t);

extern char getc();

extern void putc(char c);

#endif //SYSCALL_C_HPP
