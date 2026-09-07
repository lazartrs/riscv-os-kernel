.global _ZN3TCB14context_switchEPNS_7ContextES1_
.type _ZN3TCB14context_switchEPNS_7ContextES1_, @function
_ZN3TCB14context_switchEPNS_7ContextES1_:
    #from s regs save syscall params in context of next running
    ld s0,2*8(a0)
    ld s1,3*8(a0)
    ld s2,4*8(a0)
    ld s3,5*8(a0)
    ld s4,6*8(a0)
    ld s5,7*8(a0)
    ld s6,8*8(a0)
    ld s7,9*8(a0)

    #write syscall parameters in new_running->context
    sd s0,2*8(a1)
    sd s1,3*8(a1)
    sd s2,4*8(a1)
    sd s3,5*8(a1)
    sd s4,6*8(a1)
    sd s5,7*8(a1)
    sd s6,8*8(a1)
    sd s7,9*8(a1)

    #transferering the return value before timer was called
    #ld s0,10*8(a0)
    #sd s0,10*8(a1)

    #save ra and sp in old_running context
    sd ra,8 * 0(a0)
    sd sp,8 * 1(a0)

    #restore ra and sp from new_running
    ld ra,8 * 0(a1)
    ld sp,8 * 1(a1)
    ret
.end