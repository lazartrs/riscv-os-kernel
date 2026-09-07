//
// Created by os on 6/21/24.
//

#ifndef MEMORY_HPP
#define MEMORY_HPP
#include "../lib/hw.h"

class Memory {
public:
    struct Fragment {
        size_t size;
        bool allocated;
        Fragment* next;
    };

    static Fragment* mem_head;

    static void initialize();
    static void* mem_alloc(uint64 num_of_blocks);
    static int mem_free(void* addr);
    Memory() = delete;
};

#endif //MEMORY_HPP
