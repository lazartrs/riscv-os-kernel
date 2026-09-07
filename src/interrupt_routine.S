.align 4
.global interrupt_routine
.type interrupt_routine, @function
interrupt_routine:
   # save context on stack
   addi sp,sp,-256  #allocate space on stack
   .irp i,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
        sd x\i, \i * 8(sp)
   .endr

   call _ZN3TCB34save_syscall_parameters_to_contextEv

   call _ZN5Riscv18fix_sepc_for_ecallEv

   addi sp,sp,-8
   csrr t0,sepc
   sd t0,0*8(sp)


   call _ZN5Riscv19inc_interrupt_levelEv

   # change context to kernel_thread (which is apointed for interrupt handling) - (TCB::yield())
   call _ZN3TCB5yieldEv

   # restore context from stack (except a0 and a1(x0 & x1) - contain return value),also restore sepc from before because it has probably been tempered with

   ld t0,0*8(sp)
   csrw sepc,t0
   addi sp,sp,8

   ld a0,10*8(sp)

   call _ZN5Riscv29save_ret_val_in_case_of_timerEv

   .irp i,1,2,3,4,5,6,7,8,9,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
           ld x\i, \i * 8(sp)
   .endr

    addi sp,sp,256  #clean the stack

    sret #return to previous mode(sepc=>pc,SPP(previous privilege),SPIE=>SIE)
.end

