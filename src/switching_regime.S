.global _ZN5Riscv13switch_regimeEv
.type _ZN5Riscv13switch_regimeEv,@function
_ZN5Riscv13switch_regimeEv:
        csrw sepc, ra
        sret
.end