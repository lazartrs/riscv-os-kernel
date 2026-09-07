//
// Created by os on 5/17/24.
//

#include "../h/syscall_cpp.hpp"

using F_get = char (*)();
using F_put = void (*)(char);

F_get f_getc = getc;
F_put f_putc = putc;

using size_t = decltype(sizeof(0));

void* operator new(size_t n){
    //return __mem_alloc(n);
    return mem_alloc(n);
}
void* operator new[](size_t n){
    //return __mem_alloc(n);
    return mem_alloc(n);
}
void operator delete(void* addr){
    //__mem_free(addr);
    mem_free(addr);
}
void operator delete[](void* addr){
    //__mem_free(addr);
    mem_free(addr);
}

Thread::Thread() {
    myHandle=nullptr;
    body = nullptr;
    arg = nullptr;
}

void Thread::dispatch() {
    thread_dispatch();
}
Thread::Thread(void (*body)(void *), void *arg) {
    this->body = body;
    this->arg = arg;
    myHandle = nullptr;
    thread_create(&myHandle,this->body,this->arg);
}
void Thread::thread(void* t) {
    Thread* thr = (Thread*)t;
    if(thr)thr->run();
    //this function has no caller so it must not return
    thread_exit();
}
int Thread::start() {
    if(myHandle==nullptr) thread_create(&myHandle,thread,this);
    if(myHandle==nullptr) return -1;
    return 0;
}
int Thread::sleep(time_t t) {
    return time_sleep(t);
}
Thread::~Thread() {
    TCB::kill(this->myHandle);
}

Semaphore::Semaphore(unsigned init) {
    myHandle = nullptr;
    sem_open(&this->myHandle,init);
}
int Semaphore::wait() {
    return sem_wait(this->myHandle);
}
int Semaphore::signal() {
    return sem_signal(this->myHandle);
}
int Semaphore::tryWait() {
    return sem_trywait(this->myHandle);
}
int Semaphore::timedWait(time_t t) {
    return sem_timedwait(this->myHandle,t);
}
Semaphore::~Semaphore() {
    sem_close(this->myHandle);
}

char Console::getc() {
    return f_getc();
}
void Console::putc(char c) {
    f_putc(c);
}










