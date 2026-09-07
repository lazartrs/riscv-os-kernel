//
// Created by os on 6/3/24.
//
#include "../h/idle.hpp"

void user_idle(void*) {
    while(true) {
       // __putc('I');//putc('d');putc('l');putc('e');putc(' ');

        // Thread* t1 = new Thread(user_idle1,nullptr);
        // t1->start();

        thread_dispatch();
        //putc('B');putc('a');putc('c');putc('k');putc('t');putc('I');putc('d');putc('l');putc('e');putc(' ');
    }
}
void user_idle1(void*) {
    while(true) {
        putc('I');putc('d');putc('l');putc('e');putc(' ');putc('1');
        thread_dispatch();
        //putc('B');putc('a');putc('c');putc('k');putc('t');putc('I');putc('d');putc('l');putc('e');putc(' ');
    }
}