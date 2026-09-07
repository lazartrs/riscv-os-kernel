//
// Created by os on 6/21/24.
//

#include "../h/memory.hpp"
Memory::Fragment* Memory::mem_head;

void Memory::initialize() {
    size_t memory_size = ((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR) - 1;
    mem_head = (Fragment*) HEAP_START_ADDR;
    mem_head->allocated = false;
    mem_head->size = memory_size-sizeof(Fragment);
    mem_head->next = nullptr;
}
void *Memory::mem_alloc(uint64 num_of_blocks) {
    if(num_of_blocks<=0) return nullptr;

    uint64 size_in_bytes = num_of_blocks * MEM_BLOCK_SIZE;

    Fragment* current = mem_head;
    for(;current!=nullptr;current = current->next) {
        if(current->size>=size_in_bytes+sizeof(Fragment) && current->allocated==false) {
            break;
        }
    }
    if(current==nullptr)return nullptr;

    size_t remaining_size = current->size - size_in_bytes - sizeof(Fragment);
    current->size = remaining_size;

    Fragment* new_fragment = (Fragment*)((char*)current +sizeof(Fragment)+ current->size);
    new_fragment->size = size_in_bytes;
    new_fragment->next = current->next;
    new_fragment->allocated = true;

    current->next = new_fragment;

    return (void*)((char*)new_fragment + sizeof(Fragment));
}

int Memory::mem_free(void *addr) {
    Fragment* current = mem_head;
    for(;current!=nullptr;current = current->next) {
        if(((char*)(char*)current+sizeof(Fragment))==(char*)addr && current->allocated==true) {
            current->allocated = false;
            break;
        }
    }if(current==nullptr)return -1;
    return 0;
}
