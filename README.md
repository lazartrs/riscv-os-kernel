# RISC-V Cooperative Multithreading Kernel

A bare-metal kernel for RISC-V (RV64), implementing cooperative multithreading, a custom memory allocator, counting semaphores, and a syscall interface — built from scratch in C/C++ and RISC-V assembly, running on QEMU.

Developed as part of the Operating Systems course at the School of Electrical Engineering, University of Belgrade (ETF) — implementing a cooperative multithreading kernel from a given specification, including the interrupt handling, scheduler, semaphores, and syscall layer.

## Overview

Unlike a preemptive scheduler, threads in this kernel voluntarily yield control via `thread_dispatch()` — there is no forced context switch on timer interrupts. This cooperative model simplifies synchronization (no locking is required around scheduler data structures) while still requiring careful handling of interrupts, syscalls, and privilege transitions.

## Features

- **Thread management (TCB)** — thread creation, cooperative dispatch, sleep/wake, and termination, each with its own context (registers, stack pointer) and dedicated stack
- **Scheduler** — FIFO ready queue, separate queue for blocked (sleeping) threads, and dedicated handling for privileged interrupt/console threads
- **Custom memory allocator** — first-fit allocator over a linked list of fragments, operating in fixed-size blocks
- **Counting semaphores** — blocking `wait`/`signal` with a FIFO wait queue per semaphore
- **Syscall interface via `ecall`** — dual API:
  - C-style syscalls (`thread_create`, `mem_alloc`, `sem_wait`, `sem_signal`, `getc`/`putc`, ...)
  - C++ OOP wrappers (`Thread`, `Semaphore`, `Console` classes) built on top of the C syscalls
- **Interrupt handling** — a dedicated privileged thread handles all traps (syscalls via `ecall`, timer interrupts, illegal instruction/address exceptions), dispatching based on the RISC-V `scause` register
- **User/kernel privilege switching** — context save/restore and `sepc`/`sret`-based transitions between supervisor and user mode, implemented directly in RISC-V assembly
- **Interrupt-driven console I/O** — a separate console handler thread services character input/output

## Architecture

```
main.cpp              — kernel entry point, thread/interrupt setup
h/, src/
  tcb.hpp/.cpp         — Thread Control Block, thread lifecycle
  scheduler.hpp/.cpp   — ready/blocked queues, next-thread selection
  memory.hpp/.cpp      — first-fit memory allocator
  sem.hpp/.cpp         — counting semaphores
  syscall_c.hpp/.cpp   — C syscall API (ecall-based)
  syscall_cpp.hpp/.cpp — C++ OOP wrappers (Thread, Semaphore, Console)
  riscv.hpp/.cpp       — trap dispatch, CSR access, privilege helpers
  list.hpp/.cpp        — intrusive linked list used by scheduler/semaphores
  idle.cpp             — idle thread(s)
src/*.S                — RISC-V assembly:
  context_switch.S        — low-level register save/restore between threads
  interrupt_routine.S     — trap entry/exit, full register save on stack
  save_syscall_parameters.S — extracts syscall args from the trapped context
  switching_regime.S      — kernel → user mode transition (sepc + sret)
test/                  — test programs exercising threads, semaphores,
                          producer-consumer, and sleep, via both the C and
                          C++ APIs
kernel.ld              — linker script
kernel.asm             — boot entry
```

## Building & Running

**Requirements:** a RISC-V64 cross-compiler toolchain (`riscv64-unknown-elf-*` or `riscv64-linux-gnu-*`, auto-detected by the Makefile) and `qemu-system-riscv64`.

```bash
make          # builds the kernel image
make qemu     # builds (if needed) and runs it in QEMU
```

This is equivalent to running:
```bash
qemu-system-riscv64 -machine virt -bios none -kernel kernel -m 128M -smp 1 -nographic
```

**Debugging with GDB:**
```bash
make qemu-gdb
```
This starts QEMU paused, waiting for a GDB connection (`gdb-multiarch`, `target remote localhost:<port>` — the port is printed on start, derived from `.gdbinit.tmpl-riscv`).

**Cleaning build artifacts:**
```bash
make clean
```

## Testing

The `test/` directory contains programs exercising the syscall interface end-to-end, including:
- Thread creation and lifecycle (C and C++ APIs)
- Producer-consumer synchronization with semaphores (C and C++ APIs)
- Thread sleep
- System-mode behavior

## Notes

- This is an educational, single-core, cooperative-multithreading kernel — not intended for production use.
- Interrupt handling, context switching, and privilege-mode transitions are implemented directly in RISC-V assembly (see `src/*.S`).
