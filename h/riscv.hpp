//
// Created by os on 5/17/24.
//

#ifndef RISCV_HPP
#define RISCV_HPP
#include "../h/tcb.hpp"
extern "C" void interrupt_routine();

static uint64 constexpr volatile SSTATUS_SPP = 0x100;
static uint64 constexpr volatile SSTATUS_SPIE = 0x20;
static uint64 constexpr volatile SSTATUS_SIE = 0x2;
static uint64 constexpr volatile SIP_SSIP = 0x2;
static uint64 constexpr volatile SIP_SEIP = 0x200;
static uint64 constexpr volatile SIE_SSIE = 0x2;
static uint64 constexpr volatile SIE_SEIE = 0x200;

static uint64 constexpr SCAUSE_TIMER = 0x8000000000000001;
static uint64 constexpr SCAUSE_EXTERNAL_HARDWARE = 0x8000000000000009;
static uint64 constexpr SCAUSE_ILLEGAL_OPERATION = 0x0000000000000002;
static uint64 constexpr SCAUSE_ILLEGAL_ADDRESS_READ = 0x0000000000000005;
static uint64 constexpr SCAUSE_ILLEGAL_ADDRESS_WRITE = 0x0000000000000007;
static uint64 constexpr SCAUSE_ECALL_USER = 0x0000000000000008;
static uint64 constexpr SCAUSE_ECALL_PIVILEGED = 0x0000000000000009;


class Riscv {
public:

    static uint64 interrupt_level;
    static uint64 timer_count;

    static uint64 read_scause() {
        uint64 volatile scause;
        __asm__ volatile ("csrr %[value], scause": [value] "=r" (scause));
        return scause;
    }
    static uint64 read_a0() {
        uint64 volatile a0;
        __asm__ volatile ("mv %[value], a0": [value] "=r" (a0));
        return a0;
    }
    static uint64 read_a1() {
        uint64 volatile a1;
        __asm__ volatile ("mv %[value], a1": [value] "=r" (a1));
        return a1;
    }
    static uint64 read_a2() {
        uint64 volatile a2;
        __asm__ volatile ("mv %[value], a2": [value] "=r" (a2));
        return a2;
    }
    static uint64 read_a3() {
        uint64 volatile a3;
        __asm__ volatile ("mv %[value], a3": [value] "=r" (a3));
        return a3;
    }
    static uint64 read_a4() {
        uint64 volatile a4;
        __asm__ volatile ("mv %[value], a4": [value] "=r" (a4));
        return a4;
    }
    static uint64 read_a5() {
        uint64 volatile a5;
        __asm__ volatile ("mv %[value], a5": [value] "=r" (a5));
        return a5;
    }
    static uint64 read_a6() {
        uint64 volatile a6;
        __asm__ volatile ("mv %[value], a6": [value] "=r" (a6));
        return a6;
    }
    static uint64 read_a7() {
        uint64 volatile a7;
        __asm__ volatile ("mv %[value], a7": [value] "=r" (a7));
        return a7;
    }
    static void set_interrupt_address() {
        //write &interrupt_routine in stvec
        __asm__ volatile("csrw stvec, %[mask]" : : [mask] "r" (&interrupt_routine));
    }
    static void write_sscratch(uint64 volatile value) {
        __asm__ volatile ("csrw sscratch, %[value]" : : [value] "r" (value));
    }
    static uint64 read_sepc() {
        uint64 volatile sepc;
        __asm__ volatile ("csrr %[value], sepc": [value] "=r" (sepc));
        return sepc;
    }
    static uint64 read_sstatus() {
        uint64 volatile sstatus;
        __asm__ volatile ("csrr %[value], sstatus": [value] "=r" (sstatus));
        return sstatus;
    }
    static void write_sepc(uint64 volatile value) {
        __asm__ volatile ("csrw sepc, %[value]" : : [value] "r" (value));
    }
    static void write_sstatus(uint64 volatile value) {
        __asm__ volatile ("csrw sstatus, %[value]" : : [value] "r" (value));
    }
    static void prepare_sstatus_kernel() {
        __asm__ volatile ("csrs sstatus, %[value]" : : [value] "r" (SSTATUS_SPP));
        // __asm__ volatile ("csrc sstatus, %[value]" : : [value] "r" (SSTATUS_SPIE));
        // __asm__ volatile ("csrc sstatus, %[value]" : : [value] "r" (SSTATUS_SIE));
    }
    static void prepare_sstatus_user() {
        __asm__ volatile ("csrc sstatus, %[value]" : : [value] "r" (SSTATUS_SPP));
        __asm__ volatile ("csrc sstatus, %[value]" : : [value] "r" (SSTATUS_SIE));
        __asm__ volatile ("csrs sstatus, %[value]" : : [value] "r" (SSTATUS_SPIE));

        __asm__ volatile ("csrs sie, %[value]" : : [value] "r" (SIE_SSIE));
    }
    static void disable_interrupts() {
        __asm__ volatile ("csrc sstatus, %[value]" : : [value] "r" (SSTATUS_SIE));
    }
    static void enable_interrupts() {
        __asm__ volatile ("csrs sstatus, %[value]" : : [value] "r" (SSTATUS_SIE));
    }

    static void software_interrupt_completed() {
        __asm__ volatile ("csrc sip, %[value]" : : [value] "r" (SIP_SSIP));
    }
    static void hardware_interrupt_completed() {
        __asm__ volatile ("csrc sip, %[value]" : : [value] "r" (SIP_SEIP));
    }
    static void software_interrupt_enable() {
        __asm__ volatile ("csrs sie, %[value]" : : [value] "r" (SIE_SSIE));
    }
    static void software_interrupt_disable() {
        __asm__ volatile ("csrc sie, %[value]" : : [value] "r" (SIE_SSIE));
    }
    static void hardware_interrupt_enable() {
        __asm__ volatile ("csrs sie, %[value]" : : [value] "r" (SIE_SEIE));
    }
    static void hardware_interrupt_disable() {
        __asm__ volatile ("csrc sie, %[value]" : : [value] "r" (SIE_SEIE));
    }

    static void halt_processor();

    static void inc_interrupt_level();

    static void switch_regime();

    static void fix_sepc_for_ecall();
    static void sepc_for_getc();
    static void save_ret_val_in_case_of_timer();

    static void interrupt_console_handler(void* param);

    static void interrupt_handler(void* param);
};



#endif //RISCV_HPP
