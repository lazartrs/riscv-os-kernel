//
// Created by os on 5/27/24.
//

#ifndef LIST_HPP
#define LIST_HPP
#include "memory.hpp"
#include "../lib/mem.h"
#include "../h/tcb.hpp"

template<typename T>
class List
{
private:
    class Elem
    {
    public:
        T *data;
        Elem *next;

        Elem(T *data, Elem *next) : data(data), next(next) {}

        void* operator new(size_t n){
            return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
            // return __mem_alloc(n);
        }
        void* operator new[](size_t n){
            return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
            // return __mem_alloc(n);
        }
        void operator delete(void* addr){
            Memory::mem_free(addr);
            // __mem_free(addr);
        }
        void operator delete[](void* addr){
            Memory::mem_free(addr);
            // __mem_free(addr);
        }
    };

    Elem *head, *tail;



public:
    List() : head(nullptr), tail(nullptr) ,size(0){}

    List(const List<T> &) = delete;

    List<T> &operator=(const List<T> &) = delete;

    void addFirst(T *data)
    {
        Elem *elem = new Elem(data, head);
        head = elem;
        if (!tail) { tail = head; }
        size++;
    }

    void addLast(T *data)
    {
        Elem *elem = new Elem(data, 0);
        if (tail)
        {
            tail->next = elem;
            tail = elem;
        } else
        {
            head = tail = elem;
        }
        size++;
    }

    T *removeFirst()
    {
        if (!head) { return nullptr; }

        Elem *elem = head;
        head = head->next;
        if (!head) { tail = 0; }

        T *ret = elem->data;
        delete elem;
        size--;
        return ret;
    }

    T *peekFirst()
    {
        if (!head) { return nullptr; }
        return head->data;
    }

    T *removeLast()
    {
        if (!head) { return nullptr; }

        Elem *prev = nullptr;
        for (Elem *curr = head; curr && curr != tail; curr = curr->next)
        {
            prev = curr;
        }

        Elem *elem = tail;
        if (prev) { prev->next = 0; }
        else { head = 0; }
        tail = prev;

        T *ret = elem->data;
        delete elem;
        size--;
        return ret;
    }

    T *peekLast()
    {
        if (!tail) { return nullptr; }
        return tail->data;
    }
    bool is_empty() {
        if(!head)return true;
        else return false;
    }
    void remove(T* data) {
        Elem* cur = head;
        Elem* prev = cur;
        for(;cur!=nullptr;prev = cur,cur = cur->next) {
            if(cur->data==data) {
                prev->next = cur->next;
                delete cur;
                break;
            }
        }
        size--;
    }
    uint64 get_size() const{
        return this->size;
    }
private:
    uint64 size;
};

#endif //LIST_HPP
