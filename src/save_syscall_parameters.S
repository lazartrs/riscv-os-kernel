.global _ZN3TCB23save_syscall_parametersEPNS_7ContextE
.type _ZN3TCB23save_syscall_parametersEPNS_7ContextE,@function
_ZN3TCB23save_syscall_parametersEPNS_7ContextE:

       #because of saving return address for function a0-a7 is now on different addend from sp
       #ld s0, 4*8(sp)
       #sd s0, 1*8(a0)

       ld s0, 12*8(sp)
       ld s1, 13*8(sp)
       ld s2, 14*8(sp)
       ld s3, 15*8(sp)
       ld s4, 16*8(sp)
       ld s5, 17*8(sp)
       ld s6, 18*8(sp)
       ld s7, 19*8(sp)

       #saving system call parameters in TCB::running->context
       sd s0, 2*8(a0)
       sd s1, 3*8(a0)
       sd s2, 4*8(a0)
       sd s3, 5*8(a0)
       sd s4, 6*8(a0)
       sd s5, 7*8(a0)
       sd s6, 8*8(a0)
       sd s7, 9*8(a0)

       ret
.end
