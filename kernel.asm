
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	ea013103          	ld	sp,-352(sp) # 8000bea0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	221060ef          	jal	ra,80006a3c <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <_ZN5Riscv13switch_regimeEv>:
.global _ZN5Riscv13switch_regimeEv
.type _ZN5Riscv13switch_regimeEv,@function
_ZN5Riscv13switch_regimeEv:
        csrw sepc, ra
    80001000:	14109073          	csrw	sepc,ra
        sret
    80001004:	10200073          	sret
	...

0000000080001010 <interrupt_routine>:
.align 4
.global interrupt_routine
.type interrupt_routine, @function
interrupt_routine:
   # save context on stack
   addi sp,sp,-256  #allocate space on stack
    80001010:	f0010113          	addi	sp,sp,-256
   .irp i,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
        sd x\i, \i * 8(sp)
   .endr
    80001014:	00113423          	sd	ra,8(sp)
    80001018:	00213823          	sd	sp,16(sp)
    8000101c:	00313c23          	sd	gp,24(sp)
    80001020:	02413023          	sd	tp,32(sp)
    80001024:	02513423          	sd	t0,40(sp)
    80001028:	02613823          	sd	t1,48(sp)
    8000102c:	02713c23          	sd	t2,56(sp)
    80001030:	04813023          	sd	s0,64(sp)
    80001034:	04913423          	sd	s1,72(sp)
    80001038:	04a13823          	sd	a0,80(sp)
    8000103c:	04b13c23          	sd	a1,88(sp)
    80001040:	06c13023          	sd	a2,96(sp)
    80001044:	06d13423          	sd	a3,104(sp)
    80001048:	06e13823          	sd	a4,112(sp)
    8000104c:	06f13c23          	sd	a5,120(sp)
    80001050:	09013023          	sd	a6,128(sp)
    80001054:	09113423          	sd	a7,136(sp)
    80001058:	09213823          	sd	s2,144(sp)
    8000105c:	09313c23          	sd	s3,152(sp)
    80001060:	0b413023          	sd	s4,160(sp)
    80001064:	0b513423          	sd	s5,168(sp)
    80001068:	0b613823          	sd	s6,176(sp)
    8000106c:	0b713c23          	sd	s7,184(sp)
    80001070:	0d813023          	sd	s8,192(sp)
    80001074:	0d913423          	sd	s9,200(sp)
    80001078:	0da13823          	sd	s10,208(sp)
    8000107c:	0db13c23          	sd	s11,216(sp)
    80001080:	0fc13023          	sd	t3,224(sp)
    80001084:	0fd13423          	sd	t4,232(sp)
    80001088:	0fe13823          	sd	t5,240(sp)
    8000108c:	0ff13c23          	sd	t6,248(sp)

   call _ZN3TCB34save_syscall_parameters_to_contextEv
    80001090:	2fd000ef          	jal	ra,80001b8c <_ZN3TCB34save_syscall_parameters_to_contextEv>

   call _ZN5Riscv18fix_sepc_for_ecallEv
    80001094:	200010ef          	jal	ra,80002294 <_ZN5Riscv18fix_sepc_for_ecallEv>

   addi sp,sp,-8
    80001098:	ff810113          	addi	sp,sp,-8
   csrr t0,sepc
    8000109c:	141022f3          	csrr	t0,sepc
   sd t0,0*8(sp)
    800010a0:	00513023          	sd	t0,0(sp)


   call _ZN5Riscv19inc_interrupt_levelEv
    800010a4:	1c4010ef          	jal	ra,80002268 <_ZN5Riscv19inc_interrupt_levelEv>

   # change context to kernel_thread (which is apointed for interrupt handling) - (TCB::yield())
   call _ZN3TCB5yieldEv
    800010a8:	24d000ef          	jal	ra,80001af4 <_ZN3TCB5yieldEv>

   # restore context from stack (except a0 and a1(x0 & x1) - contain return value),also restore sepc from before because it has probably been tempered with

   ld t0,0*8(sp)
    800010ac:	00013283          	ld	t0,0(sp)
   csrw sepc,t0
    800010b0:	14129073          	csrw	sepc,t0
   addi sp,sp,8
    800010b4:	00810113          	addi	sp,sp,8

   ld a0,10*8(sp)
    800010b8:	05013503          	ld	a0,80(sp)

   call _ZN5Riscv29save_ret_val_in_case_of_timerEv
    800010bc:	26c010ef          	jal	ra,80002328 <_ZN5Riscv29save_ret_val_in_case_of_timerEv>

   .irp i,1,2,3,4,5,6,7,8,9,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
           ld x\i, \i * 8(sp)
   .endr
    800010c0:	00813083          	ld	ra,8(sp)
    800010c4:	01013103          	ld	sp,16(sp)
    800010c8:	01813183          	ld	gp,24(sp)
    800010cc:	02013203          	ld	tp,32(sp)
    800010d0:	02813283          	ld	t0,40(sp)
    800010d4:	03013303          	ld	t1,48(sp)
    800010d8:	03813383          	ld	t2,56(sp)
    800010dc:	04013403          	ld	s0,64(sp)
    800010e0:	04813483          	ld	s1,72(sp)
    800010e4:	06013603          	ld	a2,96(sp)
    800010e8:	06813683          	ld	a3,104(sp)
    800010ec:	07013703          	ld	a4,112(sp)
    800010f0:	07813783          	ld	a5,120(sp)
    800010f4:	08013803          	ld	a6,128(sp)
    800010f8:	08813883          	ld	a7,136(sp)
    800010fc:	09013903          	ld	s2,144(sp)
    80001100:	09813983          	ld	s3,152(sp)
    80001104:	0a013a03          	ld	s4,160(sp)
    80001108:	0a813a83          	ld	s5,168(sp)
    8000110c:	0b013b03          	ld	s6,176(sp)
    80001110:	0b813b83          	ld	s7,184(sp)
    80001114:	0c013c03          	ld	s8,192(sp)
    80001118:	0c813c83          	ld	s9,200(sp)
    8000111c:	0d013d03          	ld	s10,208(sp)
    80001120:	0d813d83          	ld	s11,216(sp)
    80001124:	0e013e03          	ld	t3,224(sp)
    80001128:	0e813e83          	ld	t4,232(sp)
    8000112c:	0f013f03          	ld	t5,240(sp)
    80001130:	0f813f83          	ld	t6,248(sp)

    addi sp,sp,256  #clean the stack
    80001134:	10010113          	addi	sp,sp,256

    sret #return to previous mode(sepc=>pc,SPP(previous privilege),SPIE=>SIE)
    80001138:	10200073          	sret
    8000113c:	0000                	unimp
	...

0000000080001140 <_ZN3TCB14context_switchEPNS_7ContextES1_>:
.global _ZN3TCB14context_switchEPNS_7ContextES1_
.type _ZN3TCB14context_switchEPNS_7ContextES1_, @function
_ZN3TCB14context_switchEPNS_7ContextES1_:
    #from s regs save syscall params in context of next running
    ld s0,2*8(a0)
    80001140:	01053403          	ld	s0,16(a0) # 1010 <_entry-0x7fffeff0>
    ld s1,3*8(a0)
    80001144:	01853483          	ld	s1,24(a0)
    ld s2,4*8(a0)
    80001148:	02053903          	ld	s2,32(a0)
    ld s3,5*8(a0)
    8000114c:	02853983          	ld	s3,40(a0)
    ld s4,6*8(a0)
    80001150:	03053a03          	ld	s4,48(a0)
    ld s5,7*8(a0)
    80001154:	03853a83          	ld	s5,56(a0)
    ld s6,8*8(a0)
    80001158:	04053b03          	ld	s6,64(a0)
    ld s7,9*8(a0)
    8000115c:	04853b83          	ld	s7,72(a0)

    #write syscall parameters in new_running->context
    sd s0,2*8(a1)
    80001160:	0085b823          	sd	s0,16(a1)
    sd s1,3*8(a1)
    80001164:	0095bc23          	sd	s1,24(a1)
    sd s2,4*8(a1)
    80001168:	0325b023          	sd	s2,32(a1)
    sd s3,5*8(a1)
    8000116c:	0335b423          	sd	s3,40(a1)
    sd s4,6*8(a1)
    80001170:	0345b823          	sd	s4,48(a1)
    sd s5,7*8(a1)
    80001174:	0355bc23          	sd	s5,56(a1)
    sd s6,8*8(a1)
    80001178:	0565b023          	sd	s6,64(a1)
    sd s7,9*8(a1)
    8000117c:	0575b423          	sd	s7,72(a1)
    #transferering the return value before timer was called
    #ld s0,10*8(a0)
    #sd s0,10*8(a1)

    #save ra and sp in old_running context
    sd ra,8 * 0(a0)
    80001180:	00153023          	sd	ra,0(a0)
    sd sp,8 * 1(a0)
    80001184:	00253423          	sd	sp,8(a0)

    #restore ra and sp from new_running
    ld ra,8 * 0(a1)
    80001188:	0005b083          	ld	ra,0(a1)
    ld sp,8 * 1(a1)
    8000118c:	0085b103          	ld	sp,8(a1)
    ret
    80001190:	00008067          	ret

0000000080001194 <_ZN3TCB23save_syscall_parametersEPNS_7ContextE>:

       #because of saving return address for function a0-a7 is now on different addend from sp
       #ld s0, 4*8(sp)
       #sd s0, 1*8(a0)

       ld s0, 12*8(sp)
    80001194:	06013403          	ld	s0,96(sp)
       ld s1, 13*8(sp)
    80001198:	06813483          	ld	s1,104(sp)
       ld s2, 14*8(sp)
    8000119c:	07013903          	ld	s2,112(sp)
       ld s3, 15*8(sp)
    800011a0:	07813983          	ld	s3,120(sp)
       ld s4, 16*8(sp)
    800011a4:	08013a03          	ld	s4,128(sp)
       ld s5, 17*8(sp)
    800011a8:	08813a83          	ld	s5,136(sp)
       ld s6, 18*8(sp)
    800011ac:	09013b03          	ld	s6,144(sp)
       ld s7, 19*8(sp)
    800011b0:	09813b83          	ld	s7,152(sp)

       #saving system call parameters in TCB::running->context
       sd s0, 2*8(a0)
    800011b4:	00853823          	sd	s0,16(a0)
       sd s1, 3*8(a0)
    800011b8:	00953c23          	sd	s1,24(a0)
       sd s2, 4*8(a0)
    800011bc:	03253023          	sd	s2,32(a0)
       sd s3, 5*8(a0)
    800011c0:	03353423          	sd	s3,40(a0)
       sd s4, 6*8(a0)
    800011c4:	03453823          	sd	s4,48(a0)
       sd s5, 7*8(a0)
    800011c8:	03553c23          	sd	s5,56(a0)
       sd s6, 8*8(a0)
    800011cc:	05653023          	sd	s6,64(a0)
       sd s7, 9*8(a0)
    800011d0:	05753423          	sd	s7,72(a0)

       ret
    800011d4:	00008067          	ret

00000000800011d8 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    800011d8:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    800011dc:	00b29a63          	bne	t0,a1,800011f0 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    800011e0:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    800011e4:	fe029ae3          	bnez	t0,800011d8 <copy_and_swap>
    li a0, 0               # Set return to success.
    800011e8:	00000513          	li	a0,0
    jr ra                  # Return.
    800011ec:	00008067          	ret

00000000800011f0 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    800011f0:	00100513          	li	a0,1
    800011f4:	00008067          	ret

00000000800011f8 <_Z15generic_syscallmmmmmmmm>:
#include "../h/syscall_c.hpp"

#include "../h/syscall_cpp.hpp"
sem_t mutex_handle = nullptr;

void generic_syscall(uint64 a0,uint64 a1,uint64 a2,uint64 a3,uint64 a4,uint64 a5,uint64 a6,uint64 a7) {
    800011f8:	ff010113          	addi	sp,sp,-16
    800011fc:	00813423          	sd	s0,8(sp)
    80001200:	01010413          	addi	s0,sp,16
    //generic function that receives through a0-a7 syscall args and just executes ecall
    asm volatile ("ecall");
    80001204:	00000073          	ecall
}
    80001208:	00813403          	ld	s0,8(sp)
    8000120c:	01010113          	addi	sp,sp,16
    80001210:	00008067          	ret

0000000080001214 <_Z9mem_allocm>:

void* mem_alloc(size_t size) {
    80001214:	f9010113          	addi	sp,sp,-112
    80001218:	06113423          	sd	ra,104(sp)
    8000121c:	06813023          	sd	s0,96(sp)
    80001220:	07010413          	addi	s0,sp,112
    //prepare args and ecall
    uint64 num_of_blocks = size%MEM_BLOCK_SIZE==0?size/MEM_BLOCK_SIZE:size/MEM_BLOCK_SIZE+1;
    80001224:	03f57793          	andi	a5,a0,63
    80001228:	04079663          	bnez	a5,80001274 <_Z9mem_allocm+0x60>
    8000122c:	00655593          	srli	a1,a0,0x6
    generic_syscall((uint64)SYSCALL_NUM_MEM_ALLOC,(uint64)num_of_blocks,0,0,0,0,0,0);
    80001230:	00000893          	li	a7,0
    80001234:	00000813          	li	a6,0
    80001238:	00000793          	li	a5,0
    8000123c:	00000713          	li	a4,0
    80001240:	00000693          	li	a3,0
    80001244:	00000613          	li	a2,0
    80001248:	00100513          	li	a0,1
    8000124c:	00000097          	auipc	ra,0x0
    80001250:	fac080e7          	jalr	-84(ra) # 800011f8 <_Z15generic_syscallmmmmmmmm>
    return (void*)TCB::running_thread->get_context().a0;
    80001254:	0000b797          	auipc	a5,0xb
    80001258:	c647b783          	ld	a5,-924(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000125c:	0007b783          	ld	a5,0(a5)
}
    80001260:	0307b503          	ld	a0,48(a5)
    80001264:	06813083          	ld	ra,104(sp)
    80001268:	06013403          	ld	s0,96(sp)
    8000126c:	07010113          	addi	sp,sp,112
    80001270:	00008067          	ret
    uint64 num_of_blocks = size%MEM_BLOCK_SIZE==0?size/MEM_BLOCK_SIZE:size/MEM_BLOCK_SIZE+1;
    80001274:	00655513          	srli	a0,a0,0x6
    80001278:	00150593          	addi	a1,a0,1
    8000127c:	fb5ff06f          	j	80001230 <_Z9mem_allocm+0x1c>

0000000080001280 <_Z8mem_freePv>:
int mem_free(void *addr) {
    80001280:	f9010113          	addi	sp,sp,-112
    80001284:	06113423          	sd	ra,104(sp)
    80001288:	06813023          	sd	s0,96(sp)
    8000128c:	07010413          	addi	s0,sp,112
    80001290:	00050593          	mv	a1,a0
    //prepare args and ecall
    generic_syscall((uint64)SYSCALL_NUM_MEM_FREE,(uint64)addr,0,0,0,0,0,0);
    80001294:	00000893          	li	a7,0
    80001298:	00000813          	li	a6,0
    8000129c:	00000793          	li	a5,0
    800012a0:	00000713          	li	a4,0
    800012a4:	00000693          	li	a3,0
    800012a8:	00000613          	li	a2,0
    800012ac:	00200513          	li	a0,2
    800012b0:	00000097          	auipc	ra,0x0
    800012b4:	f48080e7          	jalr	-184(ra) # 800011f8 <_Z15generic_syscallmmmmmmmm>
    return (int)TCB::running_thread->get_context().a0;
    800012b8:	0000b797          	auipc	a5,0xb
    800012bc:	c007b783          	ld	a5,-1024(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    800012c0:	0007b783          	ld	a5,0(a5)
}
    800012c4:	0307a503          	lw	a0,48(a5)
    800012c8:	06813083          	ld	ra,104(sp)
    800012cc:	06013403          	ld	s0,96(sp)
    800012d0:	07010113          	addi	sp,sp,112
    800012d4:	00008067          	ret

00000000800012d8 <_Z13thread_createPP3TCBPFvPvES2_>:

int thread_create(thread_t *handle, void (*start_routine)(void *), void *arg) {
    800012d8:	f7010113          	addi	sp,sp,-144
    800012dc:	08113423          	sd	ra,136(sp)
    800012e0:	08813023          	sd	s0,128(sp)
    800012e4:	06913c23          	sd	s1,120(sp)
    800012e8:	07213823          	sd	s2,112(sp)
    800012ec:	07313423          	sd	s3,104(sp)
    800012f0:	09010413          	addi	s0,sp,144
    800012f4:	00050493          	mv	s1,a0
    800012f8:	00058913          	mv	s2,a1
    800012fc:	00060993          	mv	s3,a2
    //allocate stack
    uint64* stack = (uint64*) mem_alloc(DEFAULT_STACK_SIZE);
    80001300:	00001537          	lui	a0,0x1
    80001304:	00000097          	auipc	ra,0x0
    80001308:	f10080e7          	jalr	-240(ra) # 80001214 <_Z9mem_allocm>
    8000130c:	00050713          	mv	a4,a0
    generic_syscall((uint64)SYSCALL_NUM_THREAD_CREATE,(uint64)handle,(uint64)start_routine,(uint64)arg,(uint64)stack,0,0,0);
    80001310:	00000893          	li	a7,0
    80001314:	00000813          	li	a6,0
    80001318:	00000793          	li	a5,0
    8000131c:	00098693          	mv	a3,s3
    80001320:	00090613          	mv	a2,s2
    80001324:	00048593          	mv	a1,s1
    80001328:	01100513          	li	a0,17
    8000132c:	00000097          	auipc	ra,0x0
    80001330:	ecc080e7          	jalr	-308(ra) # 800011f8 <_Z15generic_syscallmmmmmmmm>
    return TCB::running_thread->get_context().a0;
    80001334:	0000b797          	auipc	a5,0xb
    80001338:	b847b783          	ld	a5,-1148(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000133c:	0007b783          	ld	a5,0(a5)
}
    80001340:	0307a503          	lw	a0,48(a5)
    80001344:	08813083          	ld	ra,136(sp)
    80001348:	08013403          	ld	s0,128(sp)
    8000134c:	07813483          	ld	s1,120(sp)
    80001350:	07013903          	ld	s2,112(sp)
    80001354:	06813983          	ld	s3,104(sp)
    80001358:	09010113          	addi	sp,sp,144
    8000135c:	00008067          	ret

0000000080001360 <_Z11thread_exitv>:

int thread_exit() {
    80001360:	f9010113          	addi	sp,sp,-112
    80001364:	06113423          	sd	ra,104(sp)
    80001368:	06813023          	sd	s0,96(sp)
    8000136c:	07010413          	addi	s0,sp,112
    //prepare args and ecall
    generic_syscall((uint64)SYSCALL_NUM_THREAD_EXIT,0,0,0,0,0,0,0);
    80001370:	00000893          	li	a7,0
    80001374:	00000813          	li	a6,0
    80001378:	00000793          	li	a5,0
    8000137c:	00000713          	li	a4,0
    80001380:	00000693          	li	a3,0
    80001384:	00000613          	li	a2,0
    80001388:	00000593          	li	a1,0
    8000138c:	01200513          	li	a0,18
    80001390:	00000097          	auipc	ra,0x0
    80001394:	e68080e7          	jalr	-408(ra) # 800011f8 <_Z15generic_syscallmmmmmmmm>
    return (int)TCB::running_thread->get_context().a0;
    80001398:	0000b797          	auipc	a5,0xb
    8000139c:	b207b783          	ld	a5,-1248(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    800013a0:	0007b783          	ld	a5,0(a5)
}
    800013a4:	0307a503          	lw	a0,48(a5)
    800013a8:	06813083          	ld	ra,104(sp)
    800013ac:	06013403          	ld	s0,96(sp)
    800013b0:	07010113          	addi	sp,sp,112
    800013b4:	00008067          	ret

00000000800013b8 <_Z15thread_dispatchv>:

void thread_dispatch() {
    800013b8:	ff010113          	addi	sp,sp,-16
    800013bc:	00113423          	sd	ra,8(sp)
    800013c0:	00813023          	sd	s0,0(sp)
    800013c4:	01010413          	addi	s0,sp,16
    //prepare args and ecall
    generic_syscall((uint64)SYSCALL_NUM_THREAD_DISPATCH,0,0,0,0,0,0,0);
    800013c8:	00000893          	li	a7,0
    800013cc:	00000813          	li	a6,0
    800013d0:	00000793          	li	a5,0
    800013d4:	00000713          	li	a4,0
    800013d8:	00000693          	li	a3,0
    800013dc:	00000613          	li	a2,0
    800013e0:	00000593          	li	a1,0
    800013e4:	01300513          	li	a0,19
    800013e8:	00000097          	auipc	ra,0x0
    800013ec:	e10080e7          	jalr	-496(ra) # 800011f8 <_Z15generic_syscallmmmmmmmm>
}
    800013f0:	00813083          	ld	ra,8(sp)
    800013f4:	00013403          	ld	s0,0(sp)
    800013f8:	01010113          	addi	sp,sp,16
    800013fc:	00008067          	ret

0000000080001400 <_Z8sem_openPP3Semj>:

int sem_open (sem_t *handle,unsigned init) {
    80001400:	f9010113          	addi	sp,sp,-112
    80001404:	06113423          	sd	ra,104(sp)
    80001408:	06813023          	sd	s0,96(sp)
    8000140c:	07010413          	addi	s0,sp,112
    generic_syscall((uint64)SYSCALL_NUM_SEM_OPEN,(uint64)handle,(uint64)init,0,0,0,0,0);
    80001410:	00000893          	li	a7,0
    80001414:	00000813          	li	a6,0
    80001418:	00000793          	li	a5,0
    8000141c:	00000713          	li	a4,0
    80001420:	00000693          	li	a3,0
    80001424:	02059613          	slli	a2,a1,0x20
    80001428:	02065613          	srli	a2,a2,0x20
    8000142c:	00050593          	mv	a1,a0
    80001430:	02100513          	li	a0,33
    80001434:	00000097          	auipc	ra,0x0
    80001438:	dc4080e7          	jalr	-572(ra) # 800011f8 <_Z15generic_syscallmmmmmmmm>
    return (int)TCB::running_thread->get_context().a0;
    8000143c:	0000b797          	auipc	a5,0xb
    80001440:	a7c7b783          	ld	a5,-1412(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80001444:	0007b783          	ld	a5,0(a5)
}
    80001448:	0307a503          	lw	a0,48(a5)
    8000144c:	06813083          	ld	ra,104(sp)
    80001450:	06013403          	ld	s0,96(sp)
    80001454:	07010113          	addi	sp,sp,112
    80001458:	00008067          	ret

000000008000145c <_Z9sem_closeP3Sem>:
int sem_close (sem_t id) {
    8000145c:	f9010113          	addi	sp,sp,-112
    80001460:	06113423          	sd	ra,104(sp)
    80001464:	06813023          	sd	s0,96(sp)
    80001468:	07010413          	addi	s0,sp,112
    8000146c:	00050593          	mv	a1,a0
    generic_syscall((uint64)SYSCALL_NUM_SEM_CLOSE,(uint64)id,0,0,0,0,0,0);
    80001470:	00000893          	li	a7,0
    80001474:	00000813          	li	a6,0
    80001478:	00000793          	li	a5,0
    8000147c:	00000713          	li	a4,0
    80001480:	00000693          	li	a3,0
    80001484:	00000613          	li	a2,0
    80001488:	02200513          	li	a0,34
    8000148c:	00000097          	auipc	ra,0x0
    80001490:	d6c080e7          	jalr	-660(ra) # 800011f8 <_Z15generic_syscallmmmmmmmm>
    return (int)TCB::running_thread->get_context().a0;
    80001494:	0000b797          	auipc	a5,0xb
    80001498:	a247b783          	ld	a5,-1500(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000149c:	0007b783          	ld	a5,0(a5)
}
    800014a0:	0307a503          	lw	a0,48(a5)
    800014a4:	06813083          	ld	ra,104(sp)
    800014a8:	06013403          	ld	s0,96(sp)
    800014ac:	07010113          	addi	sp,sp,112
    800014b0:	00008067          	ret

00000000800014b4 <_Z8sem_waitP3Sem>:
int sem_wait (sem_t id) {
    800014b4:	f9010113          	addi	sp,sp,-112
    800014b8:	06113423          	sd	ra,104(sp)
    800014bc:	06813023          	sd	s0,96(sp)
    800014c0:	07010413          	addi	s0,sp,112
    800014c4:	00050593          	mv	a1,a0
    generic_syscall((uint64)SYSCALL_NUM_SEM_WAIT,(uint64)id,0,0,0,0,0,0);
    800014c8:	00000893          	li	a7,0
    800014cc:	00000813          	li	a6,0
    800014d0:	00000793          	li	a5,0
    800014d4:	00000713          	li	a4,0
    800014d8:	00000693          	li	a3,0
    800014dc:	00000613          	li	a2,0
    800014e0:	02300513          	li	a0,35
    800014e4:	00000097          	auipc	ra,0x0
    800014e8:	d14080e7          	jalr	-748(ra) # 800011f8 <_Z15generic_syscallmmmmmmmm>
    return (int)TCB::running_thread->get_context().a0;
    800014ec:	0000b797          	auipc	a5,0xb
    800014f0:	9cc7b783          	ld	a5,-1588(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    800014f4:	0007b783          	ld	a5,0(a5)
}
    800014f8:	0307a503          	lw	a0,48(a5)
    800014fc:	06813083          	ld	ra,104(sp)
    80001500:	06013403          	ld	s0,96(sp)
    80001504:	07010113          	addi	sp,sp,112
    80001508:	00008067          	ret

000000008000150c <_Z10sem_signalP3Sem>:
int sem_signal (sem_t id) {
    8000150c:	f9010113          	addi	sp,sp,-112
    80001510:	06113423          	sd	ra,104(sp)
    80001514:	06813023          	sd	s0,96(sp)
    80001518:	07010413          	addi	s0,sp,112
    8000151c:	00050593          	mv	a1,a0
    generic_syscall((uint64)SYSCALL_NUM_SEM_SIGNAL,(uint64)id,0,0,0,0,0,0);
    80001520:	00000893          	li	a7,0
    80001524:	00000813          	li	a6,0
    80001528:	00000793          	li	a5,0
    8000152c:	00000713          	li	a4,0
    80001530:	00000693          	li	a3,0
    80001534:	00000613          	li	a2,0
    80001538:	02400513          	li	a0,36
    8000153c:	00000097          	auipc	ra,0x0
    80001540:	cbc080e7          	jalr	-836(ra) # 800011f8 <_Z15generic_syscallmmmmmmmm>
    return (int)TCB::running_thread->get_context().a0;
    80001544:	0000b797          	auipc	a5,0xb
    80001548:	9747b783          	ld	a5,-1676(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000154c:	0007b783          	ld	a5,0(a5)
}
    80001550:	0307a503          	lw	a0,48(a5)
    80001554:	06813083          	ld	ra,104(sp)
    80001558:	06013403          	ld	s0,96(sp)
    8000155c:	07010113          	addi	sp,sp,112
    80001560:	00008067          	ret

0000000080001564 <_Z11sem_trywaitP3Sem>:
int sem_trywait (sem_t id) {
    80001564:	f9010113          	addi	sp,sp,-112
    80001568:	06113423          	sd	ra,104(sp)
    8000156c:	06813023          	sd	s0,96(sp)
    80001570:	07010413          	addi	s0,sp,112
    80001574:	00050593          	mv	a1,a0
    generic_syscall((uint64)SYSCALL_NUM_SEM_TRYWAIT,(uint64)id,0,0,0,0,0,0);
    80001578:	00000893          	li	a7,0
    8000157c:	00000813          	li	a6,0
    80001580:	00000793          	li	a5,0
    80001584:	00000713          	li	a4,0
    80001588:	00000693          	li	a3,0
    8000158c:	00000613          	li	a2,0
    80001590:	02600513          	li	a0,38
    80001594:	00000097          	auipc	ra,0x0
    80001598:	c64080e7          	jalr	-924(ra) # 800011f8 <_Z15generic_syscallmmmmmmmm>
    return (int)TCB::running_thread->get_context().a0;
    8000159c:	0000b797          	auipc	a5,0xb
    800015a0:	91c7b783          	ld	a5,-1764(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    800015a4:	0007b783          	ld	a5,0(a5)
}
    800015a8:	0307a503          	lw	a0,48(a5)
    800015ac:	06813083          	ld	ra,104(sp)
    800015b0:	06013403          	ld	s0,96(sp)
    800015b4:	07010113          	addi	sp,sp,112
    800015b8:	00008067          	ret

00000000800015bc <_Z13sem_timedwaitP3Semm>:
int sem_timedwait(sem_t id,time_t timeout) {
    800015bc:	ff010113          	addi	sp,sp,-16
    800015c0:	00813423          	sd	s0,8(sp)
    800015c4:	01010413          	addi	s0,sp,16
    //to be implemented
    return 0;
}
    800015c8:	00000513          	li	a0,0
    800015cc:	00813403          	ld	s0,8(sp)
    800015d0:	01010113          	addi	sp,sp,16
    800015d4:	00008067          	ret

00000000800015d8 <_Z10time_sleepm>:
int time_sleep (time_t) {
    800015d8:	ff010113          	addi	sp,sp,-16
    800015dc:	00813423          	sd	s0,8(sp)
    800015e0:	01010413          	addi	s0,sp,16
    //to be implemented
    return 0;
}
    800015e4:	00000513          	li	a0,0
    800015e8:	00813403          	ld	s0,8(sp)
    800015ec:	01010113          	addi	sp,sp,16
    800015f0:	00008067          	ret

00000000800015f4 <_Z4getcv>:
char getc() {
    800015f4:	f9010113          	addi	sp,sp,-112
    800015f8:	06113423          	sd	ra,104(sp)
    800015fc:	06813023          	sd	s0,96(sp)
    80001600:	07010413          	addi	s0,sp,112
    generic_syscall((uint64)SYSCALL_NUM_GETC,0,0,0,0,0,0,0);
    80001604:	00000893          	li	a7,0
    80001608:	00000813          	li	a6,0
    8000160c:	00000793          	li	a5,0
    80001610:	00000713          	li	a4,0
    80001614:	00000693          	li	a3,0
    80001618:	00000613          	li	a2,0
    8000161c:	00000593          	li	a1,0
    80001620:	04100513          	li	a0,65
    80001624:	00000097          	auipc	ra,0x0
    80001628:	bd4080e7          	jalr	-1068(ra) # 800011f8 <_Z15generic_syscallmmmmmmmm>
    char c = (char)TCB::running_thread->get_context().a0;
    8000162c:	0000b797          	auipc	a5,0xb
    80001630:	88c7b783          	ld	a5,-1908(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80001634:	0007b783          	ld	a5,0(a5)
    return c;
}
    80001638:	0307c503          	lbu	a0,48(a5)
    8000163c:	06813083          	ld	ra,104(sp)
    80001640:	06013403          	ld	s0,96(sp)
    80001644:	07010113          	addi	sp,sp,112
    80001648:	00008067          	ret

000000008000164c <_Z4putcc>:
void putc(char c) {
    8000164c:	ff010113          	addi	sp,sp,-16
    80001650:	00113423          	sd	ra,8(sp)
    80001654:	00813023          	sd	s0,0(sp)
    80001658:	01010413          	addi	s0,sp,16
    8000165c:	00050593          	mv	a1,a0
    generic_syscall((uint64)SYSCALL_NUM_PUTC,(uint64)c,0,0,0,0,0,0);
    80001660:	00000893          	li	a7,0
    80001664:	00000813          	li	a6,0
    80001668:	00000793          	li	a5,0
    8000166c:	00000713          	li	a4,0
    80001670:	00000693          	li	a3,0
    80001674:	00000613          	li	a2,0
    80001678:	04200513          	li	a0,66
    8000167c:	00000097          	auipc	ra,0x0
    80001680:	b7c080e7          	jalr	-1156(ra) # 800011f8 <_Z15generic_syscallmmmmmmmm>
}
    80001684:	00813083          	ld	ra,8(sp)
    80001688:	00013403          	ld	s0,0(sp)
    8000168c:	01010113          	addi	sp,sp,16
    80001690:	00008067          	ret

0000000080001694 <_Z9user_idlePv>:
//
// Created by os on 6/3/24.
//
#include "../h/idle.hpp"

void user_idle(void*) {
    80001694:	ff010113          	addi	sp,sp,-16
    80001698:	00113423          	sd	ra,8(sp)
    8000169c:	00813023          	sd	s0,0(sp)
    800016a0:	01010413          	addi	s0,sp,16
       // __putc('I');//putc('d');putc('l');putc('e');putc(' ');

        // Thread* t1 = new Thread(user_idle1,nullptr);
        // t1->start();

        thread_dispatch();
    800016a4:	00000097          	auipc	ra,0x0
    800016a8:	d14080e7          	jalr	-748(ra) # 800013b8 <_Z15thread_dispatchv>
    while(true) {
    800016ac:	ff9ff06f          	j	800016a4 <_Z9user_idlePv+0x10>

00000000800016b0 <_Z10user_idle1Pv>:
        //putc('B');putc('a');putc('c');putc('k');putc('t');putc('I');putc('d');putc('l');putc('e');putc(' ');
    }
}
void user_idle1(void*) {
    800016b0:	ff010113          	addi	sp,sp,-16
    800016b4:	00113423          	sd	ra,8(sp)
    800016b8:	00813023          	sd	s0,0(sp)
    800016bc:	01010413          	addi	s0,sp,16
    while(true) {
        putc('I');putc('d');putc('l');putc('e');putc(' ');putc('1');
    800016c0:	04900513          	li	a0,73
    800016c4:	00000097          	auipc	ra,0x0
    800016c8:	f88080e7          	jalr	-120(ra) # 8000164c <_Z4putcc>
    800016cc:	06400513          	li	a0,100
    800016d0:	00000097          	auipc	ra,0x0
    800016d4:	f7c080e7          	jalr	-132(ra) # 8000164c <_Z4putcc>
    800016d8:	06c00513          	li	a0,108
    800016dc:	00000097          	auipc	ra,0x0
    800016e0:	f70080e7          	jalr	-144(ra) # 8000164c <_Z4putcc>
    800016e4:	06500513          	li	a0,101
    800016e8:	00000097          	auipc	ra,0x0
    800016ec:	f64080e7          	jalr	-156(ra) # 8000164c <_Z4putcc>
    800016f0:	02000513          	li	a0,32
    800016f4:	00000097          	auipc	ra,0x0
    800016f8:	f58080e7          	jalr	-168(ra) # 8000164c <_Z4putcc>
    800016fc:	03100513          	li	a0,49
    80001700:	00000097          	auipc	ra,0x0
    80001704:	f4c080e7          	jalr	-180(ra) # 8000164c <_Z4putcc>
        thread_dispatch();
    80001708:	00000097          	auipc	ra,0x0
    8000170c:	cb0080e7          	jalr	-848(ra) # 800013b8 <_Z15thread_dispatchv>
    while(true) {
    80001710:	fb1ff06f          	j	800016c0 <_Z10user_idle1Pv+0x10>

0000000080001714 <_Z7wrapperPv>:
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"

extern "C" void userMain();

void wrapper(void*) {
    80001714:	ff010113          	addi	sp,sp,-16
    80001718:	00113423          	sd	ra,8(sp)
    8000171c:	00813023          	sd	s0,0(sp)
    80001720:	01010413          	addi	s0,sp,16
    userMain();
    80001724:	00004097          	auipc	ra,0x4
    80001728:	790080e7          	jalr	1936(ra) # 80005eb4 <userMain>
    //thread_exit();
}
    8000172c:	00813083          	ld	ra,8(sp)
    80001730:	00013403          	ld	s0,0(sp)
    80001734:	01010113          	addi	sp,sp,16
    80001738:	00008067          	ret

000000008000173c <main>:

int main(){
    8000173c:	fc010113          	addi	sp,sp,-64
    80001740:	02113c23          	sd	ra,56(sp)
    80001744:	02813823          	sd	s0,48(sp)
    80001748:	04010413          	addi	s0,sp,64
    Memory::initialize();
    8000174c:	00002097          	auipc	ra,0x2
    80001750:	b00080e7          	jalr	-1280(ra) # 8000324c <_ZN6Memory10initializeEv>
    //Create main thread
    TCB* main_handle;
    uint64 status = TCB::thread_create(&main_handle,nullptr,nullptr,nullptr);
    80001754:	00000693          	li	a3,0
    80001758:	00000613          	li	a2,0
    8000175c:	00000593          	li	a1,0
    80001760:	fe840513          	addi	a0,s0,-24
    80001764:	00000097          	auipc	ra,0x0
    80001768:	4e4080e7          	jalr	1252(ra) # 80001c48 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_>
    if(status!=0) return status;//check for error
    8000176c:	04051c63          	bnez	a0,800017c4 <main+0x88>

    TCB::running_thread = main_handle;
    80001770:	fe843783          	ld	a5,-24(s0)
    80001774:	0000a717          	auipc	a4,0xa
    80001778:	74473703          	ld	a4,1860(a4) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000177c:	00f73023          	sd	a5,0(a4)
    if(main_handle == nullptr) return -1;
    80001780:	12078e63          	beqz	a5,800018bc <main+0x180>

    void set_finished(bool f) {
        this->finished = f;
    }
    void set_privileged(bool p) {
        this->privileged = p;
    80001784:	00100713          	li	a4,1
    80001788:	08e784a3          	sb	a4,137(a5)
    main_handle->set_privileged(true);

    //Create interrupt thread
    TCB::thread_t interrupt_thread_handle=nullptr;
    8000178c:	fe043023          	sd	zero,-32(s0)
    uint64* stack_space = (uint64*) Memory::mem_alloc(DEFAULT_STACK_SIZE%MEM_BLOCK_SIZE==0?DEFAULT_STACK_SIZE/MEM_BLOCK_SIZE:DEFAULT_STACK_SIZE/MEM_BLOCK_SIZE+1);
    80001790:	04000513          	li	a0,64
    80001794:	00002097          	auipc	ra,0x2
    80001798:	b0c080e7          	jalr	-1268(ra) # 800032a0 <_ZN6Memory9mem_allocEm>
    8000179c:	00050693          	mv	a3,a0
    // uint64* stack_space = (uint64*) __mem_alloc(DEFAULT_STACK_SIZE);
    status = TCB::thread_create(&interrupt_thread_handle,&Riscv::interrupt_handler,nullptr,stack_space);
    800017a0:	00000613          	li	a2,0
    800017a4:	0000a597          	auipc	a1,0xa
    800017a8:	72c5b583          	ld	a1,1836(a1) # 8000bed0 <_GLOBAL_OFFSET_TABLE_+0x50>
    800017ac:	fe040513          	addi	a0,s0,-32
    800017b0:	00000097          	auipc	ra,0x0
    800017b4:	498080e7          	jalr	1176(ra) # 80001c48 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_>
    if(status != 0) return status;//check for error
    800017b8:	02050063          	beqz	a0,800017d8 <main+0x9c>
    800017bc:	0005051b          	sext.w	a0,a0
    800017c0:	0080006f          	j	800017c8 <main+0x8c>
    if(status!=0) return status;//check for error
    800017c4:	0005051b          	sext.w	a0,a0
    // delete threads[1];
    //delete interrupt_thread_handle;
    //delete main_handle;
    //Riscv::halt_processor();
    return 0;
}
    800017c8:	03813083          	ld	ra,56(sp)
    800017cc:	03013403          	ld	s0,48(sp)
    800017d0:	04010113          	addi	sp,sp,64
    800017d4:	00008067          	ret
    interrupt_thread_handle->set_privileged(true);
    800017d8:	fe043503          	ld	a0,-32(s0)
    800017dc:	00100793          	li	a5,1
    800017e0:	08f504a3          	sb	a5,137(a0) # 1089 <_entry-0x7fffef77>
    }
    void set_interrupt(bool i) {
        this->interrupt = i;
    800017e4:	08f50523          	sb	a5,138(a0)
    Scheduler::put_interrupt_thread(interrupt_thread_handle);
    800017e8:	00001097          	auipc	ra,0x1
    800017ec:	710080e7          	jalr	1808(ra) # 80002ef8 <_ZN9Scheduler20put_interrupt_threadEP3TCB>
    TCB::thread_t console_thread_handle=nullptr;
    800017f0:	fc043c23          	sd	zero,-40(s0)
    uint64* stack_space_console = (uint64*) Memory::mem_alloc(DEFAULT_STACK_SIZE%MEM_BLOCK_SIZE==0?DEFAULT_STACK_SIZE/MEM_BLOCK_SIZE:DEFAULT_STACK_SIZE/MEM_BLOCK_SIZE+1);
    800017f4:	04000513          	li	a0,64
    800017f8:	00002097          	auipc	ra,0x2
    800017fc:	aa8080e7          	jalr	-1368(ra) # 800032a0 <_ZN6Memory9mem_allocEm>
    80001800:	00050693          	mv	a3,a0
    status = TCB::thread_create(&console_thread_handle,&Riscv::interrupt_console_handler,nullptr,stack_space_console);
    80001804:	00000613          	li	a2,0
    80001808:	0000a597          	auipc	a1,0xa
    8000180c:	6c05b583          	ld	a1,1728(a1) # 8000bec8 <_GLOBAL_OFFSET_TABLE_+0x48>
    80001810:	fd840513          	addi	a0,s0,-40
    80001814:	00000097          	auipc	ra,0x0
    80001818:	434080e7          	jalr	1076(ra) # 80001c48 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_>
    if(status != 0) return status;//check for error
    8000181c:	00050663          	beqz	a0,80001828 <main+0xec>
    80001820:	0005051b          	sext.w	a0,a0
    80001824:	fa5ff06f          	j	800017c8 <main+0x8c>
    console_thread_handle->set_privileged(true);
    80001828:	fd843503          	ld	a0,-40(s0)
        this->privileged = p;
    8000182c:	00100793          	li	a5,1
    80001830:	08f504a3          	sb	a5,137(a0)
        this->interrupt = i;
    80001834:	08f50523          	sb	a5,138(a0)
    Scheduler::put_interrupt_thread(console_thread_handle);
    80001838:	00001097          	auipc	ra,0x1
    8000183c:	6c0080e7          	jalr	1728(ra) # 80002ef8 <_ZN9Scheduler20put_interrupt_threadEP3TCB>
        __asm__ volatile ("mv %[value], a7": [value] "=r" (a7));
        return a7;
    }
    static void set_interrupt_address() {
        //write &interrupt_routine in stvec
        __asm__ volatile("csrw stvec, %[mask]" : : [mask] "r" (&interrupt_routine));
    80001840:	0000a797          	auipc	a5,0xa
    80001844:	6587b783          	ld	a5,1624(a5) # 8000be98 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001848:	10579073          	csrw	stvec,a5
    }
    static void disable_interrupts() {
        __asm__ volatile ("csrc sstatus, %[value]" : : [value] "r" (SSTATUS_SIE));
    }
    static void enable_interrupts() {
        __asm__ volatile ("csrs sstatus, %[value]" : : [value] "r" (SSTATUS_SIE));
    8000184c:	0000a797          	auipc	a5,0xa
    80001850:	02c7b783          	ld	a5,44(a5) # 8000b878 <_ZL11SSTATUS_SIE>
    80001854:	1007a073          	csrs	sstatus,a5
    thread_create(&threads[0],user_idle,nullptr);
    80001858:	00000613          	li	a2,0
    8000185c:	0000a597          	auipc	a1,0xa
    80001860:	64c5b583          	ld	a1,1612(a1) # 8000bea8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001864:	fc040513          	addi	a0,s0,-64
    80001868:	00000097          	auipc	ra,0x0
    8000186c:	a70080e7          	jalr	-1424(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    if(threads[0] == nullptr) return -1;
    80001870:	fc043783          	ld	a5,-64(s0)
    80001874:	04078863          	beqz	a5,800018c4 <main+0x188>
    thread_create(&threads[1],wrapper,nullptr);
    80001878:	00000613          	li	a2,0
    8000187c:	00000597          	auipc	a1,0x0
    80001880:	e9858593          	addi	a1,a1,-360 # 80001714 <_Z7wrapperPv>
    80001884:	fc840513          	addi	a0,s0,-56
    80001888:	00000097          	auipc	ra,0x0
    8000188c:	a50080e7          	jalr	-1456(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    if(threads[1] == nullptr) return -1;
    80001890:	fc843783          	ld	a5,-56(s0)
    80001894:	02078c63          	beqz	a5,800018cc <main+0x190>
    while(!threads[0]->is_finished() && !threads[1]->is_finished()) {
    80001898:	fc043783          	ld	a5,-64(s0)
        return finished;
    8000189c:	0887c783          	lbu	a5,136(a5)
    800018a0:	02079a63          	bnez	a5,800018d4 <main+0x198>
    800018a4:	fc843783          	ld	a5,-56(s0)
    800018a8:	0887c783          	lbu	a5,136(a5)
    800018ac:	02079863          	bnez	a5,800018dc <main+0x1a0>
        thread_dispatch();
    800018b0:	00000097          	auipc	ra,0x0
    800018b4:	b08080e7          	jalr	-1272(ra) # 800013b8 <_Z15thread_dispatchv>
    800018b8:	fe1ff06f          	j	80001898 <main+0x15c>
    if(main_handle == nullptr) return -1;
    800018bc:	fff00513          	li	a0,-1
    800018c0:	f09ff06f          	j	800017c8 <main+0x8c>
    if(threads[0] == nullptr) return -1;
    800018c4:	fff00513          	li	a0,-1
    800018c8:	f01ff06f          	j	800017c8 <main+0x8c>
    if(threads[1] == nullptr) return -1;
    800018cc:	fff00513          	li	a0,-1
    800018d0:	ef9ff06f          	j	800017c8 <main+0x8c>
    return 0;
    800018d4:	00000513          	li	a0,0
    800018d8:	ef1ff06f          	j	800017c8 <main+0x8c>
    800018dc:	00000513          	li	a0,0
    800018e0:	ee9ff06f          	j	800017c8 <main+0x8c>

00000000800018e4 <_ZN3TCB14thread_wrapperEv>:
    TCB::previous_running_thread = Scheduler::get_thread();
    return 0;
}


void TCB::thread_wrapper() {
    800018e4:	fe010113          	addi	sp,sp,-32
    800018e8:	00113c23          	sd	ra,24(sp)
    800018ec:	00813823          	sd	s0,16(sp)
    800018f0:	00913423          	sd	s1,8(sp)
    800018f4:	02010413          	addi	s0,sp,32
    if(TCB::running_thread->is_privileged()==false)Riscv::switch_regime();
    800018f8:	0000a797          	auipc	a5,0xa
    800018fc:	6307b783          	ld	a5,1584(a5) # 8000bf28 <_ZN3TCB14running_threadE>
    }
    void set_interrupt(bool i) {
        this->interrupt = i;
    }
    bool is_privileged() const {
        return this->privileged;
    80001900:	0897c783          	lbu	a5,137(a5)
    80001904:	04078463          	beqz	a5,8000194c <_ZN3TCB14thread_wrapperEv+0x68>
    running_thread->start_routine(running_thread->my_arg);
    80001908:	0000a497          	auipc	s1,0xa
    8000190c:	62048493          	addi	s1,s1,1568 # 8000bf28 <_ZN3TCB14running_threadE>
    80001910:	0004b783          	ld	a5,0(s1)
    80001914:	0087b703          	ld	a4,8(a5)
    80001918:	0107b503          	ld	a0,16(a5)
    8000191c:	000700e7          	jalr	a4
    TCB::running_thread->set_finished(true);
    80001920:	0004b783          	ld	a5,0(s1)
        this->finished = f;
    80001924:	00100713          	li	a4,1
    80001928:	08e78423          	sb	a4,136(a5)
    f_thread_exit();//we are calling for syscall not directly TCB::thread_exit();
    8000192c:	0000a797          	auipc	a5,0xa
    80001930:	fdc7b783          	ld	a5,-36(a5) # 8000b908 <f_thread_exit>
    80001934:	000780e7          	jalr	a5
}
    80001938:	01813083          	ld	ra,24(sp)
    8000193c:	01013403          	ld	s0,16(sp)
    80001940:	00813483          	ld	s1,8(sp)
    80001944:	02010113          	addi	sp,sp,32
    80001948:	00008067          	ret
    if(TCB::running_thread->is_privileged()==false)Riscv::switch_regime();
    8000194c:	fffff097          	auipc	ra,0xfffff
    80001950:	6b4080e7          	jalr	1716(ra) # 80001000 <_ZN5Riscv13switch_regimeEv>
    80001954:	fb5ff06f          	j	80001908 <_ZN3TCB14thread_wrapperEv+0x24>

0000000080001958 <_ZN3TCBC1EPFvPvES0_S0_>:
TCB::TCB(void (*start_routine)(void *), void *arg, void* stack_space) {
    80001958:	ff010113          	addi	sp,sp,-16
    8000195c:	00813423          	sd	s0,8(sp)
    80001960:	01010413          	addi	s0,sp,16
    80001964:	0000a797          	auipc	a5,0xa
    80001968:	f9478793          	addi	a5,a5,-108 # 8000b8f8 <_ZTV3TCB+0x10>
    8000196c:	00f53023          	sd	a5,0(a0)
    this->context = {0,0,0,0,0,0,0,0,0,0,0,0};
    80001970:	02053023          	sd	zero,32(a0)
    80001974:	02053423          	sd	zero,40(a0)
    80001978:	02053823          	sd	zero,48(a0)
    8000197c:	02053c23          	sd	zero,56(a0)
    80001980:	04053023          	sd	zero,64(a0)
    80001984:	04053423          	sd	zero,72(a0)
    80001988:	04053823          	sd	zero,80(a0)
    8000198c:	04053c23          	sd	zero,88(a0)
    80001990:	06053023          	sd	zero,96(a0)
    80001994:	06053423          	sd	zero,104(a0)
    80001998:	06053823          	sd	zero,112(a0)
    8000199c:	06053c23          	sd	zero,120(a0)
    this->handle = nullptr;
    800019a0:	00053c23          	sd	zero,24(a0)
    this->start_routine = start_routine;
    800019a4:	00b53423          	sd	a1,8(a0)
    this->my_arg = arg;
    800019a8:	00c53823          	sd	a2,16(a0)
    this->finished = false;
    800019ac:	08050423          	sb	zero,136(a0)
    this->privileged = false;
    800019b0:	080504a3          	sb	zero,137(a0)
    this->interrupt = false;
    800019b4:	08050523          	sb	zero,138(a0)
    this->my_time_slice = DEFAULT_TIME_SLICE;
    800019b8:	00200793          	li	a5,2
    800019bc:	08f53823          	sd	a5,144(a0)
    this->my_sleep_time = 0;
    800019c0:	08053c23          	sd	zero,152(a0)
    if(stack_space!=nullptr) {
    800019c4:	02068a63          	beqz	a3,800019f8 <_ZN3TCBC1EPFvPvES0_S0_+0xa0>
        this->stack = (uint64*) stack_space;
    800019c8:	08d53023          	sd	a3,128(a0)
        this->context.sp = (uint64) (stack_space) + DEFAULT_STACK_SIZE - 1;
    800019cc:	000017b7          	lui	a5,0x1
    800019d0:	fff78793          	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800019d4:	00f686b3          	add	a3,a3,a5
    800019d8:	02d53423          	sd	a3,40(a0)
    if(start_routine != nullptr) {
    800019dc:	00058863          	beqz	a1,800019ec <_ZN3TCBC1EPFvPvES0_S0_+0x94>
        this->context.ra = (uint64)&thread_wrapper;
    800019e0:	00000797          	auipc	a5,0x0
    800019e4:	f0478793          	addi	a5,a5,-252 # 800018e4 <_ZN3TCB14thread_wrapperEv>
    800019e8:	02f53023          	sd	a5,32(a0)
}
    800019ec:	00813403          	ld	s0,8(sp)
    800019f0:	01010113          	addi	sp,sp,16
    800019f4:	00008067          	ret
        this->stack = nullptr;
    800019f8:	08053023          	sd	zero,128(a0)
        this->context.sp = 0;
    800019fc:	fe1ff06f          	j	800019dc <_ZN3TCBC1EPFvPvES0_S0_+0x84>

0000000080001a00 <_ZN3TCB15thread_dispatchEv>:
void TCB::thread_dispatch() {
    80001a00:	ff010113          	addi	sp,sp,-16
    80001a04:	00113423          	sd	ra,8(sp)
    80001a08:	00813023          	sd	s0,0(sp)
    80001a0c:	01010413          	addi	s0,sp,16
    if(TCB::previous_running_thread->is_finished()==false)
    80001a10:	0000a517          	auipc	a0,0xa
    80001a14:	52053503          	ld	a0,1312(a0) # 8000bf30 <_ZN3TCB23previous_running_threadE>
        return finished;
    80001a18:	08854783          	lbu	a5,136(a0)
    80001a1c:	02078263          	beqz	a5,80001a40 <_ZN3TCB15thread_dispatchEv+0x40>
    TCB::previous_running_thread = Scheduler::get_thread();
    80001a20:	00001097          	auipc	ra,0x1
    80001a24:	45c080e7          	jalr	1116(ra) # 80002e7c <_ZN9Scheduler10get_threadEv>
    80001a28:	0000a797          	auipc	a5,0xa
    80001a2c:	50a7b423          	sd	a0,1288(a5) # 8000bf30 <_ZN3TCB23previous_running_threadE>
}
    80001a30:	00813083          	ld	ra,8(sp)
    80001a34:	00013403          	ld	s0,0(sp)
    80001a38:	01010113          	addi	sp,sp,16
    80001a3c:	00008067          	ret
        Scheduler::put_thread(TCB::previous_running_thread);
    80001a40:	00001097          	auipc	ra,0x1
    80001a44:	538080e7          	jalr	1336(ra) # 80002f78 <_ZN9Scheduler10put_threadEP3TCB>
    80001a48:	fd9ff06f          	j	80001a20 <_ZN3TCB15thread_dispatchEv+0x20>

0000000080001a4c <_ZN3TCB11thread_exitEv>:
uint64 TCB::thread_exit() {
    80001a4c:	ff010113          	addi	sp,sp,-16
    80001a50:	00113423          	sd	ra,8(sp)
    80001a54:	00813023          	sd	s0,0(sp)
    80001a58:	01010413          	addi	s0,sp,16
    TCB::previous_running_thread->set_finished(true);
    80001a5c:	0000a517          	auipc	a0,0xa
    80001a60:	4d453503          	ld	a0,1236(a0) # 8000bf30 <_ZN3TCB23previous_running_threadE>
        this->finished = f;
    80001a64:	00100793          	li	a5,1
    80001a68:	08f50423          	sb	a5,136(a0)
    delete TCB::previous_running_thread;
    80001a6c:	00050863          	beqz	a0,80001a7c <_ZN3TCB11thread_exitEv+0x30>
    80001a70:	00053783          	ld	a5,0(a0)
    80001a74:	0087b783          	ld	a5,8(a5)
    80001a78:	000780e7          	jalr	a5
    TCB::previous_running_thread = Scheduler::get_thread();
    80001a7c:	00001097          	auipc	ra,0x1
    80001a80:	400080e7          	jalr	1024(ra) # 80002e7c <_ZN9Scheduler10get_threadEv>
    80001a84:	0000a797          	auipc	a5,0xa
    80001a88:	4aa7b623          	sd	a0,1196(a5) # 8000bf30 <_ZN3TCB23previous_running_threadE>
}
    80001a8c:	00000513          	li	a0,0
    80001a90:	00813083          	ld	ra,8(sp)
    80001a94:	00013403          	ld	s0,0(sp)
    80001a98:	01010113          	addi	sp,sp,16
    80001a9c:	00008067          	ret

0000000080001aa0 <_ZN3TCB12thread_sleepEm>:
uint64 TCB::thread_sleep(time_t timer_counts) {
    80001aa0:	fe010113          	addi	sp,sp,-32
    80001aa4:	00113c23          	sd	ra,24(sp)
    80001aa8:	00813823          	sd	s0,16(sp)
    80001aac:	00913423          	sd	s1,8(sp)
    80001ab0:	02010413          	addi	s0,sp,32
    TCB::previous_running_thread->my_sleep_time = timer_counts;
    80001ab4:	0000a497          	auipc	s1,0xa
    80001ab8:	47448493          	addi	s1,s1,1140 # 8000bf28 <_ZN3TCB14running_threadE>
    80001abc:	0084b783          	ld	a5,8(s1)
    80001ac0:	08a7bc23          	sd	a0,152(a5)
    Scheduler::block_thread(TCB::previous_running_thread);
    80001ac4:	00078513          	mv	a0,a5
    80001ac8:	00001097          	auipc	ra,0x1
    80001acc:	5b4080e7          	jalr	1460(ra) # 8000307c <_ZN9Scheduler12block_threadEP3TCB>
    TCB::previous_running_thread = Scheduler::get_thread();
    80001ad0:	00001097          	auipc	ra,0x1
    80001ad4:	3ac080e7          	jalr	940(ra) # 80002e7c <_ZN9Scheduler10get_threadEv>
    80001ad8:	00a4b423          	sd	a0,8(s1)
}
    80001adc:	00000513          	li	a0,0
    80001ae0:	01813083          	ld	ra,24(sp)
    80001ae4:	01013403          	ld	s0,16(sp)
    80001ae8:	00813483          	ld	s1,8(sp)
    80001aec:	02010113          	addi	sp,sp,32
    80001af0:	00008067          	ret

0000000080001af4 <_ZN3TCB5yieldEv>:

void TCB::yield() {
    80001af4:	fe010113          	addi	sp,sp,-32
    80001af8:	00113c23          	sd	ra,24(sp)
    80001afc:	00813823          	sd	s0,16(sp)
    80001b00:	00913423          	sd	s1,8(sp)
    80001b04:	01213023          	sd	s2,0(sp)
    80001b08:	02010413          	addi	s0,sp,32

    TCB* old_running = TCB::running_thread;
    80001b0c:	0000a497          	auipc	s1,0xa
    80001b10:	41c48493          	addi	s1,s1,1052 # 8000bf28 <_ZN3TCB14running_threadE>
    80001b14:	0004b903          	ld	s2,0(s1)
    Scheduler::choose_next_running();
    80001b18:	00001097          	auipc	ra,0x1
    80001b1c:	21c080e7          	jalr	540(ra) # 80002d34 <_ZN9Scheduler19choose_next_runningEv>
    TCB* new_running = TCB::running_thread;
    80001b20:	0004b583          	ld	a1,0(s1)
        return this->privileged;
    80001b24:	0895c783          	lbu	a5,137(a1)

    if(running_thread->is_privileged()==false) Riscv::prepare_sstatus_user();
    80001b28:	04079a63          	bnez	a5,80001b7c <_ZN3TCB5yieldEv+0x88>
        __asm__ volatile ("csrs sstatus, %[value]" : : [value] "r" (SSTATUS_SPP));
        // __asm__ volatile ("csrc sstatus, %[value]" : : [value] "r" (SSTATUS_SPIE));
        // __asm__ volatile ("csrc sstatus, %[value]" : : [value] "r" (SSTATUS_SIE));
    }
    static void prepare_sstatus_user() {
        __asm__ volatile ("csrc sstatus, %[value]" : : [value] "r" (SSTATUS_SPP));
    80001b2c:	0000a797          	auipc	a5,0xa
    80001b30:	d8478793          	addi	a5,a5,-636 # 8000b8b0 <_ZL11SSTATUS_SPP>
    80001b34:	0007b703          	ld	a4,0(a5)
    80001b38:	10073073          	csrc	sstatus,a4
        __asm__ volatile ("csrc sstatus, %[value]" : : [value] "r" (SSTATUS_SIE));
    80001b3c:	0087b703          	ld	a4,8(a5)
    80001b40:	10073073          	csrc	sstatus,a4
        __asm__ volatile ("csrs sstatus, %[value]" : : [value] "r" (SSTATUS_SPIE));
    80001b44:	0107b703          	ld	a4,16(a5)
    80001b48:	10072073          	csrs	sstatus,a4

        __asm__ volatile ("csrs sie, %[value]" : : [value] "r" (SIE_SSIE));
    80001b4c:	0187b783          	ld	a5,24(a5)
    80001b50:	1047a073          	csrs	sie,a5
    else {
        Riscv::prepare_sstatus_kernel();
    }

    context_switch(&old_running->context,&new_running->context);
    80001b54:	02058593          	addi	a1,a1,32
    80001b58:	02090513          	addi	a0,s2,32
    80001b5c:	fffff097          	auipc	ra,0xfffff
    80001b60:	5e4080e7          	jalr	1508(ra) # 80001140 <_ZN3TCB14context_switchEPNS_7ContextES1_>
    // now when ret is called in ra is correct return address
}
    80001b64:	01813083          	ld	ra,24(sp)
    80001b68:	01013403          	ld	s0,16(sp)
    80001b6c:	00813483          	ld	s1,8(sp)
    80001b70:	00013903          	ld	s2,0(sp)
    80001b74:	02010113          	addi	sp,sp,32
    80001b78:	00008067          	ret
        __asm__ volatile ("csrs sstatus, %[value]" : : [value] "r" (SSTATUS_SPP));
    80001b7c:	0000a797          	auipc	a5,0xa
    80001b80:	d347b783          	ld	a5,-716(a5) # 8000b8b0 <_ZL11SSTATUS_SPP>
    80001b84:	1007a073          	csrs	sstatus,a5
    }
    80001b88:	fcdff06f          	j	80001b54 <_ZN3TCB5yieldEv+0x60>

0000000080001b8c <_ZN3TCB34save_syscall_parameters_to_contextEv>:


void TCB::save_syscall_parameters_to_context() {
    80001b8c:	ff010113          	addi	sp,sp,-16
    80001b90:	00113423          	sd	ra,8(sp)
    80001b94:	00813023          	sd	s0,0(sp)
    80001b98:	01010413          	addi	s0,sp,16
    save_syscall_parameters(&TCB::running_thread->context);
    80001b9c:	0000a517          	auipc	a0,0xa
    80001ba0:	38c53503          	ld	a0,908(a0) # 8000bf28 <_ZN3TCB14running_threadE>
    80001ba4:	02050513          	addi	a0,a0,32
    80001ba8:	fffff097          	auipc	ra,0xfffff
    80001bac:	5ec080e7          	jalr	1516(ra) # 80001194 <_ZN3TCB23save_syscall_parametersEPNS_7ContextE>
}
    80001bb0:	00813083          	ld	ra,8(sp)
    80001bb4:	00013403          	ld	s0,0(sp)
    80001bb8:	01010113          	addi	sp,sp,16
    80001bbc:	00008067          	ret

0000000080001bc0 <_ZN3TCB4killEPS_>:

void TCB::kill(TCB *thread) {
    80001bc0:	fe010113          	addi	sp,sp,-32
    80001bc4:	00113c23          	sd	ra,24(sp)
    80001bc8:	00813823          	sd	s0,16(sp)
    80001bcc:	00913423          	sd	s1,8(sp)
    80001bd0:	02010413          	addi	s0,sp,32
    80001bd4:	00050493          	mv	s1,a0
    Scheduler::remove_thread(thread);
    80001bd8:	00001097          	auipc	ra,0x1
    80001bdc:	420080e7          	jalr	1056(ra) # 80002ff8 <_ZN9Scheduler13remove_threadEP3TCB>
    delete thread;
    80001be0:	00048a63          	beqz	s1,80001bf4 <_ZN3TCB4killEPS_+0x34>
    80001be4:	0004b783          	ld	a5,0(s1)
    80001be8:	0087b783          	ld	a5,8(a5)
    80001bec:	00048513          	mv	a0,s1
    80001bf0:	000780e7          	jalr	a5
}
    80001bf4:	01813083          	ld	ra,24(sp)
    80001bf8:	01013403          	ld	s0,16(sp)
    80001bfc:	00813483          	ld	s1,8(sp)
    80001c00:	02010113          	addi	sp,sp,32
    80001c04:	00008067          	ret

0000000080001c08 <_ZN3TCBnwEm>:


void* TCB::operator new(size_t n){
    80001c08:	ff010113          	addi	sp,sp,-16
    80001c0c:	00113423          	sd	ra,8(sp)
    80001c10:	00813023          	sd	s0,0(sp)
    80001c14:	01010413          	addi	s0,sp,16
    return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    80001c18:	03f57793          	andi	a5,a0,63
    80001c1c:	02079063          	bnez	a5,80001c3c <_ZN3TCBnwEm+0x34>
    80001c20:	00655513          	srli	a0,a0,0x6
    80001c24:	00001097          	auipc	ra,0x1
    80001c28:	67c080e7          	jalr	1660(ra) # 800032a0 <_ZN6Memory9mem_allocEm>
    // return __mem_alloc(n);
}
    80001c2c:	00813083          	ld	ra,8(sp)
    80001c30:	00013403          	ld	s0,0(sp)
    80001c34:	01010113          	addi	sp,sp,16
    80001c38:	00008067          	ret
    return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    80001c3c:	00655513          	srli	a0,a0,0x6
    80001c40:	00150513          	addi	a0,a0,1
    80001c44:	fe1ff06f          	j	80001c24 <_ZN3TCBnwEm+0x1c>

0000000080001c48 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_>:
uint64 TCB::thread_create(thread_t *handle, void (*start_routine)(void *), void *arg, void *stack_space) {
    80001c48:	fc010113          	addi	sp,sp,-64
    80001c4c:	02113c23          	sd	ra,56(sp)
    80001c50:	02813823          	sd	s0,48(sp)
    80001c54:	02913423          	sd	s1,40(sp)
    80001c58:	03213023          	sd	s2,32(sp)
    80001c5c:	01313c23          	sd	s3,24(sp)
    80001c60:	01413823          	sd	s4,16(sp)
    80001c64:	01513423          	sd	s5,8(sp)
    80001c68:	04010413          	addi	s0,sp,64
    80001c6c:	00050993          	mv	s3,a0
    80001c70:	00058913          	mv	s2,a1
    80001c74:	00060a13          	mv	s4,a2
    80001c78:	00068a93          	mv	s5,a3
    *handle = new TCB(start_routine,arg,stack_space);
    80001c7c:	0a000513          	li	a0,160
    80001c80:	00000097          	auipc	ra,0x0
    80001c84:	f88080e7          	jalr	-120(ra) # 80001c08 <_ZN3TCBnwEm>
    80001c88:	00050493          	mv	s1,a0
    80001c8c:	000a8693          	mv	a3,s5
    80001c90:	000a0613          	mv	a2,s4
    80001c94:	00090593          	mv	a1,s2
    80001c98:	00000097          	auipc	ra,0x0
    80001c9c:	cc0080e7          	jalr	-832(ra) # 80001958 <_ZN3TCBC1EPFvPvES0_S0_>
    80001ca0:	0099b023          	sd	s1,0(s3)
    if(*handle == nullptr) return -1;
    80001ca4:	04048463          	beqz	s1,80001cec <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0xa4>
    if(start_routine != nullptr) {
    80001ca8:	04090663          	beqz	s2,80001cf4 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0xac>
        if(TCB::previous_running_thread!=nullptr) {
    80001cac:	0000a797          	auipc	a5,0xa
    80001cb0:	2847b783          	ld	a5,644(a5) # 8000bf30 <_ZN3TCB23previous_running_threadE>
    80001cb4:	04078463          	beqz	a5,80001cfc <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0xb4>
            Scheduler::put_thread(*handle);
    80001cb8:	00048513          	mv	a0,s1
    80001cbc:	00001097          	auipc	ra,0x1
    80001cc0:	2bc080e7          	jalr	700(ra) # 80002f78 <_ZN9Scheduler10put_threadEP3TCB>
    return 0;
    80001cc4:	00000513          	li	a0,0
}
    80001cc8:	03813083          	ld	ra,56(sp)
    80001ccc:	03013403          	ld	s0,48(sp)
    80001cd0:	02813483          	ld	s1,40(sp)
    80001cd4:	02013903          	ld	s2,32(sp)
    80001cd8:	01813983          	ld	s3,24(sp)
    80001cdc:	01013a03          	ld	s4,16(sp)
    80001ce0:	00813a83          	ld	s5,8(sp)
    80001ce4:	04010113          	addi	sp,sp,64
    80001ce8:	00008067          	ret
    if(*handle == nullptr) return -1;
    80001cec:	fff00513          	li	a0,-1
    80001cf0:	fd9ff06f          	j	80001cc8 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0x80>
    return 0;
    80001cf4:	00000513          	li	a0,0
    80001cf8:	fd1ff06f          	j	80001cc8 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0x80>
    80001cfc:	00000513          	li	a0,0
    80001d00:	fc9ff06f          	j	80001cc8 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_+0x80>

0000000080001d04 <_ZN3TCBnaEm>:
void* TCB::operator new[](size_t n){
    80001d04:	ff010113          	addi	sp,sp,-16
    80001d08:	00113423          	sd	ra,8(sp)
    80001d0c:	00813023          	sd	s0,0(sp)
    80001d10:	01010413          	addi	s0,sp,16
    return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    80001d14:	03f57793          	andi	a5,a0,63
    80001d18:	02079063          	bnez	a5,80001d38 <_ZN3TCBnaEm+0x34>
    80001d1c:	00655513          	srli	a0,a0,0x6
    80001d20:	00001097          	auipc	ra,0x1
    80001d24:	580080e7          	jalr	1408(ra) # 800032a0 <_ZN6Memory9mem_allocEm>
    // return __mem_alloc(n);
}
    80001d28:	00813083          	ld	ra,8(sp)
    80001d2c:	00013403          	ld	s0,0(sp)
    80001d30:	01010113          	addi	sp,sp,16
    80001d34:	00008067          	ret
    return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    80001d38:	00655513          	srli	a0,a0,0x6
    80001d3c:	00150513          	addi	a0,a0,1
    80001d40:	fe1ff06f          	j	80001d20 <_ZN3TCBnaEm+0x1c>

0000000080001d44 <_ZN3TCBdlEPv>:
void TCB::operator delete(void* addr){
    80001d44:	ff010113          	addi	sp,sp,-16
    80001d48:	00113423          	sd	ra,8(sp)
    80001d4c:	00813023          	sd	s0,0(sp)
    80001d50:	01010413          	addi	s0,sp,16
    Memory::mem_free(addr);
    80001d54:	00001097          	auipc	ra,0x1
    80001d58:	5d0080e7          	jalr	1488(ra) # 80003324 <_ZN6Memory8mem_freeEPv>
    // __mem_free(addr);
}
    80001d5c:	00813083          	ld	ra,8(sp)
    80001d60:	00013403          	ld	s0,0(sp)
    80001d64:	01010113          	addi	sp,sp,16
    80001d68:	00008067          	ret

0000000080001d6c <_ZN3TCBdaEPv>:
void TCB::operator delete[](void* addr){
    80001d6c:	ff010113          	addi	sp,sp,-16
    80001d70:	00113423          	sd	ra,8(sp)
    80001d74:	00813023          	sd	s0,0(sp)
    80001d78:	01010413          	addi	s0,sp,16
    Memory::mem_free(addr);
    80001d7c:	00001097          	auipc	ra,0x1
    80001d80:	5a8080e7          	jalr	1448(ra) # 80003324 <_ZN6Memory8mem_freeEPv>
    // __mem_free(addr);
}
    80001d84:	00813083          	ld	ra,8(sp)
    80001d88:	00013403          	ld	s0,0(sp)
    80001d8c:	01010113          	addi	sp,sp,16
    80001d90:	00008067          	ret

0000000080001d94 <_ZN3TCBD1Ev>:
    bool interrupt;

    uint64 my_time_slice;
    uint64 my_sleep_time;

    virtual ~TCB() {
    80001d94:	ff010113          	addi	sp,sp,-16
    80001d98:	00113423          	sd	ra,8(sp)
    80001d9c:	00813023          	sd	s0,0(sp)
    80001da0:	01010413          	addi	s0,sp,16
    80001da4:	0000a797          	auipc	a5,0xa
    80001da8:	b5478793          	addi	a5,a5,-1196 # 8000b8f8 <_ZTV3TCB+0x10>
    80001dac:	00f53023          	sd	a5,0(a0)
        Memory::mem_free(stack);
    80001db0:	08053503          	ld	a0,128(a0)
    80001db4:	00001097          	auipc	ra,0x1
    80001db8:	570080e7          	jalr	1392(ra) # 80003324 <_ZN6Memory8mem_freeEPv>
        // __mem_free(stack);
    }
    80001dbc:	00813083          	ld	ra,8(sp)
    80001dc0:	00013403          	ld	s0,0(sp)
    80001dc4:	01010113          	addi	sp,sp,16
    80001dc8:	00008067          	ret

0000000080001dcc <_ZN3TCBD0Ev>:
    virtual ~TCB() {
    80001dcc:	fe010113          	addi	sp,sp,-32
    80001dd0:	00113c23          	sd	ra,24(sp)
    80001dd4:	00813823          	sd	s0,16(sp)
    80001dd8:	00913423          	sd	s1,8(sp)
    80001ddc:	02010413          	addi	s0,sp,32
    80001de0:	00050493          	mv	s1,a0
    80001de4:	0000a797          	auipc	a5,0xa
    80001de8:	b1478793          	addi	a5,a5,-1260 # 8000b8f8 <_ZTV3TCB+0x10>
    80001dec:	00f53023          	sd	a5,0(a0)
        Memory::mem_free(stack);
    80001df0:	08053503          	ld	a0,128(a0)
    80001df4:	00001097          	auipc	ra,0x1
    80001df8:	530080e7          	jalr	1328(ra) # 80003324 <_ZN6Memory8mem_freeEPv>
    }
    80001dfc:	00048513          	mv	a0,s1
    80001e00:	00000097          	auipc	ra,0x0
    80001e04:	f44080e7          	jalr	-188(ra) # 80001d44 <_ZN3TCBdlEPv>
    80001e08:	01813083          	ld	ra,24(sp)
    80001e0c:	01013403          	ld	s0,16(sp)
    80001e10:	00813483          	ld	s1,8(sp)
    80001e14:	02010113          	addi	sp,sp,32
    80001e18:	00008067          	ret

0000000080001e1c <_ZN6Thread6threadEPv>:
    this->body = body;
    this->arg = arg;
    myHandle = nullptr;
    thread_create(&myHandle,this->body,this->arg);
}
void Thread::thread(void* t) {
    80001e1c:	ff010113          	addi	sp,sp,-16
    80001e20:	00113423          	sd	ra,8(sp)
    80001e24:	00813023          	sd	s0,0(sp)
    80001e28:	01010413          	addi	s0,sp,16
    Thread* thr = (Thread*)t;
    if(thr)thr->run();
    80001e2c:	00050863          	beqz	a0,80001e3c <_ZN6Thread6threadEPv+0x20>
    80001e30:	00053783          	ld	a5,0(a0)
    80001e34:	0107b783          	ld	a5,16(a5)
    80001e38:	000780e7          	jalr	a5
    //this function has no caller so it must not return
    thread_exit();
    80001e3c:	fffff097          	auipc	ra,0xfffff
    80001e40:	524080e7          	jalr	1316(ra) # 80001360 <_Z11thread_exitv>
}
    80001e44:	00813083          	ld	ra,8(sp)
    80001e48:	00013403          	ld	s0,0(sp)
    80001e4c:	01010113          	addi	sp,sp,16
    80001e50:	00008067          	ret

0000000080001e54 <_ZN6ThreadD1Ev>:
    return 0;
}
int Thread::sleep(time_t t) {
    return time_sleep(t);
}
Thread::~Thread() {
    80001e54:	ff010113          	addi	sp,sp,-16
    80001e58:	00113423          	sd	ra,8(sp)
    80001e5c:	00813023          	sd	s0,0(sp)
    80001e60:	01010413          	addi	s0,sp,16
    80001e64:	0000a797          	auipc	a5,0xa
    80001e68:	afc78793          	addi	a5,a5,-1284 # 8000b960 <_ZTV6Thread+0x10>
    80001e6c:	00f53023          	sd	a5,0(a0)
    TCB::kill(this->myHandle);
    80001e70:	00853503          	ld	a0,8(a0)
    80001e74:	00000097          	auipc	ra,0x0
    80001e78:	d4c080e7          	jalr	-692(ra) # 80001bc0 <_ZN3TCB4killEPS_>
}
    80001e7c:	00813083          	ld	ra,8(sp)
    80001e80:	00013403          	ld	s0,0(sp)
    80001e84:	01010113          	addi	sp,sp,16
    80001e88:	00008067          	ret

0000000080001e8c <_ZN9SemaphoreD1Ev>:
    return sem_trywait(this->myHandle);
}
int Semaphore::timedWait(time_t t) {
    return sem_timedwait(this->myHandle,t);
}
Semaphore::~Semaphore() {
    80001e8c:	ff010113          	addi	sp,sp,-16
    80001e90:	00113423          	sd	ra,8(sp)
    80001e94:	00813023          	sd	s0,0(sp)
    80001e98:	01010413          	addi	s0,sp,16
    80001e9c:	0000a797          	auipc	a5,0xa
    80001ea0:	aec78793          	addi	a5,a5,-1300 # 8000b988 <_ZTV9Semaphore+0x10>
    80001ea4:	00f53023          	sd	a5,0(a0)
    sem_close(this->myHandle);
    80001ea8:	00853503          	ld	a0,8(a0)
    80001eac:	fffff097          	auipc	ra,0xfffff
    80001eb0:	5b0080e7          	jalr	1456(ra) # 8000145c <_Z9sem_closeP3Sem>
}
    80001eb4:	00813083          	ld	ra,8(sp)
    80001eb8:	00013403          	ld	s0,0(sp)
    80001ebc:	01010113          	addi	sp,sp,16
    80001ec0:	00008067          	ret

0000000080001ec4 <_Znwm>:
void* operator new(size_t n){
    80001ec4:	ff010113          	addi	sp,sp,-16
    80001ec8:	00113423          	sd	ra,8(sp)
    80001ecc:	00813023          	sd	s0,0(sp)
    80001ed0:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80001ed4:	fffff097          	auipc	ra,0xfffff
    80001ed8:	340080e7          	jalr	832(ra) # 80001214 <_Z9mem_allocm>
}
    80001edc:	00813083          	ld	ra,8(sp)
    80001ee0:	00013403          	ld	s0,0(sp)
    80001ee4:	01010113          	addi	sp,sp,16
    80001ee8:	00008067          	ret

0000000080001eec <_Znam>:
void* operator new[](size_t n){
    80001eec:	ff010113          	addi	sp,sp,-16
    80001ef0:	00113423          	sd	ra,8(sp)
    80001ef4:	00813023          	sd	s0,0(sp)
    80001ef8:	01010413          	addi	s0,sp,16
    return mem_alloc(n);
    80001efc:	fffff097          	auipc	ra,0xfffff
    80001f00:	318080e7          	jalr	792(ra) # 80001214 <_Z9mem_allocm>
}
    80001f04:	00813083          	ld	ra,8(sp)
    80001f08:	00013403          	ld	s0,0(sp)
    80001f0c:	01010113          	addi	sp,sp,16
    80001f10:	00008067          	ret

0000000080001f14 <_ZdlPv>:
void operator delete(void* addr){
    80001f14:	ff010113          	addi	sp,sp,-16
    80001f18:	00113423          	sd	ra,8(sp)
    80001f1c:	00813023          	sd	s0,0(sp)
    80001f20:	01010413          	addi	s0,sp,16
    mem_free(addr);
    80001f24:	fffff097          	auipc	ra,0xfffff
    80001f28:	35c080e7          	jalr	860(ra) # 80001280 <_Z8mem_freePv>
}
    80001f2c:	00813083          	ld	ra,8(sp)
    80001f30:	00013403          	ld	s0,0(sp)
    80001f34:	01010113          	addi	sp,sp,16
    80001f38:	00008067          	ret

0000000080001f3c <_ZN6ThreadD0Ev>:
Thread::~Thread() {
    80001f3c:	fe010113          	addi	sp,sp,-32
    80001f40:	00113c23          	sd	ra,24(sp)
    80001f44:	00813823          	sd	s0,16(sp)
    80001f48:	00913423          	sd	s1,8(sp)
    80001f4c:	02010413          	addi	s0,sp,32
    80001f50:	00050493          	mv	s1,a0
}
    80001f54:	00000097          	auipc	ra,0x0
    80001f58:	f00080e7          	jalr	-256(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80001f5c:	00048513          	mv	a0,s1
    80001f60:	00000097          	auipc	ra,0x0
    80001f64:	fb4080e7          	jalr	-76(ra) # 80001f14 <_ZdlPv>
    80001f68:	01813083          	ld	ra,24(sp)
    80001f6c:	01013403          	ld	s0,16(sp)
    80001f70:	00813483          	ld	s1,8(sp)
    80001f74:	02010113          	addi	sp,sp,32
    80001f78:	00008067          	ret

0000000080001f7c <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80001f7c:	fe010113          	addi	sp,sp,-32
    80001f80:	00113c23          	sd	ra,24(sp)
    80001f84:	00813823          	sd	s0,16(sp)
    80001f88:	00913423          	sd	s1,8(sp)
    80001f8c:	02010413          	addi	s0,sp,32
    80001f90:	00050493          	mv	s1,a0
}
    80001f94:	00000097          	auipc	ra,0x0
    80001f98:	ef8080e7          	jalr	-264(ra) # 80001e8c <_ZN9SemaphoreD1Ev>
    80001f9c:	00048513          	mv	a0,s1
    80001fa0:	00000097          	auipc	ra,0x0
    80001fa4:	f74080e7          	jalr	-140(ra) # 80001f14 <_ZdlPv>
    80001fa8:	01813083          	ld	ra,24(sp)
    80001fac:	01013403          	ld	s0,16(sp)
    80001fb0:	00813483          	ld	s1,8(sp)
    80001fb4:	02010113          	addi	sp,sp,32
    80001fb8:	00008067          	ret

0000000080001fbc <_ZdaPv>:
void operator delete[](void* addr){
    80001fbc:	ff010113          	addi	sp,sp,-16
    80001fc0:	00113423          	sd	ra,8(sp)
    80001fc4:	00813023          	sd	s0,0(sp)
    80001fc8:	01010413          	addi	s0,sp,16
    mem_free(addr);
    80001fcc:	fffff097          	auipc	ra,0xfffff
    80001fd0:	2b4080e7          	jalr	692(ra) # 80001280 <_Z8mem_freePv>
}
    80001fd4:	00813083          	ld	ra,8(sp)
    80001fd8:	00013403          	ld	s0,0(sp)
    80001fdc:	01010113          	addi	sp,sp,16
    80001fe0:	00008067          	ret

0000000080001fe4 <_ZN6ThreadC1Ev>:
Thread::Thread() {
    80001fe4:	ff010113          	addi	sp,sp,-16
    80001fe8:	00813423          	sd	s0,8(sp)
    80001fec:	01010413          	addi	s0,sp,16
    80001ff0:	0000a797          	auipc	a5,0xa
    80001ff4:	97078793          	addi	a5,a5,-1680 # 8000b960 <_ZTV6Thread+0x10>
    80001ff8:	00f53023          	sd	a5,0(a0)
    myHandle=nullptr;
    80001ffc:	00053423          	sd	zero,8(a0)
    body = nullptr;
    80002000:	00053823          	sd	zero,16(a0)
    arg = nullptr;
    80002004:	00053c23          	sd	zero,24(a0)
}
    80002008:	00813403          	ld	s0,8(sp)
    8000200c:	01010113          	addi	sp,sp,16
    80002010:	00008067          	ret

0000000080002014 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80002014:	ff010113          	addi	sp,sp,-16
    80002018:	00113423          	sd	ra,8(sp)
    8000201c:	00813023          	sd	s0,0(sp)
    80002020:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002024:	fffff097          	auipc	ra,0xfffff
    80002028:	394080e7          	jalr	916(ra) # 800013b8 <_Z15thread_dispatchv>
}
    8000202c:	00813083          	ld	ra,8(sp)
    80002030:	00013403          	ld	s0,0(sp)
    80002034:	01010113          	addi	sp,sp,16
    80002038:	00008067          	ret

000000008000203c <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg) {
    8000203c:	ff010113          	addi	sp,sp,-16
    80002040:	00113423          	sd	ra,8(sp)
    80002044:	00813023          	sd	s0,0(sp)
    80002048:	01010413          	addi	s0,sp,16
    8000204c:	0000a797          	auipc	a5,0xa
    80002050:	91478793          	addi	a5,a5,-1772 # 8000b960 <_ZTV6Thread+0x10>
    80002054:	00f53023          	sd	a5,0(a0)
    this->body = body;
    80002058:	00b53823          	sd	a1,16(a0)
    this->arg = arg;
    8000205c:	00c53c23          	sd	a2,24(a0)
    myHandle = nullptr;
    80002060:	00053423          	sd	zero,8(a0)
    thread_create(&myHandle,this->body,this->arg);
    80002064:	00850513          	addi	a0,a0,8
    80002068:	fffff097          	auipc	ra,0xfffff
    8000206c:	270080e7          	jalr	624(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
}
    80002070:	00813083          	ld	ra,8(sp)
    80002074:	00013403          	ld	s0,0(sp)
    80002078:	01010113          	addi	sp,sp,16
    8000207c:	00008067          	ret

0000000080002080 <_ZN6Thread5startEv>:
int Thread::start() {
    80002080:	fe010113          	addi	sp,sp,-32
    80002084:	00113c23          	sd	ra,24(sp)
    80002088:	00813823          	sd	s0,16(sp)
    8000208c:	00913423          	sd	s1,8(sp)
    80002090:	02010413          	addi	s0,sp,32
    80002094:	00050493          	mv	s1,a0
    if(myHandle==nullptr) thread_create(&myHandle,thread,this);
    80002098:	00853783          	ld	a5,8(a0)
    8000209c:	02078263          	beqz	a5,800020c0 <_ZN6Thread5startEv+0x40>
    if(myHandle==nullptr) return -1;
    800020a0:	0084b783          	ld	a5,8(s1)
    800020a4:	02078c63          	beqz	a5,800020dc <_ZN6Thread5startEv+0x5c>
    return 0;
    800020a8:	00000513          	li	a0,0
}
    800020ac:	01813083          	ld	ra,24(sp)
    800020b0:	01013403          	ld	s0,16(sp)
    800020b4:	00813483          	ld	s1,8(sp)
    800020b8:	02010113          	addi	sp,sp,32
    800020bc:	00008067          	ret
    if(myHandle==nullptr) thread_create(&myHandle,thread,this);
    800020c0:	00050613          	mv	a2,a0
    800020c4:	00000597          	auipc	a1,0x0
    800020c8:	d5858593          	addi	a1,a1,-680 # 80001e1c <_ZN6Thread6threadEPv>
    800020cc:	00850513          	addi	a0,a0,8
    800020d0:	fffff097          	auipc	ra,0xfffff
    800020d4:	208080e7          	jalr	520(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    800020d8:	fc9ff06f          	j	800020a0 <_ZN6Thread5startEv+0x20>
    if(myHandle==nullptr) return -1;
    800020dc:	fff00513          	li	a0,-1
    800020e0:	fcdff06f          	j	800020ac <_ZN6Thread5startEv+0x2c>

00000000800020e4 <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t t) {
    800020e4:	ff010113          	addi	sp,sp,-16
    800020e8:	00113423          	sd	ra,8(sp)
    800020ec:	00813023          	sd	s0,0(sp)
    800020f0:	01010413          	addi	s0,sp,16
    return time_sleep(t);
    800020f4:	fffff097          	auipc	ra,0xfffff
    800020f8:	4e4080e7          	jalr	1252(ra) # 800015d8 <_Z10time_sleepm>
}
    800020fc:	00813083          	ld	ra,8(sp)
    80002100:	00013403          	ld	s0,0(sp)
    80002104:	01010113          	addi	sp,sp,16
    80002108:	00008067          	ret

000000008000210c <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned init) {
    8000210c:	ff010113          	addi	sp,sp,-16
    80002110:	00113423          	sd	ra,8(sp)
    80002114:	00813023          	sd	s0,0(sp)
    80002118:	01010413          	addi	s0,sp,16
    8000211c:	0000a797          	auipc	a5,0xa
    80002120:	86c78793          	addi	a5,a5,-1940 # 8000b988 <_ZTV9Semaphore+0x10>
    80002124:	00f53023          	sd	a5,0(a0)
    myHandle = nullptr;
    80002128:	00053423          	sd	zero,8(a0)
    sem_open(&this->myHandle,init);
    8000212c:	00850513          	addi	a0,a0,8
    80002130:	fffff097          	auipc	ra,0xfffff
    80002134:	2d0080e7          	jalr	720(ra) # 80001400 <_Z8sem_openPP3Semj>
}
    80002138:	00813083          	ld	ra,8(sp)
    8000213c:	00013403          	ld	s0,0(sp)
    80002140:	01010113          	addi	sp,sp,16
    80002144:	00008067          	ret

0000000080002148 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80002148:	ff010113          	addi	sp,sp,-16
    8000214c:	00113423          	sd	ra,8(sp)
    80002150:	00813023          	sd	s0,0(sp)
    80002154:	01010413          	addi	s0,sp,16
    return sem_wait(this->myHandle);
    80002158:	00853503          	ld	a0,8(a0)
    8000215c:	fffff097          	auipc	ra,0xfffff
    80002160:	358080e7          	jalr	856(ra) # 800014b4 <_Z8sem_waitP3Sem>
}
    80002164:	00813083          	ld	ra,8(sp)
    80002168:	00013403          	ld	s0,0(sp)
    8000216c:	01010113          	addi	sp,sp,16
    80002170:	00008067          	ret

0000000080002174 <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80002174:	ff010113          	addi	sp,sp,-16
    80002178:	00113423          	sd	ra,8(sp)
    8000217c:	00813023          	sd	s0,0(sp)
    80002180:	01010413          	addi	s0,sp,16
    return sem_signal(this->myHandle);
    80002184:	00853503          	ld	a0,8(a0)
    80002188:	fffff097          	auipc	ra,0xfffff
    8000218c:	384080e7          	jalr	900(ra) # 8000150c <_Z10sem_signalP3Sem>
}
    80002190:	00813083          	ld	ra,8(sp)
    80002194:	00013403          	ld	s0,0(sp)
    80002198:	01010113          	addi	sp,sp,16
    8000219c:	00008067          	ret

00000000800021a0 <_ZN9Semaphore7tryWaitEv>:
int Semaphore::tryWait() {
    800021a0:	ff010113          	addi	sp,sp,-16
    800021a4:	00113423          	sd	ra,8(sp)
    800021a8:	00813023          	sd	s0,0(sp)
    800021ac:	01010413          	addi	s0,sp,16
    return sem_trywait(this->myHandle);
    800021b0:	00853503          	ld	a0,8(a0)
    800021b4:	fffff097          	auipc	ra,0xfffff
    800021b8:	3b0080e7          	jalr	944(ra) # 80001564 <_Z11sem_trywaitP3Sem>
}
    800021bc:	00813083          	ld	ra,8(sp)
    800021c0:	00013403          	ld	s0,0(sp)
    800021c4:	01010113          	addi	sp,sp,16
    800021c8:	00008067          	ret

00000000800021cc <_ZN9Semaphore9timedWaitEm>:
int Semaphore::timedWait(time_t t) {
    800021cc:	ff010113          	addi	sp,sp,-16
    800021d0:	00113423          	sd	ra,8(sp)
    800021d4:	00813023          	sd	s0,0(sp)
    800021d8:	01010413          	addi	s0,sp,16
    return sem_timedwait(this->myHandle,t);
    800021dc:	00853503          	ld	a0,8(a0)
    800021e0:	fffff097          	auipc	ra,0xfffff
    800021e4:	3dc080e7          	jalr	988(ra) # 800015bc <_Z13sem_timedwaitP3Semm>
}
    800021e8:	00813083          	ld	ra,8(sp)
    800021ec:	00013403          	ld	s0,0(sp)
    800021f0:	01010113          	addi	sp,sp,16
    800021f4:	00008067          	ret

00000000800021f8 <_ZN7Console4getcEv>:

char Console::getc() {
    800021f8:	ff010113          	addi	sp,sp,-16
    800021fc:	00113423          	sd	ra,8(sp)
    80002200:	00813023          	sd	s0,0(sp)
    80002204:	01010413          	addi	s0,sp,16
    return f_getc();
    80002208:	00009797          	auipc	a5,0x9
    8000220c:	7907b783          	ld	a5,1936(a5) # 8000b998 <f_getc>
    80002210:	000780e7          	jalr	a5
}
    80002214:	00813083          	ld	ra,8(sp)
    80002218:	00013403          	ld	s0,0(sp)
    8000221c:	01010113          	addi	sp,sp,16
    80002220:	00008067          	ret

0000000080002224 <_ZN7Console4putcEc>:
void Console::putc(char c) {
    80002224:	ff010113          	addi	sp,sp,-16
    80002228:	00113423          	sd	ra,8(sp)
    8000222c:	00813023          	sd	s0,0(sp)
    80002230:	01010413          	addi	s0,sp,16
    f_putc(c);
    80002234:	00009797          	auipc	a5,0x9
    80002238:	76c7b783          	ld	a5,1900(a5) # 8000b9a0 <f_putc>
    8000223c:	000780e7          	jalr	a5
}
    80002240:	00813083          	ld	ra,8(sp)
    80002244:	00013403          	ld	s0,0(sp)
    80002248:	01010113          	addi	sp,sp,16
    8000224c:	00008067          	ret

0000000080002250 <_ZN6Thread3runEv>:
    int start ();
    static void dispatch ();
    static int sleep (time_t);
protected:
    Thread ();
    virtual void run () {}
    80002250:	ff010113          	addi	sp,sp,-16
    80002254:	00813423          	sd	s0,8(sp)
    80002258:	01010413          	addi	s0,sp,16
    8000225c:	00813403          	ld	s0,8(sp)
    80002260:	01010113          	addi	sp,sp,16
    80002264:	00008067          	ret

0000000080002268 <_ZN5Riscv19inc_interrupt_levelEv>:
uint64 Riscv::interrupt_level = 0;
uint64 Riscv::timer_count = 0;

using Body = void (*)(void*);

void Riscv::inc_interrupt_level() {
    80002268:	ff010113          	addi	sp,sp,-16
    8000226c:	00813423          	sd	s0,8(sp)
    80002270:	01010413          	addi	s0,sp,16
    Riscv::interrupt_level++;
    80002274:	0000a717          	auipc	a4,0xa
    80002278:	cd470713          	addi	a4,a4,-812 # 8000bf48 <_ZN5Riscv15interrupt_levelE>
    8000227c:	00073783          	ld	a5,0(a4)
    80002280:	00178793          	addi	a5,a5,1
    80002284:	00f73023          	sd	a5,0(a4)
}
    80002288:	00813403          	ld	s0,8(sp)
    8000228c:	01010113          	addi	sp,sp,16
    80002290:	00008067          	ret

0000000080002294 <_ZN5Riscv18fix_sepc_for_ecallEv>:


void Riscv::fix_sepc_for_ecall() {
    80002294:	fd010113          	addi	sp,sp,-48
    80002298:	02813423          	sd	s0,40(sp)
    8000229c:	03010413          	addi	s0,sp,48
    static uint64 interrupt_level;
    static uint64 timer_count;

    static uint64 read_scause() {
        uint64 volatile scause;
        __asm__ volatile ("csrr %[value], scause": [value] "=r" (scause));
    800022a0:	142027f3          	csrr	a5,scause
    800022a4:	fcf43c23          	sd	a5,-40(s0)
        return scause;
    800022a8:	fd843783          	ld	a5,-40(s0)
    uint64 volatile scause = Riscv::read_scause();
    800022ac:	fef43423          	sd	a5,-24(s0)
    static void write_sscratch(uint64 volatile value) {
        __asm__ volatile ("csrw sscratch, %[value]" : : [value] "r" (value));
    }
    static uint64 read_sepc() {
        uint64 volatile sepc;
        __asm__ volatile ("csrr %[value], sepc": [value] "=r" (sepc));
    800022b0:	141027f3          	csrr	a5,sepc
    800022b4:	fcf43823          	sd	a5,-48(s0)
        return sepc;
    800022b8:	fd043783          	ld	a5,-48(s0)
    uint64 volatile sepc = Riscv::read_sepc();
    800022bc:	fef43023          	sd	a5,-32(s0)
    if(scause == SCAUSE_ECALL_PIVILEGED || scause == SCAUSE_ECALL_USER){//|| scause==SCAUSE_EXTERNAL_HARDWARE) {
    800022c0:	fe843703          	ld	a4,-24(s0)
    800022c4:	00900793          	li	a5,9
    800022c8:	00f70863          	beq	a4,a5,800022d8 <_ZN5Riscv18fix_sepc_for_ecallEv+0x44>
    800022cc:	fe843703          	ld	a4,-24(s0)
    800022d0:	00800793          	li	a5,8
    800022d4:	00f71c63          	bne	a4,a5,800022ec <_ZN5Riscv18fix_sepc_for_ecallEv+0x58>
        sepc = sepc + 4;
    800022d8:	fe043783          	ld	a5,-32(s0)
    800022dc:	00478793          	addi	a5,a5,4
    800022e0:	fef43023          	sd	a5,-32(s0)
        write_sepc(sepc);
    800022e4:	fe043783          	ld	a5,-32(s0)
        uint64 volatile sstatus;
        __asm__ volatile ("csrr %[value], sstatus": [value] "=r" (sstatus));
        return sstatus;
    }
    static void write_sepc(uint64 volatile value) {
        __asm__ volatile ("csrw sepc, %[value]" : : [value] "r" (value));
    800022e8:	14179073          	csrw	sepc,a5
    }
    // else if(scause==SCAUSE_EXTERNAL_HARDWARE) {
    //     sepc = TCB::running_thread->context.sepc;
    //     write_sepc(sepc);
    // }
}
    800022ec:	02813403          	ld	s0,40(sp)
    800022f0:	03010113          	addi	sp,sp,48
    800022f4:	00008067          	ret

00000000800022f8 <_ZN5Riscv13sepc_for_getcEv>:

void Riscv::sepc_for_getc() {
    800022f8:	ff010113          	addi	sp,sp,-16
    800022fc:	00813423          	sd	s0,8(sp)
    80002300:	01010413          	addi	s0,sp,16
    __asm__ volatile ("mv %[value],ra" : [value] "=r" (TCB::running_thread->context.sepc):);
    80002304:	0000a797          	auipc	a5,0xa
    80002308:	bb47b783          	ld	a5,-1100(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000230c:	0007b703          	ld	a4,0(a5)
    80002310:	00008793          	mv	a5,ra
    TCB::running_thread->context.sepc = TCB::running_thread->context.sepc + 4;
    80002314:	00478793          	addi	a5,a5,4
    80002318:	06f73823          	sd	a5,112(a4)
}
    8000231c:	00813403          	ld	s0,8(sp)
    80002320:	01010113          	addi	sp,sp,16
    80002324:	00008067          	ret

0000000080002328 <_ZN5Riscv29save_ret_val_in_case_of_timerEv>:
void Riscv::save_ret_val_in_case_of_timer() {
    80002328:	fe010113          	addi	sp,sp,-32
    8000232c:	00813c23          	sd	s0,24(sp)
    80002330:	02010413          	addi	s0,sp,32
        __asm__ volatile ("csrr %[value], scause": [value] "=r" (scause));
    80002334:	142027f3          	csrr	a5,scause
    80002338:	fef43023          	sd	a5,-32(s0)
        return scause;
    8000233c:	fe043783          	ld	a5,-32(s0)
    uint64 volatile scause = Riscv::read_scause();
    80002340:	fef43423          	sd	a5,-24(s0)
    if(scause==SCAUSE_TIMER) {
    80002344:	fe843703          	ld	a4,-24(s0)
    80002348:	fff00793          	li	a5,-1
    8000234c:	03f79793          	slli	a5,a5,0x3f
    80002350:	00178793          	addi	a5,a5,1
    80002354:	00f70863          	beq	a4,a5,80002364 <_ZN5Riscv29save_ret_val_in_case_of_timerEv+0x3c>
        TCB::running_thread->context.a0 = TCB::running_thread->context.ret_brefore_timer;
    }
}
    80002358:	01813403          	ld	s0,24(sp)
    8000235c:	02010113          	addi	sp,sp,32
    80002360:	00008067          	ret
        TCB::running_thread->context.a0 = TCB::running_thread->context.ret_brefore_timer;
    80002364:	0000a797          	auipc	a5,0xa
    80002368:	b547b783          	ld	a5,-1196(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000236c:	0007b783          	ld	a5,0(a5)
    80002370:	0787b703          	ld	a4,120(a5)
    80002374:	02e7b823          	sd	a4,48(a5)
}
    80002378:	fe1ff06f          	j	80002358 <_ZN5Riscv29save_ret_val_in_case_of_timerEv+0x30>

000000008000237c <_ZN5Riscv25interrupt_console_handlerEPv>:


void Riscv::interrupt_console_handler(void* param) {
    8000237c:	ff010113          	addi	sp,sp,-16
    80002380:	00113423          	sd	ra,8(sp)
    80002384:	00813023          	sd	s0,0(sp)
    80002388:	01010413          	addi	s0,sp,16
    while(true) {
        console_handler();
    8000238c:	00006097          	auipc	ra,0x6
    80002390:	7e4080e7          	jalr	2020(ra) # 80008b70 <console_handler>
        //Riscv::hardware_interrupt_completed();
        Riscv::interrupt_level--;
    80002394:	0000a717          	auipc	a4,0xa
    80002398:	bb470713          	addi	a4,a4,-1100 # 8000bf48 <_ZN5Riscv15interrupt_levelE>
    8000239c:	00073783          	ld	a5,0(a4)
    800023a0:	fff78793          	addi	a5,a5,-1
    800023a4:	00f73023          	sd	a5,0(a4)
        TCB::running_thread->set_finished(true);
    800023a8:	0000a797          	auipc	a5,0xa
    800023ac:	b107b783          	ld	a5,-1264(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    800023b0:	0007b783          	ld	a5,0(a5)
    bool is_finished() const {
        return finished;
    }

    void set_finished(bool f) {
        this->finished = f;
    800023b4:	00100713          	li	a4,1
    800023b8:	08e78423          	sb	a4,136(a5)
        TCB::yield();
    800023bc:	fffff097          	auipc	ra,0xfffff
    800023c0:	738080e7          	jalr	1848(ra) # 80001af4 <_ZN3TCB5yieldEv>
    while(true) {
    800023c4:	fc9ff06f          	j	8000238c <_ZN5Riscv25interrupt_console_handlerEPv+0x10>

00000000800023c8 <_ZN5Riscv14halt_processorEv>:
        TCB::yield();
    }
    //return return_value;
}

void Riscv::halt_processor() {
    800023c8:	ff010113          	addi	sp,sp,-16
    800023cc:	00813423          	sd	s0,8(sp)
    800023d0:	01010413          	addi	s0,sp,16
    __asm__ volatile ("li t0,1048576");
    800023d4:	001002b7          	lui	t0,0x100
    __asm__ volatile ("li t1,0x5555");
    800023d8:	00005337          	lui	t1,0x5
    800023dc:	5553031b          	addiw	t1,t1,1365
    __asm__ volatile ("sw t1,0(t0)");
    800023e0:	0062a023          	sw	t1,0(t0) # 100000 <_entry-0x7ff00000>
}
    800023e4:	00813403          	ld	s0,8(sp)
    800023e8:	01010113          	addi	sp,sp,16
    800023ec:	00008067          	ret

00000000800023f0 <_ZN5Riscv17interrupt_handlerEPv>:
void Riscv::interrupt_handler(void* param) {
    800023f0:	fa010113          	addi	sp,sp,-96
    800023f4:	04113c23          	sd	ra,88(sp)
    800023f8:	04813823          	sd	s0,80(sp)
    800023fc:	04913423          	sd	s1,72(sp)
    80002400:	06010413          	addi	s0,sp,96
    80002404:	11c0006f          	j	80002520 <_ZN5Riscv17interrupt_handlerEPv+0x130>
        switch (scause) {
    80002408:	00200713          	li	a4,2
    8000240c:	0ee79263          	bne	a5,a4,800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                __putc('I');__putc('l');__putc('l');__putc('e');__putc('g');__putc('a');__putc('l');
    80002410:	04900513          	li	a0,73
    80002414:	00006097          	auipc	ra,0x6
    80002418:	6e8080e7          	jalr	1768(ra) # 80008afc <__putc>
    8000241c:	06c00513          	li	a0,108
    80002420:	00006097          	auipc	ra,0x6
    80002424:	6dc080e7          	jalr	1756(ra) # 80008afc <__putc>
    80002428:	06c00513          	li	a0,108
    8000242c:	00006097          	auipc	ra,0x6
    80002430:	6d0080e7          	jalr	1744(ra) # 80008afc <__putc>
    80002434:	06500513          	li	a0,101
    80002438:	00006097          	auipc	ra,0x6
    8000243c:	6c4080e7          	jalr	1732(ra) # 80008afc <__putc>
    80002440:	06700513          	li	a0,103
    80002444:	00006097          	auipc	ra,0x6
    80002448:	6b8080e7          	jalr	1720(ra) # 80008afc <__putc>
    8000244c:	06100513          	li	a0,97
    80002450:	00006097          	auipc	ra,0x6
    80002454:	6ac080e7          	jalr	1708(ra) # 80008afc <__putc>
    80002458:	06c00513          	li	a0,108
    8000245c:	00006097          	auipc	ra,0x6
    80002460:	6a0080e7          	jalr	1696(ra) # 80008afc <__putc>
                __putc('O');__putc('P');__putc(' ');
    80002464:	04f00513          	li	a0,79
    80002468:	00006097          	auipc	ra,0x6
    8000246c:	694080e7          	jalr	1684(ra) # 80008afc <__putc>
    80002470:	05000513          	li	a0,80
    80002474:	00006097          	auipc	ra,0x6
    80002478:	688080e7          	jalr	1672(ra) # 80008afc <__putc>
    8000247c:	02000513          	li	a0,32
    80002480:	00006097          	auipc	ra,0x6
    80002484:	67c080e7          	jalr	1660(ra) # 80008afc <__putc>
                Riscv::halt_processor();
    80002488:	00000097          	auipc	ra,0x0
    8000248c:	f40080e7          	jalr	-192(ra) # 800023c8 <_ZN5Riscv14halt_processorEv>
                TCB::running_thread->context.a0 = (uint64)TCB::thread_exit();
    80002490:	0000a797          	auipc	a5,0xa
    80002494:	a287b783          	ld	a5,-1496(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002498:	0007b483          	ld	s1,0(a5)
    8000249c:	fffff097          	auipc	ra,0xfffff
    800024a0:	5b0080e7          	jalr	1456(ra) # 80001a4c <_ZN3TCB11thread_exitEv>
    800024a4:	02a4b823          	sd	a0,48(s1)
                break;
    800024a8:	0480006f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
        switch (scause) {
    800024ac:	fff00713          	li	a4,-1
    800024b0:	03f71713          	slli	a4,a4,0x3f
    800024b4:	00170713          	addi	a4,a4,1
    800024b8:	02e78663          	beq	a5,a4,800024e4 <_ZN5Riscv17interrupt_handlerEPv+0xf4>
    800024bc:	fff00713          	li	a4,-1
    800024c0:	03f71713          	slli	a4,a4,0x3f
    800024c4:	00970713          	addi	a4,a4,9
    800024c8:	02e79463          	bne	a5,a4,800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                console_handler();
    800024cc:	00006097          	auipc	ra,0x6
    800024d0:	6a4080e7          	jalr	1700(ra) # 80008b70 <console_handler>

    static void software_interrupt_completed() {
        __asm__ volatile ("csrc sip, %[value]" : : [value] "r" (SIP_SSIP));
    }
    static void hardware_interrupt_completed() {
        __asm__ volatile ("csrc sip, %[value]" : : [value] "r" (SIP_SEIP));
    800024d4:	00009797          	auipc	a5,0x9
    800024d8:	4dc7b783          	ld	a5,1244(a5) # 8000b9b0 <_ZL8SIP_SEIP>
    800024dc:	1447b073          	csrc	sip,a5
    }
    800024e0:	0100006f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
        __asm__ volatile ("csrc sip, %[value]" : : [value] "r" (SIP_SSIP));
    800024e4:	00009797          	auipc	a5,0x9
    800024e8:	4c47b783          	ld	a5,1220(a5) # 8000b9a8 <_ZL8SIP_SSIP>
    800024ec:	1447b073          	csrc	sip,a5
        Riscv::interrupt_level--;
    800024f0:	0000a717          	auipc	a4,0xa
    800024f4:	a5870713          	addi	a4,a4,-1448 # 8000bf48 <_ZN5Riscv15interrupt_levelE>
    800024f8:	00073783          	ld	a5,0(a4)
    800024fc:	fff78793          	addi	a5,a5,-1
    80002500:	00f73023          	sd	a5,0(a4)
        TCB::running_thread->set_finished(true);
    80002504:	0000a797          	auipc	a5,0xa
    80002508:	9b47b783          	ld	a5,-1612(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000250c:	0007b783          	ld	a5,0(a5)
    80002510:	00100713          	li	a4,1
    80002514:	08e78423          	sb	a4,136(a5)
        TCB::yield();
    80002518:	fffff097          	auipc	ra,0xfffff
    8000251c:	5dc080e7          	jalr	1500(ra) # 80001af4 <_ZN3TCB5yieldEv>
        TCB::running_thread->set_finished(false);
    80002520:	0000a797          	auipc	a5,0xa
    80002524:	9987b783          	ld	a5,-1640(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002528:	0007b483          	ld	s1,0(a5)
    8000252c:	08048423          	sb	zero,136(s1)
        __asm__ volatile ("csrr %[value], scause": [value] "=r" (scause));
    80002530:	142027f3          	csrr	a5,scause
    80002534:	fcf43c23          	sd	a5,-40(s0)
        return scause;
    80002538:	fd843783          	ld	a5,-40(s0)
        uint64 volatile scause = Riscv::read_scause();
    8000253c:	faf43423          	sd	a5,-88(s0)
        uint64 volatile syscall_num = TCB::running_thread->context.a0;
    80002540:	0304b783          	ld	a5,48(s1)
    80002544:	faf43823          	sd	a5,-80(s0)
        uint64 volatile arg1 = TCB::running_thread->context.a1;
    80002548:	0384b783          	ld	a5,56(s1)
    8000254c:	faf43c23          	sd	a5,-72(s0)
        uint64 volatile arg2 = TCB::running_thread->context.a2;
    80002550:	0404b783          	ld	a5,64(s1)
    80002554:	fcf43023          	sd	a5,-64(s0)
        uint64 volatile arg3 = TCB::running_thread->context.a3;
    80002558:	0484b783          	ld	a5,72(s1)
    8000255c:	fcf43423          	sd	a5,-56(s0)
        uint64 volatile arg4 = TCB::running_thread->context.a4;
    80002560:	0504b783          	ld	a5,80(s1)
    80002564:	fcf43823          	sd	a5,-48(s0)
        switch (scause) {
    80002568:	fa843783          	ld	a5,-88(s0)
    8000256c:	00900713          	li	a4,9
    80002570:	f2f76ee3          	bltu	a4,a5,800024ac <_ZN5Riscv17interrupt_handlerEPv+0xbc>
    80002574:	00800713          	li	a4,8
    80002578:	14e7f663          	bgeu	a5,a4,800026c4 <_ZN5Riscv17interrupt_handlerEPv+0x2d4>
    8000257c:	00500713          	li	a4,5
    80002580:	0ae78463          	beq	a5,a4,80002628 <_ZN5Riscv17interrupt_handlerEPv+0x238>
    80002584:	00700713          	li	a4,7
    80002588:	e8e790e3          	bne	a5,a4,80002408 <_ZN5Riscv17interrupt_handlerEPv+0x18>
                __putc('I');__putc('l');__putc('l');__putc('e');__putc('g');__putc('a');__putc('l');
    8000258c:	04900513          	li	a0,73
    80002590:	00006097          	auipc	ra,0x6
    80002594:	56c080e7          	jalr	1388(ra) # 80008afc <__putc>
    80002598:	06c00513          	li	a0,108
    8000259c:	00006097          	auipc	ra,0x6
    800025a0:	560080e7          	jalr	1376(ra) # 80008afc <__putc>
    800025a4:	06c00513          	li	a0,108
    800025a8:	00006097          	auipc	ra,0x6
    800025ac:	554080e7          	jalr	1364(ra) # 80008afc <__putc>
    800025b0:	06500513          	li	a0,101
    800025b4:	00006097          	auipc	ra,0x6
    800025b8:	548080e7          	jalr	1352(ra) # 80008afc <__putc>
    800025bc:	06700513          	li	a0,103
    800025c0:	00006097          	auipc	ra,0x6
    800025c4:	53c080e7          	jalr	1340(ra) # 80008afc <__putc>
    800025c8:	06100513          	li	a0,97
    800025cc:	00006097          	auipc	ra,0x6
    800025d0:	530080e7          	jalr	1328(ra) # 80008afc <__putc>
    800025d4:	06c00513          	li	a0,108
    800025d8:	00006097          	auipc	ra,0x6
    800025dc:	524080e7          	jalr	1316(ra) # 80008afc <__putc>
                __putc('A');__putc('W');__putc(' ');
    800025e0:	04100513          	li	a0,65
    800025e4:	00006097          	auipc	ra,0x6
    800025e8:	518080e7          	jalr	1304(ra) # 80008afc <__putc>
    800025ec:	05700513          	li	a0,87
    800025f0:	00006097          	auipc	ra,0x6
    800025f4:	50c080e7          	jalr	1292(ra) # 80008afc <__putc>
    800025f8:	02000513          	li	a0,32
    800025fc:	00006097          	auipc	ra,0x6
    80002600:	500080e7          	jalr	1280(ra) # 80008afc <__putc>
                Riscv::halt_processor();
    80002604:	00000097          	auipc	ra,0x0
    80002608:	dc4080e7          	jalr	-572(ra) # 800023c8 <_ZN5Riscv14halt_processorEv>
                TCB::running_thread->context.a0 = (uint64)TCB::thread_exit();
    8000260c:	0000a797          	auipc	a5,0xa
    80002610:	8ac7b783          	ld	a5,-1876(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002614:	0007b483          	ld	s1,0(a5)
    80002618:	fffff097          	auipc	ra,0xfffff
    8000261c:	434080e7          	jalr	1076(ra) # 80001a4c <_ZN3TCB11thread_exitEv>
    80002620:	02a4b823          	sd	a0,48(s1)
                break;
    80002624:	ecdff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                __putc('I');__putc('l');__putc('l');__putc('e');__putc('g');__putc('a');__putc('l');
    80002628:	04900513          	li	a0,73
    8000262c:	00006097          	auipc	ra,0x6
    80002630:	4d0080e7          	jalr	1232(ra) # 80008afc <__putc>
    80002634:	06c00513          	li	a0,108
    80002638:	00006097          	auipc	ra,0x6
    8000263c:	4c4080e7          	jalr	1220(ra) # 80008afc <__putc>
    80002640:	06c00513          	li	a0,108
    80002644:	00006097          	auipc	ra,0x6
    80002648:	4b8080e7          	jalr	1208(ra) # 80008afc <__putc>
    8000264c:	06500513          	li	a0,101
    80002650:	00006097          	auipc	ra,0x6
    80002654:	4ac080e7          	jalr	1196(ra) # 80008afc <__putc>
    80002658:	06700513          	li	a0,103
    8000265c:	00006097          	auipc	ra,0x6
    80002660:	4a0080e7          	jalr	1184(ra) # 80008afc <__putc>
    80002664:	06100513          	li	a0,97
    80002668:	00006097          	auipc	ra,0x6
    8000266c:	494080e7          	jalr	1172(ra) # 80008afc <__putc>
    80002670:	06c00513          	li	a0,108
    80002674:	00006097          	auipc	ra,0x6
    80002678:	488080e7          	jalr	1160(ra) # 80008afc <__putc>
                __putc('A');__putc('R');__putc(' ');
    8000267c:	04100513          	li	a0,65
    80002680:	00006097          	auipc	ra,0x6
    80002684:	47c080e7          	jalr	1148(ra) # 80008afc <__putc>
    80002688:	05200513          	li	a0,82
    8000268c:	00006097          	auipc	ra,0x6
    80002690:	470080e7          	jalr	1136(ra) # 80008afc <__putc>
    80002694:	02000513          	li	a0,32
    80002698:	00006097          	auipc	ra,0x6
    8000269c:	464080e7          	jalr	1124(ra) # 80008afc <__putc>
                Riscv::halt_processor();
    800026a0:	00000097          	auipc	ra,0x0
    800026a4:	d28080e7          	jalr	-728(ra) # 800023c8 <_ZN5Riscv14halt_processorEv>
                TCB::running_thread->context.a0 = (uint64)TCB::thread_exit();
    800026a8:	0000a797          	auipc	a5,0xa
    800026ac:	8107b783          	ld	a5,-2032(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    800026b0:	0007b483          	ld	s1,0(a5)
    800026b4:	fffff097          	auipc	ra,0xfffff
    800026b8:	398080e7          	jalr	920(ra) # 80001a4c <_ZN3TCB11thread_exitEv>
    800026bc:	02a4b823          	sd	a0,48(s1)
                break;
    800026c0:	e31ff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                switch (syscall_num) {
    800026c4:	fb043783          	ld	a5,-80(s0)
    800026c8:	04200713          	li	a4,66
    800026cc:	16f76863          	bltu	a4,a5,8000283c <_ZN5Riscv17interrupt_handlerEPv+0x44c>
    800026d0:	00279793          	slli	a5,a5,0x2
    800026d4:	00007717          	auipc	a4,0x7
    800026d8:	94c70713          	addi	a4,a4,-1716 # 80009020 <CONSOLE_STATUS+0x10>
    800026dc:	00e787b3          	add	a5,a5,a4
    800026e0:	0007a783          	lw	a5,0(a5)
    800026e4:	00e787b3          	add	a5,a5,a4
    800026e8:	00078067          	jr	a5
                        TCB::thread_dispatch();
    800026ec:	fffff097          	auipc	ra,0xfffff
    800026f0:	314080e7          	jalr	788(ra) # 80001a00 <_ZN3TCB15thread_dispatchEv>
                        break;
    800026f4:	dfdff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                        TCB::running_thread->context.a0 = (uint64)TCB::thread_create((TCB::thread_t*)arg1,(Body)arg2,(void*)arg3,(void*)arg4);
    800026f8:	fb843503          	ld	a0,-72(s0)
    800026fc:	fc043583          	ld	a1,-64(s0)
    80002700:	fc843603          	ld	a2,-56(s0)
    80002704:	fd043683          	ld	a3,-48(s0)
    80002708:	fffff097          	auipc	ra,0xfffff
    8000270c:	540080e7          	jalr	1344(ra) # 80001c48 <_ZN3TCB13thread_createEPPS_PFvPvES2_S2_>
    80002710:	02a4b823          	sd	a0,48(s1)
                        break;
    80002714:	dddff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                        TCB::running_thread->context.a0 = (uint64)TCB::thread_exit();
    80002718:	fffff097          	auipc	ra,0xfffff
    8000271c:	334080e7          	jalr	820(ra) # 80001a4c <_ZN3TCB11thread_exitEv>
    80002720:	02a4b823          	sd	a0,48(s1)
                        break;
    80002724:	dcdff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                        TCB::running_thread->context.a0 = (uint64)Memory::mem_alloc((uint64)arg1);
    80002728:	fb843503          	ld	a0,-72(s0)
    8000272c:	00001097          	auipc	ra,0x1
    80002730:	b74080e7          	jalr	-1164(ra) # 800032a0 <_ZN6Memory9mem_allocEm>
    80002734:	00009797          	auipc	a5,0x9
    80002738:	7847b783          	ld	a5,1924(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000273c:	0007b783          	ld	a5,0(a5)
    80002740:	02a7b823          	sd	a0,48(a5)
                        break;
    80002744:	dadff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                        TCB::running_thread->context.a0 = (uint64)Memory::mem_free((void*)arg1);
    80002748:	fb843503          	ld	a0,-72(s0)
    8000274c:	00001097          	auipc	ra,0x1
    80002750:	bd8080e7          	jalr	-1064(ra) # 80003324 <_ZN6Memory8mem_freeEPv>
    80002754:	00009797          	auipc	a5,0x9
    80002758:	7647b783          	ld	a5,1892(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000275c:	0007b783          	ld	a5,0(a5)
    80002760:	02a7b823          	sd	a0,48(a5)
                        break;
    80002764:	d8dff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                        TCB::running_thread->context.a0 = Sem::sem_open((Sem::sem_t*)arg1,(uint64)arg2);
    80002768:	fb843503          	ld	a0,-72(s0)
    8000276c:	fc043583          	ld	a1,-64(s0)
    80002770:	00000097          	auipc	ra,0x0
    80002774:	334080e7          	jalr	820(ra) # 80002aa4 <_ZN3Sem8sem_openEPPS_m>
    80002778:	02a4b823          	sd	a0,48(s1)
                        break;
    8000277c:	d75ff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                        TCB::running_thread->context.a0 = Sem::sem_close((Sem::sem_t)arg1);
    80002780:	fb843503          	ld	a0,-72(s0)
    80002784:	00000097          	auipc	ra,0x0
    80002788:	164080e7          	jalr	356(ra) # 800028e8 <_ZN3Sem9sem_closeEPS_>
    8000278c:	02a4b823          	sd	a0,48(s1)
                        break;;
    80002790:	d61ff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                        TCB::running_thread->context.a0 = Sem::sem_wait((Sem::sem_t)arg1);
    80002794:	fb843503          	ld	a0,-72(s0)
    80002798:	00000097          	auipc	ra,0x0
    8000279c:	4cc080e7          	jalr	1228(ra) # 80002c64 <_ZN3Sem8sem_waitEPS_>
    800027a0:	02a4b823          	sd	a0,48(s1)
                        break;
    800027a4:	d4dff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                        TCB::running_thread->context.a0 = Sem::sem_signal((Sem::sem_t)arg1);
    800027a8:	fb843503          	ld	a0,-72(s0)
    800027ac:	00000097          	auipc	ra,0x0
    800027b0:	178080e7          	jalr	376(ra) # 80002924 <_ZN3Sem10sem_signalEPS_>
    800027b4:	02a4b823          	sd	a0,48(s1)
                        break;
    800027b8:	d39ff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                        TCB::running_thread->context.a0 = Sem::sem_trywait((Sem::sem_t)arg1);
    800027bc:	fb843503          	ld	a0,-72(s0)
    800027c0:	00000097          	auipc	ra,0x0
    800027c4:	230080e7          	jalr	560(ra) # 800029f0 <_ZN3Sem11sem_trywaitEPS_>
    800027c8:	02a4b823          	sd	a0,48(s1)
                        break;
    800027cc:	d25ff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                        TCB::running_thread->context.a0 = TCB::thread_sleep((time_t)arg1);
    800027d0:	fb843503          	ld	a0,-72(s0)
    800027d4:	fffff097          	auipc	ra,0xfffff
    800027d8:	2cc080e7          	jalr	716(ra) # 80001aa0 <_ZN3TCB12thread_sleepEm>
    800027dc:	02a4b823          	sd	a0,48(s1)
                        break;
    800027e0:	d11ff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
    }
    static void software_interrupt_disable() {
        __asm__ volatile ("csrc sie, %[value]" : : [value] "r" (SIE_SSIE));
    }
    static void hardware_interrupt_enable() {
        __asm__ volatile ("csrs sie, %[value]" : : [value] "r" (SIE_SEIE));
    800027e4:	00009797          	auipc	a5,0x9
    800027e8:	1c478793          	addi	a5,a5,452 # 8000b9a8 <_ZL8SIP_SSIP>
    800027ec:	0107b703          	ld	a4,16(a5)
    800027f0:	10472073          	csrs	sie,a4
        __asm__ volatile ("csrc sie, %[value]" : : [value] "r" (SIE_SSIE));
    800027f4:	0187b783          	ld	a5,24(a5)
    800027f8:	1047b073          	csrc	sie,a5
                        TCB::running_thread->context.a0 = (uint64)__getc();
    800027fc:	00006097          	auipc	ra,0x6
    80002800:	33c080e7          	jalr	828(ra) # 80008b38 <__getc>
    80002804:	00009797          	auipc	a5,0x9
    80002808:	6b47b783          	ld	a5,1716(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    8000280c:	0007b783          	ld	a5,0(a5)
    80002810:	02a7b823          	sd	a0,48(a5)
                        TCB::previous_running_thread->context.ret_brefore_timer = TCB::running_thread->context.a0;
    80002814:	00009797          	auipc	a5,0x9
    80002818:	69c7b783          	ld	a5,1692(a5) # 8000beb0 <_GLOBAL_OFFSET_TABLE_+0x30>
    8000281c:	0007b783          	ld	a5,0(a5)
    80002820:	06a7bc23          	sd	a0,120(a5)
                        break;
    80002824:	ccdff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                        __putc((char)arg1);
    80002828:	fb843503          	ld	a0,-72(s0)
    8000282c:	0ff57513          	andi	a0,a0,255
    80002830:	00006097          	auipc	ra,0x6
    80002834:	2cc080e7          	jalr	716(ra) # 80008afc <__putc>
                        break;
    80002838:	cb9ff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>
                        TCB::running_thread->context.a0 = -5;
    8000283c:	ffb00793          	li	a5,-5
    80002840:	02f4b823          	sd	a5,48(s1)
                        break;
    80002844:	cadff06f          	j	800024f0 <_ZN5Riscv17interrupt_handlerEPv+0x100>

0000000080002848 <_ZN3SemD1Ev>:
}
void Sem::operator delete[](void* addr){
    Memory::mem_free(addr);
    // __mem_free(addr);
}
Sem::~Sem() {
    80002848:	fd010113          	addi	sp,sp,-48
    8000284c:	02113423          	sd	ra,40(sp)
    80002850:	02813023          	sd	s0,32(sp)
    80002854:	00913c23          	sd	s1,24(sp)
    80002858:	01213823          	sd	s2,16(sp)
    8000285c:	01313423          	sd	s3,8(sp)
    80002860:	03010413          	addi	s0,sp,48
    80002864:	00050493          	mv	s1,a0
    80002868:	00009797          	auipc	a5,0x9
    8000286c:	1c078793          	addi	a5,a5,448 # 8000ba28 <_ZTV3Sem+0x10>
    80002870:	00f53023          	sd	a5,0(a0)
    80002874:	02c0006f          	j	800028a0 <_ZN3SemD1Ev+0x58>
    {
        if (!head) { return nullptr; }

        Elem *elem = head;
        head = head->next;
        if (!head) { tail = 0; }
    80002878:	00093423          	sd	zero,8(s2)

        T *ret = elem->data;
    8000287c:	00053983          	ld	s3,0(a0)
            Memory::mem_free(addr);
    80002880:	00001097          	auipc	ra,0x1
    80002884:	aa4080e7          	jalr	-1372(ra) # 80003324 <_ZN6Memory8mem_freeEPv>
        delete elem;
        size--;
    80002888:	01093783          	ld	a5,16(s2)
    8000288c:	fff78793          	addi	a5,a5,-1
    80002890:	00f93823          	sd	a5,16(s2)
    while (blocked_queue.is_empty()==false) {
            Scheduler::put_thread(blocked_queue.removeFirst());
    80002894:	00098513          	mv	a0,s3
    80002898:	00000097          	auipc	ra,0x0
    8000289c:	6e0080e7          	jalr	1760(ra) # 80002f78 <_ZN9Scheduler10put_threadEP3TCB>
    {
        if (!tail) { return nullptr; }
        return tail->data;
    }
    bool is_empty() {
        if(!head)return true;
    800028a0:	0104b783          	ld	a5,16(s1)
    800028a4:	02078463          	beqz	a5,800028cc <_ZN3SemD1Ev+0x84>
    800028a8:	01048913          	addi	s2,s1,16
        if (!head) { return nullptr; }
    800028ac:	00078513          	mv	a0,a5
    800028b0:	00078a63          	beqz	a5,800028c4 <_ZN3SemD1Ev+0x7c>
        head = head->next;
    800028b4:	0087b783          	ld	a5,8(a5)
    800028b8:	00f4b823          	sd	a5,16(s1)
        if (!head) { tail = 0; }
    800028bc:	fc0790e3          	bnez	a5,8000287c <_ZN3SemD1Ev+0x34>
    800028c0:	fb9ff06f          	j	80002878 <_ZN3SemD1Ev+0x30>
        if (!head) { return nullptr; }
    800028c4:	00078993          	mv	s3,a5
    800028c8:	fcdff06f          	j	80002894 <_ZN3SemD1Ev+0x4c>
    }
}
    800028cc:	02813083          	ld	ra,40(sp)
    800028d0:	02013403          	ld	s0,32(sp)
    800028d4:	01813483          	ld	s1,24(sp)
    800028d8:	01013903          	ld	s2,16(sp)
    800028dc:	00813983          	ld	s3,8(sp)
    800028e0:	03010113          	addi	sp,sp,48
    800028e4:	00008067          	ret

00000000800028e8 <_ZN3Sem9sem_closeEPS_>:
    if(handle!=nullptr) {
    800028e8:	02050a63          	beqz	a0,8000291c <_ZN3Sem9sem_closeEPS_+0x34>
uint64 Sem::sem_close(sem_t handle) {
    800028ec:	ff010113          	addi	sp,sp,-16
    800028f0:	00113423          	sd	ra,8(sp)
    800028f4:	00813023          	sd	s0,0(sp)
    800028f8:	01010413          	addi	s0,sp,16
        delete handle;
    800028fc:	00053783          	ld	a5,0(a0)
    80002900:	0087b783          	ld	a5,8(a5)
    80002904:	000780e7          	jalr	a5
        return 0;
    80002908:	00000513          	li	a0,0
}
    8000290c:	00813083          	ld	ra,8(sp)
    80002910:	00013403          	ld	s0,0(sp)
    80002914:	01010113          	addi	sp,sp,16
    80002918:	00008067          	ret
    return -1;
    8000291c:	fff00513          	li	a0,-1
}
    80002920:	00008067          	ret

0000000080002924 <_ZN3Sem10sem_signalEPS_>:
    if(handle!=nullptr) {
    80002924:	0a050463          	beqz	a0,800029cc <_ZN3Sem10sem_signalEPS_+0xa8>
        handle->sem_value = handle->sem_value + 1;
    80002928:	00852783          	lw	a5,8(a0)
    8000292c:	0017879b          	addiw	a5,a5,1
    80002930:	0007871b          	sext.w	a4,a5
    80002934:	00f52423          	sw	a5,8(a0)
        if(handle->sem_value<=0) {
    80002938:	00e05663          	blez	a4,80002944 <_ZN3Sem10sem_signalEPS_+0x20>
        return 0;
    8000293c:	00000513          	li	a0,0
}
    80002940:	00008067          	ret
        if(!head)return true;
    80002944:	01053783          	ld	a5,16(a0)
    80002948:	fe078ae3          	beqz	a5,8000293c <_ZN3Sem10sem_signalEPS_+0x18>
uint64 Sem::sem_signal(sem_t handle) {
    8000294c:	fe010113          	addi	sp,sp,-32
    80002950:	00113c23          	sd	ra,24(sp)
    80002954:	00813823          	sd	s0,16(sp)
    80002958:	00913423          	sd	s1,8(sp)
    8000295c:	01213023          	sd	s2,0(sp)
    80002960:	02010413          	addi	s0,sp,32
                Scheduler::put_thread(handle->blocked_queue.removeFirst());
    80002964:	01050493          	addi	s1,a0,16
        if (!head) { return nullptr; }
    80002968:	04078e63          	beqz	a5,800029c4 <_ZN3Sem10sem_signalEPS_+0xa0>
        head = head->next;
    8000296c:	0087b703          	ld	a4,8(a5)
    80002970:	00e53823          	sd	a4,16(a0)
        if (!head) { tail = 0; }
    80002974:	04070463          	beqz	a4,800029bc <_ZN3Sem10sem_signalEPS_+0x98>
        T *ret = elem->data;
    80002978:	0007b903          	ld	s2,0(a5)
            Memory::mem_free(addr);
    8000297c:	00078513          	mv	a0,a5
    80002980:	00001097          	auipc	ra,0x1
    80002984:	9a4080e7          	jalr	-1628(ra) # 80003324 <_ZN6Memory8mem_freeEPv>
        size--;
    80002988:	0104b783          	ld	a5,16(s1)
    8000298c:	fff78793          	addi	a5,a5,-1
    80002990:	00f4b823          	sd	a5,16(s1)
    80002994:	00090513          	mv	a0,s2
    80002998:	00000097          	auipc	ra,0x0
    8000299c:	5e0080e7          	jalr	1504(ra) # 80002f78 <_ZN9Scheduler10put_threadEP3TCB>
        return 0;
    800029a0:	00000513          	li	a0,0
}
    800029a4:	01813083          	ld	ra,24(sp)
    800029a8:	01013403          	ld	s0,16(sp)
    800029ac:	00813483          	ld	s1,8(sp)
    800029b0:	00013903          	ld	s2,0(sp)
    800029b4:	02010113          	addi	sp,sp,32
    800029b8:	00008067          	ret
        if (!head) { tail = 0; }
    800029bc:	0004b423          	sd	zero,8(s1)
    800029c0:	fb9ff06f          	j	80002978 <_ZN3Sem10sem_signalEPS_+0x54>
        if (!head) { return nullptr; }
    800029c4:	00078913          	mv	s2,a5
    800029c8:	fcdff06f          	j	80002994 <_ZN3Sem10sem_signalEPS_+0x70>
    }return -1;
    800029cc:	fff00513          	li	a0,-1
    800029d0:	00008067          	ret

00000000800029d4 <_ZN3Sem13sem_timedwaitEPS_m>:
uint64 Sem::sem_timedwait(sem_t handle, time_t timeout) {
    800029d4:	ff010113          	addi	sp,sp,-16
    800029d8:	00813423          	sd	s0,8(sp)
    800029dc:	01010413          	addi	s0,sp,16
}
    800029e0:	00000513          	li	a0,0
    800029e4:	00813403          	ld	s0,8(sp)
    800029e8:	01010113          	addi	sp,sp,16
    800029ec:	00008067          	ret

00000000800029f0 <_ZN3Sem11sem_trywaitEPS_>:
uint64 Sem::sem_trywait(sem_t handle) {
    800029f0:	ff010113          	addi	sp,sp,-16
    800029f4:	00813423          	sd	s0,8(sp)
    800029f8:	01010413          	addi	s0,sp,16
    if(handle!=nullptr) {
    800029fc:	02050263          	beqz	a0,80002a20 <_ZN3Sem11sem_trywaitEPS_+0x30>
        if(handle->sem_value>=1) {
    80002a00:	00852783          	lw	a5,8(a0)
    80002a04:	02f05263          	blez	a5,80002a28 <_ZN3Sem11sem_trywaitEPS_+0x38>
            --handle->sem_value;
    80002a08:	fff7879b          	addiw	a5,a5,-1
    80002a0c:	00f52423          	sw	a5,8(a0)
            return 0;
    80002a10:	00000513          	li	a0,0
}
    80002a14:	00813403          	ld	s0,8(sp)
    80002a18:	01010113          	addi	sp,sp,16
    80002a1c:	00008067          	ret
    return -1;
    80002a20:	fff00513          	li	a0,-1
    80002a24:	ff1ff06f          	j	80002a14 <_ZN3Sem11sem_trywaitEPS_+0x24>
        return 1;
    80002a28:	00100513          	li	a0,1
    80002a2c:	fe9ff06f          	j	80002a14 <_ZN3Sem11sem_trywaitEPS_+0x24>

0000000080002a30 <_ZN3SemC1Em>:
Sem::Sem(uint64 init=1) {
    80002a30:	ff010113          	addi	sp,sp,-16
    80002a34:	00813423          	sd	s0,8(sp)
    80002a38:	01010413          	addi	s0,sp,16
    80002a3c:	00009797          	auipc	a5,0x9
    80002a40:	fec78793          	addi	a5,a5,-20 # 8000ba28 <_ZTV3Sem+0x10>
    80002a44:	00f53023          	sd	a5,0(a0)
    List() : head(nullptr), tail(nullptr) ,size(0){}
    80002a48:	00053823          	sd	zero,16(a0)
    80002a4c:	00053c23          	sd	zero,24(a0)
    80002a50:	02053023          	sd	zero,32(a0)
    this->sem_value = init;
    80002a54:	00b52423          	sw	a1,8(a0)
}
    80002a58:	00813403          	ld	s0,8(sp)
    80002a5c:	01010113          	addi	sp,sp,16
    80002a60:	00008067          	ret

0000000080002a64 <_ZN3SemnwEm>:
void* Sem::operator new(size_t n){
    80002a64:	ff010113          	addi	sp,sp,-16
    80002a68:	00113423          	sd	ra,8(sp)
    80002a6c:	00813023          	sd	s0,0(sp)
    80002a70:	01010413          	addi	s0,sp,16
    return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    80002a74:	03f57793          	andi	a5,a0,63
    80002a78:	02079063          	bnez	a5,80002a98 <_ZN3SemnwEm+0x34>
    80002a7c:	00655513          	srli	a0,a0,0x6
    80002a80:	00001097          	auipc	ra,0x1
    80002a84:	820080e7          	jalr	-2016(ra) # 800032a0 <_ZN6Memory9mem_allocEm>
}
    80002a88:	00813083          	ld	ra,8(sp)
    80002a8c:	00013403          	ld	s0,0(sp)
    80002a90:	01010113          	addi	sp,sp,16
    80002a94:	00008067          	ret
    return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    80002a98:	00655513          	srli	a0,a0,0x6
    80002a9c:	00150513          	addi	a0,a0,1
    80002aa0:	fe1ff06f          	j	80002a80 <_ZN3SemnwEm+0x1c>

0000000080002aa4 <_ZN3Sem8sem_openEPPS_m>:
uint64 Sem::sem_open(sem_t* handle,uint64 init){
    80002aa4:	fd010113          	addi	sp,sp,-48
    80002aa8:	02113423          	sd	ra,40(sp)
    80002aac:	02813023          	sd	s0,32(sp)
    80002ab0:	00913c23          	sd	s1,24(sp)
    80002ab4:	01213823          	sd	s2,16(sp)
    80002ab8:	01313423          	sd	s3,8(sp)
    80002abc:	03010413          	addi	s0,sp,48
    80002ac0:	00050913          	mv	s2,a0
    80002ac4:	00058993          	mv	s3,a1
    *handle = new Sem(init);
    80002ac8:	02800513          	li	a0,40
    80002acc:	00000097          	auipc	ra,0x0
    80002ad0:	f98080e7          	jalr	-104(ra) # 80002a64 <_ZN3SemnwEm>
    80002ad4:	00050493          	mv	s1,a0
    80002ad8:	00098593          	mv	a1,s3
    80002adc:	00000097          	auipc	ra,0x0
    80002ae0:	f54080e7          	jalr	-172(ra) # 80002a30 <_ZN3SemC1Em>
    80002ae4:	00993023          	sd	s1,0(s2)
    if(*handle==nullptr) return -1;
    80002ae8:	02048263          	beqz	s1,80002b0c <_ZN3Sem8sem_openEPPS_m+0x68>
    return 0;
    80002aec:	00000513          	li	a0,0
}
    80002af0:	02813083          	ld	ra,40(sp)
    80002af4:	02013403          	ld	s0,32(sp)
    80002af8:	01813483          	ld	s1,24(sp)
    80002afc:	01013903          	ld	s2,16(sp)
    80002b00:	00813983          	ld	s3,8(sp)
    80002b04:	03010113          	addi	sp,sp,48
    80002b08:	00008067          	ret
    if(*handle==nullptr) return -1;
    80002b0c:	fff00513          	li	a0,-1
    80002b10:	fe1ff06f          	j	80002af0 <_ZN3Sem8sem_openEPPS_m+0x4c>

0000000080002b14 <_ZN3SemnaEm>:
void* Sem::operator new[](size_t n){
    80002b14:	ff010113          	addi	sp,sp,-16
    80002b18:	00113423          	sd	ra,8(sp)
    80002b1c:	00813023          	sd	s0,0(sp)
    80002b20:	01010413          	addi	s0,sp,16
    return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    80002b24:	03f57793          	andi	a5,a0,63
    80002b28:	02079063          	bnez	a5,80002b48 <_ZN3SemnaEm+0x34>
    80002b2c:	00655513          	srli	a0,a0,0x6
    80002b30:	00000097          	auipc	ra,0x0
    80002b34:	770080e7          	jalr	1904(ra) # 800032a0 <_ZN6Memory9mem_allocEm>
}
    80002b38:	00813083          	ld	ra,8(sp)
    80002b3c:	00013403          	ld	s0,0(sp)
    80002b40:	01010113          	addi	sp,sp,16
    80002b44:	00008067          	ret
    return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    80002b48:	00655513          	srli	a0,a0,0x6
    80002b4c:	00150513          	addi	a0,a0,1
    80002b50:	fe1ff06f          	j	80002b30 <_ZN3SemnaEm+0x1c>

0000000080002b54 <_ZN3SemdlEPv>:
void Sem::operator delete(void* addr){
    80002b54:	ff010113          	addi	sp,sp,-16
    80002b58:	00113423          	sd	ra,8(sp)
    80002b5c:	00813023          	sd	s0,0(sp)
    80002b60:	01010413          	addi	s0,sp,16
    Memory::mem_free(addr);
    80002b64:	00000097          	auipc	ra,0x0
    80002b68:	7c0080e7          	jalr	1984(ra) # 80003324 <_ZN6Memory8mem_freeEPv>
}
    80002b6c:	00813083          	ld	ra,8(sp)
    80002b70:	00013403          	ld	s0,0(sp)
    80002b74:	01010113          	addi	sp,sp,16
    80002b78:	00008067          	ret

0000000080002b7c <_ZN3SemD0Ev>:
Sem::~Sem() {
    80002b7c:	fe010113          	addi	sp,sp,-32
    80002b80:	00113c23          	sd	ra,24(sp)
    80002b84:	00813823          	sd	s0,16(sp)
    80002b88:	00913423          	sd	s1,8(sp)
    80002b8c:	02010413          	addi	s0,sp,32
    80002b90:	00050493          	mv	s1,a0
}
    80002b94:	00000097          	auipc	ra,0x0
    80002b98:	cb4080e7          	jalr	-844(ra) # 80002848 <_ZN3SemD1Ev>
    80002b9c:	00048513          	mv	a0,s1
    80002ba0:	00000097          	auipc	ra,0x0
    80002ba4:	fb4080e7          	jalr	-76(ra) # 80002b54 <_ZN3SemdlEPv>
    80002ba8:	01813083          	ld	ra,24(sp)
    80002bac:	01013403          	ld	s0,16(sp)
    80002bb0:	00813483          	ld	s1,8(sp)
    80002bb4:	02010113          	addi	sp,sp,32
    80002bb8:	00008067          	ret

0000000080002bbc <_ZN3SemdaEPv>:
void Sem::operator delete[](void* addr){
    80002bbc:	ff010113          	addi	sp,sp,-16
    80002bc0:	00113423          	sd	ra,8(sp)
    80002bc4:	00813023          	sd	s0,0(sp)
    80002bc8:	01010413          	addi	s0,sp,16
    Memory::mem_free(addr);
    80002bcc:	00000097          	auipc	ra,0x0
    80002bd0:	758080e7          	jalr	1880(ra) # 80003324 <_ZN6Memory8mem_freeEPv>
}
    80002bd4:	00813083          	ld	ra,8(sp)
    80002bd8:	00013403          	ld	s0,0(sp)
    80002bdc:	01010113          	addi	sp,sp,16
    80002be0:	00008067          	ret

0000000080002be4 <_ZN3Sem5blockEP3TCB>:

void Sem::block(TCB *thread) {
    80002be4:	fd010113          	addi	sp,sp,-48
    80002be8:	02113423          	sd	ra,40(sp)
    80002bec:	02813023          	sd	s0,32(sp)
    80002bf0:	00913c23          	sd	s1,24(sp)
    80002bf4:	01213823          	sd	s2,16(sp)
    80002bf8:	01313423          	sd	s3,8(sp)
    80002bfc:	03010413          	addi	s0,sp,48
    80002c00:	00050913          	mv	s2,a0
    80002c04:	00058993          	mv	s3,a1
    this->blocked_queue.addLast(thread);
    80002c08:	01050493          	addi	s1,a0,16
            return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    80002c0c:	00100513          	li	a0,1
    80002c10:	00000097          	auipc	ra,0x0
    80002c14:	690080e7          	jalr	1680(ra) # 800032a0 <_ZN6Memory9mem_allocEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80002c18:	01353023          	sd	s3,0(a0)
    80002c1c:	00053423          	sd	zero,8(a0)
        if (tail)
    80002c20:	0084b783          	ld	a5,8(s1)
    80002c24:	02078a63          	beqz	a5,80002c58 <_ZN3Sem5blockEP3TCB+0x74>
            tail->next = elem;
    80002c28:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80002c2c:	00a4b423          	sd	a0,8(s1)
        size++;
    80002c30:	0104b783          	ld	a5,16(s1)
    80002c34:	00178793          	addi	a5,a5,1
    80002c38:	00f4b823          	sd	a5,16(s1)
}
    80002c3c:	02813083          	ld	ra,40(sp)
    80002c40:	02013403          	ld	s0,32(sp)
    80002c44:	01813483          	ld	s1,24(sp)
    80002c48:	01013903          	ld	s2,16(sp)
    80002c4c:	00813983          	ld	s3,8(sp)
    80002c50:	03010113          	addi	sp,sp,48
    80002c54:	00008067          	ret
            head = tail = elem;
    80002c58:	00a4b423          	sd	a0,8(s1)
    80002c5c:	00a93823          	sd	a0,16(s2)
    80002c60:	fd1ff06f          	j	80002c30 <_ZN3Sem5blockEP3TCB+0x4c>

0000000080002c64 <_ZN3Sem8sem_waitEPS_>:
    if(handle!=nullptr) {
    80002c64:	06050663          	beqz	a0,80002cd0 <_ZN3Sem8sem_waitEPS_+0x6c>
        if(--(handle->sem_value)<0) {
    80002c68:	00852783          	lw	a5,8(a0)
    80002c6c:	fff7879b          	addiw	a5,a5,-1
    80002c70:	00f52423          	sw	a5,8(a0)
    80002c74:	02079713          	slli	a4,a5,0x20
    80002c78:	00074663          	bltz	a4,80002c84 <_ZN3Sem8sem_waitEPS_+0x20>
        return 0;
    80002c7c:	00000513          	li	a0,0
}
    80002c80:	00008067          	ret
uint64 Sem::sem_wait(sem_t handle) {
    80002c84:	fe010113          	addi	sp,sp,-32
    80002c88:	00113c23          	sd	ra,24(sp)
    80002c8c:	00813823          	sd	s0,16(sp)
    80002c90:	00913423          	sd	s1,8(sp)
    80002c94:	02010413          	addi	s0,sp,32
            handle->block(TCB::previous_running_thread);
    80002c98:	00009497          	auipc	s1,0x9
    80002c9c:	2184b483          	ld	s1,536(s1) # 8000beb0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002ca0:	0004b583          	ld	a1,0(s1)
    80002ca4:	00000097          	auipc	ra,0x0
    80002ca8:	f40080e7          	jalr	-192(ra) # 80002be4 <_ZN3Sem5blockEP3TCB>
            TCB::previous_running_thread = Scheduler::get_thread();
    80002cac:	00000097          	auipc	ra,0x0
    80002cb0:	1d0080e7          	jalr	464(ra) # 80002e7c <_ZN9Scheduler10get_threadEv>
    80002cb4:	00a4b023          	sd	a0,0(s1)
        return 0;
    80002cb8:	00000513          	li	a0,0
}
    80002cbc:	01813083          	ld	ra,24(sp)
    80002cc0:	01013403          	ld	s0,16(sp)
    80002cc4:	00813483          	ld	s1,8(sp)
    80002cc8:	02010113          	addi	sp,sp,32
    80002ccc:	00008067          	ret
    }return -1;
    80002cd0:	fff00513          	li	a0,-1
    80002cd4:	00008067          	ret

0000000080002cd8 <_Z41__static_initialization_and_destruction_0ii>:
            else {
                blocked_threads.addLast(cur);
            }
        }
    }
}
    80002cd8:	ff010113          	addi	sp,sp,-16
    80002cdc:	00813423          	sd	s0,8(sp)
    80002ce0:	01010413          	addi	s0,sp,16
    80002ce4:	00100793          	li	a5,1
    80002ce8:	00f50863          	beq	a0,a5,80002cf8 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80002cec:	00813403          	ld	s0,8(sp)
    80002cf0:	01010113          	addi	sp,sp,16
    80002cf4:	00008067          	ret
    80002cf8:	000107b7          	lui	a5,0x10
    80002cfc:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002d00:	fef596e3          	bne	a1,a5,80002cec <_Z41__static_initialization_and_destruction_0ii+0x14>
    List() : head(nullptr), tail(nullptr) ,size(0){}
    80002d04:	00009797          	auipc	a5,0x9
    80002d08:	25478793          	addi	a5,a5,596 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    80002d0c:	0007b023          	sd	zero,0(a5)
    80002d10:	0007b423          	sd	zero,8(a5)
    80002d14:	0007b823          	sd	zero,16(a5)
    80002d18:	0007bc23          	sd	zero,24(a5)
    80002d1c:	0207b023          	sd	zero,32(a5)
    80002d20:	0207b423          	sd	zero,40(a5)
    80002d24:	0207b823          	sd	zero,48(a5)
    80002d28:	0207bc23          	sd	zero,56(a5)
    80002d2c:	0407b023          	sd	zero,64(a5)
    80002d30:	fbdff06f          	j	80002cec <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080002d34 <_ZN9Scheduler19choose_next_runningEv>:
void Scheduler::choose_next_running() {
    80002d34:	fe010113          	addi	sp,sp,-32
    80002d38:	00813c23          	sd	s0,24(sp)
    80002d3c:	02010413          	addi	s0,sp,32
        __asm__ volatile ("csrr %[value], scause": [value] "=r" (scause));
    80002d40:	142027f3          	csrr	a5,scause
    80002d44:	fef43023          	sd	a5,-32(s0)
        return scause;
    80002d48:	fe043783          	ld	a5,-32(s0)
    uint64 volatile scause = Riscv::read_scause();
    80002d4c:	fef43423          	sd	a5,-24(s0)
    if(TCB::running_thread->is_interrupt_thread()==false) {
    80002d50:	00009797          	auipc	a5,0x9
    80002d54:	1687b783          	ld	a5,360(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002d58:	0007b783          	ld	a5,0(a5)
    }
    bool is_privileged() const {
        return this->privileged;
    }
    bool is_interrupt_thread() const {
        return this->interrupt;
    80002d5c:	08a7c703          	lbu	a4,138(a5)
    80002d60:	06071663          	bnez	a4,80002dcc <_ZN9Scheduler19choose_next_runningEv+0x98>
        TCB::previous_running_thread = TCB::running_thread;
    80002d64:	00009717          	auipc	a4,0x9
    80002d68:	14c73703          	ld	a4,332(a4) # 8000beb0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002d6c:	00f73023          	sd	a5,0(a4)
        if(scause==SCAUSE_EXTERNAL_HARDWARE) {
    80002d70:	fe843703          	ld	a4,-24(s0)
    80002d74:	fff00793          	li	a5,-1
    80002d78:	03f79793          	slli	a5,a5,0x3f
    80002d7c:	00978793          	addi	a5,a5,9
    80002d80:	02f70663          	beq	a4,a5,80002dac <_ZN9Scheduler19choose_next_runningEv+0x78>
        if (!head) { return nullptr; }
    80002d84:	00009797          	auipc	a5,0x9
    80002d88:	1ec7b783          	ld	a5,492(a5) # 8000bf70 <_ZN9Scheduler30ready_interrupt_kernel_threadsE>
    80002d8c:	00078463          	beqz	a5,80002d94 <_ZN9Scheduler19choose_next_runningEv+0x60>
        return head->data;
    80002d90:	0007b783          	ld	a5,0(a5)
            TCB::running_thread = ready_interrupt_kernel_threads.peekFirst();
    80002d94:	00009717          	auipc	a4,0x9
    80002d98:	12473703          	ld	a4,292(a4) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002d9c:	00f73023          	sd	a5,0(a4)
}
    80002da0:	01813403          	ld	s0,24(sp)
    80002da4:	02010113          	addi	sp,sp,32
    80002da8:	00008067          	ret
        if (!tail) { return nullptr; }
    80002dac:	00009797          	auipc	a5,0x9
    80002db0:	1cc7b783          	ld	a5,460(a5) # 8000bf78 <_ZN9Scheduler30ready_interrupt_kernel_threadsE+0x8>
    80002db4:	00078463          	beqz	a5,80002dbc <_ZN9Scheduler19choose_next_runningEv+0x88>
        return tail->data;
    80002db8:	0007b783          	ld	a5,0(a5)
            TCB::running_thread = ready_interrupt_kernel_threads.peekLast();
    80002dbc:	00009717          	auipc	a4,0x9
    80002dc0:	0fc73703          	ld	a4,252(a4) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002dc4:	00f73023          	sd	a5,0(a4)
    80002dc8:	fd9ff06f          	j	80002da0 <_ZN9Scheduler19choose_next_runningEv+0x6c>
            if(Riscv::interrupt_level==2 && scause==SCAUSE_EXTERNAL_HARDWARE) {
    80002dcc:	00009797          	auipc	a5,0x9
    80002dd0:	0c47b783          	ld	a5,196(a5) # 8000be90 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002dd4:	0007b783          	ld	a5,0(a5)
    80002dd8:	00200713          	li	a4,2
    80002ddc:	02e78663          	beq	a5,a4,80002e08 <_ZN9Scheduler19choose_next_runningEv+0xd4>
            else if(Riscv::interrupt_level==1){
    80002de0:	00100713          	li	a4,1
    80002de4:	04e78c63          	beq	a5,a4,80002e3c <_ZN9Scheduler19choose_next_runningEv+0x108>
            }else if(Riscv::interrupt_level==0){
    80002de8:	06079a63          	bnez	a5,80002e5c <_ZN9Scheduler19choose_next_runningEv+0x128>
                TCB::running_thread = TCB::previous_running_thread;
    80002dec:	00009797          	auipc	a5,0x9
    80002df0:	0c47b783          	ld	a5,196(a5) # 8000beb0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002df4:	0007b703          	ld	a4,0(a5)
    80002df8:	00009797          	auipc	a5,0x9
    80002dfc:	0c07b783          	ld	a5,192(a5) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002e00:	00e7b023          	sd	a4,0(a5)
    80002e04:	f9dff06f          	j	80002da0 <_ZN9Scheduler19choose_next_runningEv+0x6c>
            if(Riscv::interrupt_level==2 && scause==SCAUSE_EXTERNAL_HARDWARE) {
    80002e08:	fe843683          	ld	a3,-24(s0)
    80002e0c:	fff00713          	li	a4,-1
    80002e10:	03f71713          	slli	a4,a4,0x3f
    80002e14:	00970713          	addi	a4,a4,9
    80002e18:	fce694e3          	bne	a3,a4,80002de0 <_ZN9Scheduler19choose_next_runningEv+0xac>
        if (!tail) { return nullptr; }
    80002e1c:	00009797          	auipc	a5,0x9
    80002e20:	15c7b783          	ld	a5,348(a5) # 8000bf78 <_ZN9Scheduler30ready_interrupt_kernel_threadsE+0x8>
    80002e24:	00078463          	beqz	a5,80002e2c <_ZN9Scheduler19choose_next_runningEv+0xf8>
        return tail->data;
    80002e28:	0007b783          	ld	a5,0(a5)
                TCB::running_thread = ready_interrupt_kernel_threads.peekLast();
    80002e2c:	00009717          	auipc	a4,0x9
    80002e30:	08c73703          	ld	a4,140(a4) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002e34:	00f73023          	sd	a5,0(a4)
    80002e38:	f69ff06f          	j	80002da0 <_ZN9Scheduler19choose_next_runningEv+0x6c>
        if (!head) { return nullptr; }
    80002e3c:	00009797          	auipc	a5,0x9
    80002e40:	1347b783          	ld	a5,308(a5) # 8000bf70 <_ZN9Scheduler30ready_interrupt_kernel_threadsE>
    80002e44:	00078463          	beqz	a5,80002e4c <_ZN9Scheduler19choose_next_runningEv+0x118>
        return head->data;
    80002e48:	0007b783          	ld	a5,0(a5)
                TCB::running_thread = ready_interrupt_kernel_threads.peekFirst();
    80002e4c:	00009717          	auipc	a4,0x9
    80002e50:	06c73703          	ld	a4,108(a4) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002e54:	00f73023          	sd	a5,0(a4)
    80002e58:	f49ff06f          	j	80002da0 <_ZN9Scheduler19choose_next_runningEv+0x6c>
        if (!head) { return nullptr; }
    80002e5c:	00009797          	auipc	a5,0x9
    80002e60:	1147b783          	ld	a5,276(a5) # 8000bf70 <_ZN9Scheduler30ready_interrupt_kernel_threadsE>
    80002e64:	00078463          	beqz	a5,80002e6c <_ZN9Scheduler19choose_next_runningEv+0x138>
        return head->data;
    80002e68:	0007b783          	ld	a5,0(a5)
                TCB::running_thread = ready_interrupt_kernel_threads.peekFirst();
    80002e6c:	00009717          	auipc	a4,0x9
    80002e70:	04c73703          	ld	a4,76(a4) # 8000beb8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002e74:	00f73023          	sd	a5,0(a4)
}
    80002e78:	f29ff06f          	j	80002da0 <_ZN9Scheduler19choose_next_runningEv+0x6c>

0000000080002e7c <_ZN9Scheduler10get_threadEv>:
TCB *Scheduler::get_thread() {
    80002e7c:	fe010113          	addi	sp,sp,-32
    80002e80:	00113c23          	sd	ra,24(sp)
    80002e84:	00813823          	sd	s0,16(sp)
    80002e88:	00913423          	sd	s1,8(sp)
    80002e8c:	02010413          	addi	s0,sp,32
        if (!head) { return nullptr; }
    80002e90:	00009517          	auipc	a0,0x9
    80002e94:	0c853503          	ld	a0,200(a0) # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    80002e98:	04050c63          	beqz	a0,80002ef0 <_ZN9Scheduler10get_threadEv+0x74>
        head = head->next;
    80002e9c:	00853783          	ld	a5,8(a0)
    80002ea0:	00009717          	auipc	a4,0x9
    80002ea4:	0af73c23          	sd	a5,184(a4) # 8000bf58 <_ZN9Scheduler13ready_threadsE>
        if (!head) { tail = 0; }
    80002ea8:	02078e63          	beqz	a5,80002ee4 <_ZN9Scheduler10get_threadEv+0x68>
        T *ret = elem->data;
    80002eac:	00053483          	ld	s1,0(a0)
            Memory::mem_free(addr);
    80002eb0:	00000097          	auipc	ra,0x0
    80002eb4:	474080e7          	jalr	1140(ra) # 80003324 <_ZN6Memory8mem_freeEPv>
        size--;
    80002eb8:	00009717          	auipc	a4,0x9
    80002ebc:	0a070713          	addi	a4,a4,160 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    80002ec0:	01073783          	ld	a5,16(a4)
    80002ec4:	fff78793          	addi	a5,a5,-1
    80002ec8:	00f73823          	sd	a5,16(a4)
}
    80002ecc:	00048513          	mv	a0,s1
    80002ed0:	01813083          	ld	ra,24(sp)
    80002ed4:	01013403          	ld	s0,16(sp)
    80002ed8:	00813483          	ld	s1,8(sp)
    80002edc:	02010113          	addi	sp,sp,32
    80002ee0:	00008067          	ret
        if (!head) { tail = 0; }
    80002ee4:	00009797          	auipc	a5,0x9
    80002ee8:	0607be23          	sd	zero,124(a5) # 8000bf60 <_ZN9Scheduler13ready_threadsE+0x8>
    80002eec:	fc1ff06f          	j	80002eac <_ZN9Scheduler10get_threadEv+0x30>
        if (!head) { return nullptr; }
    80002ef0:	00050493          	mv	s1,a0
    return ready_threads.removeFirst();
    80002ef4:	fd9ff06f          	j	80002ecc <_ZN9Scheduler10get_threadEv+0x50>

0000000080002ef8 <_ZN9Scheduler20put_interrupt_threadEP3TCB>:
void Scheduler::put_interrupt_thread(TCB *kernel_thread) {
    80002ef8:	fe010113          	addi	sp,sp,-32
    80002efc:	00113c23          	sd	ra,24(sp)
    80002f00:	00813823          	sd	s0,16(sp)
    80002f04:	00913423          	sd	s1,8(sp)
    80002f08:	02010413          	addi	s0,sp,32
    80002f0c:	00050493          	mv	s1,a0
            return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    80002f10:	00100513          	li	a0,1
    80002f14:	00000097          	auipc	ra,0x0
    80002f18:	38c080e7          	jalr	908(ra) # 800032a0 <_ZN6Memory9mem_allocEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80002f1c:	00953023          	sd	s1,0(a0)
    80002f20:	00053423          	sd	zero,8(a0)
        if (tail)
    80002f24:	00009797          	auipc	a5,0x9
    80002f28:	0547b783          	ld	a5,84(a5) # 8000bf78 <_ZN9Scheduler30ready_interrupt_kernel_threadsE+0x8>
    80002f2c:	02078c63          	beqz	a5,80002f64 <_ZN9Scheduler20put_interrupt_threadEP3TCB+0x6c>
            tail->next = elem;
    80002f30:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80002f34:	00009797          	auipc	a5,0x9
    80002f38:	04a7b223          	sd	a0,68(a5) # 8000bf78 <_ZN9Scheduler30ready_interrupt_kernel_threadsE+0x8>
        size++;
    80002f3c:	00009717          	auipc	a4,0x9
    80002f40:	01c70713          	addi	a4,a4,28 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    80002f44:	02873783          	ld	a5,40(a4)
    80002f48:	00178793          	addi	a5,a5,1
    80002f4c:	02f73423          	sd	a5,40(a4)
}
    80002f50:	01813083          	ld	ra,24(sp)
    80002f54:	01013403          	ld	s0,16(sp)
    80002f58:	00813483          	ld	s1,8(sp)
    80002f5c:	02010113          	addi	sp,sp,32
    80002f60:	00008067          	ret
            head = tail = elem;
    80002f64:	00009797          	auipc	a5,0x9
    80002f68:	ff478793          	addi	a5,a5,-12 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    80002f6c:	02a7b023          	sd	a0,32(a5)
    80002f70:	00a7bc23          	sd	a0,24(a5)
    80002f74:	fc9ff06f          	j	80002f3c <_ZN9Scheduler20put_interrupt_threadEP3TCB+0x44>

0000000080002f78 <_ZN9Scheduler10put_threadEP3TCB>:
void Scheduler::put_thread(TCB* thread) {
    80002f78:	fe010113          	addi	sp,sp,-32
    80002f7c:	00113c23          	sd	ra,24(sp)
    80002f80:	00813823          	sd	s0,16(sp)
    80002f84:	00913423          	sd	s1,8(sp)
    80002f88:	02010413          	addi	s0,sp,32
    80002f8c:	00050493          	mv	s1,a0
            return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    80002f90:	00100513          	li	a0,1
    80002f94:	00000097          	auipc	ra,0x0
    80002f98:	30c080e7          	jalr	780(ra) # 800032a0 <_ZN6Memory9mem_allocEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80002f9c:	00953023          	sd	s1,0(a0)
    80002fa0:	00053423          	sd	zero,8(a0)
        if (tail)
    80002fa4:	00009797          	auipc	a5,0x9
    80002fa8:	fbc7b783          	ld	a5,-68(a5) # 8000bf60 <_ZN9Scheduler13ready_threadsE+0x8>
    80002fac:	02078c63          	beqz	a5,80002fe4 <_ZN9Scheduler10put_threadEP3TCB+0x6c>
            tail->next = elem;
    80002fb0:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80002fb4:	00009797          	auipc	a5,0x9
    80002fb8:	faa7b623          	sd	a0,-84(a5) # 8000bf60 <_ZN9Scheduler13ready_threadsE+0x8>
        size++;
    80002fbc:	00009717          	auipc	a4,0x9
    80002fc0:	f9c70713          	addi	a4,a4,-100 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    80002fc4:	01073783          	ld	a5,16(a4)
    80002fc8:	00178793          	addi	a5,a5,1
    80002fcc:	00f73823          	sd	a5,16(a4)
}
    80002fd0:	01813083          	ld	ra,24(sp)
    80002fd4:	01013403          	ld	s0,16(sp)
    80002fd8:	00813483          	ld	s1,8(sp)
    80002fdc:	02010113          	addi	sp,sp,32
    80002fe0:	00008067          	ret
            head = tail = elem;
    80002fe4:	00009797          	auipc	a5,0x9
    80002fe8:	f7478793          	addi	a5,a5,-140 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    80002fec:	00a7b423          	sd	a0,8(a5)
    80002ff0:	00a7b023          	sd	a0,0(a5)
    80002ff4:	fc9ff06f          	j	80002fbc <_ZN9Scheduler10put_threadEP3TCB+0x44>

0000000080002ff8 <_ZN9Scheduler13remove_threadEP3TCB>:
void Scheduler::remove_thread(TCB* thread) {
    80002ff8:	00050793          	mv	a5,a0
        else return false;
    }
    void remove(T* data) {
        Elem* cur = head;
    80002ffc:	00009517          	auipc	a0,0x9
    80003000:	f5c53503          	ld	a0,-164(a0) # 8000bf58 <_ZN9Scheduler13ready_threadsE>
        Elem* prev = cur;
    80003004:	00050713          	mv	a4,a0
        for(;cur!=nullptr;prev = cur,cur = cur->next) {
    80003008:	04050e63          	beqz	a0,80003064 <_ZN9Scheduler13remove_threadEP3TCB+0x6c>
            if(cur->data==data) {
    8000300c:	00053683          	ld	a3,0(a0)
    80003010:	00d78863          	beq	a5,a3,80003020 <_ZN9Scheduler13remove_threadEP3TCB+0x28>
        for(;cur!=nullptr;prev = cur,cur = cur->next) {
    80003014:	00050713          	mv	a4,a0
    80003018:	00853503          	ld	a0,8(a0)
    8000301c:	fedff06f          	j	80003008 <_ZN9Scheduler13remove_threadEP3TCB+0x10>
    80003020:	ff010113          	addi	sp,sp,-16
    80003024:	00113423          	sd	ra,8(sp)
    80003028:	00813023          	sd	s0,0(sp)
    8000302c:	01010413          	addi	s0,sp,16
                prev->next = cur->next;
    80003030:	00853783          	ld	a5,8(a0)
    80003034:	00f73423          	sd	a5,8(a4)
            Memory::mem_free(addr);
    80003038:	00000097          	auipc	ra,0x0
    8000303c:	2ec080e7          	jalr	748(ra) # 80003324 <_ZN6Memory8mem_freeEPv>
                delete cur;
                break;
            }
        }
        size--;
    80003040:	00009717          	auipc	a4,0x9
    80003044:	f1870713          	addi	a4,a4,-232 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    80003048:	01073783          	ld	a5,16(a4)
    8000304c:	fff78793          	addi	a5,a5,-1
    80003050:	00f73823          	sd	a5,16(a4)
}
    80003054:	00813083          	ld	ra,8(sp)
    80003058:	00013403          	ld	s0,0(sp)
    8000305c:	01010113          	addi	sp,sp,16
    80003060:	00008067          	ret
    80003064:	00009717          	auipc	a4,0x9
    80003068:	ef470713          	addi	a4,a4,-268 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    8000306c:	01073783          	ld	a5,16(a4)
    80003070:	fff78793          	addi	a5,a5,-1
    80003074:	00f73823          	sd	a5,16(a4)
    80003078:	00008067          	ret

000000008000307c <_ZN9Scheduler12block_threadEP3TCB>:
void Scheduler::block_thread(TCB *thread) {
    8000307c:	fe010113          	addi	sp,sp,-32
    80003080:	00113c23          	sd	ra,24(sp)
    80003084:	00813823          	sd	s0,16(sp)
    80003088:	00913423          	sd	s1,8(sp)
    8000308c:	02010413          	addi	s0,sp,32
    80003090:	00050493          	mv	s1,a0
            return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    80003094:	00100513          	li	a0,1
    80003098:	00000097          	auipc	ra,0x0
    8000309c:	208080e7          	jalr	520(ra) # 800032a0 <_ZN6Memory9mem_allocEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    800030a0:	00953023          	sd	s1,0(a0)
    800030a4:	00053423          	sd	zero,8(a0)
        if (tail)
    800030a8:	00009797          	auipc	a5,0x9
    800030ac:	ee87b783          	ld	a5,-280(a5) # 8000bf90 <_ZN9Scheduler15blocked_threadsE+0x8>
    800030b0:	02078c63          	beqz	a5,800030e8 <_ZN9Scheduler12block_threadEP3TCB+0x6c>
            tail->next = elem;
    800030b4:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800030b8:	00009797          	auipc	a5,0x9
    800030bc:	eca7bc23          	sd	a0,-296(a5) # 8000bf90 <_ZN9Scheduler15blocked_threadsE+0x8>
        size++;
    800030c0:	00009717          	auipc	a4,0x9
    800030c4:	e9870713          	addi	a4,a4,-360 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    800030c8:	04073783          	ld	a5,64(a4)
    800030cc:	00178793          	addi	a5,a5,1
    800030d0:	04f73023          	sd	a5,64(a4)
}
    800030d4:	01813083          	ld	ra,24(sp)
    800030d8:	01013403          	ld	s0,16(sp)
    800030dc:	00813483          	ld	s1,8(sp)
    800030e0:	02010113          	addi	sp,sp,32
    800030e4:	00008067          	ret
            head = tail = elem;
    800030e8:	00009797          	auipc	a5,0x9
    800030ec:	e7078793          	addi	a5,a5,-400 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    800030f0:	02a7bc23          	sd	a0,56(a5)
    800030f4:	02a7b823          	sd	a0,48(a5)
    800030f8:	fc9ff06f          	j	800030c0 <_ZN9Scheduler12block_threadEP3TCB+0x44>

00000000800030fc <_ZN9Scheduler9awakeningEv>:
        if(!head)return true;
    800030fc:	00009797          	auipc	a5,0x9
    80003100:	e8c7b783          	ld	a5,-372(a5) # 8000bf88 <_ZN9Scheduler15blocked_threadsE>
    80003104:	10078863          	beqz	a5,80003214 <_ZN9Scheduler9awakeningEv+0x118>
void Scheduler::awakening() {
    80003108:	fe010113          	addi	sp,sp,-32
    8000310c:	00113c23          	sd	ra,24(sp)
    80003110:	00813823          	sd	s0,16(sp)
    80003114:	00913423          	sd	s1,8(sp)
    80003118:	01213023          	sd	s2,0(sp)
    8000311c:	02010413          	addi	s0,sp,32
    80003120:	00000913          	li	s2,0
    80003124:	05c0006f          	j	80003180 <_ZN9Scheduler9awakeningEv+0x84>
        if (!head) { tail = 0; }
    80003128:	00009797          	auipc	a5,0x9
    8000312c:	e607b423          	sd	zero,-408(a5) # 8000bf90 <_ZN9Scheduler15blocked_threadsE+0x8>
    80003130:	0780006f          	j	800031a8 <_ZN9Scheduler9awakeningEv+0xac>
        if (!head) { return nullptr; }
    80003134:	00050493          	mv	s1,a0
    80003138:	0900006f          	j	800031c8 <_ZN9Scheduler9awakeningEv+0xcc>
            return Memory::mem_alloc(n%MEM_BLOCK_SIZE==0?n/MEM_BLOCK_SIZE:n/MEM_BLOCK_SIZE+1);
    8000313c:	00100513          	li	a0,1
    80003140:	00000097          	auipc	ra,0x0
    80003144:	160080e7          	jalr	352(ra) # 800032a0 <_ZN6Memory9mem_allocEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80003148:	00953023          	sd	s1,0(a0)
    8000314c:	00053423          	sd	zero,8(a0)
        if (tail)
    80003150:	00009797          	auipc	a5,0x9
    80003154:	e407b783          	ld	a5,-448(a5) # 8000bf90 <_ZN9Scheduler15blocked_threadsE+0x8>
    80003158:	08078863          	beqz	a5,800031e8 <_ZN9Scheduler9awakeningEv+0xec>
            tail->next = elem;
    8000315c:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80003160:	00009797          	auipc	a5,0x9
    80003164:	e2a7b823          	sd	a0,-464(a5) # 8000bf90 <_ZN9Scheduler15blocked_threadsE+0x8>
        size++;
    80003168:	00009717          	auipc	a4,0x9
    8000316c:	df070713          	addi	a4,a4,-528 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    80003170:	04073783          	ld	a5,64(a4)
    80003174:	00178793          	addi	a5,a5,1
    80003178:	04f73023          	sd	a5,64(a4)
        for(uint64 i=0;i<blocked_threads.get_size();i++) {
    8000317c:	00190913          	addi	s2,s2,1
    }
    uint64 get_size() const{
        return this->size;
    80003180:	00009797          	auipc	a5,0x9
    80003184:	e187b783          	ld	a5,-488(a5) # 8000bf98 <_ZN9Scheduler15blocked_threadsE+0x10>
    80003188:	06f97a63          	bgeu	s2,a5,800031fc <_ZN9Scheduler9awakeningEv+0x100>
        if (!head) { return nullptr; }
    8000318c:	00009517          	auipc	a0,0x9
    80003190:	dfc53503          	ld	a0,-516(a0) # 8000bf88 <_ZN9Scheduler15blocked_threadsE>
    80003194:	fa0500e3          	beqz	a0,80003134 <_ZN9Scheduler9awakeningEv+0x38>
        head = head->next;
    80003198:	00853783          	ld	a5,8(a0)
    8000319c:	00009717          	auipc	a4,0x9
    800031a0:	def73623          	sd	a5,-532(a4) # 8000bf88 <_ZN9Scheduler15blocked_threadsE>
        if (!head) { tail = 0; }
    800031a4:	f80782e3          	beqz	a5,80003128 <_ZN9Scheduler9awakeningEv+0x2c>
        T *ret = elem->data;
    800031a8:	00053483          	ld	s1,0(a0)
            Memory::mem_free(addr);
    800031ac:	00000097          	auipc	ra,0x0
    800031b0:	178080e7          	jalr	376(ra) # 80003324 <_ZN6Memory8mem_freeEPv>
        size--;
    800031b4:	00009717          	auipc	a4,0x9
    800031b8:	da470713          	addi	a4,a4,-604 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    800031bc:	04073783          	ld	a5,64(a4)
    800031c0:	fff78793          	addi	a5,a5,-1
    800031c4:	04f73023          	sd	a5,64(a4)
            if(--cur->my_sleep_time==0) {
    800031c8:	0984b783          	ld	a5,152(s1)
    800031cc:	fff78793          	addi	a5,a5,-1
    800031d0:	08f4bc23          	sd	a5,152(s1)
    800031d4:	f60794e3          	bnez	a5,8000313c <_ZN9Scheduler9awakeningEv+0x40>
                Scheduler::put_thread(cur);
    800031d8:	00048513          	mv	a0,s1
    800031dc:	00000097          	auipc	ra,0x0
    800031e0:	d9c080e7          	jalr	-612(ra) # 80002f78 <_ZN9Scheduler10put_threadEP3TCB>
    800031e4:	f99ff06f          	j	8000317c <_ZN9Scheduler9awakeningEv+0x80>
            head = tail = elem;
    800031e8:	00009797          	auipc	a5,0x9
    800031ec:	d7078793          	addi	a5,a5,-656 # 8000bf58 <_ZN9Scheduler13ready_threadsE>
    800031f0:	02a7bc23          	sd	a0,56(a5)
    800031f4:	02a7b823          	sd	a0,48(a5)
    800031f8:	f71ff06f          	j	80003168 <_ZN9Scheduler9awakeningEv+0x6c>
}
    800031fc:	01813083          	ld	ra,24(sp)
    80003200:	01013403          	ld	s0,16(sp)
    80003204:	00813483          	ld	s1,8(sp)
    80003208:	00013903          	ld	s2,0(sp)
    8000320c:	02010113          	addi	sp,sp,32
    80003210:	00008067          	ret
    80003214:	00008067          	ret

0000000080003218 <_GLOBAL__sub_I__ZN9Scheduler13ready_threadsE>:
    80003218:	ff010113          	addi	sp,sp,-16
    8000321c:	00113423          	sd	ra,8(sp)
    80003220:	00813023          	sd	s0,0(sp)
    80003224:	01010413          	addi	s0,sp,16
    80003228:	000105b7          	lui	a1,0x10
    8000322c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80003230:	00100513          	li	a0,1
    80003234:	00000097          	auipc	ra,0x0
    80003238:	aa4080e7          	jalr	-1372(ra) # 80002cd8 <_Z41__static_initialization_and_destruction_0ii>
    8000323c:	00813083          	ld	ra,8(sp)
    80003240:	00013403          	ld	s0,0(sp)
    80003244:	01010113          	addi	sp,sp,16
    80003248:	00008067          	ret

000000008000324c <_ZN6Memory10initializeEv>:
//

#include "../h/memory.hpp"
Memory::Fragment* Memory::mem_head;

void Memory::initialize() {
    8000324c:	ff010113          	addi	sp,sp,-16
    80003250:	00813423          	sd	s0,8(sp)
    80003254:	01010413          	addi	s0,sp,16
    size_t memory_size = ((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR) - 1;
    80003258:	00009797          	auipc	a5,0x9
    8000325c:	c687b783          	ld	a5,-920(a5) # 8000bec0 <_GLOBAL_OFFSET_TABLE_+0x40>
    80003260:	0007b783          	ld	a5,0(a5)
    80003264:	00009717          	auipc	a4,0x9
    80003268:	c2473703          	ld	a4,-988(a4) # 8000be88 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000326c:	00073703          	ld	a4,0(a4)
    80003270:	40e787b3          	sub	a5,a5,a4
    mem_head = (Fragment*) HEAP_START_ADDR;
    80003274:	00009697          	auipc	a3,0x9
    80003278:	d2c68693          	addi	a3,a3,-724 # 8000bfa0 <_ZN6Memory8mem_headE>
    8000327c:	00e6b023          	sd	a4,0(a3)
    mem_head->allocated = false;
    80003280:	00070423          	sb	zero,8(a4)
    mem_head->size = memory_size-sizeof(Fragment);
    80003284:	fe778793          	addi	a5,a5,-25
    80003288:	00f73023          	sd	a5,0(a4)
    mem_head->next = nullptr;
    8000328c:	0006b783          	ld	a5,0(a3)
    80003290:	0007b823          	sd	zero,16(a5)
}
    80003294:	00813403          	ld	s0,8(sp)
    80003298:	01010113          	addi	sp,sp,16
    8000329c:	00008067          	ret

00000000800032a0 <_ZN6Memory9mem_allocEm>:
void *Memory::mem_alloc(uint64 num_of_blocks) {
    800032a0:	ff010113          	addi	sp,sp,-16
    800032a4:	00813423          	sd	s0,8(sp)
    800032a8:	01010413          	addi	s0,sp,16
    if(num_of_blocks<=0) return nullptr;
    800032ac:	06050863          	beqz	a0,8000331c <_ZN6Memory9mem_allocEm+0x7c>

    uint64 size_in_bytes = num_of_blocks * MEM_BLOCK_SIZE;
    800032b0:	00651693          	slli	a3,a0,0x6

    Fragment* current = mem_head;
    800032b4:	00009517          	auipc	a0,0x9
    800032b8:	cec53503          	ld	a0,-788(a0) # 8000bfa0 <_ZN6Memory8mem_headE>
    800032bc:	0080006f          	j	800032c4 <_ZN6Memory9mem_allocEm+0x24>
    for(;current!=nullptr;current = current->next) {
    800032c0:	01053503          	ld	a0,16(a0)
    800032c4:	00050c63          	beqz	a0,800032dc <_ZN6Memory9mem_allocEm+0x3c>
        if(current->size>=size_in_bytes+sizeof(Fragment) && current->allocated==false) {
    800032c8:	00053703          	ld	a4,0(a0)
    800032cc:	01868793          	addi	a5,a3,24
    800032d0:	fef768e3          	bltu	a4,a5,800032c0 <_ZN6Memory9mem_allocEm+0x20>
    800032d4:	00854783          	lbu	a5,8(a0)
    800032d8:	fe0794e3          	bnez	a5,800032c0 <_ZN6Memory9mem_allocEm+0x20>
            break;
        }
    }
    if(current==nullptr)return nullptr;
    800032dc:	02050a63          	beqz	a0,80003310 <_ZN6Memory9mem_allocEm+0x70>

    size_t remaining_size = current->size - size_in_bytes - sizeof(Fragment);
    800032e0:	00053783          	ld	a5,0(a0)
    800032e4:	40d787b3          	sub	a5,a5,a3
    800032e8:	fe878713          	addi	a4,a5,-24
    current->size = remaining_size;
    800032ec:	00e53023          	sd	a4,0(a0)

    Fragment* new_fragment = (Fragment*)((char*)current +sizeof(Fragment)+ current->size);
    800032f0:	00f507b3          	add	a5,a0,a5
    new_fragment->size = size_in_bytes;
    800032f4:	00d7b023          	sd	a3,0(a5)
    new_fragment->next = current->next;
    800032f8:	01053703          	ld	a4,16(a0)
    800032fc:	00e7b823          	sd	a4,16(a5)
    new_fragment->allocated = true;
    80003300:	00100713          	li	a4,1
    80003304:	00e78423          	sb	a4,8(a5)

    current->next = new_fragment;
    80003308:	00f53823          	sd	a5,16(a0)

    return (void*)((char*)new_fragment + sizeof(Fragment));
    8000330c:	01878513          	addi	a0,a5,24
}
    80003310:	00813403          	ld	s0,8(sp)
    80003314:	01010113          	addi	sp,sp,16
    80003318:	00008067          	ret
    if(num_of_blocks<=0) return nullptr;
    8000331c:	00000513          	li	a0,0
    80003320:	ff1ff06f          	j	80003310 <_ZN6Memory9mem_allocEm+0x70>

0000000080003324 <_ZN6Memory8mem_freeEPv>:

int Memory::mem_free(void *addr) {
    80003324:	ff010113          	addi	sp,sp,-16
    80003328:	00813423          	sd	s0,8(sp)
    8000332c:	01010413          	addi	s0,sp,16
    Fragment* current = mem_head;
    80003330:	00009797          	auipc	a5,0x9
    80003334:	c707b783          	ld	a5,-912(a5) # 8000bfa0 <_ZN6Memory8mem_headE>
    80003338:	0080006f          	j	80003340 <_ZN6Memory8mem_freeEPv+0x1c>
    for(;current!=nullptr;current = current->next) {
    8000333c:	0107b783          	ld	a5,16(a5)
    80003340:	00078c63          	beqz	a5,80003358 <_ZN6Memory8mem_freeEPv+0x34>
        if(((char*)(char*)current+sizeof(Fragment))==(char*)addr && current->allocated==true) {
    80003344:	01878713          	addi	a4,a5,24
    80003348:	fea71ae3          	bne	a4,a0,8000333c <_ZN6Memory8mem_freeEPv+0x18>
    8000334c:	0087c703          	lbu	a4,8(a5)
    80003350:	fe0706e3          	beqz	a4,8000333c <_ZN6Memory8mem_freeEPv+0x18>
            current->allocated = false;
    80003354:	00078423          	sb	zero,8(a5)
            break;
        }
    }if(current==nullptr)return -1;
    80003358:	00078a63          	beqz	a5,8000336c <_ZN6Memory8mem_freeEPv+0x48>
    return 0;
    8000335c:	00000513          	li	a0,0
}
    80003360:	00813403          	ld	s0,8(sp)
    80003364:	01010113          	addi	sp,sp,16
    80003368:	00008067          	ret
    }if(current==nullptr)return -1;
    8000336c:	fff00513          	li	a0,-1
    80003370:	ff1ff06f          	j	80003360 <_ZN6Memory8mem_freeEPv+0x3c>

0000000080003374 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    80003374:	fe010113          	addi	sp,sp,-32
    80003378:	00113c23          	sd	ra,24(sp)
    8000337c:	00813823          	sd	s0,16(sp)
    80003380:	00913423          	sd	s1,8(sp)
    80003384:	01213023          	sd	s2,0(sp)
    80003388:	02010413          	addi	s0,sp,32
    8000338c:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80003390:	00000913          	li	s2,0
    80003394:	00c0006f          	j	800033a0 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 35) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80003398:	ffffe097          	auipc	ra,0xffffe
    8000339c:	020080e7          	jalr	32(ra) # 800013b8 <_Z15thread_dispatchv>
    while ((key = getc()) != 35) {
    800033a0:	ffffe097          	auipc	ra,0xffffe
    800033a4:	254080e7          	jalr	596(ra) # 800015f4 <_Z4getcv>
    800033a8:	0005059b          	sext.w	a1,a0
    800033ac:	02300793          	li	a5,35
    800033b0:	02f58a63          	beq	a1,a5,800033e4 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    800033b4:	0084b503          	ld	a0,8(s1)
    800033b8:	00003097          	auipc	ra,0x3
    800033bc:	400080e7          	jalr	1024(ra) # 800067b8 <_ZN6Buffer3putEi>
        i++;
    800033c0:	0019071b          	addiw	a4,s2,1
    800033c4:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800033c8:	0004a683          	lw	a3,0(s1)
    800033cc:	0026979b          	slliw	a5,a3,0x2
    800033d0:	00d787bb          	addw	a5,a5,a3
    800033d4:	0017979b          	slliw	a5,a5,0x1
    800033d8:	02f767bb          	remw	a5,a4,a5
    800033dc:	fc0792e3          	bnez	a5,800033a0 <_ZL16producerKeyboardPv+0x2c>
    800033e0:	fb9ff06f          	j	80003398 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    800033e4:	00100793          	li	a5,1
    800033e8:	00009717          	auipc	a4,0x9
    800033ec:	bcf72023          	sw	a5,-1088(a4) # 8000bfa8 <_ZL9threadEnd>
    data->buffer->put('!');
    800033f0:	02100593          	li	a1,33
    800033f4:	0084b503          	ld	a0,8(s1)
    800033f8:	00003097          	auipc	ra,0x3
    800033fc:	3c0080e7          	jalr	960(ra) # 800067b8 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80003400:	0104b503          	ld	a0,16(s1)
    80003404:	ffffe097          	auipc	ra,0xffffe
    80003408:	108080e7          	jalr	264(ra) # 8000150c <_Z10sem_signalP3Sem>
}
    8000340c:	01813083          	ld	ra,24(sp)
    80003410:	01013403          	ld	s0,16(sp)
    80003414:	00813483          	ld	s1,8(sp)
    80003418:	00013903          	ld	s2,0(sp)
    8000341c:	02010113          	addi	sp,sp,32
    80003420:	00008067          	ret

0000000080003424 <_ZL8producerPv>:

static void producer(void *arg) {
    80003424:	fe010113          	addi	sp,sp,-32
    80003428:	00113c23          	sd	ra,24(sp)
    8000342c:	00813823          	sd	s0,16(sp)
    80003430:	00913423          	sd	s1,8(sp)
    80003434:	01213023          	sd	s2,0(sp)
    80003438:	02010413          	addi	s0,sp,32
    8000343c:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003440:	00000913          	li	s2,0
    80003444:	00c0006f          	j	80003450 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80003448:	ffffe097          	auipc	ra,0xffffe
    8000344c:	f70080e7          	jalr	-144(ra) # 800013b8 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80003450:	00009797          	auipc	a5,0x9
    80003454:	b587a783          	lw	a5,-1192(a5) # 8000bfa8 <_ZL9threadEnd>
    80003458:	02079e63          	bnez	a5,80003494 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    8000345c:	0004a583          	lw	a1,0(s1)
    80003460:	0305859b          	addiw	a1,a1,48
    80003464:	0084b503          	ld	a0,8(s1)
    80003468:	00003097          	auipc	ra,0x3
    8000346c:	350080e7          	jalr	848(ra) # 800067b8 <_ZN6Buffer3putEi>
        i++;
    80003470:	0019071b          	addiw	a4,s2,1
    80003474:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80003478:	0004a683          	lw	a3,0(s1)
    8000347c:	0026979b          	slliw	a5,a3,0x2
    80003480:	00d787bb          	addw	a5,a5,a3
    80003484:	0017979b          	slliw	a5,a5,0x1
    80003488:	02f767bb          	remw	a5,a4,a5
    8000348c:	fc0792e3          	bnez	a5,80003450 <_ZL8producerPv+0x2c>
    80003490:	fb9ff06f          	j	80003448 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    80003494:	0104b503          	ld	a0,16(s1)
    80003498:	ffffe097          	auipc	ra,0xffffe
    8000349c:	074080e7          	jalr	116(ra) # 8000150c <_Z10sem_signalP3Sem>
}
    800034a0:	01813083          	ld	ra,24(sp)
    800034a4:	01013403          	ld	s0,16(sp)
    800034a8:	00813483          	ld	s1,8(sp)
    800034ac:	00013903          	ld	s2,0(sp)
    800034b0:	02010113          	addi	sp,sp,32
    800034b4:	00008067          	ret

00000000800034b8 <_ZL8consumerPv>:

static void consumer(void *arg) {
    800034b8:	fd010113          	addi	sp,sp,-48
    800034bc:	02113423          	sd	ra,40(sp)
    800034c0:	02813023          	sd	s0,32(sp)
    800034c4:	00913c23          	sd	s1,24(sp)
    800034c8:	01213823          	sd	s2,16(sp)
    800034cc:	01313423          	sd	s3,8(sp)
    800034d0:	03010413          	addi	s0,sp,48
    800034d4:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800034d8:	00000993          	li	s3,0
    800034dc:	01c0006f          	j	800034f8 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    800034e0:	ffffe097          	auipc	ra,0xffffe
    800034e4:	ed8080e7          	jalr	-296(ra) # 800013b8 <_Z15thread_dispatchv>
    800034e8:	0500006f          	j	80003538 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    800034ec:	00a00513          	li	a0,10
    800034f0:	ffffe097          	auipc	ra,0xffffe
    800034f4:	15c080e7          	jalr	348(ra) # 8000164c <_Z4putcc>
    while (!threadEnd) {
    800034f8:	00009797          	auipc	a5,0x9
    800034fc:	ab07a783          	lw	a5,-1360(a5) # 8000bfa8 <_ZL9threadEnd>
    80003500:	06079063          	bnez	a5,80003560 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80003504:	00893503          	ld	a0,8(s2)
    80003508:	00003097          	auipc	ra,0x3
    8000350c:	340080e7          	jalr	832(ra) # 80006848 <_ZN6Buffer3getEv>
        i++;
    80003510:	0019849b          	addiw	s1,s3,1
    80003514:	0004899b          	sext.w	s3,s1
        putc(key);
    80003518:	0ff57513          	andi	a0,a0,255
    8000351c:	ffffe097          	auipc	ra,0xffffe
    80003520:	130080e7          	jalr	304(ra) # 8000164c <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80003524:	00092703          	lw	a4,0(s2)
    80003528:	0027179b          	slliw	a5,a4,0x2
    8000352c:	00e787bb          	addw	a5,a5,a4
    80003530:	02f4e7bb          	remw	a5,s1,a5
    80003534:	fa0786e3          	beqz	a5,800034e0 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    80003538:	05000793          	li	a5,80
    8000353c:	02f4e4bb          	remw	s1,s1,a5
    80003540:	fa049ce3          	bnez	s1,800034f8 <_ZL8consumerPv+0x40>
    80003544:	fa9ff06f          	j	800034ec <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80003548:	00893503          	ld	a0,8(s2)
    8000354c:	00003097          	auipc	ra,0x3
    80003550:	2fc080e7          	jalr	764(ra) # 80006848 <_ZN6Buffer3getEv>
        putc(key);
    80003554:	0ff57513          	andi	a0,a0,255
    80003558:	ffffe097          	auipc	ra,0xffffe
    8000355c:	0f4080e7          	jalr	244(ra) # 8000164c <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80003560:	00893503          	ld	a0,8(s2)
    80003564:	00003097          	auipc	ra,0x3
    80003568:	370080e7          	jalr	880(ra) # 800068d4 <_ZN6Buffer6getCntEv>
    8000356c:	fca04ee3          	bgtz	a0,80003548 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80003570:	01093503          	ld	a0,16(s2)
    80003574:	ffffe097          	auipc	ra,0xffffe
    80003578:	f98080e7          	jalr	-104(ra) # 8000150c <_Z10sem_signalP3Sem>
}
    8000357c:	02813083          	ld	ra,40(sp)
    80003580:	02013403          	ld	s0,32(sp)
    80003584:	01813483          	ld	s1,24(sp)
    80003588:	01013903          	ld	s2,16(sp)
    8000358c:	00813983          	ld	s3,8(sp)
    80003590:	03010113          	addi	sp,sp,48
    80003594:	00008067          	ret

0000000080003598 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80003598:	f9010113          	addi	sp,sp,-112
    8000359c:	06113423          	sd	ra,104(sp)
    800035a0:	06813023          	sd	s0,96(sp)
    800035a4:	04913c23          	sd	s1,88(sp)
    800035a8:	05213823          	sd	s2,80(sp)
    800035ac:	05313423          	sd	s3,72(sp)
    800035b0:	05413023          	sd	s4,64(sp)
    800035b4:	03513c23          	sd	s5,56(sp)
    800035b8:	03613823          	sd	s6,48(sp)
    800035bc:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    800035c0:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    800035c4:	00006517          	auipc	a0,0x6
    800035c8:	b6c50513          	addi	a0,a0,-1172 # 80009130 <CONSOLE_STATUS+0x120>
    800035cc:	00002097          	auipc	ra,0x2
    800035d0:	220080e7          	jalr	544(ra) # 800057ec <_Z11printStringPKc>
    getString(input, 30);
    800035d4:	01e00593          	li	a1,30
    800035d8:	fa040493          	addi	s1,s0,-96
    800035dc:	00048513          	mv	a0,s1
    800035e0:	00002097          	auipc	ra,0x2
    800035e4:	294080e7          	jalr	660(ra) # 80005874 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800035e8:	00048513          	mv	a0,s1
    800035ec:	00002097          	auipc	ra,0x2
    800035f0:	360080e7          	jalr	864(ra) # 8000594c <_Z11stringToIntPKc>
    800035f4:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800035f8:	00006517          	auipc	a0,0x6
    800035fc:	b5850513          	addi	a0,a0,-1192 # 80009150 <CONSOLE_STATUS+0x140>
    80003600:	00002097          	auipc	ra,0x2
    80003604:	1ec080e7          	jalr	492(ra) # 800057ec <_Z11printStringPKc>
    getString(input, 30);
    80003608:	01e00593          	li	a1,30
    8000360c:	00048513          	mv	a0,s1
    80003610:	00002097          	auipc	ra,0x2
    80003614:	264080e7          	jalr	612(ra) # 80005874 <_Z9getStringPci>
    n = stringToInt(input);
    80003618:	00048513          	mv	a0,s1
    8000361c:	00002097          	auipc	ra,0x2
    80003620:	330080e7          	jalr	816(ra) # 8000594c <_Z11stringToIntPKc>
    80003624:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80003628:	00006517          	auipc	a0,0x6
    8000362c:	b4850513          	addi	a0,a0,-1208 # 80009170 <CONSOLE_STATUS+0x160>
    80003630:	00002097          	auipc	ra,0x2
    80003634:	1bc080e7          	jalr	444(ra) # 800057ec <_Z11printStringPKc>
    80003638:	00000613          	li	a2,0
    8000363c:	00a00593          	li	a1,10
    80003640:	00090513          	mv	a0,s2
    80003644:	00002097          	auipc	ra,0x2
    80003648:	358080e7          	jalr	856(ra) # 8000599c <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    8000364c:	00006517          	auipc	a0,0x6
    80003650:	b3c50513          	addi	a0,a0,-1220 # 80009188 <CONSOLE_STATUS+0x178>
    80003654:	00002097          	auipc	ra,0x2
    80003658:	198080e7          	jalr	408(ra) # 800057ec <_Z11printStringPKc>
    8000365c:	00000613          	li	a2,0
    80003660:	00a00593          	li	a1,10
    80003664:	00048513          	mv	a0,s1
    80003668:	00002097          	auipc	ra,0x2
    8000366c:	334080e7          	jalr	820(ra) # 8000599c <_Z8printIntiii>
    printString(".\n");
    80003670:	00006517          	auipc	a0,0x6
    80003674:	b3050513          	addi	a0,a0,-1232 # 800091a0 <CONSOLE_STATUS+0x190>
    80003678:	00002097          	auipc	ra,0x2
    8000367c:	174080e7          	jalr	372(ra) # 800057ec <_Z11printStringPKc>
    if(threadNum > n) {
    80003680:	0324c463          	blt	s1,s2,800036a8 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    80003684:	03205c63          	blez	s2,800036bc <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80003688:	03800513          	li	a0,56
    8000368c:	fffff097          	auipc	ra,0xfffff
    80003690:	838080e7          	jalr	-1992(ra) # 80001ec4 <_Znwm>
    80003694:	00050a13          	mv	s4,a0
    80003698:	00048593          	mv	a1,s1
    8000369c:	00003097          	auipc	ra,0x3
    800036a0:	080080e7          	jalr	128(ra) # 8000671c <_ZN6BufferC1Ei>
    800036a4:	0300006f          	j	800036d4 <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800036a8:	00006517          	auipc	a0,0x6
    800036ac:	b0050513          	addi	a0,a0,-1280 # 800091a8 <CONSOLE_STATUS+0x198>
    800036b0:	00002097          	auipc	ra,0x2
    800036b4:	13c080e7          	jalr	316(ra) # 800057ec <_Z11printStringPKc>
        return;
    800036b8:	0140006f          	j	800036cc <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800036bc:	00006517          	auipc	a0,0x6
    800036c0:	b2c50513          	addi	a0,a0,-1236 # 800091e8 <CONSOLE_STATUS+0x1d8>
    800036c4:	00002097          	auipc	ra,0x2
    800036c8:	128080e7          	jalr	296(ra) # 800057ec <_Z11printStringPKc>
        return;
    800036cc:	000b0113          	mv	sp,s6
    800036d0:	1500006f          	j	80003820 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    800036d4:	00000593          	li	a1,0
    800036d8:	00009517          	auipc	a0,0x9
    800036dc:	8d850513          	addi	a0,a0,-1832 # 8000bfb0 <_ZL10waitForAll>
    800036e0:	ffffe097          	auipc	ra,0xffffe
    800036e4:	d20080e7          	jalr	-736(ra) # 80001400 <_Z8sem_openPP3Semj>
    thread_t threads[threadNum];
    800036e8:	00391793          	slli	a5,s2,0x3
    800036ec:	00f78793          	addi	a5,a5,15
    800036f0:	ff07f793          	andi	a5,a5,-16
    800036f4:	40f10133          	sub	sp,sp,a5
    800036f8:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    800036fc:	0019071b          	addiw	a4,s2,1
    80003700:	00171793          	slli	a5,a4,0x1
    80003704:	00e787b3          	add	a5,a5,a4
    80003708:	00379793          	slli	a5,a5,0x3
    8000370c:	00f78793          	addi	a5,a5,15
    80003710:	ff07f793          	andi	a5,a5,-16
    80003714:	40f10133          	sub	sp,sp,a5
    80003718:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    8000371c:	00191613          	slli	a2,s2,0x1
    80003720:	012607b3          	add	a5,a2,s2
    80003724:	00379793          	slli	a5,a5,0x3
    80003728:	00f987b3          	add	a5,s3,a5
    8000372c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80003730:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80003734:	00009717          	auipc	a4,0x9
    80003738:	87c73703          	ld	a4,-1924(a4) # 8000bfb0 <_ZL10waitForAll>
    8000373c:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80003740:	00078613          	mv	a2,a5
    80003744:	00000597          	auipc	a1,0x0
    80003748:	d7458593          	addi	a1,a1,-652 # 800034b8 <_ZL8consumerPv>
    8000374c:	f9840513          	addi	a0,s0,-104
    80003750:	ffffe097          	auipc	ra,0xffffe
    80003754:	b88080e7          	jalr	-1144(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80003758:	00000493          	li	s1,0
    8000375c:	0280006f          	j	80003784 <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80003760:	00000597          	auipc	a1,0x0
    80003764:	c1458593          	addi	a1,a1,-1004 # 80003374 <_ZL16producerKeyboardPv>
                      data + i);
    80003768:	00179613          	slli	a2,a5,0x1
    8000376c:	00f60633          	add	a2,a2,a5
    80003770:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    80003774:	00c98633          	add	a2,s3,a2
    80003778:	ffffe097          	auipc	ra,0xffffe
    8000377c:	b60080e7          	jalr	-1184(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80003780:	0014849b          	addiw	s1,s1,1
    80003784:	0524d263          	bge	s1,s2,800037c8 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80003788:	00149793          	slli	a5,s1,0x1
    8000378c:	009787b3          	add	a5,a5,s1
    80003790:	00379793          	slli	a5,a5,0x3
    80003794:	00f987b3          	add	a5,s3,a5
    80003798:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    8000379c:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    800037a0:	00009717          	auipc	a4,0x9
    800037a4:	81073703          	ld	a4,-2032(a4) # 8000bfb0 <_ZL10waitForAll>
    800037a8:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    800037ac:	00048793          	mv	a5,s1
    800037b0:	00349513          	slli	a0,s1,0x3
    800037b4:	00aa8533          	add	a0,s5,a0
    800037b8:	fa9054e3          	blez	s1,80003760 <_Z22producerConsumer_C_APIv+0x1c8>
    800037bc:	00000597          	auipc	a1,0x0
    800037c0:	c6858593          	addi	a1,a1,-920 # 80003424 <_ZL8producerPv>
    800037c4:	fa5ff06f          	j	80003768 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    800037c8:	ffffe097          	auipc	ra,0xffffe
    800037cc:	bf0080e7          	jalr	-1040(ra) # 800013b8 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    800037d0:	00000493          	li	s1,0
    800037d4:	00994e63          	blt	s2,s1,800037f0 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    800037d8:	00008517          	auipc	a0,0x8
    800037dc:	7d853503          	ld	a0,2008(a0) # 8000bfb0 <_ZL10waitForAll>
    800037e0:	ffffe097          	auipc	ra,0xffffe
    800037e4:	cd4080e7          	jalr	-812(ra) # 800014b4 <_Z8sem_waitP3Sem>
    for (int i = 0; i <= threadNum; i++) {
    800037e8:	0014849b          	addiw	s1,s1,1
    800037ec:	fe9ff06f          	j	800037d4 <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    800037f0:	00008517          	auipc	a0,0x8
    800037f4:	7c053503          	ld	a0,1984(a0) # 8000bfb0 <_ZL10waitForAll>
    800037f8:	ffffe097          	auipc	ra,0xffffe
    800037fc:	c64080e7          	jalr	-924(ra) # 8000145c <_Z9sem_closeP3Sem>
    delete buffer;
    80003800:	000a0e63          	beqz	s4,8000381c <_Z22producerConsumer_C_APIv+0x284>
    80003804:	000a0513          	mv	a0,s4
    80003808:	00003097          	auipc	ra,0x3
    8000380c:	154080e7          	jalr	340(ra) # 8000695c <_ZN6BufferD1Ev>
    80003810:	000a0513          	mv	a0,s4
    80003814:	ffffe097          	auipc	ra,0xffffe
    80003818:	700080e7          	jalr	1792(ra) # 80001f14 <_ZdlPv>
    8000381c:	000b0113          	mv	sp,s6

}
    80003820:	f9040113          	addi	sp,s0,-112
    80003824:	06813083          	ld	ra,104(sp)
    80003828:	06013403          	ld	s0,96(sp)
    8000382c:	05813483          	ld	s1,88(sp)
    80003830:	05013903          	ld	s2,80(sp)
    80003834:	04813983          	ld	s3,72(sp)
    80003838:	04013a03          	ld	s4,64(sp)
    8000383c:	03813a83          	ld	s5,56(sp)
    80003840:	03013b03          	ld	s6,48(sp)
    80003844:	07010113          	addi	sp,sp,112
    80003848:	00008067          	ret
    8000384c:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80003850:	000a0513          	mv	a0,s4
    80003854:	ffffe097          	auipc	ra,0xffffe
    80003858:	6c0080e7          	jalr	1728(ra) # 80001f14 <_ZdlPv>
    8000385c:	00048513          	mv	a0,s1
    80003860:	0000a097          	auipc	ra,0xa
    80003864:	868080e7          	jalr	-1944(ra) # 8000d0c8 <_Unwind_Resume>

0000000080003868 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80003868:	fe010113          	addi	sp,sp,-32
    8000386c:	00113c23          	sd	ra,24(sp)
    80003870:	00813823          	sd	s0,16(sp)
    80003874:	00913423          	sd	s1,8(sp)
    80003878:	01213023          	sd	s2,0(sp)
    8000387c:	02010413          	addi	s0,sp,32
    80003880:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80003884:	00100793          	li	a5,1
    80003888:	02a7f863          	bgeu	a5,a0,800038b8 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000388c:	00a00793          	li	a5,10
    80003890:	02f577b3          	remu	a5,a0,a5
    80003894:	02078e63          	beqz	a5,800038d0 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80003898:	fff48513          	addi	a0,s1,-1
    8000389c:	00000097          	auipc	ra,0x0
    800038a0:	fcc080e7          	jalr	-52(ra) # 80003868 <_ZL9fibonaccim>
    800038a4:	00050913          	mv	s2,a0
    800038a8:	ffe48513          	addi	a0,s1,-2
    800038ac:	00000097          	auipc	ra,0x0
    800038b0:	fbc080e7          	jalr	-68(ra) # 80003868 <_ZL9fibonaccim>
    800038b4:	00a90533          	add	a0,s2,a0
}
    800038b8:	01813083          	ld	ra,24(sp)
    800038bc:	01013403          	ld	s0,16(sp)
    800038c0:	00813483          	ld	s1,8(sp)
    800038c4:	00013903          	ld	s2,0(sp)
    800038c8:	02010113          	addi	sp,sp,32
    800038cc:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800038d0:	ffffe097          	auipc	ra,0xffffe
    800038d4:	ae8080e7          	jalr	-1304(ra) # 800013b8 <_Z15thread_dispatchv>
    800038d8:	fc1ff06f          	j	80003898 <_ZL9fibonaccim+0x30>

00000000800038dc <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    800038dc:	fe010113          	addi	sp,sp,-32
    800038e0:	00113c23          	sd	ra,24(sp)
    800038e4:	00813823          	sd	s0,16(sp)
    800038e8:	00913423          	sd	s1,8(sp)
    800038ec:	01213023          	sd	s2,0(sp)
    800038f0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800038f4:	00000913          	li	s2,0
    800038f8:	0380006f          	j	80003930 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800038fc:	ffffe097          	auipc	ra,0xffffe
    80003900:	abc080e7          	jalr	-1348(ra) # 800013b8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003904:	00148493          	addi	s1,s1,1
    80003908:	000027b7          	lui	a5,0x2
    8000390c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003910:	0097ee63          	bltu	a5,s1,8000392c <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003914:	00000713          	li	a4,0
    80003918:	000077b7          	lui	a5,0x7
    8000391c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003920:	fce7eee3          	bltu	a5,a4,800038fc <_ZN7WorkerA11workerBodyAEPv+0x20>
    80003924:	00170713          	addi	a4,a4,1
    80003928:	ff1ff06f          	j	80003918 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    8000392c:	00190913          	addi	s2,s2,1
    80003930:	00900793          	li	a5,9
    80003934:	0527e063          	bltu	a5,s2,80003974 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80003938:	00006517          	auipc	a0,0x6
    8000393c:	8e050513          	addi	a0,a0,-1824 # 80009218 <CONSOLE_STATUS+0x208>
    80003940:	00002097          	auipc	ra,0x2
    80003944:	eac080e7          	jalr	-340(ra) # 800057ec <_Z11printStringPKc>
    80003948:	00000613          	li	a2,0
    8000394c:	00a00593          	li	a1,10
    80003950:	0009051b          	sext.w	a0,s2
    80003954:	00002097          	auipc	ra,0x2
    80003958:	048080e7          	jalr	72(ra) # 8000599c <_Z8printIntiii>
    8000395c:	00006517          	auipc	a0,0x6
    80003960:	b0c50513          	addi	a0,a0,-1268 # 80009468 <CONSOLE_STATUS+0x458>
    80003964:	00002097          	auipc	ra,0x2
    80003968:	e88080e7          	jalr	-376(ra) # 800057ec <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    8000396c:	00000493          	li	s1,0
    80003970:	f99ff06f          	j	80003908 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80003974:	00006517          	auipc	a0,0x6
    80003978:	8ac50513          	addi	a0,a0,-1876 # 80009220 <CONSOLE_STATUS+0x210>
    8000397c:	00002097          	auipc	ra,0x2
    80003980:	e70080e7          	jalr	-400(ra) # 800057ec <_Z11printStringPKc>
    finishedA = true;
    80003984:	00100793          	li	a5,1
    80003988:	00008717          	auipc	a4,0x8
    8000398c:	62f70823          	sb	a5,1584(a4) # 8000bfb8 <_ZL9finishedA>
}
    80003990:	01813083          	ld	ra,24(sp)
    80003994:	01013403          	ld	s0,16(sp)
    80003998:	00813483          	ld	s1,8(sp)
    8000399c:	00013903          	ld	s2,0(sp)
    800039a0:	02010113          	addi	sp,sp,32
    800039a4:	00008067          	ret

00000000800039a8 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    800039a8:	fe010113          	addi	sp,sp,-32
    800039ac:	00113c23          	sd	ra,24(sp)
    800039b0:	00813823          	sd	s0,16(sp)
    800039b4:	00913423          	sd	s1,8(sp)
    800039b8:	01213023          	sd	s2,0(sp)
    800039bc:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    800039c0:	00000913          	li	s2,0
    800039c4:	0380006f          	j	800039fc <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    800039c8:	ffffe097          	auipc	ra,0xffffe
    800039cc:	9f0080e7          	jalr	-1552(ra) # 800013b8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    800039d0:	00148493          	addi	s1,s1,1
    800039d4:	000027b7          	lui	a5,0x2
    800039d8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800039dc:	0097ee63          	bltu	a5,s1,800039f8 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800039e0:	00000713          	li	a4,0
    800039e4:	000077b7          	lui	a5,0x7
    800039e8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800039ec:	fce7eee3          	bltu	a5,a4,800039c8 <_ZN7WorkerB11workerBodyBEPv+0x20>
    800039f0:	00170713          	addi	a4,a4,1
    800039f4:	ff1ff06f          	j	800039e4 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800039f8:	00190913          	addi	s2,s2,1
    800039fc:	00f00793          	li	a5,15
    80003a00:	0527e063          	bltu	a5,s2,80003a40 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80003a04:	00006517          	auipc	a0,0x6
    80003a08:	82c50513          	addi	a0,a0,-2004 # 80009230 <CONSOLE_STATUS+0x220>
    80003a0c:	00002097          	auipc	ra,0x2
    80003a10:	de0080e7          	jalr	-544(ra) # 800057ec <_Z11printStringPKc>
    80003a14:	00000613          	li	a2,0
    80003a18:	00a00593          	li	a1,10
    80003a1c:	0009051b          	sext.w	a0,s2
    80003a20:	00002097          	auipc	ra,0x2
    80003a24:	f7c080e7          	jalr	-132(ra) # 8000599c <_Z8printIntiii>
    80003a28:	00006517          	auipc	a0,0x6
    80003a2c:	a4050513          	addi	a0,a0,-1472 # 80009468 <CONSOLE_STATUS+0x458>
    80003a30:	00002097          	auipc	ra,0x2
    80003a34:	dbc080e7          	jalr	-580(ra) # 800057ec <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003a38:	00000493          	li	s1,0
    80003a3c:	f99ff06f          	j	800039d4 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80003a40:	00005517          	auipc	a0,0x5
    80003a44:	7f850513          	addi	a0,a0,2040 # 80009238 <CONSOLE_STATUS+0x228>
    80003a48:	00002097          	auipc	ra,0x2
    80003a4c:	da4080e7          	jalr	-604(ra) # 800057ec <_Z11printStringPKc>
    finishedB = true;
    80003a50:	00100793          	li	a5,1
    80003a54:	00008717          	auipc	a4,0x8
    80003a58:	56f702a3          	sb	a5,1381(a4) # 8000bfb9 <_ZL9finishedB>
    thread_dispatch();
    80003a5c:	ffffe097          	auipc	ra,0xffffe
    80003a60:	95c080e7          	jalr	-1700(ra) # 800013b8 <_Z15thread_dispatchv>
}
    80003a64:	01813083          	ld	ra,24(sp)
    80003a68:	01013403          	ld	s0,16(sp)
    80003a6c:	00813483          	ld	s1,8(sp)
    80003a70:	00013903          	ld	s2,0(sp)
    80003a74:	02010113          	addi	sp,sp,32
    80003a78:	00008067          	ret

0000000080003a7c <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80003a7c:	fe010113          	addi	sp,sp,-32
    80003a80:	00113c23          	sd	ra,24(sp)
    80003a84:	00813823          	sd	s0,16(sp)
    80003a88:	00913423          	sd	s1,8(sp)
    80003a8c:	01213023          	sd	s2,0(sp)
    80003a90:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80003a94:	00000493          	li	s1,0
    80003a98:	0400006f          	j	80003ad8 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80003a9c:	00005517          	auipc	a0,0x5
    80003aa0:	7ac50513          	addi	a0,a0,1964 # 80009248 <CONSOLE_STATUS+0x238>
    80003aa4:	00002097          	auipc	ra,0x2
    80003aa8:	d48080e7          	jalr	-696(ra) # 800057ec <_Z11printStringPKc>
    80003aac:	00000613          	li	a2,0
    80003ab0:	00a00593          	li	a1,10
    80003ab4:	00048513          	mv	a0,s1
    80003ab8:	00002097          	auipc	ra,0x2
    80003abc:	ee4080e7          	jalr	-284(ra) # 8000599c <_Z8printIntiii>
    80003ac0:	00006517          	auipc	a0,0x6
    80003ac4:	9a850513          	addi	a0,a0,-1624 # 80009468 <CONSOLE_STATUS+0x458>
    80003ac8:	00002097          	auipc	ra,0x2
    80003acc:	d24080e7          	jalr	-732(ra) # 800057ec <_Z11printStringPKc>
    for (; i < 3; i++) {
    80003ad0:	0014849b          	addiw	s1,s1,1
    80003ad4:	0ff4f493          	andi	s1,s1,255
    80003ad8:	00200793          	li	a5,2
    80003adc:	fc97f0e3          	bgeu	a5,s1,80003a9c <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80003ae0:	00005517          	auipc	a0,0x5
    80003ae4:	77050513          	addi	a0,a0,1904 # 80009250 <CONSOLE_STATUS+0x240>
    80003ae8:	00002097          	auipc	ra,0x2
    80003aec:	d04080e7          	jalr	-764(ra) # 800057ec <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80003af0:	00700313          	li	t1,7
    thread_dispatch();
    80003af4:	ffffe097          	auipc	ra,0xffffe
    80003af8:	8c4080e7          	jalr	-1852(ra) # 800013b8 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80003afc:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80003b00:	00005517          	auipc	a0,0x5
    80003b04:	76050513          	addi	a0,a0,1888 # 80009260 <CONSOLE_STATUS+0x250>
    80003b08:	00002097          	auipc	ra,0x2
    80003b0c:	ce4080e7          	jalr	-796(ra) # 800057ec <_Z11printStringPKc>
    80003b10:	00000613          	li	a2,0
    80003b14:	00a00593          	li	a1,10
    80003b18:	0009051b          	sext.w	a0,s2
    80003b1c:	00002097          	auipc	ra,0x2
    80003b20:	e80080e7          	jalr	-384(ra) # 8000599c <_Z8printIntiii>
    80003b24:	00006517          	auipc	a0,0x6
    80003b28:	94450513          	addi	a0,a0,-1724 # 80009468 <CONSOLE_STATUS+0x458>
    80003b2c:	00002097          	auipc	ra,0x2
    80003b30:	cc0080e7          	jalr	-832(ra) # 800057ec <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80003b34:	00c00513          	li	a0,12
    80003b38:	00000097          	auipc	ra,0x0
    80003b3c:	d30080e7          	jalr	-720(ra) # 80003868 <_ZL9fibonaccim>
    80003b40:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80003b44:	00005517          	auipc	a0,0x5
    80003b48:	72450513          	addi	a0,a0,1828 # 80009268 <CONSOLE_STATUS+0x258>
    80003b4c:	00002097          	auipc	ra,0x2
    80003b50:	ca0080e7          	jalr	-864(ra) # 800057ec <_Z11printStringPKc>
    80003b54:	00000613          	li	a2,0
    80003b58:	00a00593          	li	a1,10
    80003b5c:	0009051b          	sext.w	a0,s2
    80003b60:	00002097          	auipc	ra,0x2
    80003b64:	e3c080e7          	jalr	-452(ra) # 8000599c <_Z8printIntiii>
    80003b68:	00006517          	auipc	a0,0x6
    80003b6c:	90050513          	addi	a0,a0,-1792 # 80009468 <CONSOLE_STATUS+0x458>
    80003b70:	00002097          	auipc	ra,0x2
    80003b74:	c7c080e7          	jalr	-900(ra) # 800057ec <_Z11printStringPKc>
    80003b78:	0400006f          	j	80003bb8 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80003b7c:	00005517          	auipc	a0,0x5
    80003b80:	6cc50513          	addi	a0,a0,1740 # 80009248 <CONSOLE_STATUS+0x238>
    80003b84:	00002097          	auipc	ra,0x2
    80003b88:	c68080e7          	jalr	-920(ra) # 800057ec <_Z11printStringPKc>
    80003b8c:	00000613          	li	a2,0
    80003b90:	00a00593          	li	a1,10
    80003b94:	00048513          	mv	a0,s1
    80003b98:	00002097          	auipc	ra,0x2
    80003b9c:	e04080e7          	jalr	-508(ra) # 8000599c <_Z8printIntiii>
    80003ba0:	00006517          	auipc	a0,0x6
    80003ba4:	8c850513          	addi	a0,a0,-1848 # 80009468 <CONSOLE_STATUS+0x458>
    80003ba8:	00002097          	auipc	ra,0x2
    80003bac:	c44080e7          	jalr	-956(ra) # 800057ec <_Z11printStringPKc>
    for (; i < 6; i++) {
    80003bb0:	0014849b          	addiw	s1,s1,1
    80003bb4:	0ff4f493          	andi	s1,s1,255
    80003bb8:	00500793          	li	a5,5
    80003bbc:	fc97f0e3          	bgeu	a5,s1,80003b7c <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80003bc0:	00005517          	auipc	a0,0x5
    80003bc4:	66050513          	addi	a0,a0,1632 # 80009220 <CONSOLE_STATUS+0x210>
    80003bc8:	00002097          	auipc	ra,0x2
    80003bcc:	c24080e7          	jalr	-988(ra) # 800057ec <_Z11printStringPKc>
    finishedC = true;
    80003bd0:	00100793          	li	a5,1
    80003bd4:	00008717          	auipc	a4,0x8
    80003bd8:	3ef70323          	sb	a5,998(a4) # 8000bfba <_ZL9finishedC>
    thread_dispatch();
    80003bdc:	ffffd097          	auipc	ra,0xffffd
    80003be0:	7dc080e7          	jalr	2012(ra) # 800013b8 <_Z15thread_dispatchv>
}
    80003be4:	01813083          	ld	ra,24(sp)
    80003be8:	01013403          	ld	s0,16(sp)
    80003bec:	00813483          	ld	s1,8(sp)
    80003bf0:	00013903          	ld	s2,0(sp)
    80003bf4:	02010113          	addi	sp,sp,32
    80003bf8:	00008067          	ret

0000000080003bfc <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80003bfc:	fe010113          	addi	sp,sp,-32
    80003c00:	00113c23          	sd	ra,24(sp)
    80003c04:	00813823          	sd	s0,16(sp)
    80003c08:	00913423          	sd	s1,8(sp)
    80003c0c:	01213023          	sd	s2,0(sp)
    80003c10:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80003c14:	00a00493          	li	s1,10
    80003c18:	0400006f          	j	80003c58 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003c1c:	00005517          	auipc	a0,0x5
    80003c20:	65c50513          	addi	a0,a0,1628 # 80009278 <CONSOLE_STATUS+0x268>
    80003c24:	00002097          	auipc	ra,0x2
    80003c28:	bc8080e7          	jalr	-1080(ra) # 800057ec <_Z11printStringPKc>
    80003c2c:	00000613          	li	a2,0
    80003c30:	00a00593          	li	a1,10
    80003c34:	00048513          	mv	a0,s1
    80003c38:	00002097          	auipc	ra,0x2
    80003c3c:	d64080e7          	jalr	-668(ra) # 8000599c <_Z8printIntiii>
    80003c40:	00006517          	auipc	a0,0x6
    80003c44:	82850513          	addi	a0,a0,-2008 # 80009468 <CONSOLE_STATUS+0x458>
    80003c48:	00002097          	auipc	ra,0x2
    80003c4c:	ba4080e7          	jalr	-1116(ra) # 800057ec <_Z11printStringPKc>
    for (; i < 13; i++) {
    80003c50:	0014849b          	addiw	s1,s1,1
    80003c54:	0ff4f493          	andi	s1,s1,255
    80003c58:	00c00793          	li	a5,12
    80003c5c:	fc97f0e3          	bgeu	a5,s1,80003c1c <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80003c60:	00005517          	auipc	a0,0x5
    80003c64:	62050513          	addi	a0,a0,1568 # 80009280 <CONSOLE_STATUS+0x270>
    80003c68:	00002097          	auipc	ra,0x2
    80003c6c:	b84080e7          	jalr	-1148(ra) # 800057ec <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80003c70:	00500313          	li	t1,5
    thread_dispatch();
    80003c74:	ffffd097          	auipc	ra,0xffffd
    80003c78:	744080e7          	jalr	1860(ra) # 800013b8 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80003c7c:	01000513          	li	a0,16
    80003c80:	00000097          	auipc	ra,0x0
    80003c84:	be8080e7          	jalr	-1048(ra) # 80003868 <_ZL9fibonaccim>
    80003c88:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80003c8c:	00005517          	auipc	a0,0x5
    80003c90:	60450513          	addi	a0,a0,1540 # 80009290 <CONSOLE_STATUS+0x280>
    80003c94:	00002097          	auipc	ra,0x2
    80003c98:	b58080e7          	jalr	-1192(ra) # 800057ec <_Z11printStringPKc>
    80003c9c:	00000613          	li	a2,0
    80003ca0:	00a00593          	li	a1,10
    80003ca4:	0009051b          	sext.w	a0,s2
    80003ca8:	00002097          	auipc	ra,0x2
    80003cac:	cf4080e7          	jalr	-780(ra) # 8000599c <_Z8printIntiii>
    80003cb0:	00005517          	auipc	a0,0x5
    80003cb4:	7b850513          	addi	a0,a0,1976 # 80009468 <CONSOLE_STATUS+0x458>
    80003cb8:	00002097          	auipc	ra,0x2
    80003cbc:	b34080e7          	jalr	-1228(ra) # 800057ec <_Z11printStringPKc>
    80003cc0:	0400006f          	j	80003d00 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003cc4:	00005517          	auipc	a0,0x5
    80003cc8:	5b450513          	addi	a0,a0,1460 # 80009278 <CONSOLE_STATUS+0x268>
    80003ccc:	00002097          	auipc	ra,0x2
    80003cd0:	b20080e7          	jalr	-1248(ra) # 800057ec <_Z11printStringPKc>
    80003cd4:	00000613          	li	a2,0
    80003cd8:	00a00593          	li	a1,10
    80003cdc:	00048513          	mv	a0,s1
    80003ce0:	00002097          	auipc	ra,0x2
    80003ce4:	cbc080e7          	jalr	-836(ra) # 8000599c <_Z8printIntiii>
    80003ce8:	00005517          	auipc	a0,0x5
    80003cec:	78050513          	addi	a0,a0,1920 # 80009468 <CONSOLE_STATUS+0x458>
    80003cf0:	00002097          	auipc	ra,0x2
    80003cf4:	afc080e7          	jalr	-1284(ra) # 800057ec <_Z11printStringPKc>
    for (; i < 16; i++) {
    80003cf8:	0014849b          	addiw	s1,s1,1
    80003cfc:	0ff4f493          	andi	s1,s1,255
    80003d00:	00f00793          	li	a5,15
    80003d04:	fc97f0e3          	bgeu	a5,s1,80003cc4 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80003d08:	00005517          	auipc	a0,0x5
    80003d0c:	59850513          	addi	a0,a0,1432 # 800092a0 <CONSOLE_STATUS+0x290>
    80003d10:	00002097          	auipc	ra,0x2
    80003d14:	adc080e7          	jalr	-1316(ra) # 800057ec <_Z11printStringPKc>
    finishedD = true;
    80003d18:	00100793          	li	a5,1
    80003d1c:	00008717          	auipc	a4,0x8
    80003d20:	28f70fa3          	sb	a5,671(a4) # 8000bfbb <_ZL9finishedD>
    thread_dispatch();
    80003d24:	ffffd097          	auipc	ra,0xffffd
    80003d28:	694080e7          	jalr	1684(ra) # 800013b8 <_Z15thread_dispatchv>
}
    80003d2c:	01813083          	ld	ra,24(sp)
    80003d30:	01013403          	ld	s0,16(sp)
    80003d34:	00813483          	ld	s1,8(sp)
    80003d38:	00013903          	ld	s2,0(sp)
    80003d3c:	02010113          	addi	sp,sp,32
    80003d40:	00008067          	ret

0000000080003d44 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80003d44:	fc010113          	addi	sp,sp,-64
    80003d48:	02113c23          	sd	ra,56(sp)
    80003d4c:	02813823          	sd	s0,48(sp)
    80003d50:	02913423          	sd	s1,40(sp)
    80003d54:	03213023          	sd	s2,32(sp)
    80003d58:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80003d5c:	02000513          	li	a0,32
    80003d60:	ffffe097          	auipc	ra,0xffffe
    80003d64:	164080e7          	jalr	356(ra) # 80001ec4 <_Znwm>
    80003d68:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80003d6c:	ffffe097          	auipc	ra,0xffffe
    80003d70:	278080e7          	jalr	632(ra) # 80001fe4 <_ZN6ThreadC1Ev>
    80003d74:	00008797          	auipc	a5,0x8
    80003d78:	d7c78793          	addi	a5,a5,-644 # 8000baf0 <_ZTV7WorkerA+0x10>
    80003d7c:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80003d80:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80003d84:	00005517          	auipc	a0,0x5
    80003d88:	52c50513          	addi	a0,a0,1324 # 800092b0 <CONSOLE_STATUS+0x2a0>
    80003d8c:	00002097          	auipc	ra,0x2
    80003d90:	a60080e7          	jalr	-1440(ra) # 800057ec <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80003d94:	02000513          	li	a0,32
    80003d98:	ffffe097          	auipc	ra,0xffffe
    80003d9c:	12c080e7          	jalr	300(ra) # 80001ec4 <_Znwm>
    80003da0:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80003da4:	ffffe097          	auipc	ra,0xffffe
    80003da8:	240080e7          	jalr	576(ra) # 80001fe4 <_ZN6ThreadC1Ev>
    80003dac:	00008797          	auipc	a5,0x8
    80003db0:	d6c78793          	addi	a5,a5,-660 # 8000bb18 <_ZTV7WorkerB+0x10>
    80003db4:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80003db8:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80003dbc:	00005517          	auipc	a0,0x5
    80003dc0:	50c50513          	addi	a0,a0,1292 # 800092c8 <CONSOLE_STATUS+0x2b8>
    80003dc4:	00002097          	auipc	ra,0x2
    80003dc8:	a28080e7          	jalr	-1496(ra) # 800057ec <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80003dcc:	02000513          	li	a0,32
    80003dd0:	ffffe097          	auipc	ra,0xffffe
    80003dd4:	0f4080e7          	jalr	244(ra) # 80001ec4 <_Znwm>
    80003dd8:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80003ddc:	ffffe097          	auipc	ra,0xffffe
    80003de0:	208080e7          	jalr	520(ra) # 80001fe4 <_ZN6ThreadC1Ev>
    80003de4:	00008797          	auipc	a5,0x8
    80003de8:	d5c78793          	addi	a5,a5,-676 # 8000bb40 <_ZTV7WorkerC+0x10>
    80003dec:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80003df0:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80003df4:	00005517          	auipc	a0,0x5
    80003df8:	4ec50513          	addi	a0,a0,1260 # 800092e0 <CONSOLE_STATUS+0x2d0>
    80003dfc:	00002097          	auipc	ra,0x2
    80003e00:	9f0080e7          	jalr	-1552(ra) # 800057ec <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80003e04:	02000513          	li	a0,32
    80003e08:	ffffe097          	auipc	ra,0xffffe
    80003e0c:	0bc080e7          	jalr	188(ra) # 80001ec4 <_Znwm>
    80003e10:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80003e14:	ffffe097          	auipc	ra,0xffffe
    80003e18:	1d0080e7          	jalr	464(ra) # 80001fe4 <_ZN6ThreadC1Ev>
    80003e1c:	00008797          	auipc	a5,0x8
    80003e20:	d4c78793          	addi	a5,a5,-692 # 8000bb68 <_ZTV7WorkerD+0x10>
    80003e24:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80003e28:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80003e2c:	00005517          	auipc	a0,0x5
    80003e30:	4cc50513          	addi	a0,a0,1228 # 800092f8 <CONSOLE_STATUS+0x2e8>
    80003e34:	00002097          	auipc	ra,0x2
    80003e38:	9b8080e7          	jalr	-1608(ra) # 800057ec <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80003e3c:	00000493          	li	s1,0
    80003e40:	00300793          	li	a5,3
    80003e44:	0297c663          	blt	a5,s1,80003e70 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80003e48:	00349793          	slli	a5,s1,0x3
    80003e4c:	fe040713          	addi	a4,s0,-32
    80003e50:	00f707b3          	add	a5,a4,a5
    80003e54:	fe07b503          	ld	a0,-32(a5)
    80003e58:	ffffe097          	auipc	ra,0xffffe
    80003e5c:	228080e7          	jalr	552(ra) # 80002080 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80003e60:	0014849b          	addiw	s1,s1,1
    80003e64:	fddff06f          	j	80003e40 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80003e68:	ffffe097          	auipc	ra,0xffffe
    80003e6c:	1ac080e7          	jalr	428(ra) # 80002014 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80003e70:	00008797          	auipc	a5,0x8
    80003e74:	1487c783          	lbu	a5,328(a5) # 8000bfb8 <_ZL9finishedA>
    80003e78:	fe0788e3          	beqz	a5,80003e68 <_Z20Threads_CPP_API_testv+0x124>
    80003e7c:	00008797          	auipc	a5,0x8
    80003e80:	13d7c783          	lbu	a5,317(a5) # 8000bfb9 <_ZL9finishedB>
    80003e84:	fe0782e3          	beqz	a5,80003e68 <_Z20Threads_CPP_API_testv+0x124>
    80003e88:	00008797          	auipc	a5,0x8
    80003e8c:	1327c783          	lbu	a5,306(a5) # 8000bfba <_ZL9finishedC>
    80003e90:	fc078ce3          	beqz	a5,80003e68 <_Z20Threads_CPP_API_testv+0x124>
    80003e94:	00008797          	auipc	a5,0x8
    80003e98:	1277c783          	lbu	a5,295(a5) # 8000bfbb <_ZL9finishedD>
    80003e9c:	fc0786e3          	beqz	a5,80003e68 <_Z20Threads_CPP_API_testv+0x124>
    80003ea0:	fc040493          	addi	s1,s0,-64
    80003ea4:	0080006f          	j	80003eac <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    80003ea8:	00848493          	addi	s1,s1,8
    80003eac:	fe040793          	addi	a5,s0,-32
    80003eb0:	08f48663          	beq	s1,a5,80003f3c <_Z20Threads_CPP_API_testv+0x1f8>
    80003eb4:	0004b503          	ld	a0,0(s1)
    80003eb8:	fe0508e3          	beqz	a0,80003ea8 <_Z20Threads_CPP_API_testv+0x164>
    80003ebc:	00053783          	ld	a5,0(a0)
    80003ec0:	0087b783          	ld	a5,8(a5)
    80003ec4:	000780e7          	jalr	a5
    80003ec8:	fe1ff06f          	j	80003ea8 <_Z20Threads_CPP_API_testv+0x164>
    80003ecc:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80003ed0:	00048513          	mv	a0,s1
    80003ed4:	ffffe097          	auipc	ra,0xffffe
    80003ed8:	040080e7          	jalr	64(ra) # 80001f14 <_ZdlPv>
    80003edc:	00090513          	mv	a0,s2
    80003ee0:	00009097          	auipc	ra,0x9
    80003ee4:	1e8080e7          	jalr	488(ra) # 8000d0c8 <_Unwind_Resume>
    80003ee8:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    80003eec:	00048513          	mv	a0,s1
    80003ef0:	ffffe097          	auipc	ra,0xffffe
    80003ef4:	024080e7          	jalr	36(ra) # 80001f14 <_ZdlPv>
    80003ef8:	00090513          	mv	a0,s2
    80003efc:	00009097          	auipc	ra,0x9
    80003f00:	1cc080e7          	jalr	460(ra) # 8000d0c8 <_Unwind_Resume>
    80003f04:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    80003f08:	00048513          	mv	a0,s1
    80003f0c:	ffffe097          	auipc	ra,0xffffe
    80003f10:	008080e7          	jalr	8(ra) # 80001f14 <_ZdlPv>
    80003f14:	00090513          	mv	a0,s2
    80003f18:	00009097          	auipc	ra,0x9
    80003f1c:	1b0080e7          	jalr	432(ra) # 8000d0c8 <_Unwind_Resume>
    80003f20:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    80003f24:	00048513          	mv	a0,s1
    80003f28:	ffffe097          	auipc	ra,0xffffe
    80003f2c:	fec080e7          	jalr	-20(ra) # 80001f14 <_ZdlPv>
    80003f30:	00090513          	mv	a0,s2
    80003f34:	00009097          	auipc	ra,0x9
    80003f38:	194080e7          	jalr	404(ra) # 8000d0c8 <_Unwind_Resume>
}
    80003f3c:	03813083          	ld	ra,56(sp)
    80003f40:	03013403          	ld	s0,48(sp)
    80003f44:	02813483          	ld	s1,40(sp)
    80003f48:	02013903          	ld	s2,32(sp)
    80003f4c:	04010113          	addi	sp,sp,64
    80003f50:	00008067          	ret

0000000080003f54 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80003f54:	ff010113          	addi	sp,sp,-16
    80003f58:	00113423          	sd	ra,8(sp)
    80003f5c:	00813023          	sd	s0,0(sp)
    80003f60:	01010413          	addi	s0,sp,16
    80003f64:	00008797          	auipc	a5,0x8
    80003f68:	b8c78793          	addi	a5,a5,-1140 # 8000baf0 <_ZTV7WorkerA+0x10>
    80003f6c:	00f53023          	sd	a5,0(a0)
    80003f70:	ffffe097          	auipc	ra,0xffffe
    80003f74:	ee4080e7          	jalr	-284(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80003f78:	00813083          	ld	ra,8(sp)
    80003f7c:	00013403          	ld	s0,0(sp)
    80003f80:	01010113          	addi	sp,sp,16
    80003f84:	00008067          	ret

0000000080003f88 <_ZN7WorkerAD0Ev>:
    80003f88:	fe010113          	addi	sp,sp,-32
    80003f8c:	00113c23          	sd	ra,24(sp)
    80003f90:	00813823          	sd	s0,16(sp)
    80003f94:	00913423          	sd	s1,8(sp)
    80003f98:	02010413          	addi	s0,sp,32
    80003f9c:	00050493          	mv	s1,a0
    80003fa0:	00008797          	auipc	a5,0x8
    80003fa4:	b5078793          	addi	a5,a5,-1200 # 8000baf0 <_ZTV7WorkerA+0x10>
    80003fa8:	00f53023          	sd	a5,0(a0)
    80003fac:	ffffe097          	auipc	ra,0xffffe
    80003fb0:	ea8080e7          	jalr	-344(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80003fb4:	00048513          	mv	a0,s1
    80003fb8:	ffffe097          	auipc	ra,0xffffe
    80003fbc:	f5c080e7          	jalr	-164(ra) # 80001f14 <_ZdlPv>
    80003fc0:	01813083          	ld	ra,24(sp)
    80003fc4:	01013403          	ld	s0,16(sp)
    80003fc8:	00813483          	ld	s1,8(sp)
    80003fcc:	02010113          	addi	sp,sp,32
    80003fd0:	00008067          	ret

0000000080003fd4 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80003fd4:	ff010113          	addi	sp,sp,-16
    80003fd8:	00113423          	sd	ra,8(sp)
    80003fdc:	00813023          	sd	s0,0(sp)
    80003fe0:	01010413          	addi	s0,sp,16
    80003fe4:	00008797          	auipc	a5,0x8
    80003fe8:	b3478793          	addi	a5,a5,-1228 # 8000bb18 <_ZTV7WorkerB+0x10>
    80003fec:	00f53023          	sd	a5,0(a0)
    80003ff0:	ffffe097          	auipc	ra,0xffffe
    80003ff4:	e64080e7          	jalr	-412(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80003ff8:	00813083          	ld	ra,8(sp)
    80003ffc:	00013403          	ld	s0,0(sp)
    80004000:	01010113          	addi	sp,sp,16
    80004004:	00008067          	ret

0000000080004008 <_ZN7WorkerBD0Ev>:
    80004008:	fe010113          	addi	sp,sp,-32
    8000400c:	00113c23          	sd	ra,24(sp)
    80004010:	00813823          	sd	s0,16(sp)
    80004014:	00913423          	sd	s1,8(sp)
    80004018:	02010413          	addi	s0,sp,32
    8000401c:	00050493          	mv	s1,a0
    80004020:	00008797          	auipc	a5,0x8
    80004024:	af878793          	addi	a5,a5,-1288 # 8000bb18 <_ZTV7WorkerB+0x10>
    80004028:	00f53023          	sd	a5,0(a0)
    8000402c:	ffffe097          	auipc	ra,0xffffe
    80004030:	e28080e7          	jalr	-472(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80004034:	00048513          	mv	a0,s1
    80004038:	ffffe097          	auipc	ra,0xffffe
    8000403c:	edc080e7          	jalr	-292(ra) # 80001f14 <_ZdlPv>
    80004040:	01813083          	ld	ra,24(sp)
    80004044:	01013403          	ld	s0,16(sp)
    80004048:	00813483          	ld	s1,8(sp)
    8000404c:	02010113          	addi	sp,sp,32
    80004050:	00008067          	ret

0000000080004054 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80004054:	ff010113          	addi	sp,sp,-16
    80004058:	00113423          	sd	ra,8(sp)
    8000405c:	00813023          	sd	s0,0(sp)
    80004060:	01010413          	addi	s0,sp,16
    80004064:	00008797          	auipc	a5,0x8
    80004068:	adc78793          	addi	a5,a5,-1316 # 8000bb40 <_ZTV7WorkerC+0x10>
    8000406c:	00f53023          	sd	a5,0(a0)
    80004070:	ffffe097          	auipc	ra,0xffffe
    80004074:	de4080e7          	jalr	-540(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80004078:	00813083          	ld	ra,8(sp)
    8000407c:	00013403          	ld	s0,0(sp)
    80004080:	01010113          	addi	sp,sp,16
    80004084:	00008067          	ret

0000000080004088 <_ZN7WorkerCD0Ev>:
    80004088:	fe010113          	addi	sp,sp,-32
    8000408c:	00113c23          	sd	ra,24(sp)
    80004090:	00813823          	sd	s0,16(sp)
    80004094:	00913423          	sd	s1,8(sp)
    80004098:	02010413          	addi	s0,sp,32
    8000409c:	00050493          	mv	s1,a0
    800040a0:	00008797          	auipc	a5,0x8
    800040a4:	aa078793          	addi	a5,a5,-1376 # 8000bb40 <_ZTV7WorkerC+0x10>
    800040a8:	00f53023          	sd	a5,0(a0)
    800040ac:	ffffe097          	auipc	ra,0xffffe
    800040b0:	da8080e7          	jalr	-600(ra) # 80001e54 <_ZN6ThreadD1Ev>
    800040b4:	00048513          	mv	a0,s1
    800040b8:	ffffe097          	auipc	ra,0xffffe
    800040bc:	e5c080e7          	jalr	-420(ra) # 80001f14 <_ZdlPv>
    800040c0:	01813083          	ld	ra,24(sp)
    800040c4:	01013403          	ld	s0,16(sp)
    800040c8:	00813483          	ld	s1,8(sp)
    800040cc:	02010113          	addi	sp,sp,32
    800040d0:	00008067          	ret

00000000800040d4 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    800040d4:	ff010113          	addi	sp,sp,-16
    800040d8:	00113423          	sd	ra,8(sp)
    800040dc:	00813023          	sd	s0,0(sp)
    800040e0:	01010413          	addi	s0,sp,16
    800040e4:	00008797          	auipc	a5,0x8
    800040e8:	a8478793          	addi	a5,a5,-1404 # 8000bb68 <_ZTV7WorkerD+0x10>
    800040ec:	00f53023          	sd	a5,0(a0)
    800040f0:	ffffe097          	auipc	ra,0xffffe
    800040f4:	d64080e7          	jalr	-668(ra) # 80001e54 <_ZN6ThreadD1Ev>
    800040f8:	00813083          	ld	ra,8(sp)
    800040fc:	00013403          	ld	s0,0(sp)
    80004100:	01010113          	addi	sp,sp,16
    80004104:	00008067          	ret

0000000080004108 <_ZN7WorkerDD0Ev>:
    80004108:	fe010113          	addi	sp,sp,-32
    8000410c:	00113c23          	sd	ra,24(sp)
    80004110:	00813823          	sd	s0,16(sp)
    80004114:	00913423          	sd	s1,8(sp)
    80004118:	02010413          	addi	s0,sp,32
    8000411c:	00050493          	mv	s1,a0
    80004120:	00008797          	auipc	a5,0x8
    80004124:	a4878793          	addi	a5,a5,-1464 # 8000bb68 <_ZTV7WorkerD+0x10>
    80004128:	00f53023          	sd	a5,0(a0)
    8000412c:	ffffe097          	auipc	ra,0xffffe
    80004130:	d28080e7          	jalr	-728(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80004134:	00048513          	mv	a0,s1
    80004138:	ffffe097          	auipc	ra,0xffffe
    8000413c:	ddc080e7          	jalr	-548(ra) # 80001f14 <_ZdlPv>
    80004140:	01813083          	ld	ra,24(sp)
    80004144:	01013403          	ld	s0,16(sp)
    80004148:	00813483          	ld	s1,8(sp)
    8000414c:	02010113          	addi	sp,sp,32
    80004150:	00008067          	ret

0000000080004154 <_ZN7WorkerA3runEv>:
    void run() override {
    80004154:	ff010113          	addi	sp,sp,-16
    80004158:	00113423          	sd	ra,8(sp)
    8000415c:	00813023          	sd	s0,0(sp)
    80004160:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80004164:	00000593          	li	a1,0
    80004168:	fffff097          	auipc	ra,0xfffff
    8000416c:	774080e7          	jalr	1908(ra) # 800038dc <_ZN7WorkerA11workerBodyAEPv>
    }
    80004170:	00813083          	ld	ra,8(sp)
    80004174:	00013403          	ld	s0,0(sp)
    80004178:	01010113          	addi	sp,sp,16
    8000417c:	00008067          	ret

0000000080004180 <_ZN7WorkerB3runEv>:
    void run() override {
    80004180:	ff010113          	addi	sp,sp,-16
    80004184:	00113423          	sd	ra,8(sp)
    80004188:	00813023          	sd	s0,0(sp)
    8000418c:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80004190:	00000593          	li	a1,0
    80004194:	00000097          	auipc	ra,0x0
    80004198:	814080e7          	jalr	-2028(ra) # 800039a8 <_ZN7WorkerB11workerBodyBEPv>
    }
    8000419c:	00813083          	ld	ra,8(sp)
    800041a0:	00013403          	ld	s0,0(sp)
    800041a4:	01010113          	addi	sp,sp,16
    800041a8:	00008067          	ret

00000000800041ac <_ZN7WorkerC3runEv>:
    void run() override {
    800041ac:	ff010113          	addi	sp,sp,-16
    800041b0:	00113423          	sd	ra,8(sp)
    800041b4:	00813023          	sd	s0,0(sp)
    800041b8:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    800041bc:	00000593          	li	a1,0
    800041c0:	00000097          	auipc	ra,0x0
    800041c4:	8bc080e7          	jalr	-1860(ra) # 80003a7c <_ZN7WorkerC11workerBodyCEPv>
    }
    800041c8:	00813083          	ld	ra,8(sp)
    800041cc:	00013403          	ld	s0,0(sp)
    800041d0:	01010113          	addi	sp,sp,16
    800041d4:	00008067          	ret

00000000800041d8 <_ZN7WorkerD3runEv>:
    void run() override {
    800041d8:	ff010113          	addi	sp,sp,-16
    800041dc:	00113423          	sd	ra,8(sp)
    800041e0:	00813023          	sd	s0,0(sp)
    800041e4:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800041e8:	00000593          	li	a1,0
    800041ec:	00000097          	auipc	ra,0x0
    800041f0:	a10080e7          	jalr	-1520(ra) # 80003bfc <_ZN7WorkerD11workerBodyDEPv>
    }
    800041f4:	00813083          	ld	ra,8(sp)
    800041f8:	00013403          	ld	s0,0(sp)
    800041fc:	01010113          	addi	sp,sp,16
    80004200:	00008067          	ret

0000000080004204 <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    80004204:	f8010113          	addi	sp,sp,-128
    80004208:	06113c23          	sd	ra,120(sp)
    8000420c:	06813823          	sd	s0,112(sp)
    80004210:	06913423          	sd	s1,104(sp)
    80004214:	07213023          	sd	s2,96(sp)
    80004218:	05313c23          	sd	s3,88(sp)
    8000421c:	05413823          	sd	s4,80(sp)
    80004220:	05513423          	sd	s5,72(sp)
    80004224:	05613023          	sd	s6,64(sp)
    80004228:	03713c23          	sd	s7,56(sp)
    8000422c:	03813823          	sd	s8,48(sp)
    80004230:	03913423          	sd	s9,40(sp)
    80004234:	08010413          	addi	s0,sp,128
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    80004238:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    8000423c:	00005517          	auipc	a0,0x5
    80004240:	ef450513          	addi	a0,a0,-268 # 80009130 <CONSOLE_STATUS+0x120>
    80004244:	00001097          	auipc	ra,0x1
    80004248:	5a8080e7          	jalr	1448(ra) # 800057ec <_Z11printStringPKc>
    getString(input, 30);
    8000424c:	01e00593          	li	a1,30
    80004250:	f8040493          	addi	s1,s0,-128
    80004254:	00048513          	mv	a0,s1
    80004258:	00001097          	auipc	ra,0x1
    8000425c:	61c080e7          	jalr	1564(ra) # 80005874 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80004260:	00048513          	mv	a0,s1
    80004264:	00001097          	auipc	ra,0x1
    80004268:	6e8080e7          	jalr	1768(ra) # 8000594c <_Z11stringToIntPKc>
    8000426c:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    80004270:	00005517          	auipc	a0,0x5
    80004274:	ee050513          	addi	a0,a0,-288 # 80009150 <CONSOLE_STATUS+0x140>
    80004278:	00001097          	auipc	ra,0x1
    8000427c:	574080e7          	jalr	1396(ra) # 800057ec <_Z11printStringPKc>
    getString(input, 30);
    80004280:	01e00593          	li	a1,30
    80004284:	00048513          	mv	a0,s1
    80004288:	00001097          	auipc	ra,0x1
    8000428c:	5ec080e7          	jalr	1516(ra) # 80005874 <_Z9getStringPci>
    n = stringToInt(input);
    80004290:	00048513          	mv	a0,s1
    80004294:	00001097          	auipc	ra,0x1
    80004298:	6b8080e7          	jalr	1720(ra) # 8000594c <_Z11stringToIntPKc>
    8000429c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    800042a0:	00005517          	auipc	a0,0x5
    800042a4:	ed050513          	addi	a0,a0,-304 # 80009170 <CONSOLE_STATUS+0x160>
    800042a8:	00001097          	auipc	ra,0x1
    800042ac:	544080e7          	jalr	1348(ra) # 800057ec <_Z11printStringPKc>
    printInt(threadNum);
    800042b0:	00000613          	li	a2,0
    800042b4:	00a00593          	li	a1,10
    800042b8:	00098513          	mv	a0,s3
    800042bc:	00001097          	auipc	ra,0x1
    800042c0:	6e0080e7          	jalr	1760(ra) # 8000599c <_Z8printIntiii>
    printString(" i velicina bafera ");
    800042c4:	00005517          	auipc	a0,0x5
    800042c8:	ec450513          	addi	a0,a0,-316 # 80009188 <CONSOLE_STATUS+0x178>
    800042cc:	00001097          	auipc	ra,0x1
    800042d0:	520080e7          	jalr	1312(ra) # 800057ec <_Z11printStringPKc>
    printInt(n);
    800042d4:	00000613          	li	a2,0
    800042d8:	00a00593          	li	a1,10
    800042dc:	00048513          	mv	a0,s1
    800042e0:	00001097          	auipc	ra,0x1
    800042e4:	6bc080e7          	jalr	1724(ra) # 8000599c <_Z8printIntiii>
    printString(".\n");
    800042e8:	00005517          	auipc	a0,0x5
    800042ec:	eb850513          	addi	a0,a0,-328 # 800091a0 <CONSOLE_STATUS+0x190>
    800042f0:	00001097          	auipc	ra,0x1
    800042f4:	4fc080e7          	jalr	1276(ra) # 800057ec <_Z11printStringPKc>
    if (threadNum > n) {
    800042f8:	0334c463          	blt	s1,s3,80004320 <_Z20testConsumerProducerv+0x11c>
    } else if (threadNum < 1) {
    800042fc:	03305c63          	blez	s3,80004334 <_Z20testConsumerProducerv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80004300:	03800513          	li	a0,56
    80004304:	ffffe097          	auipc	ra,0xffffe
    80004308:	bc0080e7          	jalr	-1088(ra) # 80001ec4 <_Znwm>
    8000430c:	00050a93          	mv	s5,a0
    80004310:	00048593          	mv	a1,s1
    80004314:	00001097          	auipc	ra,0x1
    80004318:	7a8080e7          	jalr	1960(ra) # 80005abc <_ZN9BufferCPPC1Ei>
    8000431c:	0300006f          	j	8000434c <_Z20testConsumerProducerv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80004320:	00005517          	auipc	a0,0x5
    80004324:	e8850513          	addi	a0,a0,-376 # 800091a8 <CONSOLE_STATUS+0x198>
    80004328:	00001097          	auipc	ra,0x1
    8000432c:	4c4080e7          	jalr	1220(ra) # 800057ec <_Z11printStringPKc>
        return;
    80004330:	0140006f          	j	80004344 <_Z20testConsumerProducerv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80004334:	00005517          	auipc	a0,0x5
    80004338:	eb450513          	addi	a0,a0,-332 # 800091e8 <CONSOLE_STATUS+0x1d8>
    8000433c:	00001097          	auipc	ra,0x1
    80004340:	4b0080e7          	jalr	1200(ra) # 800057ec <_Z11printStringPKc>
        return;
    80004344:	000c0113          	mv	sp,s8
    80004348:	2140006f          	j	8000455c <_Z20testConsumerProducerv+0x358>
    waitForAll = new Semaphore(0);
    8000434c:	01000513          	li	a0,16
    80004350:	ffffe097          	auipc	ra,0xffffe
    80004354:	b74080e7          	jalr	-1164(ra) # 80001ec4 <_Znwm>
    80004358:	00050913          	mv	s2,a0
    8000435c:	00000593          	li	a1,0
    80004360:	ffffe097          	auipc	ra,0xffffe
    80004364:	dac080e7          	jalr	-596(ra) # 8000210c <_ZN9SemaphoreC1Ej>
    80004368:	00008797          	auipc	a5,0x8
    8000436c:	c727b023          	sd	s2,-928(a5) # 8000bfc8 <_ZL10waitForAll>
    Thread *producers[threadNum];
    80004370:	00399793          	slli	a5,s3,0x3
    80004374:	00f78793          	addi	a5,a5,15
    80004378:	ff07f793          	andi	a5,a5,-16
    8000437c:	40f10133          	sub	sp,sp,a5
    80004380:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    80004384:	0019871b          	addiw	a4,s3,1
    80004388:	00171793          	slli	a5,a4,0x1
    8000438c:	00e787b3          	add	a5,a5,a4
    80004390:	00379793          	slli	a5,a5,0x3
    80004394:	00f78793          	addi	a5,a5,15
    80004398:	ff07f793          	andi	a5,a5,-16
    8000439c:	40f10133          	sub	sp,sp,a5
    800043a0:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    800043a4:	00199493          	slli	s1,s3,0x1
    800043a8:	013484b3          	add	s1,s1,s3
    800043ac:	00349493          	slli	s1,s1,0x3
    800043b0:	009b04b3          	add	s1,s6,s1
    800043b4:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    800043b8:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    800043bc:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    800043c0:	02800513          	li	a0,40
    800043c4:	ffffe097          	auipc	ra,0xffffe
    800043c8:	b00080e7          	jalr	-1280(ra) # 80001ec4 <_Znwm>
    800043cc:	00050b93          	mv	s7,a0
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    800043d0:	ffffe097          	auipc	ra,0xffffe
    800043d4:	c14080e7          	jalr	-1004(ra) # 80001fe4 <_ZN6ThreadC1Ev>
    800043d8:	00008797          	auipc	a5,0x8
    800043dc:	84078793          	addi	a5,a5,-1984 # 8000bc18 <_ZTV8Consumer+0x10>
    800043e0:	00fbb023          	sd	a5,0(s7)
    800043e4:	029bb023          	sd	s1,32(s7)
    consumer->start();
    800043e8:	000b8513          	mv	a0,s7
    800043ec:	ffffe097          	auipc	ra,0xffffe
    800043f0:	c94080e7          	jalr	-876(ra) # 80002080 <_ZN6Thread5startEv>
    threadData[0].id = 0;
    800043f4:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    800043f8:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    800043fc:	00008797          	auipc	a5,0x8
    80004400:	bcc7b783          	ld	a5,-1076(a5) # 8000bfc8 <_ZL10waitForAll>
    80004404:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80004408:	02800513          	li	a0,40
    8000440c:	ffffe097          	auipc	ra,0xffffe
    80004410:	ab8080e7          	jalr	-1352(ra) # 80001ec4 <_Znwm>
    80004414:	00050493          	mv	s1,a0
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80004418:	ffffe097          	auipc	ra,0xffffe
    8000441c:	bcc080e7          	jalr	-1076(ra) # 80001fe4 <_ZN6ThreadC1Ev>
    80004420:	00007797          	auipc	a5,0x7
    80004424:	7a878793          	addi	a5,a5,1960 # 8000bbc8 <_ZTV16ProducerKeyborad+0x10>
    80004428:	00f4b023          	sd	a5,0(s1)
    8000442c:	0364b023          	sd	s6,32(s1)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80004430:	009a3023          	sd	s1,0(s4)
    producers[0]->start();
    80004434:	00048513          	mv	a0,s1
    80004438:	ffffe097          	auipc	ra,0xffffe
    8000443c:	c48080e7          	jalr	-952(ra) # 80002080 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80004440:	00100913          	li	s2,1
    80004444:	0300006f          	j	80004474 <_Z20testConsumerProducerv+0x270>
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80004448:	00007797          	auipc	a5,0x7
    8000444c:	7a878793          	addi	a5,a5,1960 # 8000bbf0 <_ZTV8Producer+0x10>
    80004450:	00fcb023          	sd	a5,0(s9)
    80004454:	029cb023          	sd	s1,32(s9)
        producers[i] = new Producer(&threadData[i]);
    80004458:	00391793          	slli	a5,s2,0x3
    8000445c:	00fa07b3          	add	a5,s4,a5
    80004460:	0197b023          	sd	s9,0(a5)
        producers[i]->start();
    80004464:	000c8513          	mv	a0,s9
    80004468:	ffffe097          	auipc	ra,0xffffe
    8000446c:	c18080e7          	jalr	-1000(ra) # 80002080 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80004470:	0019091b          	addiw	s2,s2,1
    80004474:	05395263          	bge	s2,s3,800044b8 <_Z20testConsumerProducerv+0x2b4>
        threadData[i].id = i;
    80004478:	00191493          	slli	s1,s2,0x1
    8000447c:	012484b3          	add	s1,s1,s2
    80004480:	00349493          	slli	s1,s1,0x3
    80004484:	009b04b3          	add	s1,s6,s1
    80004488:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    8000448c:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    80004490:	00008797          	auipc	a5,0x8
    80004494:	b387b783          	ld	a5,-1224(a5) # 8000bfc8 <_ZL10waitForAll>
    80004498:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    8000449c:	02800513          	li	a0,40
    800044a0:	ffffe097          	auipc	ra,0xffffe
    800044a4:	a24080e7          	jalr	-1500(ra) # 80001ec4 <_Znwm>
    800044a8:	00050c93          	mv	s9,a0
    Producer(thread_data *_td) : Thread(), td(_td) {}
    800044ac:	ffffe097          	auipc	ra,0xffffe
    800044b0:	b38080e7          	jalr	-1224(ra) # 80001fe4 <_ZN6ThreadC1Ev>
    800044b4:	f95ff06f          	j	80004448 <_Z20testConsumerProducerv+0x244>
    Thread::dispatch();
    800044b8:	ffffe097          	auipc	ra,0xffffe
    800044bc:	b5c080e7          	jalr	-1188(ra) # 80002014 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    800044c0:	00000493          	li	s1,0
    800044c4:	0099ce63          	blt	s3,s1,800044e0 <_Z20testConsumerProducerv+0x2dc>
        waitForAll->wait();
    800044c8:	00008517          	auipc	a0,0x8
    800044cc:	b0053503          	ld	a0,-1280(a0) # 8000bfc8 <_ZL10waitForAll>
    800044d0:	ffffe097          	auipc	ra,0xffffe
    800044d4:	c78080e7          	jalr	-904(ra) # 80002148 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    800044d8:	0014849b          	addiw	s1,s1,1
    800044dc:	fe9ff06f          	j	800044c4 <_Z20testConsumerProducerv+0x2c0>
    delete waitForAll;
    800044e0:	00008517          	auipc	a0,0x8
    800044e4:	ae853503          	ld	a0,-1304(a0) # 8000bfc8 <_ZL10waitForAll>
    800044e8:	00050863          	beqz	a0,800044f8 <_Z20testConsumerProducerv+0x2f4>
    800044ec:	00053783          	ld	a5,0(a0)
    800044f0:	0087b783          	ld	a5,8(a5)
    800044f4:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    800044f8:	00000493          	li	s1,0
    800044fc:	0080006f          	j	80004504 <_Z20testConsumerProducerv+0x300>
    for (int i = 0; i < threadNum; i++) {
    80004500:	0014849b          	addiw	s1,s1,1
    80004504:	0334d263          	bge	s1,s3,80004528 <_Z20testConsumerProducerv+0x324>
        delete producers[i];
    80004508:	00349793          	slli	a5,s1,0x3
    8000450c:	00fa07b3          	add	a5,s4,a5
    80004510:	0007b503          	ld	a0,0(a5)
    80004514:	fe0506e3          	beqz	a0,80004500 <_Z20testConsumerProducerv+0x2fc>
    80004518:	00053783          	ld	a5,0(a0)
    8000451c:	0087b783          	ld	a5,8(a5)
    80004520:	000780e7          	jalr	a5
    80004524:	fddff06f          	j	80004500 <_Z20testConsumerProducerv+0x2fc>
    delete consumer;
    80004528:	000b8a63          	beqz	s7,8000453c <_Z20testConsumerProducerv+0x338>
    8000452c:	000bb783          	ld	a5,0(s7)
    80004530:	0087b783          	ld	a5,8(a5)
    80004534:	000b8513          	mv	a0,s7
    80004538:	000780e7          	jalr	a5
    delete buffer;
    8000453c:	000a8e63          	beqz	s5,80004558 <_Z20testConsumerProducerv+0x354>
    80004540:	000a8513          	mv	a0,s5
    80004544:	00002097          	auipc	ra,0x2
    80004548:	870080e7          	jalr	-1936(ra) # 80005db4 <_ZN9BufferCPPD1Ev>
    8000454c:	000a8513          	mv	a0,s5
    80004550:	ffffe097          	auipc	ra,0xffffe
    80004554:	9c4080e7          	jalr	-1596(ra) # 80001f14 <_ZdlPv>
    80004558:	000c0113          	mv	sp,s8
}
    8000455c:	f8040113          	addi	sp,s0,-128
    80004560:	07813083          	ld	ra,120(sp)
    80004564:	07013403          	ld	s0,112(sp)
    80004568:	06813483          	ld	s1,104(sp)
    8000456c:	06013903          	ld	s2,96(sp)
    80004570:	05813983          	ld	s3,88(sp)
    80004574:	05013a03          	ld	s4,80(sp)
    80004578:	04813a83          	ld	s5,72(sp)
    8000457c:	04013b03          	ld	s6,64(sp)
    80004580:	03813b83          	ld	s7,56(sp)
    80004584:	03013c03          	ld	s8,48(sp)
    80004588:	02813c83          	ld	s9,40(sp)
    8000458c:	08010113          	addi	sp,sp,128
    80004590:	00008067          	ret
    80004594:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80004598:	000a8513          	mv	a0,s5
    8000459c:	ffffe097          	auipc	ra,0xffffe
    800045a0:	978080e7          	jalr	-1672(ra) # 80001f14 <_ZdlPv>
    800045a4:	00048513          	mv	a0,s1
    800045a8:	00009097          	auipc	ra,0x9
    800045ac:	b20080e7          	jalr	-1248(ra) # 8000d0c8 <_Unwind_Resume>
    800045b0:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    800045b4:	00090513          	mv	a0,s2
    800045b8:	ffffe097          	auipc	ra,0xffffe
    800045bc:	95c080e7          	jalr	-1700(ra) # 80001f14 <_ZdlPv>
    800045c0:	00048513          	mv	a0,s1
    800045c4:	00009097          	auipc	ra,0x9
    800045c8:	b04080e7          	jalr	-1276(ra) # 8000d0c8 <_Unwind_Resume>
    800045cc:	00050493          	mv	s1,a0
    Thread *consumer = new Consumer(&threadData[threadNum]);
    800045d0:	000b8513          	mv	a0,s7
    800045d4:	ffffe097          	auipc	ra,0xffffe
    800045d8:	940080e7          	jalr	-1728(ra) # 80001f14 <_ZdlPv>
    800045dc:	00048513          	mv	a0,s1
    800045e0:	00009097          	auipc	ra,0x9
    800045e4:	ae8080e7          	jalr	-1304(ra) # 8000d0c8 <_Unwind_Resume>
    800045e8:	00050913          	mv	s2,a0
    producers[0] = new ProducerKeyborad(&threadData[0]);
    800045ec:	00048513          	mv	a0,s1
    800045f0:	ffffe097          	auipc	ra,0xffffe
    800045f4:	924080e7          	jalr	-1756(ra) # 80001f14 <_ZdlPv>
    800045f8:	00090513          	mv	a0,s2
    800045fc:	00009097          	auipc	ra,0x9
    80004600:	acc080e7          	jalr	-1332(ra) # 8000d0c8 <_Unwind_Resume>
    80004604:	00050493          	mv	s1,a0
        producers[i] = new Producer(&threadData[i]);
    80004608:	000c8513          	mv	a0,s9
    8000460c:	ffffe097          	auipc	ra,0xffffe
    80004610:	908080e7          	jalr	-1784(ra) # 80001f14 <_ZdlPv>
    80004614:	00048513          	mv	a0,s1
    80004618:	00009097          	auipc	ra,0x9
    8000461c:	ab0080e7          	jalr	-1360(ra) # 8000d0c8 <_Unwind_Resume>

0000000080004620 <_ZN8Consumer3runEv>:
    void run() override {
    80004620:	fd010113          	addi	sp,sp,-48
    80004624:	02113423          	sd	ra,40(sp)
    80004628:	02813023          	sd	s0,32(sp)
    8000462c:	00913c23          	sd	s1,24(sp)
    80004630:	01213823          	sd	s2,16(sp)
    80004634:	01313423          	sd	s3,8(sp)
    80004638:	03010413          	addi	s0,sp,48
    8000463c:	00050913          	mv	s2,a0
        int i = 0;
    80004640:	00000993          	li	s3,0
    80004644:	0100006f          	j	80004654 <_ZN8Consumer3runEv+0x34>
                Console::putc('\n');
    80004648:	00a00513          	li	a0,10
    8000464c:	ffffe097          	auipc	ra,0xffffe
    80004650:	bd8080e7          	jalr	-1064(ra) # 80002224 <_ZN7Console4putcEc>
        while (!threadEnd) {
    80004654:	00008797          	auipc	a5,0x8
    80004658:	96c7a783          	lw	a5,-1684(a5) # 8000bfc0 <_ZL9threadEnd>
    8000465c:	04079a63          	bnez	a5,800046b0 <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    80004660:	02093783          	ld	a5,32(s2)
    80004664:	0087b503          	ld	a0,8(a5)
    80004668:	00001097          	auipc	ra,0x1
    8000466c:	638080e7          	jalr	1592(ra) # 80005ca0 <_ZN9BufferCPP3getEv>
            i++;
    80004670:	0019849b          	addiw	s1,s3,1
    80004674:	0004899b          	sext.w	s3,s1
            Console::putc(key);
    80004678:	0ff57513          	andi	a0,a0,255
    8000467c:	ffffe097          	auipc	ra,0xffffe
    80004680:	ba8080e7          	jalr	-1112(ra) # 80002224 <_ZN7Console4putcEc>
            if (i % 80 == 0) {
    80004684:	05000793          	li	a5,80
    80004688:	02f4e4bb          	remw	s1,s1,a5
    8000468c:	fc0494e3          	bnez	s1,80004654 <_ZN8Consumer3runEv+0x34>
    80004690:	fb9ff06f          	j	80004648 <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    80004694:	02093783          	ld	a5,32(s2)
    80004698:	0087b503          	ld	a0,8(a5)
    8000469c:	00001097          	auipc	ra,0x1
    800046a0:	604080e7          	jalr	1540(ra) # 80005ca0 <_ZN9BufferCPP3getEv>
            Console::putc(key);
    800046a4:	0ff57513          	andi	a0,a0,255
    800046a8:	ffffe097          	auipc	ra,0xffffe
    800046ac:	b7c080e7          	jalr	-1156(ra) # 80002224 <_ZN7Console4putcEc>
        while (td->buffer->getCnt() > 0) {
    800046b0:	02093783          	ld	a5,32(s2)
    800046b4:	0087b503          	ld	a0,8(a5)
    800046b8:	00001097          	auipc	ra,0x1
    800046bc:	674080e7          	jalr	1652(ra) # 80005d2c <_ZN9BufferCPP6getCntEv>
    800046c0:	fca04ae3          	bgtz	a0,80004694 <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    800046c4:	02093783          	ld	a5,32(s2)
    800046c8:	0107b503          	ld	a0,16(a5)
    800046cc:	ffffe097          	auipc	ra,0xffffe
    800046d0:	aa8080e7          	jalr	-1368(ra) # 80002174 <_ZN9Semaphore6signalEv>
    }
    800046d4:	02813083          	ld	ra,40(sp)
    800046d8:	02013403          	ld	s0,32(sp)
    800046dc:	01813483          	ld	s1,24(sp)
    800046e0:	01013903          	ld	s2,16(sp)
    800046e4:	00813983          	ld	s3,8(sp)
    800046e8:	03010113          	addi	sp,sp,48
    800046ec:	00008067          	ret

00000000800046f0 <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    800046f0:	ff010113          	addi	sp,sp,-16
    800046f4:	00113423          	sd	ra,8(sp)
    800046f8:	00813023          	sd	s0,0(sp)
    800046fc:	01010413          	addi	s0,sp,16
    80004700:	00007797          	auipc	a5,0x7
    80004704:	51878793          	addi	a5,a5,1304 # 8000bc18 <_ZTV8Consumer+0x10>
    80004708:	00f53023          	sd	a5,0(a0)
    8000470c:	ffffd097          	auipc	ra,0xffffd
    80004710:	748080e7          	jalr	1864(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80004714:	00813083          	ld	ra,8(sp)
    80004718:	00013403          	ld	s0,0(sp)
    8000471c:	01010113          	addi	sp,sp,16
    80004720:	00008067          	ret

0000000080004724 <_ZN8ConsumerD0Ev>:
    80004724:	fe010113          	addi	sp,sp,-32
    80004728:	00113c23          	sd	ra,24(sp)
    8000472c:	00813823          	sd	s0,16(sp)
    80004730:	00913423          	sd	s1,8(sp)
    80004734:	02010413          	addi	s0,sp,32
    80004738:	00050493          	mv	s1,a0
    8000473c:	00007797          	auipc	a5,0x7
    80004740:	4dc78793          	addi	a5,a5,1244 # 8000bc18 <_ZTV8Consumer+0x10>
    80004744:	00f53023          	sd	a5,0(a0)
    80004748:	ffffd097          	auipc	ra,0xffffd
    8000474c:	70c080e7          	jalr	1804(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80004750:	00048513          	mv	a0,s1
    80004754:	ffffd097          	auipc	ra,0xffffd
    80004758:	7c0080e7          	jalr	1984(ra) # 80001f14 <_ZdlPv>
    8000475c:	01813083          	ld	ra,24(sp)
    80004760:	01013403          	ld	s0,16(sp)
    80004764:	00813483          	ld	s1,8(sp)
    80004768:	02010113          	addi	sp,sp,32
    8000476c:	00008067          	ret

0000000080004770 <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    80004770:	ff010113          	addi	sp,sp,-16
    80004774:	00113423          	sd	ra,8(sp)
    80004778:	00813023          	sd	s0,0(sp)
    8000477c:	01010413          	addi	s0,sp,16
    80004780:	00007797          	auipc	a5,0x7
    80004784:	44878793          	addi	a5,a5,1096 # 8000bbc8 <_ZTV16ProducerKeyborad+0x10>
    80004788:	00f53023          	sd	a5,0(a0)
    8000478c:	ffffd097          	auipc	ra,0xffffd
    80004790:	6c8080e7          	jalr	1736(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80004794:	00813083          	ld	ra,8(sp)
    80004798:	00013403          	ld	s0,0(sp)
    8000479c:	01010113          	addi	sp,sp,16
    800047a0:	00008067          	ret

00000000800047a4 <_ZN16ProducerKeyboradD0Ev>:
    800047a4:	fe010113          	addi	sp,sp,-32
    800047a8:	00113c23          	sd	ra,24(sp)
    800047ac:	00813823          	sd	s0,16(sp)
    800047b0:	00913423          	sd	s1,8(sp)
    800047b4:	02010413          	addi	s0,sp,32
    800047b8:	00050493          	mv	s1,a0
    800047bc:	00007797          	auipc	a5,0x7
    800047c0:	40c78793          	addi	a5,a5,1036 # 8000bbc8 <_ZTV16ProducerKeyborad+0x10>
    800047c4:	00f53023          	sd	a5,0(a0)
    800047c8:	ffffd097          	auipc	ra,0xffffd
    800047cc:	68c080e7          	jalr	1676(ra) # 80001e54 <_ZN6ThreadD1Ev>
    800047d0:	00048513          	mv	a0,s1
    800047d4:	ffffd097          	auipc	ra,0xffffd
    800047d8:	740080e7          	jalr	1856(ra) # 80001f14 <_ZdlPv>
    800047dc:	01813083          	ld	ra,24(sp)
    800047e0:	01013403          	ld	s0,16(sp)
    800047e4:	00813483          	ld	s1,8(sp)
    800047e8:	02010113          	addi	sp,sp,32
    800047ec:	00008067          	ret

00000000800047f0 <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    800047f0:	ff010113          	addi	sp,sp,-16
    800047f4:	00113423          	sd	ra,8(sp)
    800047f8:	00813023          	sd	s0,0(sp)
    800047fc:	01010413          	addi	s0,sp,16
    80004800:	00007797          	auipc	a5,0x7
    80004804:	3f078793          	addi	a5,a5,1008 # 8000bbf0 <_ZTV8Producer+0x10>
    80004808:	00f53023          	sd	a5,0(a0)
    8000480c:	ffffd097          	auipc	ra,0xffffd
    80004810:	648080e7          	jalr	1608(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80004814:	00813083          	ld	ra,8(sp)
    80004818:	00013403          	ld	s0,0(sp)
    8000481c:	01010113          	addi	sp,sp,16
    80004820:	00008067          	ret

0000000080004824 <_ZN8ProducerD0Ev>:
    80004824:	fe010113          	addi	sp,sp,-32
    80004828:	00113c23          	sd	ra,24(sp)
    8000482c:	00813823          	sd	s0,16(sp)
    80004830:	00913423          	sd	s1,8(sp)
    80004834:	02010413          	addi	s0,sp,32
    80004838:	00050493          	mv	s1,a0
    8000483c:	00007797          	auipc	a5,0x7
    80004840:	3b478793          	addi	a5,a5,948 # 8000bbf0 <_ZTV8Producer+0x10>
    80004844:	00f53023          	sd	a5,0(a0)
    80004848:	ffffd097          	auipc	ra,0xffffd
    8000484c:	60c080e7          	jalr	1548(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80004850:	00048513          	mv	a0,s1
    80004854:	ffffd097          	auipc	ra,0xffffd
    80004858:	6c0080e7          	jalr	1728(ra) # 80001f14 <_ZdlPv>
    8000485c:	01813083          	ld	ra,24(sp)
    80004860:	01013403          	ld	s0,16(sp)
    80004864:	00813483          	ld	s1,8(sp)
    80004868:	02010113          	addi	sp,sp,32
    8000486c:	00008067          	ret

0000000080004870 <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    80004870:	fe010113          	addi	sp,sp,-32
    80004874:	00113c23          	sd	ra,24(sp)
    80004878:	00813823          	sd	s0,16(sp)
    8000487c:	00913423          	sd	s1,8(sp)
    80004880:	02010413          	addi	s0,sp,32
    80004884:	00050493          	mv	s1,a0
        while ((key = getc()) != 35) {
    80004888:	ffffd097          	auipc	ra,0xffffd
    8000488c:	d6c080e7          	jalr	-660(ra) # 800015f4 <_Z4getcv>
    80004890:	0005059b          	sext.w	a1,a0
    80004894:	02300793          	li	a5,35
    80004898:	00f58c63          	beq	a1,a5,800048b0 <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    8000489c:	0204b783          	ld	a5,32(s1)
    800048a0:	0087b503          	ld	a0,8(a5)
    800048a4:	00001097          	auipc	ra,0x1
    800048a8:	36c080e7          	jalr	876(ra) # 80005c10 <_ZN9BufferCPP3putEi>
        while ((key = getc()) != 35) {
    800048ac:	fddff06f          	j	80004888 <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    800048b0:	00100793          	li	a5,1
    800048b4:	00007717          	auipc	a4,0x7
    800048b8:	70f72623          	sw	a5,1804(a4) # 8000bfc0 <_ZL9threadEnd>
        td->buffer->put('!');
    800048bc:	0204b783          	ld	a5,32(s1)
    800048c0:	02100593          	li	a1,33
    800048c4:	0087b503          	ld	a0,8(a5)
    800048c8:	00001097          	auipc	ra,0x1
    800048cc:	348080e7          	jalr	840(ra) # 80005c10 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    800048d0:	0204b783          	ld	a5,32(s1)
    800048d4:	0107b503          	ld	a0,16(a5)
    800048d8:	ffffe097          	auipc	ra,0xffffe
    800048dc:	89c080e7          	jalr	-1892(ra) # 80002174 <_ZN9Semaphore6signalEv>
    }
    800048e0:	01813083          	ld	ra,24(sp)
    800048e4:	01013403          	ld	s0,16(sp)
    800048e8:	00813483          	ld	s1,8(sp)
    800048ec:	02010113          	addi	sp,sp,32
    800048f0:	00008067          	ret

00000000800048f4 <_ZN8Producer3runEv>:
    void run() override {
    800048f4:	fe010113          	addi	sp,sp,-32
    800048f8:	00113c23          	sd	ra,24(sp)
    800048fc:	00813823          	sd	s0,16(sp)
    80004900:	00913423          	sd	s1,8(sp)
    80004904:	01213023          	sd	s2,0(sp)
    80004908:	02010413          	addi	s0,sp,32
    8000490c:	00050493          	mv	s1,a0
        int i = 0;
    80004910:	00000913          	li	s2,0
        while (!threadEnd) {
    80004914:	00007797          	auipc	a5,0x7
    80004918:	6ac7a783          	lw	a5,1708(a5) # 8000bfc0 <_ZL9threadEnd>
    8000491c:	04079263          	bnez	a5,80004960 <_ZN8Producer3runEv+0x6c>
            td->buffer->put(td->id + '0');
    80004920:	0204b783          	ld	a5,32(s1)
    80004924:	0007a583          	lw	a1,0(a5)
    80004928:	0305859b          	addiw	a1,a1,48
    8000492c:	0087b503          	ld	a0,8(a5)
    80004930:	00001097          	auipc	ra,0x1
    80004934:	2e0080e7          	jalr	736(ra) # 80005c10 <_ZN9BufferCPP3putEi>
            i++;
    80004938:	0019071b          	addiw	a4,s2,1
    8000493c:	0007091b          	sext.w	s2,a4
            Thread::sleep((i + td->id) % 5);
    80004940:	0204b783          	ld	a5,32(s1)
    80004944:	0007a783          	lw	a5,0(a5)
    80004948:	00e787bb          	addw	a5,a5,a4
    8000494c:	00500513          	li	a0,5
    80004950:	02a7e53b          	remw	a0,a5,a0
    80004954:	ffffd097          	auipc	ra,0xffffd
    80004958:	790080e7          	jalr	1936(ra) # 800020e4 <_ZN6Thread5sleepEm>
        while (!threadEnd) {
    8000495c:	fb9ff06f          	j	80004914 <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    80004960:	0204b783          	ld	a5,32(s1)
    80004964:	0107b503          	ld	a0,16(a5)
    80004968:	ffffe097          	auipc	ra,0xffffe
    8000496c:	80c080e7          	jalr	-2036(ra) # 80002174 <_ZN9Semaphore6signalEv>
    }
    80004970:	01813083          	ld	ra,24(sp)
    80004974:	01013403          	ld	s0,16(sp)
    80004978:	00813483          	ld	s1,8(sp)
    8000497c:	00013903          	ld	s2,0(sp)
    80004980:	02010113          	addi	sp,sp,32
    80004984:	00008067          	ret

0000000080004988 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004988:	fe010113          	addi	sp,sp,-32
    8000498c:	00113c23          	sd	ra,24(sp)
    80004990:	00813823          	sd	s0,16(sp)
    80004994:	00913423          	sd	s1,8(sp)
    80004998:	01213023          	sd	s2,0(sp)
    8000499c:	02010413          	addi	s0,sp,32
    800049a0:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800049a4:	00100793          	li	a5,1
    800049a8:	02a7f863          	bgeu	a5,a0,800049d8 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800049ac:	00a00793          	li	a5,10
    800049b0:	02f577b3          	remu	a5,a0,a5
    800049b4:	02078e63          	beqz	a5,800049f0 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    800049b8:	fff48513          	addi	a0,s1,-1
    800049bc:	00000097          	auipc	ra,0x0
    800049c0:	fcc080e7          	jalr	-52(ra) # 80004988 <_ZL9fibonaccim>
    800049c4:	00050913          	mv	s2,a0
    800049c8:	ffe48513          	addi	a0,s1,-2
    800049cc:	00000097          	auipc	ra,0x0
    800049d0:	fbc080e7          	jalr	-68(ra) # 80004988 <_ZL9fibonaccim>
    800049d4:	00a90533          	add	a0,s2,a0
}
    800049d8:	01813083          	ld	ra,24(sp)
    800049dc:	01013403          	ld	s0,16(sp)
    800049e0:	00813483          	ld	s1,8(sp)
    800049e4:	00013903          	ld	s2,0(sp)
    800049e8:	02010113          	addi	sp,sp,32
    800049ec:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800049f0:	ffffd097          	auipc	ra,0xffffd
    800049f4:	9c8080e7          	jalr	-1592(ra) # 800013b8 <_Z15thread_dispatchv>
    800049f8:	fc1ff06f          	j	800049b8 <_ZL9fibonaccim+0x30>

00000000800049fc <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    800049fc:	fe010113          	addi	sp,sp,-32
    80004a00:	00113c23          	sd	ra,24(sp)
    80004a04:	00813823          	sd	s0,16(sp)
    80004a08:	00913423          	sd	s1,8(sp)
    80004a0c:	01213023          	sd	s2,0(sp)
    80004a10:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004a14:	00a00493          	li	s1,10
    80004a18:	0400006f          	j	80004a58 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004a1c:	00005517          	auipc	a0,0x5
    80004a20:	85c50513          	addi	a0,a0,-1956 # 80009278 <CONSOLE_STATUS+0x268>
    80004a24:	00001097          	auipc	ra,0x1
    80004a28:	dc8080e7          	jalr	-568(ra) # 800057ec <_Z11printStringPKc>
    80004a2c:	00000613          	li	a2,0
    80004a30:	00a00593          	li	a1,10
    80004a34:	00048513          	mv	a0,s1
    80004a38:	00001097          	auipc	ra,0x1
    80004a3c:	f64080e7          	jalr	-156(ra) # 8000599c <_Z8printIntiii>
    80004a40:	00005517          	auipc	a0,0x5
    80004a44:	a2850513          	addi	a0,a0,-1496 # 80009468 <CONSOLE_STATUS+0x458>
    80004a48:	00001097          	auipc	ra,0x1
    80004a4c:	da4080e7          	jalr	-604(ra) # 800057ec <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004a50:	0014849b          	addiw	s1,s1,1
    80004a54:	0ff4f493          	andi	s1,s1,255
    80004a58:	00c00793          	li	a5,12
    80004a5c:	fc97f0e3          	bgeu	a5,s1,80004a1c <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80004a60:	00005517          	auipc	a0,0x5
    80004a64:	82050513          	addi	a0,a0,-2016 # 80009280 <CONSOLE_STATUS+0x270>
    80004a68:	00001097          	auipc	ra,0x1
    80004a6c:	d84080e7          	jalr	-636(ra) # 800057ec <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004a70:	00500313          	li	t1,5
    thread_dispatch();
    80004a74:	ffffd097          	auipc	ra,0xffffd
    80004a78:	944080e7          	jalr	-1724(ra) # 800013b8 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004a7c:	01000513          	li	a0,16
    80004a80:	00000097          	auipc	ra,0x0
    80004a84:	f08080e7          	jalr	-248(ra) # 80004988 <_ZL9fibonaccim>
    80004a88:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004a8c:	00005517          	auipc	a0,0x5
    80004a90:	80450513          	addi	a0,a0,-2044 # 80009290 <CONSOLE_STATUS+0x280>
    80004a94:	00001097          	auipc	ra,0x1
    80004a98:	d58080e7          	jalr	-680(ra) # 800057ec <_Z11printStringPKc>
    80004a9c:	00000613          	li	a2,0
    80004aa0:	00a00593          	li	a1,10
    80004aa4:	0009051b          	sext.w	a0,s2
    80004aa8:	00001097          	auipc	ra,0x1
    80004aac:	ef4080e7          	jalr	-268(ra) # 8000599c <_Z8printIntiii>
    80004ab0:	00005517          	auipc	a0,0x5
    80004ab4:	9b850513          	addi	a0,a0,-1608 # 80009468 <CONSOLE_STATUS+0x458>
    80004ab8:	00001097          	auipc	ra,0x1
    80004abc:	d34080e7          	jalr	-716(ra) # 800057ec <_Z11printStringPKc>
    80004ac0:	0400006f          	j	80004b00 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004ac4:	00004517          	auipc	a0,0x4
    80004ac8:	7b450513          	addi	a0,a0,1972 # 80009278 <CONSOLE_STATUS+0x268>
    80004acc:	00001097          	auipc	ra,0x1
    80004ad0:	d20080e7          	jalr	-736(ra) # 800057ec <_Z11printStringPKc>
    80004ad4:	00000613          	li	a2,0
    80004ad8:	00a00593          	li	a1,10
    80004adc:	00048513          	mv	a0,s1
    80004ae0:	00001097          	auipc	ra,0x1
    80004ae4:	ebc080e7          	jalr	-324(ra) # 8000599c <_Z8printIntiii>
    80004ae8:	00005517          	auipc	a0,0x5
    80004aec:	98050513          	addi	a0,a0,-1664 # 80009468 <CONSOLE_STATUS+0x458>
    80004af0:	00001097          	auipc	ra,0x1
    80004af4:	cfc080e7          	jalr	-772(ra) # 800057ec <_Z11printStringPKc>
    for (; i < 16; i++) {
    80004af8:	0014849b          	addiw	s1,s1,1
    80004afc:	0ff4f493          	andi	s1,s1,255
    80004b00:	00f00793          	li	a5,15
    80004b04:	fc97f0e3          	bgeu	a5,s1,80004ac4 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80004b08:	00004517          	auipc	a0,0x4
    80004b0c:	79850513          	addi	a0,a0,1944 # 800092a0 <CONSOLE_STATUS+0x290>
    80004b10:	00001097          	auipc	ra,0x1
    80004b14:	cdc080e7          	jalr	-804(ra) # 800057ec <_Z11printStringPKc>
    finishedD = true;
    80004b18:	00100793          	li	a5,1
    80004b1c:	00007717          	auipc	a4,0x7
    80004b20:	4af70a23          	sb	a5,1204(a4) # 8000bfd0 <_ZL9finishedD>
    thread_dispatch();
    80004b24:	ffffd097          	auipc	ra,0xffffd
    80004b28:	894080e7          	jalr	-1900(ra) # 800013b8 <_Z15thread_dispatchv>
}
    80004b2c:	01813083          	ld	ra,24(sp)
    80004b30:	01013403          	ld	s0,16(sp)
    80004b34:	00813483          	ld	s1,8(sp)
    80004b38:	00013903          	ld	s2,0(sp)
    80004b3c:	02010113          	addi	sp,sp,32
    80004b40:	00008067          	ret

0000000080004b44 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80004b44:	fe010113          	addi	sp,sp,-32
    80004b48:	00113c23          	sd	ra,24(sp)
    80004b4c:	00813823          	sd	s0,16(sp)
    80004b50:	00913423          	sd	s1,8(sp)
    80004b54:	01213023          	sd	s2,0(sp)
    80004b58:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004b5c:	00000493          	li	s1,0
    80004b60:	0400006f          	j	80004ba0 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80004b64:	00004517          	auipc	a0,0x4
    80004b68:	6e450513          	addi	a0,a0,1764 # 80009248 <CONSOLE_STATUS+0x238>
    80004b6c:	00001097          	auipc	ra,0x1
    80004b70:	c80080e7          	jalr	-896(ra) # 800057ec <_Z11printStringPKc>
    80004b74:	00000613          	li	a2,0
    80004b78:	00a00593          	li	a1,10
    80004b7c:	00048513          	mv	a0,s1
    80004b80:	00001097          	auipc	ra,0x1
    80004b84:	e1c080e7          	jalr	-484(ra) # 8000599c <_Z8printIntiii>
    80004b88:	00005517          	auipc	a0,0x5
    80004b8c:	8e050513          	addi	a0,a0,-1824 # 80009468 <CONSOLE_STATUS+0x458>
    80004b90:	00001097          	auipc	ra,0x1
    80004b94:	c5c080e7          	jalr	-932(ra) # 800057ec <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004b98:	0014849b          	addiw	s1,s1,1
    80004b9c:	0ff4f493          	andi	s1,s1,255
    80004ba0:	00200793          	li	a5,2
    80004ba4:	fc97f0e3          	bgeu	a5,s1,80004b64 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80004ba8:	00004517          	auipc	a0,0x4
    80004bac:	6a850513          	addi	a0,a0,1704 # 80009250 <CONSOLE_STATUS+0x240>
    80004bb0:	00001097          	auipc	ra,0x1
    80004bb4:	c3c080e7          	jalr	-964(ra) # 800057ec <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004bb8:	00700313          	li	t1,7
    thread_dispatch();
    80004bbc:	ffffc097          	auipc	ra,0xffffc
    80004bc0:	7fc080e7          	jalr	2044(ra) # 800013b8 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004bc4:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80004bc8:	00004517          	auipc	a0,0x4
    80004bcc:	69850513          	addi	a0,a0,1688 # 80009260 <CONSOLE_STATUS+0x250>
    80004bd0:	00001097          	auipc	ra,0x1
    80004bd4:	c1c080e7          	jalr	-996(ra) # 800057ec <_Z11printStringPKc>
    80004bd8:	00000613          	li	a2,0
    80004bdc:	00a00593          	li	a1,10
    80004be0:	0009051b          	sext.w	a0,s2
    80004be4:	00001097          	auipc	ra,0x1
    80004be8:	db8080e7          	jalr	-584(ra) # 8000599c <_Z8printIntiii>
    80004bec:	00005517          	auipc	a0,0x5
    80004bf0:	87c50513          	addi	a0,a0,-1924 # 80009468 <CONSOLE_STATUS+0x458>
    80004bf4:	00001097          	auipc	ra,0x1
    80004bf8:	bf8080e7          	jalr	-1032(ra) # 800057ec <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80004bfc:	00c00513          	li	a0,12
    80004c00:	00000097          	auipc	ra,0x0
    80004c04:	d88080e7          	jalr	-632(ra) # 80004988 <_ZL9fibonaccim>
    80004c08:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004c0c:	00004517          	auipc	a0,0x4
    80004c10:	65c50513          	addi	a0,a0,1628 # 80009268 <CONSOLE_STATUS+0x258>
    80004c14:	00001097          	auipc	ra,0x1
    80004c18:	bd8080e7          	jalr	-1064(ra) # 800057ec <_Z11printStringPKc>
    80004c1c:	00000613          	li	a2,0
    80004c20:	00a00593          	li	a1,10
    80004c24:	0009051b          	sext.w	a0,s2
    80004c28:	00001097          	auipc	ra,0x1
    80004c2c:	d74080e7          	jalr	-652(ra) # 8000599c <_Z8printIntiii>
    80004c30:	00005517          	auipc	a0,0x5
    80004c34:	83850513          	addi	a0,a0,-1992 # 80009468 <CONSOLE_STATUS+0x458>
    80004c38:	00001097          	auipc	ra,0x1
    80004c3c:	bb4080e7          	jalr	-1100(ra) # 800057ec <_Z11printStringPKc>
    80004c40:	0400006f          	j	80004c80 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80004c44:	00004517          	auipc	a0,0x4
    80004c48:	60450513          	addi	a0,a0,1540 # 80009248 <CONSOLE_STATUS+0x238>
    80004c4c:	00001097          	auipc	ra,0x1
    80004c50:	ba0080e7          	jalr	-1120(ra) # 800057ec <_Z11printStringPKc>
    80004c54:	00000613          	li	a2,0
    80004c58:	00a00593          	li	a1,10
    80004c5c:	00048513          	mv	a0,s1
    80004c60:	00001097          	auipc	ra,0x1
    80004c64:	d3c080e7          	jalr	-708(ra) # 8000599c <_Z8printIntiii>
    80004c68:	00005517          	auipc	a0,0x5
    80004c6c:	80050513          	addi	a0,a0,-2048 # 80009468 <CONSOLE_STATUS+0x458>
    80004c70:	00001097          	auipc	ra,0x1
    80004c74:	b7c080e7          	jalr	-1156(ra) # 800057ec <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004c78:	0014849b          	addiw	s1,s1,1
    80004c7c:	0ff4f493          	andi	s1,s1,255
    80004c80:	00500793          	li	a5,5
    80004c84:	fc97f0e3          	bgeu	a5,s1,80004c44 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80004c88:	00004517          	auipc	a0,0x4
    80004c8c:	59850513          	addi	a0,a0,1432 # 80009220 <CONSOLE_STATUS+0x210>
    80004c90:	00001097          	auipc	ra,0x1
    80004c94:	b5c080e7          	jalr	-1188(ra) # 800057ec <_Z11printStringPKc>
    finishedC = true;
    80004c98:	00100793          	li	a5,1
    80004c9c:	00007717          	auipc	a4,0x7
    80004ca0:	32f70aa3          	sb	a5,821(a4) # 8000bfd1 <_ZL9finishedC>
    thread_dispatch();
    80004ca4:	ffffc097          	auipc	ra,0xffffc
    80004ca8:	714080e7          	jalr	1812(ra) # 800013b8 <_Z15thread_dispatchv>
}
    80004cac:	01813083          	ld	ra,24(sp)
    80004cb0:	01013403          	ld	s0,16(sp)
    80004cb4:	00813483          	ld	s1,8(sp)
    80004cb8:	00013903          	ld	s2,0(sp)
    80004cbc:	02010113          	addi	sp,sp,32
    80004cc0:	00008067          	ret

0000000080004cc4 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80004cc4:	fe010113          	addi	sp,sp,-32
    80004cc8:	00113c23          	sd	ra,24(sp)
    80004ccc:	00813823          	sd	s0,16(sp)
    80004cd0:	00913423          	sd	s1,8(sp)
    80004cd4:	01213023          	sd	s2,0(sp)
    80004cd8:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004cdc:	00000913          	li	s2,0
    80004ce0:	0380006f          	j	80004d18 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80004ce4:	ffffc097          	auipc	ra,0xffffc
    80004ce8:	6d4080e7          	jalr	1748(ra) # 800013b8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004cec:	00148493          	addi	s1,s1,1
    80004cf0:	000027b7          	lui	a5,0x2
    80004cf4:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004cf8:	0097ee63          	bltu	a5,s1,80004d14 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004cfc:	00000713          	li	a4,0
    80004d00:	000077b7          	lui	a5,0x7
    80004d04:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004d08:	fce7eee3          	bltu	a5,a4,80004ce4 <_ZL11workerBodyBPv+0x20>
    80004d0c:	00170713          	addi	a4,a4,1
    80004d10:	ff1ff06f          	j	80004d00 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80004d14:	00190913          	addi	s2,s2,1
    80004d18:	00f00793          	li	a5,15
    80004d1c:	0527e063          	bltu	a5,s2,80004d5c <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80004d20:	00004517          	auipc	a0,0x4
    80004d24:	51050513          	addi	a0,a0,1296 # 80009230 <CONSOLE_STATUS+0x220>
    80004d28:	00001097          	auipc	ra,0x1
    80004d2c:	ac4080e7          	jalr	-1340(ra) # 800057ec <_Z11printStringPKc>
    80004d30:	00000613          	li	a2,0
    80004d34:	00a00593          	li	a1,10
    80004d38:	0009051b          	sext.w	a0,s2
    80004d3c:	00001097          	auipc	ra,0x1
    80004d40:	c60080e7          	jalr	-928(ra) # 8000599c <_Z8printIntiii>
    80004d44:	00004517          	auipc	a0,0x4
    80004d48:	72450513          	addi	a0,a0,1828 # 80009468 <CONSOLE_STATUS+0x458>
    80004d4c:	00001097          	auipc	ra,0x1
    80004d50:	aa0080e7          	jalr	-1376(ra) # 800057ec <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004d54:	00000493          	li	s1,0
    80004d58:	f99ff06f          	j	80004cf0 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80004d5c:	00004517          	auipc	a0,0x4
    80004d60:	4dc50513          	addi	a0,a0,1244 # 80009238 <CONSOLE_STATUS+0x228>
    80004d64:	00001097          	auipc	ra,0x1
    80004d68:	a88080e7          	jalr	-1400(ra) # 800057ec <_Z11printStringPKc>
    finishedB = true;
    80004d6c:	00100793          	li	a5,1
    80004d70:	00007717          	auipc	a4,0x7
    80004d74:	26f70123          	sb	a5,610(a4) # 8000bfd2 <_ZL9finishedB>
    thread_dispatch();
    80004d78:	ffffc097          	auipc	ra,0xffffc
    80004d7c:	640080e7          	jalr	1600(ra) # 800013b8 <_Z15thread_dispatchv>
}
    80004d80:	01813083          	ld	ra,24(sp)
    80004d84:	01013403          	ld	s0,16(sp)
    80004d88:	00813483          	ld	s1,8(sp)
    80004d8c:	00013903          	ld	s2,0(sp)
    80004d90:	02010113          	addi	sp,sp,32
    80004d94:	00008067          	ret

0000000080004d98 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80004d98:	fe010113          	addi	sp,sp,-32
    80004d9c:	00113c23          	sd	ra,24(sp)
    80004da0:	00813823          	sd	s0,16(sp)
    80004da4:	00913423          	sd	s1,8(sp)
    80004da8:	01213023          	sd	s2,0(sp)
    80004dac:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004db0:	00000913          	li	s2,0
    80004db4:	0380006f          	j	80004dec <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80004db8:	ffffc097          	auipc	ra,0xffffc
    80004dbc:	600080e7          	jalr	1536(ra) # 800013b8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004dc0:	00148493          	addi	s1,s1,1
    80004dc4:	000027b7          	lui	a5,0x2
    80004dc8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004dcc:	0097ee63          	bltu	a5,s1,80004de8 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004dd0:	00000713          	li	a4,0
    80004dd4:	000077b7          	lui	a5,0x7
    80004dd8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004ddc:	fce7eee3          	bltu	a5,a4,80004db8 <_ZL11workerBodyAPv+0x20>
    80004de0:	00170713          	addi	a4,a4,1
    80004de4:	ff1ff06f          	j	80004dd4 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004de8:	00190913          	addi	s2,s2,1
    80004dec:	00900793          	li	a5,9
    80004df0:	0527e063          	bltu	a5,s2,80004e30 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004df4:	00004517          	auipc	a0,0x4
    80004df8:	42450513          	addi	a0,a0,1060 # 80009218 <CONSOLE_STATUS+0x208>
    80004dfc:	00001097          	auipc	ra,0x1
    80004e00:	9f0080e7          	jalr	-1552(ra) # 800057ec <_Z11printStringPKc>
    80004e04:	00000613          	li	a2,0
    80004e08:	00a00593          	li	a1,10
    80004e0c:	0009051b          	sext.w	a0,s2
    80004e10:	00001097          	auipc	ra,0x1
    80004e14:	b8c080e7          	jalr	-1140(ra) # 8000599c <_Z8printIntiii>
    80004e18:	00004517          	auipc	a0,0x4
    80004e1c:	65050513          	addi	a0,a0,1616 # 80009468 <CONSOLE_STATUS+0x458>
    80004e20:	00001097          	auipc	ra,0x1
    80004e24:	9cc080e7          	jalr	-1588(ra) # 800057ec <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004e28:	00000493          	li	s1,0
    80004e2c:	f99ff06f          	j	80004dc4 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80004e30:	00004517          	auipc	a0,0x4
    80004e34:	3f050513          	addi	a0,a0,1008 # 80009220 <CONSOLE_STATUS+0x210>
    80004e38:	00001097          	auipc	ra,0x1
    80004e3c:	9b4080e7          	jalr	-1612(ra) # 800057ec <_Z11printStringPKc>
    finishedA = true;
    80004e40:	00100793          	li	a5,1
    80004e44:	00007717          	auipc	a4,0x7
    80004e48:	18f707a3          	sb	a5,399(a4) # 8000bfd3 <_ZL9finishedA>
}
    80004e4c:	01813083          	ld	ra,24(sp)
    80004e50:	01013403          	ld	s0,16(sp)
    80004e54:	00813483          	ld	s1,8(sp)
    80004e58:	00013903          	ld	s2,0(sp)
    80004e5c:	02010113          	addi	sp,sp,32
    80004e60:	00008067          	ret

0000000080004e64 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80004e64:	fd010113          	addi	sp,sp,-48
    80004e68:	02113423          	sd	ra,40(sp)
    80004e6c:	02813023          	sd	s0,32(sp)
    80004e70:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80004e74:	00000613          	li	a2,0
    80004e78:	00000597          	auipc	a1,0x0
    80004e7c:	f2058593          	addi	a1,a1,-224 # 80004d98 <_ZL11workerBodyAPv>
    80004e80:	fd040513          	addi	a0,s0,-48
    80004e84:	ffffc097          	auipc	ra,0xffffc
    80004e88:	454080e7          	jalr	1108(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80004e8c:	00004517          	auipc	a0,0x4
    80004e90:	42450513          	addi	a0,a0,1060 # 800092b0 <CONSOLE_STATUS+0x2a0>
    80004e94:	00001097          	auipc	ra,0x1
    80004e98:	958080e7          	jalr	-1704(ra) # 800057ec <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80004e9c:	00000613          	li	a2,0
    80004ea0:	00000597          	auipc	a1,0x0
    80004ea4:	e2458593          	addi	a1,a1,-476 # 80004cc4 <_ZL11workerBodyBPv>
    80004ea8:	fd840513          	addi	a0,s0,-40
    80004eac:	ffffc097          	auipc	ra,0xffffc
    80004eb0:	42c080e7          	jalr	1068(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    80004eb4:	00004517          	auipc	a0,0x4
    80004eb8:	41450513          	addi	a0,a0,1044 # 800092c8 <CONSOLE_STATUS+0x2b8>
    80004ebc:	00001097          	auipc	ra,0x1
    80004ec0:	930080e7          	jalr	-1744(ra) # 800057ec <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80004ec4:	00000613          	li	a2,0
    80004ec8:	00000597          	auipc	a1,0x0
    80004ecc:	c7c58593          	addi	a1,a1,-900 # 80004b44 <_ZL11workerBodyCPv>
    80004ed0:	fe040513          	addi	a0,s0,-32
    80004ed4:	ffffc097          	auipc	ra,0xffffc
    80004ed8:	404080e7          	jalr	1028(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    80004edc:	00004517          	auipc	a0,0x4
    80004ee0:	40450513          	addi	a0,a0,1028 # 800092e0 <CONSOLE_STATUS+0x2d0>
    80004ee4:	00001097          	auipc	ra,0x1
    80004ee8:	908080e7          	jalr	-1784(ra) # 800057ec <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80004eec:	00000613          	li	a2,0
    80004ef0:	00000597          	auipc	a1,0x0
    80004ef4:	b0c58593          	addi	a1,a1,-1268 # 800049fc <_ZL11workerBodyDPv>
    80004ef8:	fe840513          	addi	a0,s0,-24
    80004efc:	ffffc097          	auipc	ra,0xffffc
    80004f00:	3dc080e7          	jalr	988(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    80004f04:	00004517          	auipc	a0,0x4
    80004f08:	3f450513          	addi	a0,a0,1012 # 800092f8 <CONSOLE_STATUS+0x2e8>
    80004f0c:	00001097          	auipc	ra,0x1
    80004f10:	8e0080e7          	jalr	-1824(ra) # 800057ec <_Z11printStringPKc>
    80004f14:	00c0006f          	j	80004f20 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80004f18:	ffffc097          	auipc	ra,0xffffc
    80004f1c:	4a0080e7          	jalr	1184(ra) # 800013b8 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004f20:	00007797          	auipc	a5,0x7
    80004f24:	0b37c783          	lbu	a5,179(a5) # 8000bfd3 <_ZL9finishedA>
    80004f28:	fe0788e3          	beqz	a5,80004f18 <_Z18Threads_C_API_testv+0xb4>
    80004f2c:	00007797          	auipc	a5,0x7
    80004f30:	0a67c783          	lbu	a5,166(a5) # 8000bfd2 <_ZL9finishedB>
    80004f34:	fe0782e3          	beqz	a5,80004f18 <_Z18Threads_C_API_testv+0xb4>
    80004f38:	00007797          	auipc	a5,0x7
    80004f3c:	0997c783          	lbu	a5,153(a5) # 8000bfd1 <_ZL9finishedC>
    80004f40:	fc078ce3          	beqz	a5,80004f18 <_Z18Threads_C_API_testv+0xb4>
    80004f44:	00007797          	auipc	a5,0x7
    80004f48:	08c7c783          	lbu	a5,140(a5) # 8000bfd0 <_ZL9finishedD>
    80004f4c:	fc0786e3          	beqz	a5,80004f18 <_Z18Threads_C_API_testv+0xb4>
    }

}
    80004f50:	02813083          	ld	ra,40(sp)
    80004f54:	02013403          	ld	s0,32(sp)
    80004f58:	03010113          	addi	sp,sp,48
    80004f5c:	00008067          	ret

0000000080004f60 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80004f60:	fd010113          	addi	sp,sp,-48
    80004f64:	02113423          	sd	ra,40(sp)
    80004f68:	02813023          	sd	s0,32(sp)
    80004f6c:	00913c23          	sd	s1,24(sp)
    80004f70:	01213823          	sd	s2,16(sp)
    80004f74:	01313423          	sd	s3,8(sp)
    80004f78:	03010413          	addi	s0,sp,48
    80004f7c:	00050993          	mv	s3,a0
    80004f80:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80004f84:	00000913          	li	s2,0
    80004f88:	00c0006f          	j	80004f94 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 35) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80004f8c:	ffffd097          	auipc	ra,0xffffd
    80004f90:	088080e7          	jalr	136(ra) # 80002014 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 35) {
    80004f94:	ffffc097          	auipc	ra,0xffffc
    80004f98:	660080e7          	jalr	1632(ra) # 800015f4 <_Z4getcv>
    80004f9c:	0005059b          	sext.w	a1,a0
    80004fa0:	02300793          	li	a5,35
    80004fa4:	02f58a63          	beq	a1,a5,80004fd8 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80004fa8:	0084b503          	ld	a0,8(s1)
    80004fac:	00001097          	auipc	ra,0x1
    80004fb0:	c64080e7          	jalr	-924(ra) # 80005c10 <_ZN9BufferCPP3putEi>
        i++;
    80004fb4:	0019071b          	addiw	a4,s2,1
    80004fb8:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80004fbc:	0004a683          	lw	a3,0(s1)
    80004fc0:	0026979b          	slliw	a5,a3,0x2
    80004fc4:	00d787bb          	addw	a5,a5,a3
    80004fc8:	0017979b          	slliw	a5,a5,0x1
    80004fcc:	02f767bb          	remw	a5,a4,a5
    80004fd0:	fc0792e3          	bnez	a5,80004f94 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80004fd4:	fb9ff06f          	j	80004f8c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80004fd8:	00100793          	li	a5,1
    80004fdc:	00007717          	auipc	a4,0x7
    80004fe0:	fef72e23          	sw	a5,-4(a4) # 8000bfd8 <_ZL9threadEnd>
    td->buffer->put('!');
    80004fe4:	0209b783          	ld	a5,32(s3)
    80004fe8:	02100593          	li	a1,33
    80004fec:	0087b503          	ld	a0,8(a5)
    80004ff0:	00001097          	auipc	ra,0x1
    80004ff4:	c20080e7          	jalr	-992(ra) # 80005c10 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80004ff8:	0104b503          	ld	a0,16(s1)
    80004ffc:	ffffd097          	auipc	ra,0xffffd
    80005000:	178080e7          	jalr	376(ra) # 80002174 <_ZN9Semaphore6signalEv>
}
    80005004:	02813083          	ld	ra,40(sp)
    80005008:	02013403          	ld	s0,32(sp)
    8000500c:	01813483          	ld	s1,24(sp)
    80005010:	01013903          	ld	s2,16(sp)
    80005014:	00813983          	ld	s3,8(sp)
    80005018:	03010113          	addi	sp,sp,48
    8000501c:	00008067          	ret

0000000080005020 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    80005020:	fe010113          	addi	sp,sp,-32
    80005024:	00113c23          	sd	ra,24(sp)
    80005028:	00813823          	sd	s0,16(sp)
    8000502c:	00913423          	sd	s1,8(sp)
    80005030:	01213023          	sd	s2,0(sp)
    80005034:	02010413          	addi	s0,sp,32
    80005038:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    8000503c:	00000913          	li	s2,0
    80005040:	00c0006f          	j	8000504c <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80005044:	ffffd097          	auipc	ra,0xffffd
    80005048:	fd0080e7          	jalr	-48(ra) # 80002014 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    8000504c:	00007797          	auipc	a5,0x7
    80005050:	f8c7a783          	lw	a5,-116(a5) # 8000bfd8 <_ZL9threadEnd>
    80005054:	02079e63          	bnez	a5,80005090 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80005058:	0004a583          	lw	a1,0(s1)
    8000505c:	0305859b          	addiw	a1,a1,48
    80005060:	0084b503          	ld	a0,8(s1)
    80005064:	00001097          	auipc	ra,0x1
    80005068:	bac080e7          	jalr	-1108(ra) # 80005c10 <_ZN9BufferCPP3putEi>
        i++;
    8000506c:	0019071b          	addiw	a4,s2,1
    80005070:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80005074:	0004a683          	lw	a3,0(s1)
    80005078:	0026979b          	slliw	a5,a3,0x2
    8000507c:	00d787bb          	addw	a5,a5,a3
    80005080:	0017979b          	slliw	a5,a5,0x1
    80005084:	02f767bb          	remw	a5,a4,a5
    80005088:	fc0792e3          	bnez	a5,8000504c <_ZN12ProducerSync8producerEPv+0x2c>
    8000508c:	fb9ff06f          	j	80005044 <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80005090:	0104b503          	ld	a0,16(s1)
    80005094:	ffffd097          	auipc	ra,0xffffd
    80005098:	0e0080e7          	jalr	224(ra) # 80002174 <_ZN9Semaphore6signalEv>
}
    8000509c:	01813083          	ld	ra,24(sp)
    800050a0:	01013403          	ld	s0,16(sp)
    800050a4:	00813483          	ld	s1,8(sp)
    800050a8:	00013903          	ld	s2,0(sp)
    800050ac:	02010113          	addi	sp,sp,32
    800050b0:	00008067          	ret

00000000800050b4 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    800050b4:	fd010113          	addi	sp,sp,-48
    800050b8:	02113423          	sd	ra,40(sp)
    800050bc:	02813023          	sd	s0,32(sp)
    800050c0:	00913c23          	sd	s1,24(sp)
    800050c4:	01213823          	sd	s2,16(sp)
    800050c8:	01313423          	sd	s3,8(sp)
    800050cc:	01413023          	sd	s4,0(sp)
    800050d0:	03010413          	addi	s0,sp,48
    800050d4:	00050993          	mv	s3,a0
    800050d8:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800050dc:	00000a13          	li	s4,0
    800050e0:	01c0006f          	j	800050fc <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    800050e4:	ffffd097          	auipc	ra,0xffffd
    800050e8:	f30080e7          	jalr	-208(ra) # 80002014 <_ZN6Thread8dispatchEv>
    800050ec:	0500006f          	j	8000513c <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    800050f0:	00a00513          	li	a0,10
    800050f4:	ffffc097          	auipc	ra,0xffffc
    800050f8:	558080e7          	jalr	1368(ra) # 8000164c <_Z4putcc>
    while (!threadEnd) {
    800050fc:	00007797          	auipc	a5,0x7
    80005100:	edc7a783          	lw	a5,-292(a5) # 8000bfd8 <_ZL9threadEnd>
    80005104:	06079263          	bnez	a5,80005168 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    80005108:	00893503          	ld	a0,8(s2)
    8000510c:	00001097          	auipc	ra,0x1
    80005110:	b94080e7          	jalr	-1132(ra) # 80005ca0 <_ZN9BufferCPP3getEv>
        i++;
    80005114:	001a049b          	addiw	s1,s4,1
    80005118:	00048a1b          	sext.w	s4,s1
        putc(key);
    8000511c:	0ff57513          	andi	a0,a0,255
    80005120:	ffffc097          	auipc	ra,0xffffc
    80005124:	52c080e7          	jalr	1324(ra) # 8000164c <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80005128:	00092703          	lw	a4,0(s2)
    8000512c:	0027179b          	slliw	a5,a4,0x2
    80005130:	00e787bb          	addw	a5,a5,a4
    80005134:	02f4e7bb          	remw	a5,s1,a5
    80005138:	fa0786e3          	beqz	a5,800050e4 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    8000513c:	05000793          	li	a5,80
    80005140:	02f4e4bb          	remw	s1,s1,a5
    80005144:	fa049ce3          	bnez	s1,800050fc <_ZN12ConsumerSync8consumerEPv+0x48>
    80005148:	fa9ff06f          	j	800050f0 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    8000514c:	0209b783          	ld	a5,32(s3)
    80005150:	0087b503          	ld	a0,8(a5)
    80005154:	00001097          	auipc	ra,0x1
    80005158:	b4c080e7          	jalr	-1204(ra) # 80005ca0 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    8000515c:	0ff57513          	andi	a0,a0,255
    80005160:	ffffd097          	auipc	ra,0xffffd
    80005164:	0c4080e7          	jalr	196(ra) # 80002224 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80005168:	0209b783          	ld	a5,32(s3)
    8000516c:	0087b503          	ld	a0,8(a5)
    80005170:	00001097          	auipc	ra,0x1
    80005174:	bbc080e7          	jalr	-1092(ra) # 80005d2c <_ZN9BufferCPP6getCntEv>
    80005178:	fca04ae3          	bgtz	a0,8000514c <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    8000517c:	01093503          	ld	a0,16(s2)
    80005180:	ffffd097          	auipc	ra,0xffffd
    80005184:	ff4080e7          	jalr	-12(ra) # 80002174 <_ZN9Semaphore6signalEv>
}
    80005188:	02813083          	ld	ra,40(sp)
    8000518c:	02013403          	ld	s0,32(sp)
    80005190:	01813483          	ld	s1,24(sp)
    80005194:	01013903          	ld	s2,16(sp)
    80005198:	00813983          	ld	s3,8(sp)
    8000519c:	00013a03          	ld	s4,0(sp)
    800051a0:	03010113          	addi	sp,sp,48
    800051a4:	00008067          	ret

00000000800051a8 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    800051a8:	f8010113          	addi	sp,sp,-128
    800051ac:	06113c23          	sd	ra,120(sp)
    800051b0:	06813823          	sd	s0,112(sp)
    800051b4:	06913423          	sd	s1,104(sp)
    800051b8:	07213023          	sd	s2,96(sp)
    800051bc:	05313c23          	sd	s3,88(sp)
    800051c0:	05413823          	sd	s4,80(sp)
    800051c4:	05513423          	sd	s5,72(sp)
    800051c8:	05613023          	sd	s6,64(sp)
    800051cc:	03713c23          	sd	s7,56(sp)
    800051d0:	03813823          	sd	s8,48(sp)
    800051d4:	03913423          	sd	s9,40(sp)
    800051d8:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    800051dc:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    800051e0:	00004517          	auipc	a0,0x4
    800051e4:	f5050513          	addi	a0,a0,-176 # 80009130 <CONSOLE_STATUS+0x120>
    800051e8:	00000097          	auipc	ra,0x0
    800051ec:	604080e7          	jalr	1540(ra) # 800057ec <_Z11printStringPKc>
    getString(input, 30);
    800051f0:	01e00593          	li	a1,30
    800051f4:	f8040493          	addi	s1,s0,-128
    800051f8:	00048513          	mv	a0,s1
    800051fc:	00000097          	auipc	ra,0x0
    80005200:	678080e7          	jalr	1656(ra) # 80005874 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80005204:	00048513          	mv	a0,s1
    80005208:	00000097          	auipc	ra,0x0
    8000520c:	744080e7          	jalr	1860(ra) # 8000594c <_Z11stringToIntPKc>
    80005210:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80005214:	00004517          	auipc	a0,0x4
    80005218:	f3c50513          	addi	a0,a0,-196 # 80009150 <CONSOLE_STATUS+0x140>
    8000521c:	00000097          	auipc	ra,0x0
    80005220:	5d0080e7          	jalr	1488(ra) # 800057ec <_Z11printStringPKc>
    getString(input, 30);
    80005224:	01e00593          	li	a1,30
    80005228:	00048513          	mv	a0,s1
    8000522c:	00000097          	auipc	ra,0x0
    80005230:	648080e7          	jalr	1608(ra) # 80005874 <_Z9getStringPci>
    n = stringToInt(input);
    80005234:	00048513          	mv	a0,s1
    80005238:	00000097          	auipc	ra,0x0
    8000523c:	714080e7          	jalr	1812(ra) # 8000594c <_Z11stringToIntPKc>
    80005240:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80005244:	00004517          	auipc	a0,0x4
    80005248:	f2c50513          	addi	a0,a0,-212 # 80009170 <CONSOLE_STATUS+0x160>
    8000524c:	00000097          	auipc	ra,0x0
    80005250:	5a0080e7          	jalr	1440(ra) # 800057ec <_Z11printStringPKc>
    80005254:	00000613          	li	a2,0
    80005258:	00a00593          	li	a1,10
    8000525c:	00090513          	mv	a0,s2
    80005260:	00000097          	auipc	ra,0x0
    80005264:	73c080e7          	jalr	1852(ra) # 8000599c <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80005268:	00004517          	auipc	a0,0x4
    8000526c:	f2050513          	addi	a0,a0,-224 # 80009188 <CONSOLE_STATUS+0x178>
    80005270:	00000097          	auipc	ra,0x0
    80005274:	57c080e7          	jalr	1404(ra) # 800057ec <_Z11printStringPKc>
    80005278:	00000613          	li	a2,0
    8000527c:	00a00593          	li	a1,10
    80005280:	00048513          	mv	a0,s1
    80005284:	00000097          	auipc	ra,0x0
    80005288:	718080e7          	jalr	1816(ra) # 8000599c <_Z8printIntiii>
    printString(".\n");
    8000528c:	00004517          	auipc	a0,0x4
    80005290:	f1450513          	addi	a0,a0,-236 # 800091a0 <CONSOLE_STATUS+0x190>
    80005294:	00000097          	auipc	ra,0x0
    80005298:	558080e7          	jalr	1368(ra) # 800057ec <_Z11printStringPKc>
    if(threadNum > n) {
    8000529c:	0324c463          	blt	s1,s2,800052c4 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    800052a0:	03205c63          	blez	s2,800052d8 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    800052a4:	03800513          	li	a0,56
    800052a8:	ffffd097          	auipc	ra,0xffffd
    800052ac:	c1c080e7          	jalr	-996(ra) # 80001ec4 <_Znwm>
    800052b0:	00050a93          	mv	s5,a0
    800052b4:	00048593          	mv	a1,s1
    800052b8:	00001097          	auipc	ra,0x1
    800052bc:	804080e7          	jalr	-2044(ra) # 80005abc <_ZN9BufferCPPC1Ei>
    800052c0:	0300006f          	j	800052f0 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800052c4:	00004517          	auipc	a0,0x4
    800052c8:	ee450513          	addi	a0,a0,-284 # 800091a8 <CONSOLE_STATUS+0x198>
    800052cc:	00000097          	auipc	ra,0x0
    800052d0:	520080e7          	jalr	1312(ra) # 800057ec <_Z11printStringPKc>
        return;
    800052d4:	0140006f          	j	800052e8 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800052d8:	00004517          	auipc	a0,0x4
    800052dc:	f1050513          	addi	a0,a0,-240 # 800091e8 <CONSOLE_STATUS+0x1d8>
    800052e0:	00000097          	auipc	ra,0x0
    800052e4:	50c080e7          	jalr	1292(ra) # 800057ec <_Z11printStringPKc>
        return;
    800052e8:	000b8113          	mv	sp,s7
    800052ec:	2380006f          	j	80005524 <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    800052f0:	01000513          	li	a0,16
    800052f4:	ffffd097          	auipc	ra,0xffffd
    800052f8:	bd0080e7          	jalr	-1072(ra) # 80001ec4 <_Znwm>
    800052fc:	00050493          	mv	s1,a0
    80005300:	00000593          	li	a1,0
    80005304:	ffffd097          	auipc	ra,0xffffd
    80005308:	e08080e7          	jalr	-504(ra) # 8000210c <_ZN9SemaphoreC1Ej>
    8000530c:	00007797          	auipc	a5,0x7
    80005310:	cc97ba23          	sd	s1,-812(a5) # 8000bfe0 <_ZL10waitForAll>
    Thread* threads[threadNum];
    80005314:	00391793          	slli	a5,s2,0x3
    80005318:	00f78793          	addi	a5,a5,15
    8000531c:	ff07f793          	andi	a5,a5,-16
    80005320:	40f10133          	sub	sp,sp,a5
    80005324:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80005328:	0019071b          	addiw	a4,s2,1
    8000532c:	00171793          	slli	a5,a4,0x1
    80005330:	00e787b3          	add	a5,a5,a4
    80005334:	00379793          	slli	a5,a5,0x3
    80005338:	00f78793          	addi	a5,a5,15
    8000533c:	ff07f793          	andi	a5,a5,-16
    80005340:	40f10133          	sub	sp,sp,a5
    80005344:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80005348:	00191c13          	slli	s8,s2,0x1
    8000534c:	012c07b3          	add	a5,s8,s2
    80005350:	00379793          	slli	a5,a5,0x3
    80005354:	00fa07b3          	add	a5,s4,a5
    80005358:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    8000535c:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80005360:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80005364:	02800513          	li	a0,40
    80005368:	ffffd097          	auipc	ra,0xffffd
    8000536c:	b5c080e7          	jalr	-1188(ra) # 80001ec4 <_Znwm>
    80005370:	00050b13          	mv	s6,a0
    80005374:	012c0c33          	add	s8,s8,s2
    80005378:	003c1c13          	slli	s8,s8,0x3
    8000537c:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80005380:	ffffd097          	auipc	ra,0xffffd
    80005384:	c64080e7          	jalr	-924(ra) # 80001fe4 <_ZN6ThreadC1Ev>
    80005388:	00007797          	auipc	a5,0x7
    8000538c:	97878793          	addi	a5,a5,-1672 # 8000bd00 <_ZTV12ConsumerSync+0x10>
    80005390:	00fb3023          	sd	a5,0(s6)
    80005394:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    80005398:	000b0513          	mv	a0,s6
    8000539c:	ffffd097          	auipc	ra,0xffffd
    800053a0:	ce4080e7          	jalr	-796(ra) # 80002080 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800053a4:	00000493          	li	s1,0
    800053a8:	0380006f          	j	800053e0 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    800053ac:	00007797          	auipc	a5,0x7
    800053b0:	92c78793          	addi	a5,a5,-1748 # 8000bcd8 <_ZTV12ProducerSync+0x10>
    800053b4:	00fcb023          	sd	a5,0(s9)
    800053b8:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    800053bc:	00349793          	slli	a5,s1,0x3
    800053c0:	00f987b3          	add	a5,s3,a5
    800053c4:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    800053c8:	00349793          	slli	a5,s1,0x3
    800053cc:	00f987b3          	add	a5,s3,a5
    800053d0:	0007b503          	ld	a0,0(a5)
    800053d4:	ffffd097          	auipc	ra,0xffffd
    800053d8:	cac080e7          	jalr	-852(ra) # 80002080 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800053dc:	0014849b          	addiw	s1,s1,1
    800053e0:	0b24d063          	bge	s1,s2,80005480 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    800053e4:	00149793          	slli	a5,s1,0x1
    800053e8:	009787b3          	add	a5,a5,s1
    800053ec:	00379793          	slli	a5,a5,0x3
    800053f0:	00fa07b3          	add	a5,s4,a5
    800053f4:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800053f8:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    800053fc:	00007717          	auipc	a4,0x7
    80005400:	be473703          	ld	a4,-1052(a4) # 8000bfe0 <_ZL10waitForAll>
    80005404:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80005408:	02905863          	blez	s1,80005438 <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    8000540c:	02800513          	li	a0,40
    80005410:	ffffd097          	auipc	ra,0xffffd
    80005414:	ab4080e7          	jalr	-1356(ra) # 80001ec4 <_Znwm>
    80005418:	00050c93          	mv	s9,a0
    8000541c:	00149c13          	slli	s8,s1,0x1
    80005420:	009c0c33          	add	s8,s8,s1
    80005424:	003c1c13          	slli	s8,s8,0x3
    80005428:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    8000542c:	ffffd097          	auipc	ra,0xffffd
    80005430:	bb8080e7          	jalr	-1096(ra) # 80001fe4 <_ZN6ThreadC1Ev>
    80005434:	f79ff06f          	j	800053ac <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    80005438:	02800513          	li	a0,40
    8000543c:	ffffd097          	auipc	ra,0xffffd
    80005440:	a88080e7          	jalr	-1400(ra) # 80001ec4 <_Znwm>
    80005444:	00050c93          	mv	s9,a0
    80005448:	00149c13          	slli	s8,s1,0x1
    8000544c:	009c0c33          	add	s8,s8,s1
    80005450:	003c1c13          	slli	s8,s8,0x3
    80005454:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80005458:	ffffd097          	auipc	ra,0xffffd
    8000545c:	b8c080e7          	jalr	-1140(ra) # 80001fe4 <_ZN6ThreadC1Ev>
    80005460:	00007797          	auipc	a5,0x7
    80005464:	85078793          	addi	a5,a5,-1968 # 8000bcb0 <_ZTV16ProducerKeyboard+0x10>
    80005468:	00fcb023          	sd	a5,0(s9)
    8000546c:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80005470:	00349793          	slli	a5,s1,0x3
    80005474:	00f987b3          	add	a5,s3,a5
    80005478:	0197b023          	sd	s9,0(a5)
    8000547c:	f4dff06f          	j	800053c8 <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    80005480:	ffffd097          	auipc	ra,0xffffd
    80005484:	b94080e7          	jalr	-1132(ra) # 80002014 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80005488:	00000493          	li	s1,0
    8000548c:	00994e63          	blt	s2,s1,800054a8 <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    80005490:	00007517          	auipc	a0,0x7
    80005494:	b5053503          	ld	a0,-1200(a0) # 8000bfe0 <_ZL10waitForAll>
    80005498:	ffffd097          	auipc	ra,0xffffd
    8000549c:	cb0080e7          	jalr	-848(ra) # 80002148 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    800054a0:	0014849b          	addiw	s1,s1,1
    800054a4:	fe9ff06f          	j	8000548c <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    800054a8:	00000493          	li	s1,0
    800054ac:	0080006f          	j	800054b4 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    800054b0:	0014849b          	addiw	s1,s1,1
    800054b4:	0324d263          	bge	s1,s2,800054d8 <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    800054b8:	00349793          	slli	a5,s1,0x3
    800054bc:	00f987b3          	add	a5,s3,a5
    800054c0:	0007b503          	ld	a0,0(a5)
    800054c4:	fe0506e3          	beqz	a0,800054b0 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    800054c8:	00053783          	ld	a5,0(a0)
    800054cc:	0087b783          	ld	a5,8(a5)
    800054d0:	000780e7          	jalr	a5
    800054d4:	fddff06f          	j	800054b0 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    800054d8:	000b0a63          	beqz	s6,800054ec <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    800054dc:	000b3783          	ld	a5,0(s6)
    800054e0:	0087b783          	ld	a5,8(a5)
    800054e4:	000b0513          	mv	a0,s6
    800054e8:	000780e7          	jalr	a5
    delete waitForAll;
    800054ec:	00007517          	auipc	a0,0x7
    800054f0:	af453503          	ld	a0,-1292(a0) # 8000bfe0 <_ZL10waitForAll>
    800054f4:	00050863          	beqz	a0,80005504 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    800054f8:	00053783          	ld	a5,0(a0)
    800054fc:	0087b783          	ld	a5,8(a5)
    80005500:	000780e7          	jalr	a5
    delete buffer;
    80005504:	000a8e63          	beqz	s5,80005520 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    80005508:	000a8513          	mv	a0,s5
    8000550c:	00001097          	auipc	ra,0x1
    80005510:	8a8080e7          	jalr	-1880(ra) # 80005db4 <_ZN9BufferCPPD1Ev>
    80005514:	000a8513          	mv	a0,s5
    80005518:	ffffd097          	auipc	ra,0xffffd
    8000551c:	9fc080e7          	jalr	-1540(ra) # 80001f14 <_ZdlPv>
    80005520:	000b8113          	mv	sp,s7

}
    80005524:	f8040113          	addi	sp,s0,-128
    80005528:	07813083          	ld	ra,120(sp)
    8000552c:	07013403          	ld	s0,112(sp)
    80005530:	06813483          	ld	s1,104(sp)
    80005534:	06013903          	ld	s2,96(sp)
    80005538:	05813983          	ld	s3,88(sp)
    8000553c:	05013a03          	ld	s4,80(sp)
    80005540:	04813a83          	ld	s5,72(sp)
    80005544:	04013b03          	ld	s6,64(sp)
    80005548:	03813b83          	ld	s7,56(sp)
    8000554c:	03013c03          	ld	s8,48(sp)
    80005550:	02813c83          	ld	s9,40(sp)
    80005554:	08010113          	addi	sp,sp,128
    80005558:	00008067          	ret
    8000555c:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80005560:	000a8513          	mv	a0,s5
    80005564:	ffffd097          	auipc	ra,0xffffd
    80005568:	9b0080e7          	jalr	-1616(ra) # 80001f14 <_ZdlPv>
    8000556c:	00048513          	mv	a0,s1
    80005570:	00008097          	auipc	ra,0x8
    80005574:	b58080e7          	jalr	-1192(ra) # 8000d0c8 <_Unwind_Resume>
    80005578:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    8000557c:	00048513          	mv	a0,s1
    80005580:	ffffd097          	auipc	ra,0xffffd
    80005584:	994080e7          	jalr	-1644(ra) # 80001f14 <_ZdlPv>
    80005588:	00090513          	mv	a0,s2
    8000558c:	00008097          	auipc	ra,0x8
    80005590:	b3c080e7          	jalr	-1220(ra) # 8000d0c8 <_Unwind_Resume>
    80005594:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    80005598:	000b0513          	mv	a0,s6
    8000559c:	ffffd097          	auipc	ra,0xffffd
    800055a0:	978080e7          	jalr	-1672(ra) # 80001f14 <_ZdlPv>
    800055a4:	00048513          	mv	a0,s1
    800055a8:	00008097          	auipc	ra,0x8
    800055ac:	b20080e7          	jalr	-1248(ra) # 8000d0c8 <_Unwind_Resume>
    800055b0:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    800055b4:	000c8513          	mv	a0,s9
    800055b8:	ffffd097          	auipc	ra,0xffffd
    800055bc:	95c080e7          	jalr	-1700(ra) # 80001f14 <_ZdlPv>
    800055c0:	00048513          	mv	a0,s1
    800055c4:	00008097          	auipc	ra,0x8
    800055c8:	b04080e7          	jalr	-1276(ra) # 8000d0c8 <_Unwind_Resume>
    800055cc:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    800055d0:	000c8513          	mv	a0,s9
    800055d4:	ffffd097          	auipc	ra,0xffffd
    800055d8:	940080e7          	jalr	-1728(ra) # 80001f14 <_ZdlPv>
    800055dc:	00048513          	mv	a0,s1
    800055e0:	00008097          	auipc	ra,0x8
    800055e4:	ae8080e7          	jalr	-1304(ra) # 8000d0c8 <_Unwind_Resume>

00000000800055e8 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    800055e8:	ff010113          	addi	sp,sp,-16
    800055ec:	00113423          	sd	ra,8(sp)
    800055f0:	00813023          	sd	s0,0(sp)
    800055f4:	01010413          	addi	s0,sp,16
    800055f8:	00006797          	auipc	a5,0x6
    800055fc:	70878793          	addi	a5,a5,1800 # 8000bd00 <_ZTV12ConsumerSync+0x10>
    80005600:	00f53023          	sd	a5,0(a0)
    80005604:	ffffd097          	auipc	ra,0xffffd
    80005608:	850080e7          	jalr	-1968(ra) # 80001e54 <_ZN6ThreadD1Ev>
    8000560c:	00813083          	ld	ra,8(sp)
    80005610:	00013403          	ld	s0,0(sp)
    80005614:	01010113          	addi	sp,sp,16
    80005618:	00008067          	ret

000000008000561c <_ZN12ConsumerSyncD0Ev>:
    8000561c:	fe010113          	addi	sp,sp,-32
    80005620:	00113c23          	sd	ra,24(sp)
    80005624:	00813823          	sd	s0,16(sp)
    80005628:	00913423          	sd	s1,8(sp)
    8000562c:	02010413          	addi	s0,sp,32
    80005630:	00050493          	mv	s1,a0
    80005634:	00006797          	auipc	a5,0x6
    80005638:	6cc78793          	addi	a5,a5,1740 # 8000bd00 <_ZTV12ConsumerSync+0x10>
    8000563c:	00f53023          	sd	a5,0(a0)
    80005640:	ffffd097          	auipc	ra,0xffffd
    80005644:	814080e7          	jalr	-2028(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80005648:	00048513          	mv	a0,s1
    8000564c:	ffffd097          	auipc	ra,0xffffd
    80005650:	8c8080e7          	jalr	-1848(ra) # 80001f14 <_ZdlPv>
    80005654:	01813083          	ld	ra,24(sp)
    80005658:	01013403          	ld	s0,16(sp)
    8000565c:	00813483          	ld	s1,8(sp)
    80005660:	02010113          	addi	sp,sp,32
    80005664:	00008067          	ret

0000000080005668 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80005668:	ff010113          	addi	sp,sp,-16
    8000566c:	00113423          	sd	ra,8(sp)
    80005670:	00813023          	sd	s0,0(sp)
    80005674:	01010413          	addi	s0,sp,16
    80005678:	00006797          	auipc	a5,0x6
    8000567c:	66078793          	addi	a5,a5,1632 # 8000bcd8 <_ZTV12ProducerSync+0x10>
    80005680:	00f53023          	sd	a5,0(a0)
    80005684:	ffffc097          	auipc	ra,0xffffc
    80005688:	7d0080e7          	jalr	2000(ra) # 80001e54 <_ZN6ThreadD1Ev>
    8000568c:	00813083          	ld	ra,8(sp)
    80005690:	00013403          	ld	s0,0(sp)
    80005694:	01010113          	addi	sp,sp,16
    80005698:	00008067          	ret

000000008000569c <_ZN12ProducerSyncD0Ev>:
    8000569c:	fe010113          	addi	sp,sp,-32
    800056a0:	00113c23          	sd	ra,24(sp)
    800056a4:	00813823          	sd	s0,16(sp)
    800056a8:	00913423          	sd	s1,8(sp)
    800056ac:	02010413          	addi	s0,sp,32
    800056b0:	00050493          	mv	s1,a0
    800056b4:	00006797          	auipc	a5,0x6
    800056b8:	62478793          	addi	a5,a5,1572 # 8000bcd8 <_ZTV12ProducerSync+0x10>
    800056bc:	00f53023          	sd	a5,0(a0)
    800056c0:	ffffc097          	auipc	ra,0xffffc
    800056c4:	794080e7          	jalr	1940(ra) # 80001e54 <_ZN6ThreadD1Ev>
    800056c8:	00048513          	mv	a0,s1
    800056cc:	ffffd097          	auipc	ra,0xffffd
    800056d0:	848080e7          	jalr	-1976(ra) # 80001f14 <_ZdlPv>
    800056d4:	01813083          	ld	ra,24(sp)
    800056d8:	01013403          	ld	s0,16(sp)
    800056dc:	00813483          	ld	s1,8(sp)
    800056e0:	02010113          	addi	sp,sp,32
    800056e4:	00008067          	ret

00000000800056e8 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    800056e8:	ff010113          	addi	sp,sp,-16
    800056ec:	00113423          	sd	ra,8(sp)
    800056f0:	00813023          	sd	s0,0(sp)
    800056f4:	01010413          	addi	s0,sp,16
    800056f8:	00006797          	auipc	a5,0x6
    800056fc:	5b878793          	addi	a5,a5,1464 # 8000bcb0 <_ZTV16ProducerKeyboard+0x10>
    80005700:	00f53023          	sd	a5,0(a0)
    80005704:	ffffc097          	auipc	ra,0xffffc
    80005708:	750080e7          	jalr	1872(ra) # 80001e54 <_ZN6ThreadD1Ev>
    8000570c:	00813083          	ld	ra,8(sp)
    80005710:	00013403          	ld	s0,0(sp)
    80005714:	01010113          	addi	sp,sp,16
    80005718:	00008067          	ret

000000008000571c <_ZN16ProducerKeyboardD0Ev>:
    8000571c:	fe010113          	addi	sp,sp,-32
    80005720:	00113c23          	sd	ra,24(sp)
    80005724:	00813823          	sd	s0,16(sp)
    80005728:	00913423          	sd	s1,8(sp)
    8000572c:	02010413          	addi	s0,sp,32
    80005730:	00050493          	mv	s1,a0
    80005734:	00006797          	auipc	a5,0x6
    80005738:	57c78793          	addi	a5,a5,1404 # 8000bcb0 <_ZTV16ProducerKeyboard+0x10>
    8000573c:	00f53023          	sd	a5,0(a0)
    80005740:	ffffc097          	auipc	ra,0xffffc
    80005744:	714080e7          	jalr	1812(ra) # 80001e54 <_ZN6ThreadD1Ev>
    80005748:	00048513          	mv	a0,s1
    8000574c:	ffffc097          	auipc	ra,0xffffc
    80005750:	7c8080e7          	jalr	1992(ra) # 80001f14 <_ZdlPv>
    80005754:	01813083          	ld	ra,24(sp)
    80005758:	01013403          	ld	s0,16(sp)
    8000575c:	00813483          	ld	s1,8(sp)
    80005760:	02010113          	addi	sp,sp,32
    80005764:	00008067          	ret

0000000080005768 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80005768:	ff010113          	addi	sp,sp,-16
    8000576c:	00113423          	sd	ra,8(sp)
    80005770:	00813023          	sd	s0,0(sp)
    80005774:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80005778:	02053583          	ld	a1,32(a0)
    8000577c:	fffff097          	auipc	ra,0xfffff
    80005780:	7e4080e7          	jalr	2020(ra) # 80004f60 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80005784:	00813083          	ld	ra,8(sp)
    80005788:	00013403          	ld	s0,0(sp)
    8000578c:	01010113          	addi	sp,sp,16
    80005790:	00008067          	ret

0000000080005794 <_ZN12ProducerSync3runEv>:
    void run() override {
    80005794:	ff010113          	addi	sp,sp,-16
    80005798:	00113423          	sd	ra,8(sp)
    8000579c:	00813023          	sd	s0,0(sp)
    800057a0:	01010413          	addi	s0,sp,16
        producer(td);
    800057a4:	02053583          	ld	a1,32(a0)
    800057a8:	00000097          	auipc	ra,0x0
    800057ac:	878080e7          	jalr	-1928(ra) # 80005020 <_ZN12ProducerSync8producerEPv>
    }
    800057b0:	00813083          	ld	ra,8(sp)
    800057b4:	00013403          	ld	s0,0(sp)
    800057b8:	01010113          	addi	sp,sp,16
    800057bc:	00008067          	ret

00000000800057c0 <_ZN12ConsumerSync3runEv>:
    void run() override {
    800057c0:	ff010113          	addi	sp,sp,-16
    800057c4:	00113423          	sd	ra,8(sp)
    800057c8:	00813023          	sd	s0,0(sp)
    800057cc:	01010413          	addi	s0,sp,16
        consumer(td);
    800057d0:	02053583          	ld	a1,32(a0)
    800057d4:	00000097          	auipc	ra,0x0
    800057d8:	8e0080e7          	jalr	-1824(ra) # 800050b4 <_ZN12ConsumerSync8consumerEPv>
    }
    800057dc:	00813083          	ld	ra,8(sp)
    800057e0:	00013403          	ld	s0,0(sp)
    800057e4:	01010113          	addi	sp,sp,16
    800057e8:	00008067          	ret

00000000800057ec <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    800057ec:	fe010113          	addi	sp,sp,-32
    800057f0:	00113c23          	sd	ra,24(sp)
    800057f4:	00813823          	sd	s0,16(sp)
    800057f8:	00913423          	sd	s1,8(sp)
    800057fc:	02010413          	addi	s0,sp,32
    80005800:	00050493          	mv	s1,a0
    LOCK();
    80005804:	00100613          	li	a2,1
    80005808:	00000593          	li	a1,0
    8000580c:	00006517          	auipc	a0,0x6
    80005810:	7dc50513          	addi	a0,a0,2012 # 8000bfe8 <lockPrint>
    80005814:	ffffc097          	auipc	ra,0xffffc
    80005818:	9c4080e7          	jalr	-1596(ra) # 800011d8 <copy_and_swap>
    8000581c:	00050863          	beqz	a0,8000582c <_Z11printStringPKc+0x40>
    80005820:	ffffc097          	auipc	ra,0xffffc
    80005824:	b98080e7          	jalr	-1128(ra) # 800013b8 <_Z15thread_dispatchv>
    80005828:	fddff06f          	j	80005804 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    8000582c:	0004c503          	lbu	a0,0(s1)
    80005830:	00050a63          	beqz	a0,80005844 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80005834:	ffffc097          	auipc	ra,0xffffc
    80005838:	e18080e7          	jalr	-488(ra) # 8000164c <_Z4putcc>
        string++;
    8000583c:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80005840:	fedff06f          	j	8000582c <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80005844:	00000613          	li	a2,0
    80005848:	00100593          	li	a1,1
    8000584c:	00006517          	auipc	a0,0x6
    80005850:	79c50513          	addi	a0,a0,1948 # 8000bfe8 <lockPrint>
    80005854:	ffffc097          	auipc	ra,0xffffc
    80005858:	984080e7          	jalr	-1660(ra) # 800011d8 <copy_and_swap>
    8000585c:	fe0514e3          	bnez	a0,80005844 <_Z11printStringPKc+0x58>
}
    80005860:	01813083          	ld	ra,24(sp)
    80005864:	01013403          	ld	s0,16(sp)
    80005868:	00813483          	ld	s1,8(sp)
    8000586c:	02010113          	addi	sp,sp,32
    80005870:	00008067          	ret

0000000080005874 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80005874:	fd010113          	addi	sp,sp,-48
    80005878:	02113423          	sd	ra,40(sp)
    8000587c:	02813023          	sd	s0,32(sp)
    80005880:	00913c23          	sd	s1,24(sp)
    80005884:	01213823          	sd	s2,16(sp)
    80005888:	01313423          	sd	s3,8(sp)
    8000588c:	01413023          	sd	s4,0(sp)
    80005890:	03010413          	addi	s0,sp,48
    80005894:	00050993          	mv	s3,a0
    80005898:	00058a13          	mv	s4,a1
    LOCK();
    8000589c:	00100613          	li	a2,1
    800058a0:	00000593          	li	a1,0
    800058a4:	00006517          	auipc	a0,0x6
    800058a8:	74450513          	addi	a0,a0,1860 # 8000bfe8 <lockPrint>
    800058ac:	ffffc097          	auipc	ra,0xffffc
    800058b0:	92c080e7          	jalr	-1748(ra) # 800011d8 <copy_and_swap>
    800058b4:	00050863          	beqz	a0,800058c4 <_Z9getStringPci+0x50>
    800058b8:	ffffc097          	auipc	ra,0xffffc
    800058bc:	b00080e7          	jalr	-1280(ra) # 800013b8 <_Z15thread_dispatchv>
    800058c0:	fddff06f          	j	8000589c <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800058c4:	00000913          	li	s2,0
    800058c8:	00090493          	mv	s1,s2
    800058cc:	0019091b          	addiw	s2,s2,1
    800058d0:	03495a63          	bge	s2,s4,80005904 <_Z9getStringPci+0x90>
        cc = getc();
    800058d4:	ffffc097          	auipc	ra,0xffffc
    800058d8:	d20080e7          	jalr	-736(ra) # 800015f4 <_Z4getcv>
        if(cc < 1)
    800058dc:	02050463          	beqz	a0,80005904 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    800058e0:	009984b3          	add	s1,s3,s1
    800058e4:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800058e8:	00a00793          	li	a5,10
    800058ec:	00f50a63          	beq	a0,a5,80005900 <_Z9getStringPci+0x8c>
    800058f0:	00d00793          	li	a5,13
    800058f4:	fcf51ae3          	bne	a0,a5,800058c8 <_Z9getStringPci+0x54>
        buf[i++] = c;
    800058f8:	00090493          	mv	s1,s2
    800058fc:	0080006f          	j	80005904 <_Z9getStringPci+0x90>
    80005900:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80005904:	009984b3          	add	s1,s3,s1
    80005908:	00048023          	sb	zero,0(s1)

    UNLOCK();
    8000590c:	00000613          	li	a2,0
    80005910:	00100593          	li	a1,1
    80005914:	00006517          	auipc	a0,0x6
    80005918:	6d450513          	addi	a0,a0,1748 # 8000bfe8 <lockPrint>
    8000591c:	ffffc097          	auipc	ra,0xffffc
    80005920:	8bc080e7          	jalr	-1860(ra) # 800011d8 <copy_and_swap>
    80005924:	fe0514e3          	bnez	a0,8000590c <_Z9getStringPci+0x98>
    return buf;
}
    80005928:	00098513          	mv	a0,s3
    8000592c:	02813083          	ld	ra,40(sp)
    80005930:	02013403          	ld	s0,32(sp)
    80005934:	01813483          	ld	s1,24(sp)
    80005938:	01013903          	ld	s2,16(sp)
    8000593c:	00813983          	ld	s3,8(sp)
    80005940:	00013a03          	ld	s4,0(sp)
    80005944:	03010113          	addi	sp,sp,48
    80005948:	00008067          	ret

000000008000594c <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    8000594c:	ff010113          	addi	sp,sp,-16
    80005950:	00813423          	sd	s0,8(sp)
    80005954:	01010413          	addi	s0,sp,16
    80005958:	00050693          	mv	a3,a0
    int n;

    n = 0;
    8000595c:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80005960:	0006c603          	lbu	a2,0(a3)
    80005964:	fd06071b          	addiw	a4,a2,-48
    80005968:	0ff77713          	andi	a4,a4,255
    8000596c:	00900793          	li	a5,9
    80005970:	02e7e063          	bltu	a5,a4,80005990 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80005974:	0025179b          	slliw	a5,a0,0x2
    80005978:	00a787bb          	addw	a5,a5,a0
    8000597c:	0017979b          	slliw	a5,a5,0x1
    80005980:	00168693          	addi	a3,a3,1
    80005984:	00c787bb          	addw	a5,a5,a2
    80005988:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    8000598c:	fd5ff06f          	j	80005960 <_Z11stringToIntPKc+0x14>
    return n;
}
    80005990:	00813403          	ld	s0,8(sp)
    80005994:	01010113          	addi	sp,sp,16
    80005998:	00008067          	ret

000000008000599c <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    8000599c:	fc010113          	addi	sp,sp,-64
    800059a0:	02113c23          	sd	ra,56(sp)
    800059a4:	02813823          	sd	s0,48(sp)
    800059a8:	02913423          	sd	s1,40(sp)
    800059ac:	03213023          	sd	s2,32(sp)
    800059b0:	01313c23          	sd	s3,24(sp)
    800059b4:	04010413          	addi	s0,sp,64
    800059b8:	00050493          	mv	s1,a0
    800059bc:	00058913          	mv	s2,a1
    800059c0:	00060993          	mv	s3,a2
    LOCK();
    800059c4:	00100613          	li	a2,1
    800059c8:	00000593          	li	a1,0
    800059cc:	00006517          	auipc	a0,0x6
    800059d0:	61c50513          	addi	a0,a0,1564 # 8000bfe8 <lockPrint>
    800059d4:	ffffc097          	auipc	ra,0xffffc
    800059d8:	804080e7          	jalr	-2044(ra) # 800011d8 <copy_and_swap>
    800059dc:	00050863          	beqz	a0,800059ec <_Z8printIntiii+0x50>
    800059e0:	ffffc097          	auipc	ra,0xffffc
    800059e4:	9d8080e7          	jalr	-1576(ra) # 800013b8 <_Z15thread_dispatchv>
    800059e8:	fddff06f          	j	800059c4 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800059ec:	00098463          	beqz	s3,800059f4 <_Z8printIntiii+0x58>
    800059f0:	0804c463          	bltz	s1,80005a78 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800059f4:	0004851b          	sext.w	a0,s1
    neg = 0;
    800059f8:	00000593          	li	a1,0
    }

    i = 0;
    800059fc:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80005a00:	0009079b          	sext.w	a5,s2
    80005a04:	0325773b          	remuw	a4,a0,s2
    80005a08:	00048613          	mv	a2,s1
    80005a0c:	0014849b          	addiw	s1,s1,1
    80005a10:	02071693          	slli	a3,a4,0x20
    80005a14:	0206d693          	srli	a3,a3,0x20
    80005a18:	00006717          	auipc	a4,0x6
    80005a1c:	30070713          	addi	a4,a4,768 # 8000bd18 <digits>
    80005a20:	00d70733          	add	a4,a4,a3
    80005a24:	00074683          	lbu	a3,0(a4)
    80005a28:	fd040713          	addi	a4,s0,-48
    80005a2c:	00c70733          	add	a4,a4,a2
    80005a30:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80005a34:	0005071b          	sext.w	a4,a0
    80005a38:	0325553b          	divuw	a0,a0,s2
    80005a3c:	fcf772e3          	bgeu	a4,a5,80005a00 <_Z8printIntiii+0x64>
    if(neg)
    80005a40:	00058c63          	beqz	a1,80005a58 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80005a44:	fd040793          	addi	a5,s0,-48
    80005a48:	009784b3          	add	s1,a5,s1
    80005a4c:	02d00793          	li	a5,45
    80005a50:	fef48823          	sb	a5,-16(s1)
    80005a54:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80005a58:	fff4849b          	addiw	s1,s1,-1
    80005a5c:	0204c463          	bltz	s1,80005a84 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80005a60:	fd040793          	addi	a5,s0,-48
    80005a64:	009787b3          	add	a5,a5,s1
    80005a68:	ff07c503          	lbu	a0,-16(a5)
    80005a6c:	ffffc097          	auipc	ra,0xffffc
    80005a70:	be0080e7          	jalr	-1056(ra) # 8000164c <_Z4putcc>
    80005a74:	fe5ff06f          	j	80005a58 <_Z8printIntiii+0xbc>
        x = -xx;
    80005a78:	4090053b          	negw	a0,s1
        neg = 1;
    80005a7c:	00100593          	li	a1,1
        x = -xx;
    80005a80:	f7dff06f          	j	800059fc <_Z8printIntiii+0x60>

    UNLOCK();
    80005a84:	00000613          	li	a2,0
    80005a88:	00100593          	li	a1,1
    80005a8c:	00006517          	auipc	a0,0x6
    80005a90:	55c50513          	addi	a0,a0,1372 # 8000bfe8 <lockPrint>
    80005a94:	ffffb097          	auipc	ra,0xffffb
    80005a98:	744080e7          	jalr	1860(ra) # 800011d8 <copy_and_swap>
    80005a9c:	fe0514e3          	bnez	a0,80005a84 <_Z8printIntiii+0xe8>
    80005aa0:	03813083          	ld	ra,56(sp)
    80005aa4:	03013403          	ld	s0,48(sp)
    80005aa8:	02813483          	ld	s1,40(sp)
    80005aac:	02013903          	ld	s2,32(sp)
    80005ab0:	01813983          	ld	s3,24(sp)
    80005ab4:	04010113          	addi	sp,sp,64
    80005ab8:	00008067          	ret

0000000080005abc <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80005abc:	fd010113          	addi	sp,sp,-48
    80005ac0:	02113423          	sd	ra,40(sp)
    80005ac4:	02813023          	sd	s0,32(sp)
    80005ac8:	00913c23          	sd	s1,24(sp)
    80005acc:	01213823          	sd	s2,16(sp)
    80005ad0:	01313423          	sd	s3,8(sp)
    80005ad4:	03010413          	addi	s0,sp,48
    80005ad8:	00050493          	mv	s1,a0
    80005adc:	00058913          	mv	s2,a1
    80005ae0:	0015879b          	addiw	a5,a1,1
    80005ae4:	0007851b          	sext.w	a0,a5
    80005ae8:	00f4a023          	sw	a5,0(s1)
    80005aec:	0004a823          	sw	zero,16(s1)
    80005af0:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80005af4:	00251513          	slli	a0,a0,0x2
    80005af8:	ffffb097          	auipc	ra,0xffffb
    80005afc:	71c080e7          	jalr	1820(ra) # 80001214 <_Z9mem_allocm>
    80005b00:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80005b04:	01000513          	li	a0,16
    80005b08:	ffffc097          	auipc	ra,0xffffc
    80005b0c:	3bc080e7          	jalr	956(ra) # 80001ec4 <_Znwm>
    80005b10:	00050993          	mv	s3,a0
    80005b14:	00000593          	li	a1,0
    80005b18:	ffffc097          	auipc	ra,0xffffc
    80005b1c:	5f4080e7          	jalr	1524(ra) # 8000210c <_ZN9SemaphoreC1Ej>
    80005b20:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80005b24:	01000513          	li	a0,16
    80005b28:	ffffc097          	auipc	ra,0xffffc
    80005b2c:	39c080e7          	jalr	924(ra) # 80001ec4 <_Znwm>
    80005b30:	00050993          	mv	s3,a0
    80005b34:	00090593          	mv	a1,s2
    80005b38:	ffffc097          	auipc	ra,0xffffc
    80005b3c:	5d4080e7          	jalr	1492(ra) # 8000210c <_ZN9SemaphoreC1Ej>
    80005b40:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80005b44:	01000513          	li	a0,16
    80005b48:	ffffc097          	auipc	ra,0xffffc
    80005b4c:	37c080e7          	jalr	892(ra) # 80001ec4 <_Znwm>
    80005b50:	00050913          	mv	s2,a0
    80005b54:	00100593          	li	a1,1
    80005b58:	ffffc097          	auipc	ra,0xffffc
    80005b5c:	5b4080e7          	jalr	1460(ra) # 8000210c <_ZN9SemaphoreC1Ej>
    80005b60:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80005b64:	01000513          	li	a0,16
    80005b68:	ffffc097          	auipc	ra,0xffffc
    80005b6c:	35c080e7          	jalr	860(ra) # 80001ec4 <_Znwm>
    80005b70:	00050913          	mv	s2,a0
    80005b74:	00100593          	li	a1,1
    80005b78:	ffffc097          	auipc	ra,0xffffc
    80005b7c:	594080e7          	jalr	1428(ra) # 8000210c <_ZN9SemaphoreC1Ej>
    80005b80:	0324b823          	sd	s2,48(s1)
}
    80005b84:	02813083          	ld	ra,40(sp)
    80005b88:	02013403          	ld	s0,32(sp)
    80005b8c:	01813483          	ld	s1,24(sp)
    80005b90:	01013903          	ld	s2,16(sp)
    80005b94:	00813983          	ld	s3,8(sp)
    80005b98:	03010113          	addi	sp,sp,48
    80005b9c:	00008067          	ret
    80005ba0:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80005ba4:	00098513          	mv	a0,s3
    80005ba8:	ffffc097          	auipc	ra,0xffffc
    80005bac:	36c080e7          	jalr	876(ra) # 80001f14 <_ZdlPv>
    80005bb0:	00048513          	mv	a0,s1
    80005bb4:	00007097          	auipc	ra,0x7
    80005bb8:	514080e7          	jalr	1300(ra) # 8000d0c8 <_Unwind_Resume>
    80005bbc:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80005bc0:	00098513          	mv	a0,s3
    80005bc4:	ffffc097          	auipc	ra,0xffffc
    80005bc8:	350080e7          	jalr	848(ra) # 80001f14 <_ZdlPv>
    80005bcc:	00048513          	mv	a0,s1
    80005bd0:	00007097          	auipc	ra,0x7
    80005bd4:	4f8080e7          	jalr	1272(ra) # 8000d0c8 <_Unwind_Resume>
    80005bd8:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80005bdc:	00090513          	mv	a0,s2
    80005be0:	ffffc097          	auipc	ra,0xffffc
    80005be4:	334080e7          	jalr	820(ra) # 80001f14 <_ZdlPv>
    80005be8:	00048513          	mv	a0,s1
    80005bec:	00007097          	auipc	ra,0x7
    80005bf0:	4dc080e7          	jalr	1244(ra) # 8000d0c8 <_Unwind_Resume>
    80005bf4:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80005bf8:	00090513          	mv	a0,s2
    80005bfc:	ffffc097          	auipc	ra,0xffffc
    80005c00:	318080e7          	jalr	792(ra) # 80001f14 <_ZdlPv>
    80005c04:	00048513          	mv	a0,s1
    80005c08:	00007097          	auipc	ra,0x7
    80005c0c:	4c0080e7          	jalr	1216(ra) # 8000d0c8 <_Unwind_Resume>

0000000080005c10 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80005c10:	fe010113          	addi	sp,sp,-32
    80005c14:	00113c23          	sd	ra,24(sp)
    80005c18:	00813823          	sd	s0,16(sp)
    80005c1c:	00913423          	sd	s1,8(sp)
    80005c20:	01213023          	sd	s2,0(sp)
    80005c24:	02010413          	addi	s0,sp,32
    80005c28:	00050493          	mv	s1,a0
    80005c2c:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80005c30:	01853503          	ld	a0,24(a0)
    80005c34:	ffffc097          	auipc	ra,0xffffc
    80005c38:	514080e7          	jalr	1300(ra) # 80002148 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80005c3c:	0304b503          	ld	a0,48(s1)
    80005c40:	ffffc097          	auipc	ra,0xffffc
    80005c44:	508080e7          	jalr	1288(ra) # 80002148 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80005c48:	0084b783          	ld	a5,8(s1)
    80005c4c:	0144a703          	lw	a4,20(s1)
    80005c50:	00271713          	slli	a4,a4,0x2
    80005c54:	00e787b3          	add	a5,a5,a4
    80005c58:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80005c5c:	0144a783          	lw	a5,20(s1)
    80005c60:	0017879b          	addiw	a5,a5,1
    80005c64:	0004a703          	lw	a4,0(s1)
    80005c68:	02e7e7bb          	remw	a5,a5,a4
    80005c6c:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80005c70:	0304b503          	ld	a0,48(s1)
    80005c74:	ffffc097          	auipc	ra,0xffffc
    80005c78:	500080e7          	jalr	1280(ra) # 80002174 <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80005c7c:	0204b503          	ld	a0,32(s1)
    80005c80:	ffffc097          	auipc	ra,0xffffc
    80005c84:	4f4080e7          	jalr	1268(ra) # 80002174 <_ZN9Semaphore6signalEv>

}
    80005c88:	01813083          	ld	ra,24(sp)
    80005c8c:	01013403          	ld	s0,16(sp)
    80005c90:	00813483          	ld	s1,8(sp)
    80005c94:	00013903          	ld	s2,0(sp)
    80005c98:	02010113          	addi	sp,sp,32
    80005c9c:	00008067          	ret

0000000080005ca0 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80005ca0:	fe010113          	addi	sp,sp,-32
    80005ca4:	00113c23          	sd	ra,24(sp)
    80005ca8:	00813823          	sd	s0,16(sp)
    80005cac:	00913423          	sd	s1,8(sp)
    80005cb0:	01213023          	sd	s2,0(sp)
    80005cb4:	02010413          	addi	s0,sp,32
    80005cb8:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80005cbc:	02053503          	ld	a0,32(a0)
    80005cc0:	ffffc097          	auipc	ra,0xffffc
    80005cc4:	488080e7          	jalr	1160(ra) # 80002148 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80005cc8:	0284b503          	ld	a0,40(s1)
    80005ccc:	ffffc097          	auipc	ra,0xffffc
    80005cd0:	47c080e7          	jalr	1148(ra) # 80002148 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80005cd4:	0084b703          	ld	a4,8(s1)
    80005cd8:	0104a783          	lw	a5,16(s1)
    80005cdc:	00279693          	slli	a3,a5,0x2
    80005ce0:	00d70733          	add	a4,a4,a3
    80005ce4:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005ce8:	0017879b          	addiw	a5,a5,1
    80005cec:	0004a703          	lw	a4,0(s1)
    80005cf0:	02e7e7bb          	remw	a5,a5,a4
    80005cf4:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80005cf8:	0284b503          	ld	a0,40(s1)
    80005cfc:	ffffc097          	auipc	ra,0xffffc
    80005d00:	478080e7          	jalr	1144(ra) # 80002174 <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80005d04:	0184b503          	ld	a0,24(s1)
    80005d08:	ffffc097          	auipc	ra,0xffffc
    80005d0c:	46c080e7          	jalr	1132(ra) # 80002174 <_ZN9Semaphore6signalEv>

    return ret;
}
    80005d10:	00090513          	mv	a0,s2
    80005d14:	01813083          	ld	ra,24(sp)
    80005d18:	01013403          	ld	s0,16(sp)
    80005d1c:	00813483          	ld	s1,8(sp)
    80005d20:	00013903          	ld	s2,0(sp)
    80005d24:	02010113          	addi	sp,sp,32
    80005d28:	00008067          	ret

0000000080005d2c <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80005d2c:	fe010113          	addi	sp,sp,-32
    80005d30:	00113c23          	sd	ra,24(sp)
    80005d34:	00813823          	sd	s0,16(sp)
    80005d38:	00913423          	sd	s1,8(sp)
    80005d3c:	01213023          	sd	s2,0(sp)
    80005d40:	02010413          	addi	s0,sp,32
    80005d44:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80005d48:	02853503          	ld	a0,40(a0)
    80005d4c:	ffffc097          	auipc	ra,0xffffc
    80005d50:	3fc080e7          	jalr	1020(ra) # 80002148 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80005d54:	0304b503          	ld	a0,48(s1)
    80005d58:	ffffc097          	auipc	ra,0xffffc
    80005d5c:	3f0080e7          	jalr	1008(ra) # 80002148 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80005d60:	0144a783          	lw	a5,20(s1)
    80005d64:	0104a903          	lw	s2,16(s1)
    80005d68:	0327ce63          	blt	a5,s2,80005da4 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80005d6c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80005d70:	0304b503          	ld	a0,48(s1)
    80005d74:	ffffc097          	auipc	ra,0xffffc
    80005d78:	400080e7          	jalr	1024(ra) # 80002174 <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80005d7c:	0284b503          	ld	a0,40(s1)
    80005d80:	ffffc097          	auipc	ra,0xffffc
    80005d84:	3f4080e7          	jalr	1012(ra) # 80002174 <_ZN9Semaphore6signalEv>

    return ret;
}
    80005d88:	00090513          	mv	a0,s2
    80005d8c:	01813083          	ld	ra,24(sp)
    80005d90:	01013403          	ld	s0,16(sp)
    80005d94:	00813483          	ld	s1,8(sp)
    80005d98:	00013903          	ld	s2,0(sp)
    80005d9c:	02010113          	addi	sp,sp,32
    80005da0:	00008067          	ret
        ret = cap - head + tail;
    80005da4:	0004a703          	lw	a4,0(s1)
    80005da8:	4127093b          	subw	s2,a4,s2
    80005dac:	00f9093b          	addw	s2,s2,a5
    80005db0:	fc1ff06f          	j	80005d70 <_ZN9BufferCPP6getCntEv+0x44>

0000000080005db4 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80005db4:	fe010113          	addi	sp,sp,-32
    80005db8:	00113c23          	sd	ra,24(sp)
    80005dbc:	00813823          	sd	s0,16(sp)
    80005dc0:	00913423          	sd	s1,8(sp)
    80005dc4:	02010413          	addi	s0,sp,32
    80005dc8:	00050493          	mv	s1,a0
    Console::putc('\n');
    80005dcc:	00a00513          	li	a0,10
    80005dd0:	ffffc097          	auipc	ra,0xffffc
    80005dd4:	454080e7          	jalr	1108(ra) # 80002224 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80005dd8:	00003517          	auipc	a0,0x3
    80005ddc:	53850513          	addi	a0,a0,1336 # 80009310 <CONSOLE_STATUS+0x300>
    80005de0:	00000097          	auipc	ra,0x0
    80005de4:	a0c080e7          	jalr	-1524(ra) # 800057ec <_Z11printStringPKc>
    while (getCnt()) {
    80005de8:	00048513          	mv	a0,s1
    80005dec:	00000097          	auipc	ra,0x0
    80005df0:	f40080e7          	jalr	-192(ra) # 80005d2c <_ZN9BufferCPP6getCntEv>
    80005df4:	02050c63          	beqz	a0,80005e2c <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80005df8:	0084b783          	ld	a5,8(s1)
    80005dfc:	0104a703          	lw	a4,16(s1)
    80005e00:	00271713          	slli	a4,a4,0x2
    80005e04:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80005e08:	0007c503          	lbu	a0,0(a5)
    80005e0c:	ffffc097          	auipc	ra,0xffffc
    80005e10:	418080e7          	jalr	1048(ra) # 80002224 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80005e14:	0104a783          	lw	a5,16(s1)
    80005e18:	0017879b          	addiw	a5,a5,1
    80005e1c:	0004a703          	lw	a4,0(s1)
    80005e20:	02e7e7bb          	remw	a5,a5,a4
    80005e24:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80005e28:	fc1ff06f          	j	80005de8 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80005e2c:	02100513          	li	a0,33
    80005e30:	ffffc097          	auipc	ra,0xffffc
    80005e34:	3f4080e7          	jalr	1012(ra) # 80002224 <_ZN7Console4putcEc>
    Console::putc('\n');
    80005e38:	00a00513          	li	a0,10
    80005e3c:	ffffc097          	auipc	ra,0xffffc
    80005e40:	3e8080e7          	jalr	1000(ra) # 80002224 <_ZN7Console4putcEc>
    mem_free(buffer);
    80005e44:	0084b503          	ld	a0,8(s1)
    80005e48:	ffffb097          	auipc	ra,0xffffb
    80005e4c:	438080e7          	jalr	1080(ra) # 80001280 <_Z8mem_freePv>
    delete itemAvailable;
    80005e50:	0204b503          	ld	a0,32(s1)
    80005e54:	00050863          	beqz	a0,80005e64 <_ZN9BufferCPPD1Ev+0xb0>
    80005e58:	00053783          	ld	a5,0(a0)
    80005e5c:	0087b783          	ld	a5,8(a5)
    80005e60:	000780e7          	jalr	a5
    delete spaceAvailable;
    80005e64:	0184b503          	ld	a0,24(s1)
    80005e68:	00050863          	beqz	a0,80005e78 <_ZN9BufferCPPD1Ev+0xc4>
    80005e6c:	00053783          	ld	a5,0(a0)
    80005e70:	0087b783          	ld	a5,8(a5)
    80005e74:	000780e7          	jalr	a5
    delete mutexTail;
    80005e78:	0304b503          	ld	a0,48(s1)
    80005e7c:	00050863          	beqz	a0,80005e8c <_ZN9BufferCPPD1Ev+0xd8>
    80005e80:	00053783          	ld	a5,0(a0)
    80005e84:	0087b783          	ld	a5,8(a5)
    80005e88:	000780e7          	jalr	a5
    delete mutexHead;
    80005e8c:	0284b503          	ld	a0,40(s1)
    80005e90:	00050863          	beqz	a0,80005ea0 <_ZN9BufferCPPD1Ev+0xec>
    80005e94:	00053783          	ld	a5,0(a0)
    80005e98:	0087b783          	ld	a5,8(a5)
    80005e9c:	000780e7          	jalr	a5
}
    80005ea0:	01813083          	ld	ra,24(sp)
    80005ea4:	01013403          	ld	s0,16(sp)
    80005ea8:	00813483          	ld	s1,8(sp)
    80005eac:	02010113          	addi	sp,sp,32
    80005eb0:	00008067          	ret

0000000080005eb4 <userMain>:

#endif

extern "C" void userMain();

void userMain() {
    80005eb4:	fe010113          	addi	sp,sp,-32
    80005eb8:	00113c23          	sd	ra,24(sp)
    80005ebc:	00813823          	sd	s0,16(sp)
    80005ec0:	00913423          	sd	s1,8(sp)
    80005ec4:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80005ec8:	00003517          	auipc	a0,0x3
    80005ecc:	46050513          	addi	a0,a0,1120 # 80009328 <CONSOLE_STATUS+0x318>
    80005ed0:	00000097          	auipc	ra,0x0
    80005ed4:	91c080e7          	jalr	-1764(ra) # 800057ec <_Z11printStringPKc>
    int test = getc() - '0';
    80005ed8:	ffffb097          	auipc	ra,0xffffb
    80005edc:	71c080e7          	jalr	1820(ra) # 800015f4 <_Z4getcv>
    80005ee0:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80005ee4:	ffffb097          	auipc	ra,0xffffb
    80005ee8:	710080e7          	jalr	1808(ra) # 800015f4 <_Z4getcv>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80005eec:	00700793          	li	a5,7
    80005ef0:	1097e263          	bltu	a5,s1,80005ff4 <userMain+0x140>
    80005ef4:	00249493          	slli	s1,s1,0x2
    80005ef8:	00003717          	auipc	a4,0x3
    80005efc:	68870713          	addi	a4,a4,1672 # 80009580 <CONSOLE_STATUS+0x570>
    80005f00:	00e484b3          	add	s1,s1,a4
    80005f04:	0004a783          	lw	a5,0(s1)
    80005f08:	00e787b3          	add	a5,a5,a4
    80005f0c:	00078067          	jr	a5
        case 1:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_C_API_test();
    80005f10:	fffff097          	auipc	ra,0xfffff
    80005f14:	f54080e7          	jalr	-172(ra) # 80004e64 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80005f18:	00003517          	auipc	a0,0x3
    80005f1c:	43050513          	addi	a0,a0,1072 # 80009348 <CONSOLE_STATUS+0x338>
    80005f20:	00000097          	auipc	ra,0x0
    80005f24:	8cc080e7          	jalr	-1844(ra) # 800057ec <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80005f28:	01813083          	ld	ra,24(sp)
    80005f2c:	01013403          	ld	s0,16(sp)
    80005f30:	00813483          	ld	s1,8(sp)
    80005f34:	02010113          	addi	sp,sp,32
    80005f38:	00008067          	ret
            Threads_CPP_API_test();
    80005f3c:	ffffe097          	auipc	ra,0xffffe
    80005f40:	e08080e7          	jalr	-504(ra) # 80003d44 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80005f44:	00003517          	auipc	a0,0x3
    80005f48:	44450513          	addi	a0,a0,1092 # 80009388 <CONSOLE_STATUS+0x378>
    80005f4c:	00000097          	auipc	ra,0x0
    80005f50:	8a0080e7          	jalr	-1888(ra) # 800057ec <_Z11printStringPKc>
            break;
    80005f54:	fd5ff06f          	j	80005f28 <userMain+0x74>
            producerConsumer_C_API();
    80005f58:	ffffd097          	auipc	ra,0xffffd
    80005f5c:	640080e7          	jalr	1600(ra) # 80003598 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80005f60:	00003517          	auipc	a0,0x3
    80005f64:	46850513          	addi	a0,a0,1128 # 800093c8 <CONSOLE_STATUS+0x3b8>
    80005f68:	00000097          	auipc	ra,0x0
    80005f6c:	884080e7          	jalr	-1916(ra) # 800057ec <_Z11printStringPKc>
            break;
    80005f70:	fb9ff06f          	j	80005f28 <userMain+0x74>
            producerConsumer_CPP_Sync_API();
    80005f74:	fffff097          	auipc	ra,0xfffff
    80005f78:	234080e7          	jalr	564(ra) # 800051a8 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80005f7c:	00003517          	auipc	a0,0x3
    80005f80:	49c50513          	addi	a0,a0,1180 # 80009418 <CONSOLE_STATUS+0x408>
    80005f84:	00000097          	auipc	ra,0x0
    80005f88:	868080e7          	jalr	-1944(ra) # 800057ec <_Z11printStringPKc>
            break;
    80005f8c:	f9dff06f          	j	80005f28 <userMain+0x74>
            testSleeping();
    80005f90:	00000097          	auipc	ra,0x0
    80005f94:	11c080e7          	jalr	284(ra) # 800060ac <_Z12testSleepingv>
            printString("TEST 5 (zadatak 4., thread_sleep test C API)\n");
    80005f98:	00003517          	auipc	a0,0x3
    80005f9c:	4d850513          	addi	a0,a0,1240 # 80009470 <CONSOLE_STATUS+0x460>
    80005fa0:	00000097          	auipc	ra,0x0
    80005fa4:	84c080e7          	jalr	-1972(ra) # 800057ec <_Z11printStringPKc>
            break;
    80005fa8:	f81ff06f          	j	80005f28 <userMain+0x74>
            testConsumerProducer();
    80005fac:	ffffe097          	auipc	ra,0xffffe
    80005fb0:	258080e7          	jalr	600(ra) # 80004204 <_Z20testConsumerProducerv>
            printString("TEST 6 (zadatak 4. CPP API i asinhrona promena konteksta)\n");
    80005fb4:	00003517          	auipc	a0,0x3
    80005fb8:	4ec50513          	addi	a0,a0,1260 # 800094a0 <CONSOLE_STATUS+0x490>
    80005fbc:	00000097          	auipc	ra,0x0
    80005fc0:	830080e7          	jalr	-2000(ra) # 800057ec <_Z11printStringPKc>
            break;
    80005fc4:	f65ff06f          	j	80005f28 <userMain+0x74>
            System_Mode_test();
    80005fc8:	00000097          	auipc	ra,0x0
    80005fcc:	658080e7          	jalr	1624(ra) # 80006620 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80005fd0:	00003517          	auipc	a0,0x3
    80005fd4:	51050513          	addi	a0,a0,1296 # 800094e0 <CONSOLE_STATUS+0x4d0>
    80005fd8:	00000097          	auipc	ra,0x0
    80005fdc:	814080e7          	jalr	-2028(ra) # 800057ec <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80005fe0:	00003517          	auipc	a0,0x3
    80005fe4:	52050513          	addi	a0,a0,1312 # 80009500 <CONSOLE_STATUS+0x4f0>
    80005fe8:	00000097          	auipc	ra,0x0
    80005fec:	804080e7          	jalr	-2044(ra) # 800057ec <_Z11printStringPKc>
            break;
    80005ff0:	f39ff06f          	j	80005f28 <userMain+0x74>
            printString("Niste uneli odgovarajuci broj za test\n");
    80005ff4:	00003517          	auipc	a0,0x3
    80005ff8:	56450513          	addi	a0,a0,1380 # 80009558 <CONSOLE_STATUS+0x548>
    80005ffc:	fffff097          	auipc	ra,0xfffff
    80006000:	7f0080e7          	jalr	2032(ra) # 800057ec <_Z11printStringPKc>
    80006004:	f25ff06f          	j	80005f28 <userMain+0x74>

0000000080006008 <_ZL9sleepyRunPv>:

#include "printing.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    80006008:	fe010113          	addi	sp,sp,-32
    8000600c:	00113c23          	sd	ra,24(sp)
    80006010:	00813823          	sd	s0,16(sp)
    80006014:	00913423          	sd	s1,8(sp)
    80006018:	01213023          	sd	s2,0(sp)
    8000601c:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    80006020:	00053903          	ld	s2,0(a0)
    int i = 6;
    80006024:	00600493          	li	s1,6
    while (--i > 0) {
    80006028:	fff4849b          	addiw	s1,s1,-1
    8000602c:	04905463          	blez	s1,80006074 <_ZL9sleepyRunPv+0x6c>

        printString("Hello ");
    80006030:	00003517          	auipc	a0,0x3
    80006034:	57050513          	addi	a0,a0,1392 # 800095a0 <CONSOLE_STATUS+0x590>
    80006038:	fffff097          	auipc	ra,0xfffff
    8000603c:	7b4080e7          	jalr	1972(ra) # 800057ec <_Z11printStringPKc>
        printInt(sleep_time);
    80006040:	00000613          	li	a2,0
    80006044:	00a00593          	li	a1,10
    80006048:	0009051b          	sext.w	a0,s2
    8000604c:	00000097          	auipc	ra,0x0
    80006050:	950080e7          	jalr	-1712(ra) # 8000599c <_Z8printIntiii>
        printString(" !\n");
    80006054:	00003517          	auipc	a0,0x3
    80006058:	55450513          	addi	a0,a0,1364 # 800095a8 <CONSOLE_STATUS+0x598>
    8000605c:	fffff097          	auipc	ra,0xfffff
    80006060:	790080e7          	jalr	1936(ra) # 800057ec <_Z11printStringPKc>
        time_sleep(sleep_time);
    80006064:	00090513          	mv	a0,s2
    80006068:	ffffb097          	auipc	ra,0xffffb
    8000606c:	570080e7          	jalr	1392(ra) # 800015d8 <_Z10time_sleepm>
    while (--i > 0) {
    80006070:	fb9ff06f          	j	80006028 <_ZL9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80006074:	00a00793          	li	a5,10
    80006078:	02f95933          	divu	s2,s2,a5
    8000607c:	fff90913          	addi	s2,s2,-1
    80006080:	00006797          	auipc	a5,0x6
    80006084:	f7078793          	addi	a5,a5,-144 # 8000bff0 <_ZL8finished>
    80006088:	01278933          	add	s2,a5,s2
    8000608c:	00100793          	li	a5,1
    80006090:	00f90023          	sb	a5,0(s2)
}
    80006094:	01813083          	ld	ra,24(sp)
    80006098:	01013403          	ld	s0,16(sp)
    8000609c:	00813483          	ld	s1,8(sp)
    800060a0:	00013903          	ld	s2,0(sp)
    800060a4:	02010113          	addi	sp,sp,32
    800060a8:	00008067          	ret

00000000800060ac <_Z12testSleepingv>:

void testSleeping() {
    800060ac:	fc010113          	addi	sp,sp,-64
    800060b0:	02113c23          	sd	ra,56(sp)
    800060b4:	02813823          	sd	s0,48(sp)
    800060b8:	02913423          	sd	s1,40(sp)
    800060bc:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    800060c0:	00a00793          	li	a5,10
    800060c4:	fcf43823          	sd	a5,-48(s0)
    800060c8:	01400793          	li	a5,20
    800060cc:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    800060d0:	00000493          	li	s1,0
    800060d4:	02c0006f          	j	80006100 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    800060d8:	00349793          	slli	a5,s1,0x3
    800060dc:	fd040613          	addi	a2,s0,-48
    800060e0:	00f60633          	add	a2,a2,a5
    800060e4:	00000597          	auipc	a1,0x0
    800060e8:	f2458593          	addi	a1,a1,-220 # 80006008 <_ZL9sleepyRunPv>
    800060ec:	fc040513          	addi	a0,s0,-64
    800060f0:	00f50533          	add	a0,a0,a5
    800060f4:	ffffb097          	auipc	ra,0xffffb
    800060f8:	1e4080e7          	jalr	484(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    800060fc:	0014849b          	addiw	s1,s1,1
    80006100:	00100793          	li	a5,1
    80006104:	fc97dae3          	bge	a5,s1,800060d8 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    80006108:	00006797          	auipc	a5,0x6
    8000610c:	ee87c783          	lbu	a5,-280(a5) # 8000bff0 <_ZL8finished>
    80006110:	fe078ce3          	beqz	a5,80006108 <_Z12testSleepingv+0x5c>
    80006114:	00006797          	auipc	a5,0x6
    80006118:	edd7c783          	lbu	a5,-291(a5) # 8000bff1 <_ZL8finished+0x1>
    8000611c:	fe0786e3          	beqz	a5,80006108 <_Z12testSleepingv+0x5c>
}
    80006120:	03813083          	ld	ra,56(sp)
    80006124:	03013403          	ld	s0,48(sp)
    80006128:	02813483          	ld	s1,40(sp)
    8000612c:	04010113          	addi	sp,sp,64
    80006130:	00008067          	ret

0000000080006134 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80006134:	fe010113          	addi	sp,sp,-32
    80006138:	00113c23          	sd	ra,24(sp)
    8000613c:	00813823          	sd	s0,16(sp)
    80006140:	00913423          	sd	s1,8(sp)
    80006144:	01213023          	sd	s2,0(sp)
    80006148:	02010413          	addi	s0,sp,32
    8000614c:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80006150:	00100793          	li	a5,1
    80006154:	02a7f863          	bgeu	a5,a0,80006184 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80006158:	00a00793          	li	a5,10
    8000615c:	02f577b3          	remu	a5,a0,a5
    80006160:	02078e63          	beqz	a5,8000619c <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80006164:	fff48513          	addi	a0,s1,-1
    80006168:	00000097          	auipc	ra,0x0
    8000616c:	fcc080e7          	jalr	-52(ra) # 80006134 <_ZL9fibonaccim>
    80006170:	00050913          	mv	s2,a0
    80006174:	ffe48513          	addi	a0,s1,-2
    80006178:	00000097          	auipc	ra,0x0
    8000617c:	fbc080e7          	jalr	-68(ra) # 80006134 <_ZL9fibonaccim>
    80006180:	00a90533          	add	a0,s2,a0
}
    80006184:	01813083          	ld	ra,24(sp)
    80006188:	01013403          	ld	s0,16(sp)
    8000618c:	00813483          	ld	s1,8(sp)
    80006190:	00013903          	ld	s2,0(sp)
    80006194:	02010113          	addi	sp,sp,32
    80006198:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000619c:	ffffb097          	auipc	ra,0xffffb
    800061a0:	21c080e7          	jalr	540(ra) # 800013b8 <_Z15thread_dispatchv>
    800061a4:	fc1ff06f          	j	80006164 <_ZL9fibonaccim+0x30>

00000000800061a8 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    800061a8:	fe010113          	addi	sp,sp,-32
    800061ac:	00113c23          	sd	ra,24(sp)
    800061b0:	00813823          	sd	s0,16(sp)
    800061b4:	00913423          	sd	s1,8(sp)
    800061b8:	01213023          	sd	s2,0(sp)
    800061bc:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800061c0:	00a00493          	li	s1,10
    800061c4:	0400006f          	j	80006204 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800061c8:	00003517          	auipc	a0,0x3
    800061cc:	0b050513          	addi	a0,a0,176 # 80009278 <CONSOLE_STATUS+0x268>
    800061d0:	fffff097          	auipc	ra,0xfffff
    800061d4:	61c080e7          	jalr	1564(ra) # 800057ec <_Z11printStringPKc>
    800061d8:	00000613          	li	a2,0
    800061dc:	00a00593          	li	a1,10
    800061e0:	00048513          	mv	a0,s1
    800061e4:	fffff097          	auipc	ra,0xfffff
    800061e8:	7b8080e7          	jalr	1976(ra) # 8000599c <_Z8printIntiii>
    800061ec:	00003517          	auipc	a0,0x3
    800061f0:	27c50513          	addi	a0,a0,636 # 80009468 <CONSOLE_STATUS+0x458>
    800061f4:	fffff097          	auipc	ra,0xfffff
    800061f8:	5f8080e7          	jalr	1528(ra) # 800057ec <_Z11printStringPKc>
    for (; i < 13; i++) {
    800061fc:	0014849b          	addiw	s1,s1,1
    80006200:	0ff4f493          	andi	s1,s1,255
    80006204:	00c00793          	li	a5,12
    80006208:	fc97f0e3          	bgeu	a5,s1,800061c8 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    8000620c:	00003517          	auipc	a0,0x3
    80006210:	07450513          	addi	a0,a0,116 # 80009280 <CONSOLE_STATUS+0x270>
    80006214:	fffff097          	auipc	ra,0xfffff
    80006218:	5d8080e7          	jalr	1496(ra) # 800057ec <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000621c:	00500313          	li	t1,5
    thread_dispatch();
    80006220:	ffffb097          	auipc	ra,0xffffb
    80006224:	198080e7          	jalr	408(ra) # 800013b8 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80006228:	01000513          	li	a0,16
    8000622c:	00000097          	auipc	ra,0x0
    80006230:	f08080e7          	jalr	-248(ra) # 80006134 <_ZL9fibonaccim>
    80006234:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80006238:	00003517          	auipc	a0,0x3
    8000623c:	05850513          	addi	a0,a0,88 # 80009290 <CONSOLE_STATUS+0x280>
    80006240:	fffff097          	auipc	ra,0xfffff
    80006244:	5ac080e7          	jalr	1452(ra) # 800057ec <_Z11printStringPKc>
    80006248:	00000613          	li	a2,0
    8000624c:	00a00593          	li	a1,10
    80006250:	0009051b          	sext.w	a0,s2
    80006254:	fffff097          	auipc	ra,0xfffff
    80006258:	748080e7          	jalr	1864(ra) # 8000599c <_Z8printIntiii>
    8000625c:	00003517          	auipc	a0,0x3
    80006260:	20c50513          	addi	a0,a0,524 # 80009468 <CONSOLE_STATUS+0x458>
    80006264:	fffff097          	auipc	ra,0xfffff
    80006268:	588080e7          	jalr	1416(ra) # 800057ec <_Z11printStringPKc>
    8000626c:	0400006f          	j	800062ac <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80006270:	00003517          	auipc	a0,0x3
    80006274:	00850513          	addi	a0,a0,8 # 80009278 <CONSOLE_STATUS+0x268>
    80006278:	fffff097          	auipc	ra,0xfffff
    8000627c:	574080e7          	jalr	1396(ra) # 800057ec <_Z11printStringPKc>
    80006280:	00000613          	li	a2,0
    80006284:	00a00593          	li	a1,10
    80006288:	00048513          	mv	a0,s1
    8000628c:	fffff097          	auipc	ra,0xfffff
    80006290:	710080e7          	jalr	1808(ra) # 8000599c <_Z8printIntiii>
    80006294:	00003517          	auipc	a0,0x3
    80006298:	1d450513          	addi	a0,a0,468 # 80009468 <CONSOLE_STATUS+0x458>
    8000629c:	fffff097          	auipc	ra,0xfffff
    800062a0:	550080e7          	jalr	1360(ra) # 800057ec <_Z11printStringPKc>
    for (; i < 16; i++) {
    800062a4:	0014849b          	addiw	s1,s1,1
    800062a8:	0ff4f493          	andi	s1,s1,255
    800062ac:	00f00793          	li	a5,15
    800062b0:	fc97f0e3          	bgeu	a5,s1,80006270 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800062b4:	00003517          	auipc	a0,0x3
    800062b8:	fec50513          	addi	a0,a0,-20 # 800092a0 <CONSOLE_STATUS+0x290>
    800062bc:	fffff097          	auipc	ra,0xfffff
    800062c0:	530080e7          	jalr	1328(ra) # 800057ec <_Z11printStringPKc>
    finishedD = true;
    800062c4:	00100793          	li	a5,1
    800062c8:	00006717          	auipc	a4,0x6
    800062cc:	d2f70523          	sb	a5,-726(a4) # 8000bff2 <_ZL9finishedD>
    thread_dispatch();
    800062d0:	ffffb097          	auipc	ra,0xffffb
    800062d4:	0e8080e7          	jalr	232(ra) # 800013b8 <_Z15thread_dispatchv>
}
    800062d8:	01813083          	ld	ra,24(sp)
    800062dc:	01013403          	ld	s0,16(sp)
    800062e0:	00813483          	ld	s1,8(sp)
    800062e4:	00013903          	ld	s2,0(sp)
    800062e8:	02010113          	addi	sp,sp,32
    800062ec:	00008067          	ret

00000000800062f0 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    800062f0:	fe010113          	addi	sp,sp,-32
    800062f4:	00113c23          	sd	ra,24(sp)
    800062f8:	00813823          	sd	s0,16(sp)
    800062fc:	00913423          	sd	s1,8(sp)
    80006300:	01213023          	sd	s2,0(sp)
    80006304:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80006308:	00000493          	li	s1,0
    8000630c:	0400006f          	j	8000634c <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80006310:	00003517          	auipc	a0,0x3
    80006314:	f3850513          	addi	a0,a0,-200 # 80009248 <CONSOLE_STATUS+0x238>
    80006318:	fffff097          	auipc	ra,0xfffff
    8000631c:	4d4080e7          	jalr	1236(ra) # 800057ec <_Z11printStringPKc>
    80006320:	00000613          	li	a2,0
    80006324:	00a00593          	li	a1,10
    80006328:	00048513          	mv	a0,s1
    8000632c:	fffff097          	auipc	ra,0xfffff
    80006330:	670080e7          	jalr	1648(ra) # 8000599c <_Z8printIntiii>
    80006334:	00003517          	auipc	a0,0x3
    80006338:	13450513          	addi	a0,a0,308 # 80009468 <CONSOLE_STATUS+0x458>
    8000633c:	fffff097          	auipc	ra,0xfffff
    80006340:	4b0080e7          	jalr	1200(ra) # 800057ec <_Z11printStringPKc>
    for (; i < 3; i++) {
    80006344:	0014849b          	addiw	s1,s1,1
    80006348:	0ff4f493          	andi	s1,s1,255
    8000634c:	00200793          	li	a5,2
    80006350:	fc97f0e3          	bgeu	a5,s1,80006310 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80006354:	00003517          	auipc	a0,0x3
    80006358:	efc50513          	addi	a0,a0,-260 # 80009250 <CONSOLE_STATUS+0x240>
    8000635c:	fffff097          	auipc	ra,0xfffff
    80006360:	490080e7          	jalr	1168(ra) # 800057ec <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80006364:	00700313          	li	t1,7
    thread_dispatch();
    80006368:	ffffb097          	auipc	ra,0xffffb
    8000636c:	050080e7          	jalr	80(ra) # 800013b8 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80006370:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80006374:	00003517          	auipc	a0,0x3
    80006378:	eec50513          	addi	a0,a0,-276 # 80009260 <CONSOLE_STATUS+0x250>
    8000637c:	fffff097          	auipc	ra,0xfffff
    80006380:	470080e7          	jalr	1136(ra) # 800057ec <_Z11printStringPKc>
    80006384:	00000613          	li	a2,0
    80006388:	00a00593          	li	a1,10
    8000638c:	0009051b          	sext.w	a0,s2
    80006390:	fffff097          	auipc	ra,0xfffff
    80006394:	60c080e7          	jalr	1548(ra) # 8000599c <_Z8printIntiii>
    80006398:	00003517          	auipc	a0,0x3
    8000639c:	0d050513          	addi	a0,a0,208 # 80009468 <CONSOLE_STATUS+0x458>
    800063a0:	fffff097          	auipc	ra,0xfffff
    800063a4:	44c080e7          	jalr	1100(ra) # 800057ec <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800063a8:	00c00513          	li	a0,12
    800063ac:	00000097          	auipc	ra,0x0
    800063b0:	d88080e7          	jalr	-632(ra) # 80006134 <_ZL9fibonaccim>
    800063b4:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800063b8:	00003517          	auipc	a0,0x3
    800063bc:	eb050513          	addi	a0,a0,-336 # 80009268 <CONSOLE_STATUS+0x258>
    800063c0:	fffff097          	auipc	ra,0xfffff
    800063c4:	42c080e7          	jalr	1068(ra) # 800057ec <_Z11printStringPKc>
    800063c8:	00000613          	li	a2,0
    800063cc:	00a00593          	li	a1,10
    800063d0:	0009051b          	sext.w	a0,s2
    800063d4:	fffff097          	auipc	ra,0xfffff
    800063d8:	5c8080e7          	jalr	1480(ra) # 8000599c <_Z8printIntiii>
    800063dc:	00003517          	auipc	a0,0x3
    800063e0:	08c50513          	addi	a0,a0,140 # 80009468 <CONSOLE_STATUS+0x458>
    800063e4:	fffff097          	auipc	ra,0xfffff
    800063e8:	408080e7          	jalr	1032(ra) # 800057ec <_Z11printStringPKc>
    800063ec:	0400006f          	j	8000642c <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    800063f0:	00003517          	auipc	a0,0x3
    800063f4:	e5850513          	addi	a0,a0,-424 # 80009248 <CONSOLE_STATUS+0x238>
    800063f8:	fffff097          	auipc	ra,0xfffff
    800063fc:	3f4080e7          	jalr	1012(ra) # 800057ec <_Z11printStringPKc>
    80006400:	00000613          	li	a2,0
    80006404:	00a00593          	li	a1,10
    80006408:	00048513          	mv	a0,s1
    8000640c:	fffff097          	auipc	ra,0xfffff
    80006410:	590080e7          	jalr	1424(ra) # 8000599c <_Z8printIntiii>
    80006414:	00003517          	auipc	a0,0x3
    80006418:	05450513          	addi	a0,a0,84 # 80009468 <CONSOLE_STATUS+0x458>
    8000641c:	fffff097          	auipc	ra,0xfffff
    80006420:	3d0080e7          	jalr	976(ra) # 800057ec <_Z11printStringPKc>
    for (; i < 6; i++) {
    80006424:	0014849b          	addiw	s1,s1,1
    80006428:	0ff4f493          	andi	s1,s1,255
    8000642c:	00500793          	li	a5,5
    80006430:	fc97f0e3          	bgeu	a5,s1,800063f0 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80006434:	00003517          	auipc	a0,0x3
    80006438:	dec50513          	addi	a0,a0,-532 # 80009220 <CONSOLE_STATUS+0x210>
    8000643c:	fffff097          	auipc	ra,0xfffff
    80006440:	3b0080e7          	jalr	944(ra) # 800057ec <_Z11printStringPKc>
    finishedC = true;
    80006444:	00100793          	li	a5,1
    80006448:	00006717          	auipc	a4,0x6
    8000644c:	baf705a3          	sb	a5,-1109(a4) # 8000bff3 <_ZL9finishedC>
    thread_dispatch();
    80006450:	ffffb097          	auipc	ra,0xffffb
    80006454:	f68080e7          	jalr	-152(ra) # 800013b8 <_Z15thread_dispatchv>
}
    80006458:	01813083          	ld	ra,24(sp)
    8000645c:	01013403          	ld	s0,16(sp)
    80006460:	00813483          	ld	s1,8(sp)
    80006464:	00013903          	ld	s2,0(sp)
    80006468:	02010113          	addi	sp,sp,32
    8000646c:	00008067          	ret

0000000080006470 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80006470:	fe010113          	addi	sp,sp,-32
    80006474:	00113c23          	sd	ra,24(sp)
    80006478:	00813823          	sd	s0,16(sp)
    8000647c:	00913423          	sd	s1,8(sp)
    80006480:	01213023          	sd	s2,0(sp)
    80006484:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80006488:	00000913          	li	s2,0
    8000648c:	0400006f          	j	800064cc <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    80006490:	ffffb097          	auipc	ra,0xffffb
    80006494:	f28080e7          	jalr	-216(ra) # 800013b8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80006498:	00148493          	addi	s1,s1,1
    8000649c:	000027b7          	lui	a5,0x2
    800064a0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800064a4:	0097ee63          	bltu	a5,s1,800064c0 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800064a8:	00000713          	li	a4,0
    800064ac:	000077b7          	lui	a5,0x7
    800064b0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800064b4:	fce7eee3          	bltu	a5,a4,80006490 <_ZL11workerBodyBPv+0x20>
    800064b8:	00170713          	addi	a4,a4,1
    800064bc:	ff1ff06f          	j	800064ac <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    800064c0:	00a00793          	li	a5,10
    800064c4:	04f90663          	beq	s2,a5,80006510 <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    800064c8:	00190913          	addi	s2,s2,1
    800064cc:	00f00793          	li	a5,15
    800064d0:	0527e463          	bltu	a5,s2,80006518 <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    800064d4:	00003517          	auipc	a0,0x3
    800064d8:	d5c50513          	addi	a0,a0,-676 # 80009230 <CONSOLE_STATUS+0x220>
    800064dc:	fffff097          	auipc	ra,0xfffff
    800064e0:	310080e7          	jalr	784(ra) # 800057ec <_Z11printStringPKc>
    800064e4:	00000613          	li	a2,0
    800064e8:	00a00593          	li	a1,10
    800064ec:	0009051b          	sext.w	a0,s2
    800064f0:	fffff097          	auipc	ra,0xfffff
    800064f4:	4ac080e7          	jalr	1196(ra) # 8000599c <_Z8printIntiii>
    800064f8:	00003517          	auipc	a0,0x3
    800064fc:	f7050513          	addi	a0,a0,-144 # 80009468 <CONSOLE_STATUS+0x458>
    80006500:	fffff097          	auipc	ra,0xfffff
    80006504:	2ec080e7          	jalr	748(ra) # 800057ec <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80006508:	00000493          	li	s1,0
    8000650c:	f91ff06f          	j	8000649c <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    80006510:	14102ff3          	csrr	t6,sepc
    80006514:	fb5ff06f          	j	800064c8 <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    80006518:	00003517          	auipc	a0,0x3
    8000651c:	d2050513          	addi	a0,a0,-736 # 80009238 <CONSOLE_STATUS+0x228>
    80006520:	fffff097          	auipc	ra,0xfffff
    80006524:	2cc080e7          	jalr	716(ra) # 800057ec <_Z11printStringPKc>
    finishedB = true;
    80006528:	00100793          	li	a5,1
    8000652c:	00006717          	auipc	a4,0x6
    80006530:	acf70423          	sb	a5,-1336(a4) # 8000bff4 <_ZL9finishedB>
    thread_dispatch();
    80006534:	ffffb097          	auipc	ra,0xffffb
    80006538:	e84080e7          	jalr	-380(ra) # 800013b8 <_Z15thread_dispatchv>
}
    8000653c:	01813083          	ld	ra,24(sp)
    80006540:	01013403          	ld	s0,16(sp)
    80006544:	00813483          	ld	s1,8(sp)
    80006548:	00013903          	ld	s2,0(sp)
    8000654c:	02010113          	addi	sp,sp,32
    80006550:	00008067          	ret

0000000080006554 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80006554:	fe010113          	addi	sp,sp,-32
    80006558:	00113c23          	sd	ra,24(sp)
    8000655c:	00813823          	sd	s0,16(sp)
    80006560:	00913423          	sd	s1,8(sp)
    80006564:	01213023          	sd	s2,0(sp)
    80006568:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8000656c:	00000913          	li	s2,0
    80006570:	0380006f          	j	800065a8 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80006574:	ffffb097          	auipc	ra,0xffffb
    80006578:	e44080e7          	jalr	-444(ra) # 800013b8 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000657c:	00148493          	addi	s1,s1,1
    80006580:	000027b7          	lui	a5,0x2
    80006584:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80006588:	0097ee63          	bltu	a5,s1,800065a4 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000658c:	00000713          	li	a4,0
    80006590:	000077b7          	lui	a5,0x7
    80006594:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80006598:	fce7eee3          	bltu	a5,a4,80006574 <_ZL11workerBodyAPv+0x20>
    8000659c:	00170713          	addi	a4,a4,1
    800065a0:	ff1ff06f          	j	80006590 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800065a4:	00190913          	addi	s2,s2,1
    800065a8:	00900793          	li	a5,9
    800065ac:	0527e063          	bltu	a5,s2,800065ec <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800065b0:	00003517          	auipc	a0,0x3
    800065b4:	c6850513          	addi	a0,a0,-920 # 80009218 <CONSOLE_STATUS+0x208>
    800065b8:	fffff097          	auipc	ra,0xfffff
    800065bc:	234080e7          	jalr	564(ra) # 800057ec <_Z11printStringPKc>
    800065c0:	00000613          	li	a2,0
    800065c4:	00a00593          	li	a1,10
    800065c8:	0009051b          	sext.w	a0,s2
    800065cc:	fffff097          	auipc	ra,0xfffff
    800065d0:	3d0080e7          	jalr	976(ra) # 8000599c <_Z8printIntiii>
    800065d4:	00003517          	auipc	a0,0x3
    800065d8:	e9450513          	addi	a0,a0,-364 # 80009468 <CONSOLE_STATUS+0x458>
    800065dc:	fffff097          	auipc	ra,0xfffff
    800065e0:	210080e7          	jalr	528(ra) # 800057ec <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800065e4:	00000493          	li	s1,0
    800065e8:	f99ff06f          	j	80006580 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800065ec:	00003517          	auipc	a0,0x3
    800065f0:	c3450513          	addi	a0,a0,-972 # 80009220 <CONSOLE_STATUS+0x210>
    800065f4:	fffff097          	auipc	ra,0xfffff
    800065f8:	1f8080e7          	jalr	504(ra) # 800057ec <_Z11printStringPKc>
    finishedA = true;
    800065fc:	00100793          	li	a5,1
    80006600:	00006717          	auipc	a4,0x6
    80006604:	9ef70aa3          	sb	a5,-1547(a4) # 8000bff5 <_ZL9finishedA>
}
    80006608:	01813083          	ld	ra,24(sp)
    8000660c:	01013403          	ld	s0,16(sp)
    80006610:	00813483          	ld	s1,8(sp)
    80006614:	00013903          	ld	s2,0(sp)
    80006618:	02010113          	addi	sp,sp,32
    8000661c:	00008067          	ret

0000000080006620 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80006620:	fd010113          	addi	sp,sp,-48
    80006624:	02113423          	sd	ra,40(sp)
    80006628:	02813023          	sd	s0,32(sp)
    8000662c:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80006630:	00000613          	li	a2,0
    80006634:	00000597          	auipc	a1,0x0
    80006638:	f2058593          	addi	a1,a1,-224 # 80006554 <_ZL11workerBodyAPv>
    8000663c:	fd040513          	addi	a0,s0,-48
    80006640:	ffffb097          	auipc	ra,0xffffb
    80006644:	c98080e7          	jalr	-872(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80006648:	00003517          	auipc	a0,0x3
    8000664c:	c6850513          	addi	a0,a0,-920 # 800092b0 <CONSOLE_STATUS+0x2a0>
    80006650:	fffff097          	auipc	ra,0xfffff
    80006654:	19c080e7          	jalr	412(ra) # 800057ec <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80006658:	00000613          	li	a2,0
    8000665c:	00000597          	auipc	a1,0x0
    80006660:	e1458593          	addi	a1,a1,-492 # 80006470 <_ZL11workerBodyBPv>
    80006664:	fd840513          	addi	a0,s0,-40
    80006668:	ffffb097          	auipc	ra,0xffffb
    8000666c:	c70080e7          	jalr	-912(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    80006670:	00003517          	auipc	a0,0x3
    80006674:	c5850513          	addi	a0,a0,-936 # 800092c8 <CONSOLE_STATUS+0x2b8>
    80006678:	fffff097          	auipc	ra,0xfffff
    8000667c:	174080e7          	jalr	372(ra) # 800057ec <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80006680:	00000613          	li	a2,0
    80006684:	00000597          	auipc	a1,0x0
    80006688:	c6c58593          	addi	a1,a1,-916 # 800062f0 <_ZL11workerBodyCPv>
    8000668c:	fe040513          	addi	a0,s0,-32
    80006690:	ffffb097          	auipc	ra,0xffffb
    80006694:	c48080e7          	jalr	-952(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    80006698:	00003517          	auipc	a0,0x3
    8000669c:	c4850513          	addi	a0,a0,-952 # 800092e0 <CONSOLE_STATUS+0x2d0>
    800066a0:	fffff097          	auipc	ra,0xfffff
    800066a4:	14c080e7          	jalr	332(ra) # 800057ec <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800066a8:	00000613          	li	a2,0
    800066ac:	00000597          	auipc	a1,0x0
    800066b0:	afc58593          	addi	a1,a1,-1284 # 800061a8 <_ZL11workerBodyDPv>
    800066b4:	fe840513          	addi	a0,s0,-24
    800066b8:	ffffb097          	auipc	ra,0xffffb
    800066bc:	c20080e7          	jalr	-992(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    800066c0:	00003517          	auipc	a0,0x3
    800066c4:	c3850513          	addi	a0,a0,-968 # 800092f8 <CONSOLE_STATUS+0x2e8>
    800066c8:	fffff097          	auipc	ra,0xfffff
    800066cc:	124080e7          	jalr	292(ra) # 800057ec <_Z11printStringPKc>
    800066d0:	00c0006f          	j	800066dc <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800066d4:	ffffb097          	auipc	ra,0xffffb
    800066d8:	ce4080e7          	jalr	-796(ra) # 800013b8 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800066dc:	00006797          	auipc	a5,0x6
    800066e0:	9197c783          	lbu	a5,-1767(a5) # 8000bff5 <_ZL9finishedA>
    800066e4:	fe0788e3          	beqz	a5,800066d4 <_Z16System_Mode_testv+0xb4>
    800066e8:	00006797          	auipc	a5,0x6
    800066ec:	90c7c783          	lbu	a5,-1780(a5) # 8000bff4 <_ZL9finishedB>
    800066f0:	fe0782e3          	beqz	a5,800066d4 <_Z16System_Mode_testv+0xb4>
    800066f4:	00006797          	auipc	a5,0x6
    800066f8:	8ff7c783          	lbu	a5,-1793(a5) # 8000bff3 <_ZL9finishedC>
    800066fc:	fc078ce3          	beqz	a5,800066d4 <_Z16System_Mode_testv+0xb4>
    80006700:	00006797          	auipc	a5,0x6
    80006704:	8f27c783          	lbu	a5,-1806(a5) # 8000bff2 <_ZL9finishedD>
    80006708:	fc0786e3          	beqz	a5,800066d4 <_Z16System_Mode_testv+0xb4>
    }

}
    8000670c:	02813083          	ld	ra,40(sp)
    80006710:	02013403          	ld	s0,32(sp)
    80006714:	03010113          	addi	sp,sp,48
    80006718:	00008067          	ret

000000008000671c <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000671c:	fe010113          	addi	sp,sp,-32
    80006720:	00113c23          	sd	ra,24(sp)
    80006724:	00813823          	sd	s0,16(sp)
    80006728:	00913423          	sd	s1,8(sp)
    8000672c:	01213023          	sd	s2,0(sp)
    80006730:	02010413          	addi	s0,sp,32
    80006734:	00050493          	mv	s1,a0
    80006738:	00058913          	mv	s2,a1
    8000673c:	0015879b          	addiw	a5,a1,1
    80006740:	0007851b          	sext.w	a0,a5
    80006744:	00f4a023          	sw	a5,0(s1)
    80006748:	0004a823          	sw	zero,16(s1)
    8000674c:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80006750:	00251513          	slli	a0,a0,0x2
    80006754:	ffffb097          	auipc	ra,0xffffb
    80006758:	ac0080e7          	jalr	-1344(ra) # 80001214 <_Z9mem_allocm>
    8000675c:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80006760:	00000593          	li	a1,0
    80006764:	02048513          	addi	a0,s1,32
    80006768:	ffffb097          	auipc	ra,0xffffb
    8000676c:	c98080e7          	jalr	-872(ra) # 80001400 <_Z8sem_openPP3Semj>
    sem_open(&spaceAvailable, _cap);
    80006770:	00090593          	mv	a1,s2
    80006774:	01848513          	addi	a0,s1,24
    80006778:	ffffb097          	auipc	ra,0xffffb
    8000677c:	c88080e7          	jalr	-888(ra) # 80001400 <_Z8sem_openPP3Semj>
    sem_open(&mutexHead, 1);
    80006780:	00100593          	li	a1,1
    80006784:	02848513          	addi	a0,s1,40
    80006788:	ffffb097          	auipc	ra,0xffffb
    8000678c:	c78080e7          	jalr	-904(ra) # 80001400 <_Z8sem_openPP3Semj>
    sem_open(&mutexTail, 1);
    80006790:	00100593          	li	a1,1
    80006794:	03048513          	addi	a0,s1,48
    80006798:	ffffb097          	auipc	ra,0xffffb
    8000679c:	c68080e7          	jalr	-920(ra) # 80001400 <_Z8sem_openPP3Semj>
}
    800067a0:	01813083          	ld	ra,24(sp)
    800067a4:	01013403          	ld	s0,16(sp)
    800067a8:	00813483          	ld	s1,8(sp)
    800067ac:	00013903          	ld	s2,0(sp)
    800067b0:	02010113          	addi	sp,sp,32
    800067b4:	00008067          	ret

00000000800067b8 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    800067b8:	fe010113          	addi	sp,sp,-32
    800067bc:	00113c23          	sd	ra,24(sp)
    800067c0:	00813823          	sd	s0,16(sp)
    800067c4:	00913423          	sd	s1,8(sp)
    800067c8:	01213023          	sd	s2,0(sp)
    800067cc:	02010413          	addi	s0,sp,32
    800067d0:	00050493          	mv	s1,a0
    800067d4:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800067d8:	01853503          	ld	a0,24(a0)
    800067dc:	ffffb097          	auipc	ra,0xffffb
    800067e0:	cd8080e7          	jalr	-808(ra) # 800014b4 <_Z8sem_waitP3Sem>

    sem_wait(mutexTail);
    800067e4:	0304b503          	ld	a0,48(s1)
    800067e8:	ffffb097          	auipc	ra,0xffffb
    800067ec:	ccc080e7          	jalr	-820(ra) # 800014b4 <_Z8sem_waitP3Sem>
    buffer[tail] = val;
    800067f0:	0084b783          	ld	a5,8(s1)
    800067f4:	0144a703          	lw	a4,20(s1)
    800067f8:	00271713          	slli	a4,a4,0x2
    800067fc:	00e787b3          	add	a5,a5,a4
    80006800:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80006804:	0144a783          	lw	a5,20(s1)
    80006808:	0017879b          	addiw	a5,a5,1
    8000680c:	0004a703          	lw	a4,0(s1)
    80006810:	02e7e7bb          	remw	a5,a5,a4
    80006814:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80006818:	0304b503          	ld	a0,48(s1)
    8000681c:	ffffb097          	auipc	ra,0xffffb
    80006820:	cf0080e7          	jalr	-784(ra) # 8000150c <_Z10sem_signalP3Sem>

    sem_signal(itemAvailable);
    80006824:	0204b503          	ld	a0,32(s1)
    80006828:	ffffb097          	auipc	ra,0xffffb
    8000682c:	ce4080e7          	jalr	-796(ra) # 8000150c <_Z10sem_signalP3Sem>

}
    80006830:	01813083          	ld	ra,24(sp)
    80006834:	01013403          	ld	s0,16(sp)
    80006838:	00813483          	ld	s1,8(sp)
    8000683c:	00013903          	ld	s2,0(sp)
    80006840:	02010113          	addi	sp,sp,32
    80006844:	00008067          	ret

0000000080006848 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80006848:	fe010113          	addi	sp,sp,-32
    8000684c:	00113c23          	sd	ra,24(sp)
    80006850:	00813823          	sd	s0,16(sp)
    80006854:	00913423          	sd	s1,8(sp)
    80006858:	01213023          	sd	s2,0(sp)
    8000685c:	02010413          	addi	s0,sp,32
    80006860:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80006864:	02053503          	ld	a0,32(a0)
    80006868:	ffffb097          	auipc	ra,0xffffb
    8000686c:	c4c080e7          	jalr	-948(ra) # 800014b4 <_Z8sem_waitP3Sem>

    sem_wait(mutexHead);
    80006870:	0284b503          	ld	a0,40(s1)
    80006874:	ffffb097          	auipc	ra,0xffffb
    80006878:	c40080e7          	jalr	-960(ra) # 800014b4 <_Z8sem_waitP3Sem>

    int ret = buffer[head];
    8000687c:	0084b703          	ld	a4,8(s1)
    80006880:	0104a783          	lw	a5,16(s1)
    80006884:	00279693          	slli	a3,a5,0x2
    80006888:	00d70733          	add	a4,a4,a3
    8000688c:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006890:	0017879b          	addiw	a5,a5,1
    80006894:	0004a703          	lw	a4,0(s1)
    80006898:	02e7e7bb          	remw	a5,a5,a4
    8000689c:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    800068a0:	0284b503          	ld	a0,40(s1)
    800068a4:	ffffb097          	auipc	ra,0xffffb
    800068a8:	c68080e7          	jalr	-920(ra) # 8000150c <_Z10sem_signalP3Sem>

    sem_signal(spaceAvailable);
    800068ac:	0184b503          	ld	a0,24(s1)
    800068b0:	ffffb097          	auipc	ra,0xffffb
    800068b4:	c5c080e7          	jalr	-932(ra) # 8000150c <_Z10sem_signalP3Sem>

    return ret;
}
    800068b8:	00090513          	mv	a0,s2
    800068bc:	01813083          	ld	ra,24(sp)
    800068c0:	01013403          	ld	s0,16(sp)
    800068c4:	00813483          	ld	s1,8(sp)
    800068c8:	00013903          	ld	s2,0(sp)
    800068cc:	02010113          	addi	sp,sp,32
    800068d0:	00008067          	ret

00000000800068d4 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    800068d4:	fe010113          	addi	sp,sp,-32
    800068d8:	00113c23          	sd	ra,24(sp)
    800068dc:	00813823          	sd	s0,16(sp)
    800068e0:	00913423          	sd	s1,8(sp)
    800068e4:	01213023          	sd	s2,0(sp)
    800068e8:	02010413          	addi	s0,sp,32
    800068ec:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800068f0:	02853503          	ld	a0,40(a0)
    800068f4:	ffffb097          	auipc	ra,0xffffb
    800068f8:	bc0080e7          	jalr	-1088(ra) # 800014b4 <_Z8sem_waitP3Sem>
    sem_wait(mutexTail);
    800068fc:	0304b503          	ld	a0,48(s1)
    80006900:	ffffb097          	auipc	ra,0xffffb
    80006904:	bb4080e7          	jalr	-1100(ra) # 800014b4 <_Z8sem_waitP3Sem>

    if (tail >= head) {
    80006908:	0144a783          	lw	a5,20(s1)
    8000690c:	0104a903          	lw	s2,16(s1)
    80006910:	0327ce63          	blt	a5,s2,8000694c <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80006914:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80006918:	0304b503          	ld	a0,48(s1)
    8000691c:	ffffb097          	auipc	ra,0xffffb
    80006920:	bf0080e7          	jalr	-1040(ra) # 8000150c <_Z10sem_signalP3Sem>
    sem_signal(mutexHead);
    80006924:	0284b503          	ld	a0,40(s1)
    80006928:	ffffb097          	auipc	ra,0xffffb
    8000692c:	be4080e7          	jalr	-1052(ra) # 8000150c <_Z10sem_signalP3Sem>

    return ret;
}
    80006930:	00090513          	mv	a0,s2
    80006934:	01813083          	ld	ra,24(sp)
    80006938:	01013403          	ld	s0,16(sp)
    8000693c:	00813483          	ld	s1,8(sp)
    80006940:	00013903          	ld	s2,0(sp)
    80006944:	02010113          	addi	sp,sp,32
    80006948:	00008067          	ret
        ret = cap - head + tail;
    8000694c:	0004a703          	lw	a4,0(s1)
    80006950:	4127093b          	subw	s2,a4,s2
    80006954:	00f9093b          	addw	s2,s2,a5
    80006958:	fc1ff06f          	j	80006918 <_ZN6Buffer6getCntEv+0x44>

000000008000695c <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    8000695c:	fe010113          	addi	sp,sp,-32
    80006960:	00113c23          	sd	ra,24(sp)
    80006964:	00813823          	sd	s0,16(sp)
    80006968:	00913423          	sd	s1,8(sp)
    8000696c:	02010413          	addi	s0,sp,32
    80006970:	00050493          	mv	s1,a0
    putc('\n');
    80006974:	00a00513          	li	a0,10
    80006978:	ffffb097          	auipc	ra,0xffffb
    8000697c:	cd4080e7          	jalr	-812(ra) # 8000164c <_Z4putcc>
    printString("Buffer deleted!\n");
    80006980:	00003517          	auipc	a0,0x3
    80006984:	99050513          	addi	a0,a0,-1648 # 80009310 <CONSOLE_STATUS+0x300>
    80006988:	fffff097          	auipc	ra,0xfffff
    8000698c:	e64080e7          	jalr	-412(ra) # 800057ec <_Z11printStringPKc>
    while (getCnt() > 0) {
    80006990:	00048513          	mv	a0,s1
    80006994:	00000097          	auipc	ra,0x0
    80006998:	f40080e7          	jalr	-192(ra) # 800068d4 <_ZN6Buffer6getCntEv>
    8000699c:	02a05c63          	blez	a0,800069d4 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    800069a0:	0084b783          	ld	a5,8(s1)
    800069a4:	0104a703          	lw	a4,16(s1)
    800069a8:	00271713          	slli	a4,a4,0x2
    800069ac:	00e787b3          	add	a5,a5,a4
        putc(ch);
    800069b0:	0007c503          	lbu	a0,0(a5)
    800069b4:	ffffb097          	auipc	ra,0xffffb
    800069b8:	c98080e7          	jalr	-872(ra) # 8000164c <_Z4putcc>
        head = (head + 1) % cap;
    800069bc:	0104a783          	lw	a5,16(s1)
    800069c0:	0017879b          	addiw	a5,a5,1
    800069c4:	0004a703          	lw	a4,0(s1)
    800069c8:	02e7e7bb          	remw	a5,a5,a4
    800069cc:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    800069d0:	fc1ff06f          	j	80006990 <_ZN6BufferD1Ev+0x34>
    putc('!');
    800069d4:	02100513          	li	a0,33
    800069d8:	ffffb097          	auipc	ra,0xffffb
    800069dc:	c74080e7          	jalr	-908(ra) # 8000164c <_Z4putcc>
    putc('\n');
    800069e0:	00a00513          	li	a0,10
    800069e4:	ffffb097          	auipc	ra,0xffffb
    800069e8:	c68080e7          	jalr	-920(ra) # 8000164c <_Z4putcc>
    mem_free(buffer);
    800069ec:	0084b503          	ld	a0,8(s1)
    800069f0:	ffffb097          	auipc	ra,0xffffb
    800069f4:	890080e7          	jalr	-1904(ra) # 80001280 <_Z8mem_freePv>
    sem_close(itemAvailable);
    800069f8:	0204b503          	ld	a0,32(s1)
    800069fc:	ffffb097          	auipc	ra,0xffffb
    80006a00:	a60080e7          	jalr	-1440(ra) # 8000145c <_Z9sem_closeP3Sem>
    sem_close(spaceAvailable);
    80006a04:	0184b503          	ld	a0,24(s1)
    80006a08:	ffffb097          	auipc	ra,0xffffb
    80006a0c:	a54080e7          	jalr	-1452(ra) # 8000145c <_Z9sem_closeP3Sem>
    sem_close(mutexTail);
    80006a10:	0304b503          	ld	a0,48(s1)
    80006a14:	ffffb097          	auipc	ra,0xffffb
    80006a18:	a48080e7          	jalr	-1464(ra) # 8000145c <_Z9sem_closeP3Sem>
    sem_close(mutexHead);
    80006a1c:	0284b503          	ld	a0,40(s1)
    80006a20:	ffffb097          	auipc	ra,0xffffb
    80006a24:	a3c080e7          	jalr	-1476(ra) # 8000145c <_Z9sem_closeP3Sem>
}
    80006a28:	01813083          	ld	ra,24(sp)
    80006a2c:	01013403          	ld	s0,16(sp)
    80006a30:	00813483          	ld	s1,8(sp)
    80006a34:	02010113          	addi	sp,sp,32
    80006a38:	00008067          	ret

0000000080006a3c <start>:
    80006a3c:	ff010113          	addi	sp,sp,-16
    80006a40:	00813423          	sd	s0,8(sp)
    80006a44:	01010413          	addi	s0,sp,16
    80006a48:	300027f3          	csrr	a5,mstatus
    80006a4c:	ffffe737          	lui	a4,0xffffe
    80006a50:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff159f>
    80006a54:	00e7f7b3          	and	a5,a5,a4
    80006a58:	00001737          	lui	a4,0x1
    80006a5c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80006a60:	00e7e7b3          	or	a5,a5,a4
    80006a64:	30079073          	csrw	mstatus,a5
    80006a68:	00000797          	auipc	a5,0x0
    80006a6c:	16078793          	addi	a5,a5,352 # 80006bc8 <system_main>
    80006a70:	34179073          	csrw	mepc,a5
    80006a74:	00000793          	li	a5,0
    80006a78:	18079073          	csrw	satp,a5
    80006a7c:	000107b7          	lui	a5,0x10
    80006a80:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006a84:	30279073          	csrw	medeleg,a5
    80006a88:	30379073          	csrw	mideleg,a5
    80006a8c:	104027f3          	csrr	a5,sie
    80006a90:	2227e793          	ori	a5,a5,546
    80006a94:	10479073          	csrw	sie,a5
    80006a98:	fff00793          	li	a5,-1
    80006a9c:	00a7d793          	srli	a5,a5,0xa
    80006aa0:	3b079073          	csrw	pmpaddr0,a5
    80006aa4:	00f00793          	li	a5,15
    80006aa8:	3a079073          	csrw	pmpcfg0,a5
    80006aac:	f14027f3          	csrr	a5,mhartid
    80006ab0:	0200c737          	lui	a4,0x200c
    80006ab4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006ab8:	0007869b          	sext.w	a3,a5
    80006abc:	00269713          	slli	a4,a3,0x2
    80006ac0:	000f4637          	lui	a2,0xf4
    80006ac4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006ac8:	00d70733          	add	a4,a4,a3
    80006acc:	0037979b          	slliw	a5,a5,0x3
    80006ad0:	020046b7          	lui	a3,0x2004
    80006ad4:	00d787b3          	add	a5,a5,a3
    80006ad8:	00c585b3          	add	a1,a1,a2
    80006adc:	00371693          	slli	a3,a4,0x3
    80006ae0:	00005717          	auipc	a4,0x5
    80006ae4:	52070713          	addi	a4,a4,1312 # 8000c000 <timer_scratch>
    80006ae8:	00b7b023          	sd	a1,0(a5)
    80006aec:	00d70733          	add	a4,a4,a3
    80006af0:	00f73c23          	sd	a5,24(a4)
    80006af4:	02c73023          	sd	a2,32(a4)
    80006af8:	34071073          	csrw	mscratch,a4
    80006afc:	00000797          	auipc	a5,0x0
    80006b00:	6e478793          	addi	a5,a5,1764 # 800071e0 <timervec>
    80006b04:	30579073          	csrw	mtvec,a5
    80006b08:	300027f3          	csrr	a5,mstatus
    80006b0c:	0087e793          	ori	a5,a5,8
    80006b10:	30079073          	csrw	mstatus,a5
    80006b14:	304027f3          	csrr	a5,mie
    80006b18:	0807e793          	ori	a5,a5,128
    80006b1c:	30479073          	csrw	mie,a5
    80006b20:	f14027f3          	csrr	a5,mhartid
    80006b24:	0007879b          	sext.w	a5,a5
    80006b28:	00078213          	mv	tp,a5
    80006b2c:	30200073          	mret
    80006b30:	00813403          	ld	s0,8(sp)
    80006b34:	01010113          	addi	sp,sp,16
    80006b38:	00008067          	ret

0000000080006b3c <timerinit>:
    80006b3c:	ff010113          	addi	sp,sp,-16
    80006b40:	00813423          	sd	s0,8(sp)
    80006b44:	01010413          	addi	s0,sp,16
    80006b48:	f14027f3          	csrr	a5,mhartid
    80006b4c:	0200c737          	lui	a4,0x200c
    80006b50:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006b54:	0007869b          	sext.w	a3,a5
    80006b58:	00269713          	slli	a4,a3,0x2
    80006b5c:	000f4637          	lui	a2,0xf4
    80006b60:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006b64:	00d70733          	add	a4,a4,a3
    80006b68:	0037979b          	slliw	a5,a5,0x3
    80006b6c:	020046b7          	lui	a3,0x2004
    80006b70:	00d787b3          	add	a5,a5,a3
    80006b74:	00c585b3          	add	a1,a1,a2
    80006b78:	00371693          	slli	a3,a4,0x3
    80006b7c:	00005717          	auipc	a4,0x5
    80006b80:	48470713          	addi	a4,a4,1156 # 8000c000 <timer_scratch>
    80006b84:	00b7b023          	sd	a1,0(a5)
    80006b88:	00d70733          	add	a4,a4,a3
    80006b8c:	00f73c23          	sd	a5,24(a4)
    80006b90:	02c73023          	sd	a2,32(a4)
    80006b94:	34071073          	csrw	mscratch,a4
    80006b98:	00000797          	auipc	a5,0x0
    80006b9c:	64878793          	addi	a5,a5,1608 # 800071e0 <timervec>
    80006ba0:	30579073          	csrw	mtvec,a5
    80006ba4:	300027f3          	csrr	a5,mstatus
    80006ba8:	0087e793          	ori	a5,a5,8
    80006bac:	30079073          	csrw	mstatus,a5
    80006bb0:	304027f3          	csrr	a5,mie
    80006bb4:	0807e793          	ori	a5,a5,128
    80006bb8:	30479073          	csrw	mie,a5
    80006bbc:	00813403          	ld	s0,8(sp)
    80006bc0:	01010113          	addi	sp,sp,16
    80006bc4:	00008067          	ret

0000000080006bc8 <system_main>:
    80006bc8:	fe010113          	addi	sp,sp,-32
    80006bcc:	00813823          	sd	s0,16(sp)
    80006bd0:	00913423          	sd	s1,8(sp)
    80006bd4:	00113c23          	sd	ra,24(sp)
    80006bd8:	02010413          	addi	s0,sp,32
    80006bdc:	00000097          	auipc	ra,0x0
    80006be0:	0c4080e7          	jalr	196(ra) # 80006ca0 <cpuid>
    80006be4:	00005497          	auipc	s1,0x5
    80006be8:	30c48493          	addi	s1,s1,780 # 8000bef0 <started>
    80006bec:	02050263          	beqz	a0,80006c10 <system_main+0x48>
    80006bf0:	0004a783          	lw	a5,0(s1)
    80006bf4:	0007879b          	sext.w	a5,a5
    80006bf8:	fe078ce3          	beqz	a5,80006bf0 <system_main+0x28>
    80006bfc:	0ff0000f          	fence
    80006c00:	00003517          	auipc	a0,0x3
    80006c04:	9e050513          	addi	a0,a0,-1568 # 800095e0 <CONSOLE_STATUS+0x5d0>
    80006c08:	00001097          	auipc	ra,0x1
    80006c0c:	a74080e7          	jalr	-1420(ra) # 8000767c <panic>
    80006c10:	00001097          	auipc	ra,0x1
    80006c14:	9c8080e7          	jalr	-1592(ra) # 800075d8 <consoleinit>
    80006c18:	00001097          	auipc	ra,0x1
    80006c1c:	154080e7          	jalr	340(ra) # 80007d6c <printfinit>
    80006c20:	00003517          	auipc	a0,0x3
    80006c24:	84850513          	addi	a0,a0,-1976 # 80009468 <CONSOLE_STATUS+0x458>
    80006c28:	00001097          	auipc	ra,0x1
    80006c2c:	ab0080e7          	jalr	-1360(ra) # 800076d8 <__printf>
    80006c30:	00003517          	auipc	a0,0x3
    80006c34:	98050513          	addi	a0,a0,-1664 # 800095b0 <CONSOLE_STATUS+0x5a0>
    80006c38:	00001097          	auipc	ra,0x1
    80006c3c:	aa0080e7          	jalr	-1376(ra) # 800076d8 <__printf>
    80006c40:	00003517          	auipc	a0,0x3
    80006c44:	82850513          	addi	a0,a0,-2008 # 80009468 <CONSOLE_STATUS+0x458>
    80006c48:	00001097          	auipc	ra,0x1
    80006c4c:	a90080e7          	jalr	-1392(ra) # 800076d8 <__printf>
    80006c50:	00001097          	auipc	ra,0x1
    80006c54:	4a8080e7          	jalr	1192(ra) # 800080f8 <kinit>
    80006c58:	00000097          	auipc	ra,0x0
    80006c5c:	148080e7          	jalr	328(ra) # 80006da0 <trapinit>
    80006c60:	00000097          	auipc	ra,0x0
    80006c64:	16c080e7          	jalr	364(ra) # 80006dcc <trapinithart>
    80006c68:	00000097          	auipc	ra,0x0
    80006c6c:	5b8080e7          	jalr	1464(ra) # 80007220 <plicinit>
    80006c70:	00000097          	auipc	ra,0x0
    80006c74:	5d8080e7          	jalr	1496(ra) # 80007248 <plicinithart>
    80006c78:	00000097          	auipc	ra,0x0
    80006c7c:	078080e7          	jalr	120(ra) # 80006cf0 <userinit>
    80006c80:	0ff0000f          	fence
    80006c84:	00100793          	li	a5,1
    80006c88:	00003517          	auipc	a0,0x3
    80006c8c:	94050513          	addi	a0,a0,-1728 # 800095c8 <CONSOLE_STATUS+0x5b8>
    80006c90:	00f4a023          	sw	a5,0(s1)
    80006c94:	00001097          	auipc	ra,0x1
    80006c98:	a44080e7          	jalr	-1468(ra) # 800076d8 <__printf>
    80006c9c:	0000006f          	j	80006c9c <system_main+0xd4>

0000000080006ca0 <cpuid>:
    80006ca0:	ff010113          	addi	sp,sp,-16
    80006ca4:	00813423          	sd	s0,8(sp)
    80006ca8:	01010413          	addi	s0,sp,16
    80006cac:	00020513          	mv	a0,tp
    80006cb0:	00813403          	ld	s0,8(sp)
    80006cb4:	0005051b          	sext.w	a0,a0
    80006cb8:	01010113          	addi	sp,sp,16
    80006cbc:	00008067          	ret

0000000080006cc0 <mycpu>:
    80006cc0:	ff010113          	addi	sp,sp,-16
    80006cc4:	00813423          	sd	s0,8(sp)
    80006cc8:	01010413          	addi	s0,sp,16
    80006ccc:	00020793          	mv	a5,tp
    80006cd0:	00813403          	ld	s0,8(sp)
    80006cd4:	0007879b          	sext.w	a5,a5
    80006cd8:	00779793          	slli	a5,a5,0x7
    80006cdc:	00006517          	auipc	a0,0x6
    80006ce0:	35450513          	addi	a0,a0,852 # 8000d030 <cpus>
    80006ce4:	00f50533          	add	a0,a0,a5
    80006ce8:	01010113          	addi	sp,sp,16
    80006cec:	00008067          	ret

0000000080006cf0 <userinit>:
    80006cf0:	ff010113          	addi	sp,sp,-16
    80006cf4:	00813423          	sd	s0,8(sp)
    80006cf8:	01010413          	addi	s0,sp,16
    80006cfc:	00813403          	ld	s0,8(sp)
    80006d00:	01010113          	addi	sp,sp,16
    80006d04:	ffffb317          	auipc	t1,0xffffb
    80006d08:	a3830067          	jr	-1480(t1) # 8000173c <main>

0000000080006d0c <either_copyout>:
    80006d0c:	ff010113          	addi	sp,sp,-16
    80006d10:	00813023          	sd	s0,0(sp)
    80006d14:	00113423          	sd	ra,8(sp)
    80006d18:	01010413          	addi	s0,sp,16
    80006d1c:	02051663          	bnez	a0,80006d48 <either_copyout+0x3c>
    80006d20:	00058513          	mv	a0,a1
    80006d24:	00060593          	mv	a1,a2
    80006d28:	0006861b          	sext.w	a2,a3
    80006d2c:	00002097          	auipc	ra,0x2
    80006d30:	c58080e7          	jalr	-936(ra) # 80008984 <__memmove>
    80006d34:	00813083          	ld	ra,8(sp)
    80006d38:	00013403          	ld	s0,0(sp)
    80006d3c:	00000513          	li	a0,0
    80006d40:	01010113          	addi	sp,sp,16
    80006d44:	00008067          	ret
    80006d48:	00003517          	auipc	a0,0x3
    80006d4c:	8c050513          	addi	a0,a0,-1856 # 80009608 <CONSOLE_STATUS+0x5f8>
    80006d50:	00001097          	auipc	ra,0x1
    80006d54:	92c080e7          	jalr	-1748(ra) # 8000767c <panic>

0000000080006d58 <either_copyin>:
    80006d58:	ff010113          	addi	sp,sp,-16
    80006d5c:	00813023          	sd	s0,0(sp)
    80006d60:	00113423          	sd	ra,8(sp)
    80006d64:	01010413          	addi	s0,sp,16
    80006d68:	02059463          	bnez	a1,80006d90 <either_copyin+0x38>
    80006d6c:	00060593          	mv	a1,a2
    80006d70:	0006861b          	sext.w	a2,a3
    80006d74:	00002097          	auipc	ra,0x2
    80006d78:	c10080e7          	jalr	-1008(ra) # 80008984 <__memmove>
    80006d7c:	00813083          	ld	ra,8(sp)
    80006d80:	00013403          	ld	s0,0(sp)
    80006d84:	00000513          	li	a0,0
    80006d88:	01010113          	addi	sp,sp,16
    80006d8c:	00008067          	ret
    80006d90:	00003517          	auipc	a0,0x3
    80006d94:	8a050513          	addi	a0,a0,-1888 # 80009630 <CONSOLE_STATUS+0x620>
    80006d98:	00001097          	auipc	ra,0x1
    80006d9c:	8e4080e7          	jalr	-1820(ra) # 8000767c <panic>

0000000080006da0 <trapinit>:
    80006da0:	ff010113          	addi	sp,sp,-16
    80006da4:	00813423          	sd	s0,8(sp)
    80006da8:	01010413          	addi	s0,sp,16
    80006dac:	00813403          	ld	s0,8(sp)
    80006db0:	00003597          	auipc	a1,0x3
    80006db4:	8a858593          	addi	a1,a1,-1880 # 80009658 <CONSOLE_STATUS+0x648>
    80006db8:	00006517          	auipc	a0,0x6
    80006dbc:	2f850513          	addi	a0,a0,760 # 8000d0b0 <tickslock>
    80006dc0:	01010113          	addi	sp,sp,16
    80006dc4:	00001317          	auipc	t1,0x1
    80006dc8:	5c430067          	jr	1476(t1) # 80008388 <initlock>

0000000080006dcc <trapinithart>:
    80006dcc:	ff010113          	addi	sp,sp,-16
    80006dd0:	00813423          	sd	s0,8(sp)
    80006dd4:	01010413          	addi	s0,sp,16
    80006dd8:	00000797          	auipc	a5,0x0
    80006ddc:	2f878793          	addi	a5,a5,760 # 800070d0 <kernelvec>
    80006de0:	10579073          	csrw	stvec,a5
    80006de4:	00813403          	ld	s0,8(sp)
    80006de8:	01010113          	addi	sp,sp,16
    80006dec:	00008067          	ret

0000000080006df0 <usertrap>:
    80006df0:	ff010113          	addi	sp,sp,-16
    80006df4:	00813423          	sd	s0,8(sp)
    80006df8:	01010413          	addi	s0,sp,16
    80006dfc:	00813403          	ld	s0,8(sp)
    80006e00:	01010113          	addi	sp,sp,16
    80006e04:	00008067          	ret

0000000080006e08 <usertrapret>:
    80006e08:	ff010113          	addi	sp,sp,-16
    80006e0c:	00813423          	sd	s0,8(sp)
    80006e10:	01010413          	addi	s0,sp,16
    80006e14:	00813403          	ld	s0,8(sp)
    80006e18:	01010113          	addi	sp,sp,16
    80006e1c:	00008067          	ret

0000000080006e20 <kerneltrap>:
    80006e20:	fe010113          	addi	sp,sp,-32
    80006e24:	00813823          	sd	s0,16(sp)
    80006e28:	00113c23          	sd	ra,24(sp)
    80006e2c:	00913423          	sd	s1,8(sp)
    80006e30:	02010413          	addi	s0,sp,32
    80006e34:	142025f3          	csrr	a1,scause
    80006e38:	100027f3          	csrr	a5,sstatus
    80006e3c:	0027f793          	andi	a5,a5,2
    80006e40:	10079c63          	bnez	a5,80006f58 <kerneltrap+0x138>
    80006e44:	142027f3          	csrr	a5,scause
    80006e48:	0207ce63          	bltz	a5,80006e84 <kerneltrap+0x64>
    80006e4c:	00003517          	auipc	a0,0x3
    80006e50:	85450513          	addi	a0,a0,-1964 # 800096a0 <CONSOLE_STATUS+0x690>
    80006e54:	00001097          	auipc	ra,0x1
    80006e58:	884080e7          	jalr	-1916(ra) # 800076d8 <__printf>
    80006e5c:	141025f3          	csrr	a1,sepc
    80006e60:	14302673          	csrr	a2,stval
    80006e64:	00003517          	auipc	a0,0x3
    80006e68:	84c50513          	addi	a0,a0,-1972 # 800096b0 <CONSOLE_STATUS+0x6a0>
    80006e6c:	00001097          	auipc	ra,0x1
    80006e70:	86c080e7          	jalr	-1940(ra) # 800076d8 <__printf>
    80006e74:	00003517          	auipc	a0,0x3
    80006e78:	85450513          	addi	a0,a0,-1964 # 800096c8 <CONSOLE_STATUS+0x6b8>
    80006e7c:	00001097          	auipc	ra,0x1
    80006e80:	800080e7          	jalr	-2048(ra) # 8000767c <panic>
    80006e84:	0ff7f713          	andi	a4,a5,255
    80006e88:	00900693          	li	a3,9
    80006e8c:	04d70063          	beq	a4,a3,80006ecc <kerneltrap+0xac>
    80006e90:	fff00713          	li	a4,-1
    80006e94:	03f71713          	slli	a4,a4,0x3f
    80006e98:	00170713          	addi	a4,a4,1
    80006e9c:	fae798e3          	bne	a5,a4,80006e4c <kerneltrap+0x2c>
    80006ea0:	00000097          	auipc	ra,0x0
    80006ea4:	e00080e7          	jalr	-512(ra) # 80006ca0 <cpuid>
    80006ea8:	06050663          	beqz	a0,80006f14 <kerneltrap+0xf4>
    80006eac:	144027f3          	csrr	a5,sip
    80006eb0:	ffd7f793          	andi	a5,a5,-3
    80006eb4:	14479073          	csrw	sip,a5
    80006eb8:	01813083          	ld	ra,24(sp)
    80006ebc:	01013403          	ld	s0,16(sp)
    80006ec0:	00813483          	ld	s1,8(sp)
    80006ec4:	02010113          	addi	sp,sp,32
    80006ec8:	00008067          	ret
    80006ecc:	00000097          	auipc	ra,0x0
    80006ed0:	3c8080e7          	jalr	968(ra) # 80007294 <plic_claim>
    80006ed4:	00a00793          	li	a5,10
    80006ed8:	00050493          	mv	s1,a0
    80006edc:	06f50863          	beq	a0,a5,80006f4c <kerneltrap+0x12c>
    80006ee0:	fc050ce3          	beqz	a0,80006eb8 <kerneltrap+0x98>
    80006ee4:	00050593          	mv	a1,a0
    80006ee8:	00002517          	auipc	a0,0x2
    80006eec:	79850513          	addi	a0,a0,1944 # 80009680 <CONSOLE_STATUS+0x670>
    80006ef0:	00000097          	auipc	ra,0x0
    80006ef4:	7e8080e7          	jalr	2024(ra) # 800076d8 <__printf>
    80006ef8:	01013403          	ld	s0,16(sp)
    80006efc:	01813083          	ld	ra,24(sp)
    80006f00:	00048513          	mv	a0,s1
    80006f04:	00813483          	ld	s1,8(sp)
    80006f08:	02010113          	addi	sp,sp,32
    80006f0c:	00000317          	auipc	t1,0x0
    80006f10:	3c030067          	jr	960(t1) # 800072cc <plic_complete>
    80006f14:	00006517          	auipc	a0,0x6
    80006f18:	19c50513          	addi	a0,a0,412 # 8000d0b0 <tickslock>
    80006f1c:	00001097          	auipc	ra,0x1
    80006f20:	490080e7          	jalr	1168(ra) # 800083ac <acquire>
    80006f24:	00005717          	auipc	a4,0x5
    80006f28:	fd070713          	addi	a4,a4,-48 # 8000bef4 <ticks>
    80006f2c:	00072783          	lw	a5,0(a4)
    80006f30:	00006517          	auipc	a0,0x6
    80006f34:	18050513          	addi	a0,a0,384 # 8000d0b0 <tickslock>
    80006f38:	0017879b          	addiw	a5,a5,1
    80006f3c:	00f72023          	sw	a5,0(a4)
    80006f40:	00001097          	auipc	ra,0x1
    80006f44:	538080e7          	jalr	1336(ra) # 80008478 <release>
    80006f48:	f65ff06f          	j	80006eac <kerneltrap+0x8c>
    80006f4c:	00001097          	auipc	ra,0x1
    80006f50:	094080e7          	jalr	148(ra) # 80007fe0 <uartintr>
    80006f54:	fa5ff06f          	j	80006ef8 <kerneltrap+0xd8>
    80006f58:	00002517          	auipc	a0,0x2
    80006f5c:	70850513          	addi	a0,a0,1800 # 80009660 <CONSOLE_STATUS+0x650>
    80006f60:	00000097          	auipc	ra,0x0
    80006f64:	71c080e7          	jalr	1820(ra) # 8000767c <panic>

0000000080006f68 <clockintr>:
    80006f68:	fe010113          	addi	sp,sp,-32
    80006f6c:	00813823          	sd	s0,16(sp)
    80006f70:	00913423          	sd	s1,8(sp)
    80006f74:	00113c23          	sd	ra,24(sp)
    80006f78:	02010413          	addi	s0,sp,32
    80006f7c:	00006497          	auipc	s1,0x6
    80006f80:	13448493          	addi	s1,s1,308 # 8000d0b0 <tickslock>
    80006f84:	00048513          	mv	a0,s1
    80006f88:	00001097          	auipc	ra,0x1
    80006f8c:	424080e7          	jalr	1060(ra) # 800083ac <acquire>
    80006f90:	00005717          	auipc	a4,0x5
    80006f94:	f6470713          	addi	a4,a4,-156 # 8000bef4 <ticks>
    80006f98:	00072783          	lw	a5,0(a4)
    80006f9c:	01013403          	ld	s0,16(sp)
    80006fa0:	01813083          	ld	ra,24(sp)
    80006fa4:	00048513          	mv	a0,s1
    80006fa8:	0017879b          	addiw	a5,a5,1
    80006fac:	00813483          	ld	s1,8(sp)
    80006fb0:	00f72023          	sw	a5,0(a4)
    80006fb4:	02010113          	addi	sp,sp,32
    80006fb8:	00001317          	auipc	t1,0x1
    80006fbc:	4c030067          	jr	1216(t1) # 80008478 <release>

0000000080006fc0 <devintr>:
    80006fc0:	142027f3          	csrr	a5,scause
    80006fc4:	00000513          	li	a0,0
    80006fc8:	0007c463          	bltz	a5,80006fd0 <devintr+0x10>
    80006fcc:	00008067          	ret
    80006fd0:	fe010113          	addi	sp,sp,-32
    80006fd4:	00813823          	sd	s0,16(sp)
    80006fd8:	00113c23          	sd	ra,24(sp)
    80006fdc:	00913423          	sd	s1,8(sp)
    80006fe0:	02010413          	addi	s0,sp,32
    80006fe4:	0ff7f713          	andi	a4,a5,255
    80006fe8:	00900693          	li	a3,9
    80006fec:	04d70c63          	beq	a4,a3,80007044 <devintr+0x84>
    80006ff0:	fff00713          	li	a4,-1
    80006ff4:	03f71713          	slli	a4,a4,0x3f
    80006ff8:	00170713          	addi	a4,a4,1
    80006ffc:	00e78c63          	beq	a5,a4,80007014 <devintr+0x54>
    80007000:	01813083          	ld	ra,24(sp)
    80007004:	01013403          	ld	s0,16(sp)
    80007008:	00813483          	ld	s1,8(sp)
    8000700c:	02010113          	addi	sp,sp,32
    80007010:	00008067          	ret
    80007014:	00000097          	auipc	ra,0x0
    80007018:	c8c080e7          	jalr	-884(ra) # 80006ca0 <cpuid>
    8000701c:	06050663          	beqz	a0,80007088 <devintr+0xc8>
    80007020:	144027f3          	csrr	a5,sip
    80007024:	ffd7f793          	andi	a5,a5,-3
    80007028:	14479073          	csrw	sip,a5
    8000702c:	01813083          	ld	ra,24(sp)
    80007030:	01013403          	ld	s0,16(sp)
    80007034:	00813483          	ld	s1,8(sp)
    80007038:	00200513          	li	a0,2
    8000703c:	02010113          	addi	sp,sp,32
    80007040:	00008067          	ret
    80007044:	00000097          	auipc	ra,0x0
    80007048:	250080e7          	jalr	592(ra) # 80007294 <plic_claim>
    8000704c:	00a00793          	li	a5,10
    80007050:	00050493          	mv	s1,a0
    80007054:	06f50663          	beq	a0,a5,800070c0 <devintr+0x100>
    80007058:	00100513          	li	a0,1
    8000705c:	fa0482e3          	beqz	s1,80007000 <devintr+0x40>
    80007060:	00048593          	mv	a1,s1
    80007064:	00002517          	auipc	a0,0x2
    80007068:	61c50513          	addi	a0,a0,1564 # 80009680 <CONSOLE_STATUS+0x670>
    8000706c:	00000097          	auipc	ra,0x0
    80007070:	66c080e7          	jalr	1644(ra) # 800076d8 <__printf>
    80007074:	00048513          	mv	a0,s1
    80007078:	00000097          	auipc	ra,0x0
    8000707c:	254080e7          	jalr	596(ra) # 800072cc <plic_complete>
    80007080:	00100513          	li	a0,1
    80007084:	f7dff06f          	j	80007000 <devintr+0x40>
    80007088:	00006517          	auipc	a0,0x6
    8000708c:	02850513          	addi	a0,a0,40 # 8000d0b0 <tickslock>
    80007090:	00001097          	auipc	ra,0x1
    80007094:	31c080e7          	jalr	796(ra) # 800083ac <acquire>
    80007098:	00005717          	auipc	a4,0x5
    8000709c:	e5c70713          	addi	a4,a4,-420 # 8000bef4 <ticks>
    800070a0:	00072783          	lw	a5,0(a4)
    800070a4:	00006517          	auipc	a0,0x6
    800070a8:	00c50513          	addi	a0,a0,12 # 8000d0b0 <tickslock>
    800070ac:	0017879b          	addiw	a5,a5,1
    800070b0:	00f72023          	sw	a5,0(a4)
    800070b4:	00001097          	auipc	ra,0x1
    800070b8:	3c4080e7          	jalr	964(ra) # 80008478 <release>
    800070bc:	f65ff06f          	j	80007020 <devintr+0x60>
    800070c0:	00001097          	auipc	ra,0x1
    800070c4:	f20080e7          	jalr	-224(ra) # 80007fe0 <uartintr>
    800070c8:	fadff06f          	j	80007074 <devintr+0xb4>
    800070cc:	0000                	unimp
	...

00000000800070d0 <kernelvec>:
    800070d0:	f0010113          	addi	sp,sp,-256
    800070d4:	00113023          	sd	ra,0(sp)
    800070d8:	00213423          	sd	sp,8(sp)
    800070dc:	00313823          	sd	gp,16(sp)
    800070e0:	00413c23          	sd	tp,24(sp)
    800070e4:	02513023          	sd	t0,32(sp)
    800070e8:	02613423          	sd	t1,40(sp)
    800070ec:	02713823          	sd	t2,48(sp)
    800070f0:	02813c23          	sd	s0,56(sp)
    800070f4:	04913023          	sd	s1,64(sp)
    800070f8:	04a13423          	sd	a0,72(sp)
    800070fc:	04b13823          	sd	a1,80(sp)
    80007100:	04c13c23          	sd	a2,88(sp)
    80007104:	06d13023          	sd	a3,96(sp)
    80007108:	06e13423          	sd	a4,104(sp)
    8000710c:	06f13823          	sd	a5,112(sp)
    80007110:	07013c23          	sd	a6,120(sp)
    80007114:	09113023          	sd	a7,128(sp)
    80007118:	09213423          	sd	s2,136(sp)
    8000711c:	09313823          	sd	s3,144(sp)
    80007120:	09413c23          	sd	s4,152(sp)
    80007124:	0b513023          	sd	s5,160(sp)
    80007128:	0b613423          	sd	s6,168(sp)
    8000712c:	0b713823          	sd	s7,176(sp)
    80007130:	0b813c23          	sd	s8,184(sp)
    80007134:	0d913023          	sd	s9,192(sp)
    80007138:	0da13423          	sd	s10,200(sp)
    8000713c:	0db13823          	sd	s11,208(sp)
    80007140:	0dc13c23          	sd	t3,216(sp)
    80007144:	0fd13023          	sd	t4,224(sp)
    80007148:	0fe13423          	sd	t5,232(sp)
    8000714c:	0ff13823          	sd	t6,240(sp)
    80007150:	cd1ff0ef          	jal	ra,80006e20 <kerneltrap>
    80007154:	00013083          	ld	ra,0(sp)
    80007158:	00813103          	ld	sp,8(sp)
    8000715c:	01013183          	ld	gp,16(sp)
    80007160:	02013283          	ld	t0,32(sp)
    80007164:	02813303          	ld	t1,40(sp)
    80007168:	03013383          	ld	t2,48(sp)
    8000716c:	03813403          	ld	s0,56(sp)
    80007170:	04013483          	ld	s1,64(sp)
    80007174:	04813503          	ld	a0,72(sp)
    80007178:	05013583          	ld	a1,80(sp)
    8000717c:	05813603          	ld	a2,88(sp)
    80007180:	06013683          	ld	a3,96(sp)
    80007184:	06813703          	ld	a4,104(sp)
    80007188:	07013783          	ld	a5,112(sp)
    8000718c:	07813803          	ld	a6,120(sp)
    80007190:	08013883          	ld	a7,128(sp)
    80007194:	08813903          	ld	s2,136(sp)
    80007198:	09013983          	ld	s3,144(sp)
    8000719c:	09813a03          	ld	s4,152(sp)
    800071a0:	0a013a83          	ld	s5,160(sp)
    800071a4:	0a813b03          	ld	s6,168(sp)
    800071a8:	0b013b83          	ld	s7,176(sp)
    800071ac:	0b813c03          	ld	s8,184(sp)
    800071b0:	0c013c83          	ld	s9,192(sp)
    800071b4:	0c813d03          	ld	s10,200(sp)
    800071b8:	0d013d83          	ld	s11,208(sp)
    800071bc:	0d813e03          	ld	t3,216(sp)
    800071c0:	0e013e83          	ld	t4,224(sp)
    800071c4:	0e813f03          	ld	t5,232(sp)
    800071c8:	0f013f83          	ld	t6,240(sp)
    800071cc:	10010113          	addi	sp,sp,256
    800071d0:	10200073          	sret
    800071d4:	00000013          	nop
    800071d8:	00000013          	nop
    800071dc:	00000013          	nop

00000000800071e0 <timervec>:
    800071e0:	34051573          	csrrw	a0,mscratch,a0
    800071e4:	00b53023          	sd	a1,0(a0)
    800071e8:	00c53423          	sd	a2,8(a0)
    800071ec:	00d53823          	sd	a3,16(a0)
    800071f0:	01853583          	ld	a1,24(a0)
    800071f4:	02053603          	ld	a2,32(a0)
    800071f8:	0005b683          	ld	a3,0(a1)
    800071fc:	00c686b3          	add	a3,a3,a2
    80007200:	00d5b023          	sd	a3,0(a1)
    80007204:	00200593          	li	a1,2
    80007208:	14459073          	csrw	sip,a1
    8000720c:	01053683          	ld	a3,16(a0)
    80007210:	00853603          	ld	a2,8(a0)
    80007214:	00053583          	ld	a1,0(a0)
    80007218:	34051573          	csrrw	a0,mscratch,a0
    8000721c:	30200073          	mret

0000000080007220 <plicinit>:
    80007220:	ff010113          	addi	sp,sp,-16
    80007224:	00813423          	sd	s0,8(sp)
    80007228:	01010413          	addi	s0,sp,16
    8000722c:	00813403          	ld	s0,8(sp)
    80007230:	0c0007b7          	lui	a5,0xc000
    80007234:	00100713          	li	a4,1
    80007238:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000723c:	00e7a223          	sw	a4,4(a5)
    80007240:	01010113          	addi	sp,sp,16
    80007244:	00008067          	ret

0000000080007248 <plicinithart>:
    80007248:	ff010113          	addi	sp,sp,-16
    8000724c:	00813023          	sd	s0,0(sp)
    80007250:	00113423          	sd	ra,8(sp)
    80007254:	01010413          	addi	s0,sp,16
    80007258:	00000097          	auipc	ra,0x0
    8000725c:	a48080e7          	jalr	-1464(ra) # 80006ca0 <cpuid>
    80007260:	0085171b          	slliw	a4,a0,0x8
    80007264:	0c0027b7          	lui	a5,0xc002
    80007268:	00e787b3          	add	a5,a5,a4
    8000726c:	40200713          	li	a4,1026
    80007270:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80007274:	00813083          	ld	ra,8(sp)
    80007278:	00013403          	ld	s0,0(sp)
    8000727c:	00d5151b          	slliw	a0,a0,0xd
    80007280:	0c2017b7          	lui	a5,0xc201
    80007284:	00a78533          	add	a0,a5,a0
    80007288:	00052023          	sw	zero,0(a0)
    8000728c:	01010113          	addi	sp,sp,16
    80007290:	00008067          	ret

0000000080007294 <plic_claim>:
    80007294:	ff010113          	addi	sp,sp,-16
    80007298:	00813023          	sd	s0,0(sp)
    8000729c:	00113423          	sd	ra,8(sp)
    800072a0:	01010413          	addi	s0,sp,16
    800072a4:	00000097          	auipc	ra,0x0
    800072a8:	9fc080e7          	jalr	-1540(ra) # 80006ca0 <cpuid>
    800072ac:	00813083          	ld	ra,8(sp)
    800072b0:	00013403          	ld	s0,0(sp)
    800072b4:	00d5151b          	slliw	a0,a0,0xd
    800072b8:	0c2017b7          	lui	a5,0xc201
    800072bc:	00a78533          	add	a0,a5,a0
    800072c0:	00452503          	lw	a0,4(a0)
    800072c4:	01010113          	addi	sp,sp,16
    800072c8:	00008067          	ret

00000000800072cc <plic_complete>:
    800072cc:	fe010113          	addi	sp,sp,-32
    800072d0:	00813823          	sd	s0,16(sp)
    800072d4:	00913423          	sd	s1,8(sp)
    800072d8:	00113c23          	sd	ra,24(sp)
    800072dc:	02010413          	addi	s0,sp,32
    800072e0:	00050493          	mv	s1,a0
    800072e4:	00000097          	auipc	ra,0x0
    800072e8:	9bc080e7          	jalr	-1604(ra) # 80006ca0 <cpuid>
    800072ec:	01813083          	ld	ra,24(sp)
    800072f0:	01013403          	ld	s0,16(sp)
    800072f4:	00d5179b          	slliw	a5,a0,0xd
    800072f8:	0c201737          	lui	a4,0xc201
    800072fc:	00f707b3          	add	a5,a4,a5
    80007300:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80007304:	00813483          	ld	s1,8(sp)
    80007308:	02010113          	addi	sp,sp,32
    8000730c:	00008067          	ret

0000000080007310 <consolewrite>:
    80007310:	fb010113          	addi	sp,sp,-80
    80007314:	04813023          	sd	s0,64(sp)
    80007318:	04113423          	sd	ra,72(sp)
    8000731c:	02913c23          	sd	s1,56(sp)
    80007320:	03213823          	sd	s2,48(sp)
    80007324:	03313423          	sd	s3,40(sp)
    80007328:	03413023          	sd	s4,32(sp)
    8000732c:	01513c23          	sd	s5,24(sp)
    80007330:	05010413          	addi	s0,sp,80
    80007334:	06c05c63          	blez	a2,800073ac <consolewrite+0x9c>
    80007338:	00060993          	mv	s3,a2
    8000733c:	00050a13          	mv	s4,a0
    80007340:	00058493          	mv	s1,a1
    80007344:	00000913          	li	s2,0
    80007348:	fff00a93          	li	s5,-1
    8000734c:	01c0006f          	j	80007368 <consolewrite+0x58>
    80007350:	fbf44503          	lbu	a0,-65(s0)
    80007354:	0019091b          	addiw	s2,s2,1
    80007358:	00148493          	addi	s1,s1,1
    8000735c:	00001097          	auipc	ra,0x1
    80007360:	a9c080e7          	jalr	-1380(ra) # 80007df8 <uartputc>
    80007364:	03298063          	beq	s3,s2,80007384 <consolewrite+0x74>
    80007368:	00048613          	mv	a2,s1
    8000736c:	00100693          	li	a3,1
    80007370:	000a0593          	mv	a1,s4
    80007374:	fbf40513          	addi	a0,s0,-65
    80007378:	00000097          	auipc	ra,0x0
    8000737c:	9e0080e7          	jalr	-1568(ra) # 80006d58 <either_copyin>
    80007380:	fd5518e3          	bne	a0,s5,80007350 <consolewrite+0x40>
    80007384:	04813083          	ld	ra,72(sp)
    80007388:	04013403          	ld	s0,64(sp)
    8000738c:	03813483          	ld	s1,56(sp)
    80007390:	02813983          	ld	s3,40(sp)
    80007394:	02013a03          	ld	s4,32(sp)
    80007398:	01813a83          	ld	s5,24(sp)
    8000739c:	00090513          	mv	a0,s2
    800073a0:	03013903          	ld	s2,48(sp)
    800073a4:	05010113          	addi	sp,sp,80
    800073a8:	00008067          	ret
    800073ac:	00000913          	li	s2,0
    800073b0:	fd5ff06f          	j	80007384 <consolewrite+0x74>

00000000800073b4 <consoleread>:
    800073b4:	f9010113          	addi	sp,sp,-112
    800073b8:	06813023          	sd	s0,96(sp)
    800073bc:	04913c23          	sd	s1,88(sp)
    800073c0:	05213823          	sd	s2,80(sp)
    800073c4:	05313423          	sd	s3,72(sp)
    800073c8:	05413023          	sd	s4,64(sp)
    800073cc:	03513c23          	sd	s5,56(sp)
    800073d0:	03613823          	sd	s6,48(sp)
    800073d4:	03713423          	sd	s7,40(sp)
    800073d8:	03813023          	sd	s8,32(sp)
    800073dc:	06113423          	sd	ra,104(sp)
    800073e0:	01913c23          	sd	s9,24(sp)
    800073e4:	07010413          	addi	s0,sp,112
    800073e8:	00060b93          	mv	s7,a2
    800073ec:	00050913          	mv	s2,a0
    800073f0:	00058c13          	mv	s8,a1
    800073f4:	00060b1b          	sext.w	s6,a2
    800073f8:	00006497          	auipc	s1,0x6
    800073fc:	ce048493          	addi	s1,s1,-800 # 8000d0d8 <cons>
    80007400:	00400993          	li	s3,4
    80007404:	fff00a13          	li	s4,-1
    80007408:	00a00a93          	li	s5,10
    8000740c:	05705e63          	blez	s7,80007468 <consoleread+0xb4>
    80007410:	09c4a703          	lw	a4,156(s1)
    80007414:	0984a783          	lw	a5,152(s1)
    80007418:	0007071b          	sext.w	a4,a4
    8000741c:	08e78463          	beq	a5,a4,800074a4 <consoleread+0xf0>
    80007420:	07f7f713          	andi	a4,a5,127
    80007424:	00e48733          	add	a4,s1,a4
    80007428:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000742c:	0017869b          	addiw	a3,a5,1
    80007430:	08d4ac23          	sw	a3,152(s1)
    80007434:	00070c9b          	sext.w	s9,a4
    80007438:	0b370663          	beq	a4,s3,800074e4 <consoleread+0x130>
    8000743c:	00100693          	li	a3,1
    80007440:	f9f40613          	addi	a2,s0,-97
    80007444:	000c0593          	mv	a1,s8
    80007448:	00090513          	mv	a0,s2
    8000744c:	f8e40fa3          	sb	a4,-97(s0)
    80007450:	00000097          	auipc	ra,0x0
    80007454:	8bc080e7          	jalr	-1860(ra) # 80006d0c <either_copyout>
    80007458:	01450863          	beq	a0,s4,80007468 <consoleread+0xb4>
    8000745c:	001c0c13          	addi	s8,s8,1
    80007460:	fffb8b9b          	addiw	s7,s7,-1
    80007464:	fb5c94e3          	bne	s9,s5,8000740c <consoleread+0x58>
    80007468:	000b851b          	sext.w	a0,s7
    8000746c:	06813083          	ld	ra,104(sp)
    80007470:	06013403          	ld	s0,96(sp)
    80007474:	05813483          	ld	s1,88(sp)
    80007478:	05013903          	ld	s2,80(sp)
    8000747c:	04813983          	ld	s3,72(sp)
    80007480:	04013a03          	ld	s4,64(sp)
    80007484:	03813a83          	ld	s5,56(sp)
    80007488:	02813b83          	ld	s7,40(sp)
    8000748c:	02013c03          	ld	s8,32(sp)
    80007490:	01813c83          	ld	s9,24(sp)
    80007494:	40ab053b          	subw	a0,s6,a0
    80007498:	03013b03          	ld	s6,48(sp)
    8000749c:	07010113          	addi	sp,sp,112
    800074a0:	00008067          	ret
    800074a4:	00001097          	auipc	ra,0x1
    800074a8:	1d8080e7          	jalr	472(ra) # 8000867c <push_on>
    800074ac:	0984a703          	lw	a4,152(s1)
    800074b0:	09c4a783          	lw	a5,156(s1)
    800074b4:	0007879b          	sext.w	a5,a5
    800074b8:	fef70ce3          	beq	a4,a5,800074b0 <consoleread+0xfc>
    800074bc:	00001097          	auipc	ra,0x1
    800074c0:	234080e7          	jalr	564(ra) # 800086f0 <pop_on>
    800074c4:	0984a783          	lw	a5,152(s1)
    800074c8:	07f7f713          	andi	a4,a5,127
    800074cc:	00e48733          	add	a4,s1,a4
    800074d0:	01874703          	lbu	a4,24(a4)
    800074d4:	0017869b          	addiw	a3,a5,1
    800074d8:	08d4ac23          	sw	a3,152(s1)
    800074dc:	00070c9b          	sext.w	s9,a4
    800074e0:	f5371ee3          	bne	a4,s3,8000743c <consoleread+0x88>
    800074e4:	000b851b          	sext.w	a0,s7
    800074e8:	f96bf2e3          	bgeu	s7,s6,8000746c <consoleread+0xb8>
    800074ec:	08f4ac23          	sw	a5,152(s1)
    800074f0:	f7dff06f          	j	8000746c <consoleread+0xb8>

00000000800074f4 <consputc>:
    800074f4:	10000793          	li	a5,256
    800074f8:	00f50663          	beq	a0,a5,80007504 <consputc+0x10>
    800074fc:	00001317          	auipc	t1,0x1
    80007500:	9f430067          	jr	-1548(t1) # 80007ef0 <uartputc_sync>
    80007504:	ff010113          	addi	sp,sp,-16
    80007508:	00113423          	sd	ra,8(sp)
    8000750c:	00813023          	sd	s0,0(sp)
    80007510:	01010413          	addi	s0,sp,16
    80007514:	00800513          	li	a0,8
    80007518:	00001097          	auipc	ra,0x1
    8000751c:	9d8080e7          	jalr	-1576(ra) # 80007ef0 <uartputc_sync>
    80007520:	02000513          	li	a0,32
    80007524:	00001097          	auipc	ra,0x1
    80007528:	9cc080e7          	jalr	-1588(ra) # 80007ef0 <uartputc_sync>
    8000752c:	00013403          	ld	s0,0(sp)
    80007530:	00813083          	ld	ra,8(sp)
    80007534:	00800513          	li	a0,8
    80007538:	01010113          	addi	sp,sp,16
    8000753c:	00001317          	auipc	t1,0x1
    80007540:	9b430067          	jr	-1612(t1) # 80007ef0 <uartputc_sync>

0000000080007544 <consoleintr>:
    80007544:	fe010113          	addi	sp,sp,-32
    80007548:	00813823          	sd	s0,16(sp)
    8000754c:	00913423          	sd	s1,8(sp)
    80007550:	01213023          	sd	s2,0(sp)
    80007554:	00113c23          	sd	ra,24(sp)
    80007558:	02010413          	addi	s0,sp,32
    8000755c:	00006917          	auipc	s2,0x6
    80007560:	b7c90913          	addi	s2,s2,-1156 # 8000d0d8 <cons>
    80007564:	00050493          	mv	s1,a0
    80007568:	00090513          	mv	a0,s2
    8000756c:	00001097          	auipc	ra,0x1
    80007570:	e40080e7          	jalr	-448(ra) # 800083ac <acquire>
    80007574:	02048c63          	beqz	s1,800075ac <consoleintr+0x68>
    80007578:	0a092783          	lw	a5,160(s2)
    8000757c:	09892703          	lw	a4,152(s2)
    80007580:	07f00693          	li	a3,127
    80007584:	40e7873b          	subw	a4,a5,a4
    80007588:	02e6e263          	bltu	a3,a4,800075ac <consoleintr+0x68>
    8000758c:	00d00713          	li	a4,13
    80007590:	04e48063          	beq	s1,a4,800075d0 <consoleintr+0x8c>
    80007594:	07f7f713          	andi	a4,a5,127
    80007598:	00e90733          	add	a4,s2,a4
    8000759c:	0017879b          	addiw	a5,a5,1
    800075a0:	0af92023          	sw	a5,160(s2)
    800075a4:	00970c23          	sb	s1,24(a4)
    800075a8:	08f92e23          	sw	a5,156(s2)
    800075ac:	01013403          	ld	s0,16(sp)
    800075b0:	01813083          	ld	ra,24(sp)
    800075b4:	00813483          	ld	s1,8(sp)
    800075b8:	00013903          	ld	s2,0(sp)
    800075bc:	00006517          	auipc	a0,0x6
    800075c0:	b1c50513          	addi	a0,a0,-1252 # 8000d0d8 <cons>
    800075c4:	02010113          	addi	sp,sp,32
    800075c8:	00001317          	auipc	t1,0x1
    800075cc:	eb030067          	jr	-336(t1) # 80008478 <release>
    800075d0:	00a00493          	li	s1,10
    800075d4:	fc1ff06f          	j	80007594 <consoleintr+0x50>

00000000800075d8 <consoleinit>:
    800075d8:	fe010113          	addi	sp,sp,-32
    800075dc:	00113c23          	sd	ra,24(sp)
    800075e0:	00813823          	sd	s0,16(sp)
    800075e4:	00913423          	sd	s1,8(sp)
    800075e8:	02010413          	addi	s0,sp,32
    800075ec:	00006497          	auipc	s1,0x6
    800075f0:	aec48493          	addi	s1,s1,-1300 # 8000d0d8 <cons>
    800075f4:	00048513          	mv	a0,s1
    800075f8:	00002597          	auipc	a1,0x2
    800075fc:	0e058593          	addi	a1,a1,224 # 800096d8 <CONSOLE_STATUS+0x6c8>
    80007600:	00001097          	auipc	ra,0x1
    80007604:	d88080e7          	jalr	-632(ra) # 80008388 <initlock>
    80007608:	00000097          	auipc	ra,0x0
    8000760c:	7ac080e7          	jalr	1964(ra) # 80007db4 <uartinit>
    80007610:	01813083          	ld	ra,24(sp)
    80007614:	01013403          	ld	s0,16(sp)
    80007618:	00000797          	auipc	a5,0x0
    8000761c:	d9c78793          	addi	a5,a5,-612 # 800073b4 <consoleread>
    80007620:	0af4bc23          	sd	a5,184(s1)
    80007624:	00000797          	auipc	a5,0x0
    80007628:	cec78793          	addi	a5,a5,-788 # 80007310 <consolewrite>
    8000762c:	0cf4b023          	sd	a5,192(s1)
    80007630:	00813483          	ld	s1,8(sp)
    80007634:	02010113          	addi	sp,sp,32
    80007638:	00008067          	ret

000000008000763c <console_read>:
    8000763c:	ff010113          	addi	sp,sp,-16
    80007640:	00813423          	sd	s0,8(sp)
    80007644:	01010413          	addi	s0,sp,16
    80007648:	00813403          	ld	s0,8(sp)
    8000764c:	00006317          	auipc	t1,0x6
    80007650:	b4433303          	ld	t1,-1212(t1) # 8000d190 <devsw+0x10>
    80007654:	01010113          	addi	sp,sp,16
    80007658:	00030067          	jr	t1

000000008000765c <console_write>:
    8000765c:	ff010113          	addi	sp,sp,-16
    80007660:	00813423          	sd	s0,8(sp)
    80007664:	01010413          	addi	s0,sp,16
    80007668:	00813403          	ld	s0,8(sp)
    8000766c:	00006317          	auipc	t1,0x6
    80007670:	b2c33303          	ld	t1,-1236(t1) # 8000d198 <devsw+0x18>
    80007674:	01010113          	addi	sp,sp,16
    80007678:	00030067          	jr	t1

000000008000767c <panic>:
    8000767c:	fe010113          	addi	sp,sp,-32
    80007680:	00113c23          	sd	ra,24(sp)
    80007684:	00813823          	sd	s0,16(sp)
    80007688:	00913423          	sd	s1,8(sp)
    8000768c:	02010413          	addi	s0,sp,32
    80007690:	00050493          	mv	s1,a0
    80007694:	00002517          	auipc	a0,0x2
    80007698:	04c50513          	addi	a0,a0,76 # 800096e0 <CONSOLE_STATUS+0x6d0>
    8000769c:	00006797          	auipc	a5,0x6
    800076a0:	b807ae23          	sw	zero,-1124(a5) # 8000d238 <pr+0x18>
    800076a4:	00000097          	auipc	ra,0x0
    800076a8:	034080e7          	jalr	52(ra) # 800076d8 <__printf>
    800076ac:	00048513          	mv	a0,s1
    800076b0:	00000097          	auipc	ra,0x0
    800076b4:	028080e7          	jalr	40(ra) # 800076d8 <__printf>
    800076b8:	00002517          	auipc	a0,0x2
    800076bc:	db050513          	addi	a0,a0,-592 # 80009468 <CONSOLE_STATUS+0x458>
    800076c0:	00000097          	auipc	ra,0x0
    800076c4:	018080e7          	jalr	24(ra) # 800076d8 <__printf>
    800076c8:	00100793          	li	a5,1
    800076cc:	00005717          	auipc	a4,0x5
    800076d0:	82f72623          	sw	a5,-2004(a4) # 8000bef8 <panicked>
    800076d4:	0000006f          	j	800076d4 <panic+0x58>

00000000800076d8 <__printf>:
    800076d8:	f3010113          	addi	sp,sp,-208
    800076dc:	08813023          	sd	s0,128(sp)
    800076e0:	07313423          	sd	s3,104(sp)
    800076e4:	09010413          	addi	s0,sp,144
    800076e8:	05813023          	sd	s8,64(sp)
    800076ec:	08113423          	sd	ra,136(sp)
    800076f0:	06913c23          	sd	s1,120(sp)
    800076f4:	07213823          	sd	s2,112(sp)
    800076f8:	07413023          	sd	s4,96(sp)
    800076fc:	05513c23          	sd	s5,88(sp)
    80007700:	05613823          	sd	s6,80(sp)
    80007704:	05713423          	sd	s7,72(sp)
    80007708:	03913c23          	sd	s9,56(sp)
    8000770c:	03a13823          	sd	s10,48(sp)
    80007710:	03b13423          	sd	s11,40(sp)
    80007714:	00006317          	auipc	t1,0x6
    80007718:	b0c30313          	addi	t1,t1,-1268 # 8000d220 <pr>
    8000771c:	01832c03          	lw	s8,24(t1)
    80007720:	00b43423          	sd	a1,8(s0)
    80007724:	00c43823          	sd	a2,16(s0)
    80007728:	00d43c23          	sd	a3,24(s0)
    8000772c:	02e43023          	sd	a4,32(s0)
    80007730:	02f43423          	sd	a5,40(s0)
    80007734:	03043823          	sd	a6,48(s0)
    80007738:	03143c23          	sd	a7,56(s0)
    8000773c:	00050993          	mv	s3,a0
    80007740:	4a0c1663          	bnez	s8,80007bec <__printf+0x514>
    80007744:	60098c63          	beqz	s3,80007d5c <__printf+0x684>
    80007748:	0009c503          	lbu	a0,0(s3)
    8000774c:	00840793          	addi	a5,s0,8
    80007750:	f6f43c23          	sd	a5,-136(s0)
    80007754:	00000493          	li	s1,0
    80007758:	22050063          	beqz	a0,80007978 <__printf+0x2a0>
    8000775c:	00002a37          	lui	s4,0x2
    80007760:	00018ab7          	lui	s5,0x18
    80007764:	000f4b37          	lui	s6,0xf4
    80007768:	00989bb7          	lui	s7,0x989
    8000776c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007770:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007774:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007778:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000777c:	00148c9b          	addiw	s9,s1,1
    80007780:	02500793          	li	a5,37
    80007784:	01998933          	add	s2,s3,s9
    80007788:	38f51263          	bne	a0,a5,80007b0c <__printf+0x434>
    8000778c:	00094783          	lbu	a5,0(s2)
    80007790:	00078c9b          	sext.w	s9,a5
    80007794:	1e078263          	beqz	a5,80007978 <__printf+0x2a0>
    80007798:	0024849b          	addiw	s1,s1,2
    8000779c:	07000713          	li	a4,112
    800077a0:	00998933          	add	s2,s3,s1
    800077a4:	38e78a63          	beq	a5,a4,80007b38 <__printf+0x460>
    800077a8:	20f76863          	bltu	a4,a5,800079b8 <__printf+0x2e0>
    800077ac:	42a78863          	beq	a5,a0,80007bdc <__printf+0x504>
    800077b0:	06400713          	li	a4,100
    800077b4:	40e79663          	bne	a5,a4,80007bc0 <__printf+0x4e8>
    800077b8:	f7843783          	ld	a5,-136(s0)
    800077bc:	0007a603          	lw	a2,0(a5)
    800077c0:	00878793          	addi	a5,a5,8
    800077c4:	f6f43c23          	sd	a5,-136(s0)
    800077c8:	42064a63          	bltz	a2,80007bfc <__printf+0x524>
    800077cc:	00a00713          	li	a4,10
    800077d0:	02e677bb          	remuw	a5,a2,a4
    800077d4:	00002d97          	auipc	s11,0x2
    800077d8:	f34d8d93          	addi	s11,s11,-204 # 80009708 <digits>
    800077dc:	00900593          	li	a1,9
    800077e0:	0006051b          	sext.w	a0,a2
    800077e4:	00000c93          	li	s9,0
    800077e8:	02079793          	slli	a5,a5,0x20
    800077ec:	0207d793          	srli	a5,a5,0x20
    800077f0:	00fd87b3          	add	a5,s11,a5
    800077f4:	0007c783          	lbu	a5,0(a5)
    800077f8:	02e656bb          	divuw	a3,a2,a4
    800077fc:	f8f40023          	sb	a5,-128(s0)
    80007800:	14c5d863          	bge	a1,a2,80007950 <__printf+0x278>
    80007804:	06300593          	li	a1,99
    80007808:	00100c93          	li	s9,1
    8000780c:	02e6f7bb          	remuw	a5,a3,a4
    80007810:	02079793          	slli	a5,a5,0x20
    80007814:	0207d793          	srli	a5,a5,0x20
    80007818:	00fd87b3          	add	a5,s11,a5
    8000781c:	0007c783          	lbu	a5,0(a5)
    80007820:	02e6d73b          	divuw	a4,a3,a4
    80007824:	f8f400a3          	sb	a5,-127(s0)
    80007828:	12a5f463          	bgeu	a1,a0,80007950 <__printf+0x278>
    8000782c:	00a00693          	li	a3,10
    80007830:	00900593          	li	a1,9
    80007834:	02d777bb          	remuw	a5,a4,a3
    80007838:	02079793          	slli	a5,a5,0x20
    8000783c:	0207d793          	srli	a5,a5,0x20
    80007840:	00fd87b3          	add	a5,s11,a5
    80007844:	0007c503          	lbu	a0,0(a5)
    80007848:	02d757bb          	divuw	a5,a4,a3
    8000784c:	f8a40123          	sb	a0,-126(s0)
    80007850:	48e5f263          	bgeu	a1,a4,80007cd4 <__printf+0x5fc>
    80007854:	06300513          	li	a0,99
    80007858:	02d7f5bb          	remuw	a1,a5,a3
    8000785c:	02059593          	slli	a1,a1,0x20
    80007860:	0205d593          	srli	a1,a1,0x20
    80007864:	00bd85b3          	add	a1,s11,a1
    80007868:	0005c583          	lbu	a1,0(a1)
    8000786c:	02d7d7bb          	divuw	a5,a5,a3
    80007870:	f8b401a3          	sb	a1,-125(s0)
    80007874:	48e57263          	bgeu	a0,a4,80007cf8 <__printf+0x620>
    80007878:	3e700513          	li	a0,999
    8000787c:	02d7f5bb          	remuw	a1,a5,a3
    80007880:	02059593          	slli	a1,a1,0x20
    80007884:	0205d593          	srli	a1,a1,0x20
    80007888:	00bd85b3          	add	a1,s11,a1
    8000788c:	0005c583          	lbu	a1,0(a1)
    80007890:	02d7d7bb          	divuw	a5,a5,a3
    80007894:	f8b40223          	sb	a1,-124(s0)
    80007898:	46e57663          	bgeu	a0,a4,80007d04 <__printf+0x62c>
    8000789c:	02d7f5bb          	remuw	a1,a5,a3
    800078a0:	02059593          	slli	a1,a1,0x20
    800078a4:	0205d593          	srli	a1,a1,0x20
    800078a8:	00bd85b3          	add	a1,s11,a1
    800078ac:	0005c583          	lbu	a1,0(a1)
    800078b0:	02d7d7bb          	divuw	a5,a5,a3
    800078b4:	f8b402a3          	sb	a1,-123(s0)
    800078b8:	46ea7863          	bgeu	s4,a4,80007d28 <__printf+0x650>
    800078bc:	02d7f5bb          	remuw	a1,a5,a3
    800078c0:	02059593          	slli	a1,a1,0x20
    800078c4:	0205d593          	srli	a1,a1,0x20
    800078c8:	00bd85b3          	add	a1,s11,a1
    800078cc:	0005c583          	lbu	a1,0(a1)
    800078d0:	02d7d7bb          	divuw	a5,a5,a3
    800078d4:	f8b40323          	sb	a1,-122(s0)
    800078d8:	3eeaf863          	bgeu	s5,a4,80007cc8 <__printf+0x5f0>
    800078dc:	02d7f5bb          	remuw	a1,a5,a3
    800078e0:	02059593          	slli	a1,a1,0x20
    800078e4:	0205d593          	srli	a1,a1,0x20
    800078e8:	00bd85b3          	add	a1,s11,a1
    800078ec:	0005c583          	lbu	a1,0(a1)
    800078f0:	02d7d7bb          	divuw	a5,a5,a3
    800078f4:	f8b403a3          	sb	a1,-121(s0)
    800078f8:	42eb7e63          	bgeu	s6,a4,80007d34 <__printf+0x65c>
    800078fc:	02d7f5bb          	remuw	a1,a5,a3
    80007900:	02059593          	slli	a1,a1,0x20
    80007904:	0205d593          	srli	a1,a1,0x20
    80007908:	00bd85b3          	add	a1,s11,a1
    8000790c:	0005c583          	lbu	a1,0(a1)
    80007910:	02d7d7bb          	divuw	a5,a5,a3
    80007914:	f8b40423          	sb	a1,-120(s0)
    80007918:	42ebfc63          	bgeu	s7,a4,80007d50 <__printf+0x678>
    8000791c:	02079793          	slli	a5,a5,0x20
    80007920:	0207d793          	srli	a5,a5,0x20
    80007924:	00fd8db3          	add	s11,s11,a5
    80007928:	000dc703          	lbu	a4,0(s11)
    8000792c:	00a00793          	li	a5,10
    80007930:	00900c93          	li	s9,9
    80007934:	f8e404a3          	sb	a4,-119(s0)
    80007938:	00065c63          	bgez	a2,80007950 <__printf+0x278>
    8000793c:	f9040713          	addi	a4,s0,-112
    80007940:	00f70733          	add	a4,a4,a5
    80007944:	02d00693          	li	a3,45
    80007948:	fed70823          	sb	a3,-16(a4)
    8000794c:	00078c93          	mv	s9,a5
    80007950:	f8040793          	addi	a5,s0,-128
    80007954:	01978cb3          	add	s9,a5,s9
    80007958:	f7f40d13          	addi	s10,s0,-129
    8000795c:	000cc503          	lbu	a0,0(s9)
    80007960:	fffc8c93          	addi	s9,s9,-1
    80007964:	00000097          	auipc	ra,0x0
    80007968:	b90080e7          	jalr	-1136(ra) # 800074f4 <consputc>
    8000796c:	ffac98e3          	bne	s9,s10,8000795c <__printf+0x284>
    80007970:	00094503          	lbu	a0,0(s2)
    80007974:	e00514e3          	bnez	a0,8000777c <__printf+0xa4>
    80007978:	1a0c1663          	bnez	s8,80007b24 <__printf+0x44c>
    8000797c:	08813083          	ld	ra,136(sp)
    80007980:	08013403          	ld	s0,128(sp)
    80007984:	07813483          	ld	s1,120(sp)
    80007988:	07013903          	ld	s2,112(sp)
    8000798c:	06813983          	ld	s3,104(sp)
    80007990:	06013a03          	ld	s4,96(sp)
    80007994:	05813a83          	ld	s5,88(sp)
    80007998:	05013b03          	ld	s6,80(sp)
    8000799c:	04813b83          	ld	s7,72(sp)
    800079a0:	04013c03          	ld	s8,64(sp)
    800079a4:	03813c83          	ld	s9,56(sp)
    800079a8:	03013d03          	ld	s10,48(sp)
    800079ac:	02813d83          	ld	s11,40(sp)
    800079b0:	0d010113          	addi	sp,sp,208
    800079b4:	00008067          	ret
    800079b8:	07300713          	li	a4,115
    800079bc:	1ce78a63          	beq	a5,a4,80007b90 <__printf+0x4b8>
    800079c0:	07800713          	li	a4,120
    800079c4:	1ee79e63          	bne	a5,a4,80007bc0 <__printf+0x4e8>
    800079c8:	f7843783          	ld	a5,-136(s0)
    800079cc:	0007a703          	lw	a4,0(a5)
    800079d0:	00878793          	addi	a5,a5,8
    800079d4:	f6f43c23          	sd	a5,-136(s0)
    800079d8:	28074263          	bltz	a4,80007c5c <__printf+0x584>
    800079dc:	00002d97          	auipc	s11,0x2
    800079e0:	d2cd8d93          	addi	s11,s11,-724 # 80009708 <digits>
    800079e4:	00f77793          	andi	a5,a4,15
    800079e8:	00fd87b3          	add	a5,s11,a5
    800079ec:	0007c683          	lbu	a3,0(a5)
    800079f0:	00f00613          	li	a2,15
    800079f4:	0007079b          	sext.w	a5,a4
    800079f8:	f8d40023          	sb	a3,-128(s0)
    800079fc:	0047559b          	srliw	a1,a4,0x4
    80007a00:	0047569b          	srliw	a3,a4,0x4
    80007a04:	00000c93          	li	s9,0
    80007a08:	0ee65063          	bge	a2,a4,80007ae8 <__printf+0x410>
    80007a0c:	00f6f693          	andi	a3,a3,15
    80007a10:	00dd86b3          	add	a3,s11,a3
    80007a14:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007a18:	0087d79b          	srliw	a5,a5,0x8
    80007a1c:	00100c93          	li	s9,1
    80007a20:	f8d400a3          	sb	a3,-127(s0)
    80007a24:	0cb67263          	bgeu	a2,a1,80007ae8 <__printf+0x410>
    80007a28:	00f7f693          	andi	a3,a5,15
    80007a2c:	00dd86b3          	add	a3,s11,a3
    80007a30:	0006c583          	lbu	a1,0(a3)
    80007a34:	00f00613          	li	a2,15
    80007a38:	0047d69b          	srliw	a3,a5,0x4
    80007a3c:	f8b40123          	sb	a1,-126(s0)
    80007a40:	0047d593          	srli	a1,a5,0x4
    80007a44:	28f67e63          	bgeu	a2,a5,80007ce0 <__printf+0x608>
    80007a48:	00f6f693          	andi	a3,a3,15
    80007a4c:	00dd86b3          	add	a3,s11,a3
    80007a50:	0006c503          	lbu	a0,0(a3)
    80007a54:	0087d813          	srli	a6,a5,0x8
    80007a58:	0087d69b          	srliw	a3,a5,0x8
    80007a5c:	f8a401a3          	sb	a0,-125(s0)
    80007a60:	28b67663          	bgeu	a2,a1,80007cec <__printf+0x614>
    80007a64:	00f6f693          	andi	a3,a3,15
    80007a68:	00dd86b3          	add	a3,s11,a3
    80007a6c:	0006c583          	lbu	a1,0(a3)
    80007a70:	00c7d513          	srli	a0,a5,0xc
    80007a74:	00c7d69b          	srliw	a3,a5,0xc
    80007a78:	f8b40223          	sb	a1,-124(s0)
    80007a7c:	29067a63          	bgeu	a2,a6,80007d10 <__printf+0x638>
    80007a80:	00f6f693          	andi	a3,a3,15
    80007a84:	00dd86b3          	add	a3,s11,a3
    80007a88:	0006c583          	lbu	a1,0(a3)
    80007a8c:	0107d813          	srli	a6,a5,0x10
    80007a90:	0107d69b          	srliw	a3,a5,0x10
    80007a94:	f8b402a3          	sb	a1,-123(s0)
    80007a98:	28a67263          	bgeu	a2,a0,80007d1c <__printf+0x644>
    80007a9c:	00f6f693          	andi	a3,a3,15
    80007aa0:	00dd86b3          	add	a3,s11,a3
    80007aa4:	0006c683          	lbu	a3,0(a3)
    80007aa8:	0147d79b          	srliw	a5,a5,0x14
    80007aac:	f8d40323          	sb	a3,-122(s0)
    80007ab0:	21067663          	bgeu	a2,a6,80007cbc <__printf+0x5e4>
    80007ab4:	02079793          	slli	a5,a5,0x20
    80007ab8:	0207d793          	srli	a5,a5,0x20
    80007abc:	00fd8db3          	add	s11,s11,a5
    80007ac0:	000dc683          	lbu	a3,0(s11)
    80007ac4:	00800793          	li	a5,8
    80007ac8:	00700c93          	li	s9,7
    80007acc:	f8d403a3          	sb	a3,-121(s0)
    80007ad0:	00075c63          	bgez	a4,80007ae8 <__printf+0x410>
    80007ad4:	f9040713          	addi	a4,s0,-112
    80007ad8:	00f70733          	add	a4,a4,a5
    80007adc:	02d00693          	li	a3,45
    80007ae0:	fed70823          	sb	a3,-16(a4)
    80007ae4:	00078c93          	mv	s9,a5
    80007ae8:	f8040793          	addi	a5,s0,-128
    80007aec:	01978cb3          	add	s9,a5,s9
    80007af0:	f7f40d13          	addi	s10,s0,-129
    80007af4:	000cc503          	lbu	a0,0(s9)
    80007af8:	fffc8c93          	addi	s9,s9,-1
    80007afc:	00000097          	auipc	ra,0x0
    80007b00:	9f8080e7          	jalr	-1544(ra) # 800074f4 <consputc>
    80007b04:	ff9d18e3          	bne	s10,s9,80007af4 <__printf+0x41c>
    80007b08:	0100006f          	j	80007b18 <__printf+0x440>
    80007b0c:	00000097          	auipc	ra,0x0
    80007b10:	9e8080e7          	jalr	-1560(ra) # 800074f4 <consputc>
    80007b14:	000c8493          	mv	s1,s9
    80007b18:	00094503          	lbu	a0,0(s2)
    80007b1c:	c60510e3          	bnez	a0,8000777c <__printf+0xa4>
    80007b20:	e40c0ee3          	beqz	s8,8000797c <__printf+0x2a4>
    80007b24:	00005517          	auipc	a0,0x5
    80007b28:	6fc50513          	addi	a0,a0,1788 # 8000d220 <pr>
    80007b2c:	00001097          	auipc	ra,0x1
    80007b30:	94c080e7          	jalr	-1716(ra) # 80008478 <release>
    80007b34:	e49ff06f          	j	8000797c <__printf+0x2a4>
    80007b38:	f7843783          	ld	a5,-136(s0)
    80007b3c:	03000513          	li	a0,48
    80007b40:	01000d13          	li	s10,16
    80007b44:	00878713          	addi	a4,a5,8
    80007b48:	0007bc83          	ld	s9,0(a5)
    80007b4c:	f6e43c23          	sd	a4,-136(s0)
    80007b50:	00000097          	auipc	ra,0x0
    80007b54:	9a4080e7          	jalr	-1628(ra) # 800074f4 <consputc>
    80007b58:	07800513          	li	a0,120
    80007b5c:	00000097          	auipc	ra,0x0
    80007b60:	998080e7          	jalr	-1640(ra) # 800074f4 <consputc>
    80007b64:	00002d97          	auipc	s11,0x2
    80007b68:	ba4d8d93          	addi	s11,s11,-1116 # 80009708 <digits>
    80007b6c:	03ccd793          	srli	a5,s9,0x3c
    80007b70:	00fd87b3          	add	a5,s11,a5
    80007b74:	0007c503          	lbu	a0,0(a5)
    80007b78:	fffd0d1b          	addiw	s10,s10,-1
    80007b7c:	004c9c93          	slli	s9,s9,0x4
    80007b80:	00000097          	auipc	ra,0x0
    80007b84:	974080e7          	jalr	-1676(ra) # 800074f4 <consputc>
    80007b88:	fe0d12e3          	bnez	s10,80007b6c <__printf+0x494>
    80007b8c:	f8dff06f          	j	80007b18 <__printf+0x440>
    80007b90:	f7843783          	ld	a5,-136(s0)
    80007b94:	0007bc83          	ld	s9,0(a5)
    80007b98:	00878793          	addi	a5,a5,8
    80007b9c:	f6f43c23          	sd	a5,-136(s0)
    80007ba0:	000c9a63          	bnez	s9,80007bb4 <__printf+0x4dc>
    80007ba4:	1080006f          	j	80007cac <__printf+0x5d4>
    80007ba8:	001c8c93          	addi	s9,s9,1
    80007bac:	00000097          	auipc	ra,0x0
    80007bb0:	948080e7          	jalr	-1720(ra) # 800074f4 <consputc>
    80007bb4:	000cc503          	lbu	a0,0(s9)
    80007bb8:	fe0518e3          	bnez	a0,80007ba8 <__printf+0x4d0>
    80007bbc:	f5dff06f          	j	80007b18 <__printf+0x440>
    80007bc0:	02500513          	li	a0,37
    80007bc4:	00000097          	auipc	ra,0x0
    80007bc8:	930080e7          	jalr	-1744(ra) # 800074f4 <consputc>
    80007bcc:	000c8513          	mv	a0,s9
    80007bd0:	00000097          	auipc	ra,0x0
    80007bd4:	924080e7          	jalr	-1756(ra) # 800074f4 <consputc>
    80007bd8:	f41ff06f          	j	80007b18 <__printf+0x440>
    80007bdc:	02500513          	li	a0,37
    80007be0:	00000097          	auipc	ra,0x0
    80007be4:	914080e7          	jalr	-1772(ra) # 800074f4 <consputc>
    80007be8:	f31ff06f          	j	80007b18 <__printf+0x440>
    80007bec:	00030513          	mv	a0,t1
    80007bf0:	00000097          	auipc	ra,0x0
    80007bf4:	7bc080e7          	jalr	1980(ra) # 800083ac <acquire>
    80007bf8:	b4dff06f          	j	80007744 <__printf+0x6c>
    80007bfc:	40c0053b          	negw	a0,a2
    80007c00:	00a00713          	li	a4,10
    80007c04:	02e576bb          	remuw	a3,a0,a4
    80007c08:	00002d97          	auipc	s11,0x2
    80007c0c:	b00d8d93          	addi	s11,s11,-1280 # 80009708 <digits>
    80007c10:	ff700593          	li	a1,-9
    80007c14:	02069693          	slli	a3,a3,0x20
    80007c18:	0206d693          	srli	a3,a3,0x20
    80007c1c:	00dd86b3          	add	a3,s11,a3
    80007c20:	0006c683          	lbu	a3,0(a3)
    80007c24:	02e557bb          	divuw	a5,a0,a4
    80007c28:	f8d40023          	sb	a3,-128(s0)
    80007c2c:	10b65e63          	bge	a2,a1,80007d48 <__printf+0x670>
    80007c30:	06300593          	li	a1,99
    80007c34:	02e7f6bb          	remuw	a3,a5,a4
    80007c38:	02069693          	slli	a3,a3,0x20
    80007c3c:	0206d693          	srli	a3,a3,0x20
    80007c40:	00dd86b3          	add	a3,s11,a3
    80007c44:	0006c683          	lbu	a3,0(a3)
    80007c48:	02e7d73b          	divuw	a4,a5,a4
    80007c4c:	00200793          	li	a5,2
    80007c50:	f8d400a3          	sb	a3,-127(s0)
    80007c54:	bca5ece3          	bltu	a1,a0,8000782c <__printf+0x154>
    80007c58:	ce5ff06f          	j	8000793c <__printf+0x264>
    80007c5c:	40e007bb          	negw	a5,a4
    80007c60:	00002d97          	auipc	s11,0x2
    80007c64:	aa8d8d93          	addi	s11,s11,-1368 # 80009708 <digits>
    80007c68:	00f7f693          	andi	a3,a5,15
    80007c6c:	00dd86b3          	add	a3,s11,a3
    80007c70:	0006c583          	lbu	a1,0(a3)
    80007c74:	ff100613          	li	a2,-15
    80007c78:	0047d69b          	srliw	a3,a5,0x4
    80007c7c:	f8b40023          	sb	a1,-128(s0)
    80007c80:	0047d59b          	srliw	a1,a5,0x4
    80007c84:	0ac75e63          	bge	a4,a2,80007d40 <__printf+0x668>
    80007c88:	00f6f693          	andi	a3,a3,15
    80007c8c:	00dd86b3          	add	a3,s11,a3
    80007c90:	0006c603          	lbu	a2,0(a3)
    80007c94:	00f00693          	li	a3,15
    80007c98:	0087d79b          	srliw	a5,a5,0x8
    80007c9c:	f8c400a3          	sb	a2,-127(s0)
    80007ca0:	d8b6e4e3          	bltu	a3,a1,80007a28 <__printf+0x350>
    80007ca4:	00200793          	li	a5,2
    80007ca8:	e2dff06f          	j	80007ad4 <__printf+0x3fc>
    80007cac:	00002c97          	auipc	s9,0x2
    80007cb0:	a3cc8c93          	addi	s9,s9,-1476 # 800096e8 <CONSOLE_STATUS+0x6d8>
    80007cb4:	02800513          	li	a0,40
    80007cb8:	ef1ff06f          	j	80007ba8 <__printf+0x4d0>
    80007cbc:	00700793          	li	a5,7
    80007cc0:	00600c93          	li	s9,6
    80007cc4:	e0dff06f          	j	80007ad0 <__printf+0x3f8>
    80007cc8:	00700793          	li	a5,7
    80007ccc:	00600c93          	li	s9,6
    80007cd0:	c69ff06f          	j	80007938 <__printf+0x260>
    80007cd4:	00300793          	li	a5,3
    80007cd8:	00200c93          	li	s9,2
    80007cdc:	c5dff06f          	j	80007938 <__printf+0x260>
    80007ce0:	00300793          	li	a5,3
    80007ce4:	00200c93          	li	s9,2
    80007ce8:	de9ff06f          	j	80007ad0 <__printf+0x3f8>
    80007cec:	00400793          	li	a5,4
    80007cf0:	00300c93          	li	s9,3
    80007cf4:	dddff06f          	j	80007ad0 <__printf+0x3f8>
    80007cf8:	00400793          	li	a5,4
    80007cfc:	00300c93          	li	s9,3
    80007d00:	c39ff06f          	j	80007938 <__printf+0x260>
    80007d04:	00500793          	li	a5,5
    80007d08:	00400c93          	li	s9,4
    80007d0c:	c2dff06f          	j	80007938 <__printf+0x260>
    80007d10:	00500793          	li	a5,5
    80007d14:	00400c93          	li	s9,4
    80007d18:	db9ff06f          	j	80007ad0 <__printf+0x3f8>
    80007d1c:	00600793          	li	a5,6
    80007d20:	00500c93          	li	s9,5
    80007d24:	dadff06f          	j	80007ad0 <__printf+0x3f8>
    80007d28:	00600793          	li	a5,6
    80007d2c:	00500c93          	li	s9,5
    80007d30:	c09ff06f          	j	80007938 <__printf+0x260>
    80007d34:	00800793          	li	a5,8
    80007d38:	00700c93          	li	s9,7
    80007d3c:	bfdff06f          	j	80007938 <__printf+0x260>
    80007d40:	00100793          	li	a5,1
    80007d44:	d91ff06f          	j	80007ad4 <__printf+0x3fc>
    80007d48:	00100793          	li	a5,1
    80007d4c:	bf1ff06f          	j	8000793c <__printf+0x264>
    80007d50:	00900793          	li	a5,9
    80007d54:	00800c93          	li	s9,8
    80007d58:	be1ff06f          	j	80007938 <__printf+0x260>
    80007d5c:	00002517          	auipc	a0,0x2
    80007d60:	99450513          	addi	a0,a0,-1644 # 800096f0 <CONSOLE_STATUS+0x6e0>
    80007d64:	00000097          	auipc	ra,0x0
    80007d68:	918080e7          	jalr	-1768(ra) # 8000767c <panic>

0000000080007d6c <printfinit>:
    80007d6c:	fe010113          	addi	sp,sp,-32
    80007d70:	00813823          	sd	s0,16(sp)
    80007d74:	00913423          	sd	s1,8(sp)
    80007d78:	00113c23          	sd	ra,24(sp)
    80007d7c:	02010413          	addi	s0,sp,32
    80007d80:	00005497          	auipc	s1,0x5
    80007d84:	4a048493          	addi	s1,s1,1184 # 8000d220 <pr>
    80007d88:	00048513          	mv	a0,s1
    80007d8c:	00002597          	auipc	a1,0x2
    80007d90:	97458593          	addi	a1,a1,-1676 # 80009700 <CONSOLE_STATUS+0x6f0>
    80007d94:	00000097          	auipc	ra,0x0
    80007d98:	5f4080e7          	jalr	1524(ra) # 80008388 <initlock>
    80007d9c:	01813083          	ld	ra,24(sp)
    80007da0:	01013403          	ld	s0,16(sp)
    80007da4:	0004ac23          	sw	zero,24(s1)
    80007da8:	00813483          	ld	s1,8(sp)
    80007dac:	02010113          	addi	sp,sp,32
    80007db0:	00008067          	ret

0000000080007db4 <uartinit>:
    80007db4:	ff010113          	addi	sp,sp,-16
    80007db8:	00813423          	sd	s0,8(sp)
    80007dbc:	01010413          	addi	s0,sp,16
    80007dc0:	100007b7          	lui	a5,0x10000
    80007dc4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80007dc8:	f8000713          	li	a4,-128
    80007dcc:	00e781a3          	sb	a4,3(a5)
    80007dd0:	00300713          	li	a4,3
    80007dd4:	00e78023          	sb	a4,0(a5)
    80007dd8:	000780a3          	sb	zero,1(a5)
    80007ddc:	00e781a3          	sb	a4,3(a5)
    80007de0:	00700693          	li	a3,7
    80007de4:	00d78123          	sb	a3,2(a5)
    80007de8:	00e780a3          	sb	a4,1(a5)
    80007dec:	00813403          	ld	s0,8(sp)
    80007df0:	01010113          	addi	sp,sp,16
    80007df4:	00008067          	ret

0000000080007df8 <uartputc>:
    80007df8:	00004797          	auipc	a5,0x4
    80007dfc:	1007a783          	lw	a5,256(a5) # 8000bef8 <panicked>
    80007e00:	00078463          	beqz	a5,80007e08 <uartputc+0x10>
    80007e04:	0000006f          	j	80007e04 <uartputc+0xc>
    80007e08:	fd010113          	addi	sp,sp,-48
    80007e0c:	02813023          	sd	s0,32(sp)
    80007e10:	00913c23          	sd	s1,24(sp)
    80007e14:	01213823          	sd	s2,16(sp)
    80007e18:	01313423          	sd	s3,8(sp)
    80007e1c:	02113423          	sd	ra,40(sp)
    80007e20:	03010413          	addi	s0,sp,48
    80007e24:	00004917          	auipc	s2,0x4
    80007e28:	0dc90913          	addi	s2,s2,220 # 8000bf00 <uart_tx_r>
    80007e2c:	00093783          	ld	a5,0(s2)
    80007e30:	00004497          	auipc	s1,0x4
    80007e34:	0d848493          	addi	s1,s1,216 # 8000bf08 <uart_tx_w>
    80007e38:	0004b703          	ld	a4,0(s1)
    80007e3c:	02078693          	addi	a3,a5,32
    80007e40:	00050993          	mv	s3,a0
    80007e44:	02e69c63          	bne	a3,a4,80007e7c <uartputc+0x84>
    80007e48:	00001097          	auipc	ra,0x1
    80007e4c:	834080e7          	jalr	-1996(ra) # 8000867c <push_on>
    80007e50:	00093783          	ld	a5,0(s2)
    80007e54:	0004b703          	ld	a4,0(s1)
    80007e58:	02078793          	addi	a5,a5,32
    80007e5c:	00e79463          	bne	a5,a4,80007e64 <uartputc+0x6c>
    80007e60:	0000006f          	j	80007e60 <uartputc+0x68>
    80007e64:	00001097          	auipc	ra,0x1
    80007e68:	88c080e7          	jalr	-1908(ra) # 800086f0 <pop_on>
    80007e6c:	00093783          	ld	a5,0(s2)
    80007e70:	0004b703          	ld	a4,0(s1)
    80007e74:	02078693          	addi	a3,a5,32
    80007e78:	fce688e3          	beq	a3,a4,80007e48 <uartputc+0x50>
    80007e7c:	01f77693          	andi	a3,a4,31
    80007e80:	00005597          	auipc	a1,0x5
    80007e84:	3c058593          	addi	a1,a1,960 # 8000d240 <uart_tx_buf>
    80007e88:	00d586b3          	add	a3,a1,a3
    80007e8c:	00170713          	addi	a4,a4,1
    80007e90:	01368023          	sb	s3,0(a3)
    80007e94:	00e4b023          	sd	a4,0(s1)
    80007e98:	10000637          	lui	a2,0x10000
    80007e9c:	02f71063          	bne	a4,a5,80007ebc <uartputc+0xc4>
    80007ea0:	0340006f          	j	80007ed4 <uartputc+0xdc>
    80007ea4:	00074703          	lbu	a4,0(a4)
    80007ea8:	00f93023          	sd	a5,0(s2)
    80007eac:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80007eb0:	00093783          	ld	a5,0(s2)
    80007eb4:	0004b703          	ld	a4,0(s1)
    80007eb8:	00f70e63          	beq	a4,a5,80007ed4 <uartputc+0xdc>
    80007ebc:	00564683          	lbu	a3,5(a2)
    80007ec0:	01f7f713          	andi	a4,a5,31
    80007ec4:	00e58733          	add	a4,a1,a4
    80007ec8:	0206f693          	andi	a3,a3,32
    80007ecc:	00178793          	addi	a5,a5,1
    80007ed0:	fc069ae3          	bnez	a3,80007ea4 <uartputc+0xac>
    80007ed4:	02813083          	ld	ra,40(sp)
    80007ed8:	02013403          	ld	s0,32(sp)
    80007edc:	01813483          	ld	s1,24(sp)
    80007ee0:	01013903          	ld	s2,16(sp)
    80007ee4:	00813983          	ld	s3,8(sp)
    80007ee8:	03010113          	addi	sp,sp,48
    80007eec:	00008067          	ret

0000000080007ef0 <uartputc_sync>:
    80007ef0:	ff010113          	addi	sp,sp,-16
    80007ef4:	00813423          	sd	s0,8(sp)
    80007ef8:	01010413          	addi	s0,sp,16
    80007efc:	00004717          	auipc	a4,0x4
    80007f00:	ffc72703          	lw	a4,-4(a4) # 8000bef8 <panicked>
    80007f04:	02071663          	bnez	a4,80007f30 <uartputc_sync+0x40>
    80007f08:	00050793          	mv	a5,a0
    80007f0c:	100006b7          	lui	a3,0x10000
    80007f10:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80007f14:	02077713          	andi	a4,a4,32
    80007f18:	fe070ce3          	beqz	a4,80007f10 <uartputc_sync+0x20>
    80007f1c:	0ff7f793          	andi	a5,a5,255
    80007f20:	00f68023          	sb	a5,0(a3)
    80007f24:	00813403          	ld	s0,8(sp)
    80007f28:	01010113          	addi	sp,sp,16
    80007f2c:	00008067          	ret
    80007f30:	0000006f          	j	80007f30 <uartputc_sync+0x40>

0000000080007f34 <uartstart>:
    80007f34:	ff010113          	addi	sp,sp,-16
    80007f38:	00813423          	sd	s0,8(sp)
    80007f3c:	01010413          	addi	s0,sp,16
    80007f40:	00004617          	auipc	a2,0x4
    80007f44:	fc060613          	addi	a2,a2,-64 # 8000bf00 <uart_tx_r>
    80007f48:	00004517          	auipc	a0,0x4
    80007f4c:	fc050513          	addi	a0,a0,-64 # 8000bf08 <uart_tx_w>
    80007f50:	00063783          	ld	a5,0(a2)
    80007f54:	00053703          	ld	a4,0(a0)
    80007f58:	04f70263          	beq	a4,a5,80007f9c <uartstart+0x68>
    80007f5c:	100005b7          	lui	a1,0x10000
    80007f60:	00005817          	auipc	a6,0x5
    80007f64:	2e080813          	addi	a6,a6,736 # 8000d240 <uart_tx_buf>
    80007f68:	01c0006f          	j	80007f84 <uartstart+0x50>
    80007f6c:	0006c703          	lbu	a4,0(a3)
    80007f70:	00f63023          	sd	a5,0(a2)
    80007f74:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007f78:	00063783          	ld	a5,0(a2)
    80007f7c:	00053703          	ld	a4,0(a0)
    80007f80:	00f70e63          	beq	a4,a5,80007f9c <uartstart+0x68>
    80007f84:	01f7f713          	andi	a4,a5,31
    80007f88:	00e806b3          	add	a3,a6,a4
    80007f8c:	0055c703          	lbu	a4,5(a1)
    80007f90:	00178793          	addi	a5,a5,1
    80007f94:	02077713          	andi	a4,a4,32
    80007f98:	fc071ae3          	bnez	a4,80007f6c <uartstart+0x38>
    80007f9c:	00813403          	ld	s0,8(sp)
    80007fa0:	01010113          	addi	sp,sp,16
    80007fa4:	00008067          	ret

0000000080007fa8 <uartgetc>:
    80007fa8:	ff010113          	addi	sp,sp,-16
    80007fac:	00813423          	sd	s0,8(sp)
    80007fb0:	01010413          	addi	s0,sp,16
    80007fb4:	10000737          	lui	a4,0x10000
    80007fb8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80007fbc:	0017f793          	andi	a5,a5,1
    80007fc0:	00078c63          	beqz	a5,80007fd8 <uartgetc+0x30>
    80007fc4:	00074503          	lbu	a0,0(a4)
    80007fc8:	0ff57513          	andi	a0,a0,255
    80007fcc:	00813403          	ld	s0,8(sp)
    80007fd0:	01010113          	addi	sp,sp,16
    80007fd4:	00008067          	ret
    80007fd8:	fff00513          	li	a0,-1
    80007fdc:	ff1ff06f          	j	80007fcc <uartgetc+0x24>

0000000080007fe0 <uartintr>:
    80007fe0:	100007b7          	lui	a5,0x10000
    80007fe4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80007fe8:	0017f793          	andi	a5,a5,1
    80007fec:	0a078463          	beqz	a5,80008094 <uartintr+0xb4>
    80007ff0:	fe010113          	addi	sp,sp,-32
    80007ff4:	00813823          	sd	s0,16(sp)
    80007ff8:	00913423          	sd	s1,8(sp)
    80007ffc:	00113c23          	sd	ra,24(sp)
    80008000:	02010413          	addi	s0,sp,32
    80008004:	100004b7          	lui	s1,0x10000
    80008008:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000800c:	0ff57513          	andi	a0,a0,255
    80008010:	fffff097          	auipc	ra,0xfffff
    80008014:	534080e7          	jalr	1332(ra) # 80007544 <consoleintr>
    80008018:	0054c783          	lbu	a5,5(s1)
    8000801c:	0017f793          	andi	a5,a5,1
    80008020:	fe0794e3          	bnez	a5,80008008 <uartintr+0x28>
    80008024:	00004617          	auipc	a2,0x4
    80008028:	edc60613          	addi	a2,a2,-292 # 8000bf00 <uart_tx_r>
    8000802c:	00004517          	auipc	a0,0x4
    80008030:	edc50513          	addi	a0,a0,-292 # 8000bf08 <uart_tx_w>
    80008034:	00063783          	ld	a5,0(a2)
    80008038:	00053703          	ld	a4,0(a0)
    8000803c:	04f70263          	beq	a4,a5,80008080 <uartintr+0xa0>
    80008040:	100005b7          	lui	a1,0x10000
    80008044:	00005817          	auipc	a6,0x5
    80008048:	1fc80813          	addi	a6,a6,508 # 8000d240 <uart_tx_buf>
    8000804c:	01c0006f          	j	80008068 <uartintr+0x88>
    80008050:	0006c703          	lbu	a4,0(a3)
    80008054:	00f63023          	sd	a5,0(a2)
    80008058:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000805c:	00063783          	ld	a5,0(a2)
    80008060:	00053703          	ld	a4,0(a0)
    80008064:	00f70e63          	beq	a4,a5,80008080 <uartintr+0xa0>
    80008068:	01f7f713          	andi	a4,a5,31
    8000806c:	00e806b3          	add	a3,a6,a4
    80008070:	0055c703          	lbu	a4,5(a1)
    80008074:	00178793          	addi	a5,a5,1
    80008078:	02077713          	andi	a4,a4,32
    8000807c:	fc071ae3          	bnez	a4,80008050 <uartintr+0x70>
    80008080:	01813083          	ld	ra,24(sp)
    80008084:	01013403          	ld	s0,16(sp)
    80008088:	00813483          	ld	s1,8(sp)
    8000808c:	02010113          	addi	sp,sp,32
    80008090:	00008067          	ret
    80008094:	00004617          	auipc	a2,0x4
    80008098:	e6c60613          	addi	a2,a2,-404 # 8000bf00 <uart_tx_r>
    8000809c:	00004517          	auipc	a0,0x4
    800080a0:	e6c50513          	addi	a0,a0,-404 # 8000bf08 <uart_tx_w>
    800080a4:	00063783          	ld	a5,0(a2)
    800080a8:	00053703          	ld	a4,0(a0)
    800080ac:	04f70263          	beq	a4,a5,800080f0 <uartintr+0x110>
    800080b0:	100005b7          	lui	a1,0x10000
    800080b4:	00005817          	auipc	a6,0x5
    800080b8:	18c80813          	addi	a6,a6,396 # 8000d240 <uart_tx_buf>
    800080bc:	01c0006f          	j	800080d8 <uartintr+0xf8>
    800080c0:	0006c703          	lbu	a4,0(a3)
    800080c4:	00f63023          	sd	a5,0(a2)
    800080c8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800080cc:	00063783          	ld	a5,0(a2)
    800080d0:	00053703          	ld	a4,0(a0)
    800080d4:	02f70063          	beq	a4,a5,800080f4 <uartintr+0x114>
    800080d8:	01f7f713          	andi	a4,a5,31
    800080dc:	00e806b3          	add	a3,a6,a4
    800080e0:	0055c703          	lbu	a4,5(a1)
    800080e4:	00178793          	addi	a5,a5,1
    800080e8:	02077713          	andi	a4,a4,32
    800080ec:	fc071ae3          	bnez	a4,800080c0 <uartintr+0xe0>
    800080f0:	00008067          	ret
    800080f4:	00008067          	ret

00000000800080f8 <kinit>:
    800080f8:	fc010113          	addi	sp,sp,-64
    800080fc:	02913423          	sd	s1,40(sp)
    80008100:	fffff7b7          	lui	a5,0xfffff
    80008104:	00006497          	auipc	s1,0x6
    80008108:	15b48493          	addi	s1,s1,347 # 8000e25f <end+0xfff>
    8000810c:	02813823          	sd	s0,48(sp)
    80008110:	01313c23          	sd	s3,24(sp)
    80008114:	00f4f4b3          	and	s1,s1,a5
    80008118:	02113c23          	sd	ra,56(sp)
    8000811c:	03213023          	sd	s2,32(sp)
    80008120:	01413823          	sd	s4,16(sp)
    80008124:	01513423          	sd	s5,8(sp)
    80008128:	04010413          	addi	s0,sp,64
    8000812c:	000017b7          	lui	a5,0x1
    80008130:	01100993          	li	s3,17
    80008134:	00f487b3          	add	a5,s1,a5
    80008138:	01b99993          	slli	s3,s3,0x1b
    8000813c:	06f9e063          	bltu	s3,a5,8000819c <kinit+0xa4>
    80008140:	00005a97          	auipc	s5,0x5
    80008144:	120a8a93          	addi	s5,s5,288 # 8000d260 <end>
    80008148:	0754ec63          	bltu	s1,s5,800081c0 <kinit+0xc8>
    8000814c:	0734fa63          	bgeu	s1,s3,800081c0 <kinit+0xc8>
    80008150:	00088a37          	lui	s4,0x88
    80008154:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80008158:	00004917          	auipc	s2,0x4
    8000815c:	db890913          	addi	s2,s2,-584 # 8000bf10 <kmem>
    80008160:	00ca1a13          	slli	s4,s4,0xc
    80008164:	0140006f          	j	80008178 <kinit+0x80>
    80008168:	000017b7          	lui	a5,0x1
    8000816c:	00f484b3          	add	s1,s1,a5
    80008170:	0554e863          	bltu	s1,s5,800081c0 <kinit+0xc8>
    80008174:	0534f663          	bgeu	s1,s3,800081c0 <kinit+0xc8>
    80008178:	00001637          	lui	a2,0x1
    8000817c:	00100593          	li	a1,1
    80008180:	00048513          	mv	a0,s1
    80008184:	00000097          	auipc	ra,0x0
    80008188:	5e4080e7          	jalr	1508(ra) # 80008768 <__memset>
    8000818c:	00093783          	ld	a5,0(s2)
    80008190:	00f4b023          	sd	a5,0(s1)
    80008194:	00993023          	sd	s1,0(s2)
    80008198:	fd4498e3          	bne	s1,s4,80008168 <kinit+0x70>
    8000819c:	03813083          	ld	ra,56(sp)
    800081a0:	03013403          	ld	s0,48(sp)
    800081a4:	02813483          	ld	s1,40(sp)
    800081a8:	02013903          	ld	s2,32(sp)
    800081ac:	01813983          	ld	s3,24(sp)
    800081b0:	01013a03          	ld	s4,16(sp)
    800081b4:	00813a83          	ld	s5,8(sp)
    800081b8:	04010113          	addi	sp,sp,64
    800081bc:	00008067          	ret
    800081c0:	00001517          	auipc	a0,0x1
    800081c4:	56050513          	addi	a0,a0,1376 # 80009720 <digits+0x18>
    800081c8:	fffff097          	auipc	ra,0xfffff
    800081cc:	4b4080e7          	jalr	1204(ra) # 8000767c <panic>

00000000800081d0 <freerange>:
    800081d0:	fc010113          	addi	sp,sp,-64
    800081d4:	000017b7          	lui	a5,0x1
    800081d8:	02913423          	sd	s1,40(sp)
    800081dc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800081e0:	009504b3          	add	s1,a0,s1
    800081e4:	fffff537          	lui	a0,0xfffff
    800081e8:	02813823          	sd	s0,48(sp)
    800081ec:	02113c23          	sd	ra,56(sp)
    800081f0:	03213023          	sd	s2,32(sp)
    800081f4:	01313c23          	sd	s3,24(sp)
    800081f8:	01413823          	sd	s4,16(sp)
    800081fc:	01513423          	sd	s5,8(sp)
    80008200:	01613023          	sd	s6,0(sp)
    80008204:	04010413          	addi	s0,sp,64
    80008208:	00a4f4b3          	and	s1,s1,a0
    8000820c:	00f487b3          	add	a5,s1,a5
    80008210:	06f5e463          	bltu	a1,a5,80008278 <freerange+0xa8>
    80008214:	00005a97          	auipc	s5,0x5
    80008218:	04ca8a93          	addi	s5,s5,76 # 8000d260 <end>
    8000821c:	0954e263          	bltu	s1,s5,800082a0 <freerange+0xd0>
    80008220:	01100993          	li	s3,17
    80008224:	01b99993          	slli	s3,s3,0x1b
    80008228:	0734fc63          	bgeu	s1,s3,800082a0 <freerange+0xd0>
    8000822c:	00058a13          	mv	s4,a1
    80008230:	00004917          	auipc	s2,0x4
    80008234:	ce090913          	addi	s2,s2,-800 # 8000bf10 <kmem>
    80008238:	00002b37          	lui	s6,0x2
    8000823c:	0140006f          	j	80008250 <freerange+0x80>
    80008240:	000017b7          	lui	a5,0x1
    80008244:	00f484b3          	add	s1,s1,a5
    80008248:	0554ec63          	bltu	s1,s5,800082a0 <freerange+0xd0>
    8000824c:	0534fa63          	bgeu	s1,s3,800082a0 <freerange+0xd0>
    80008250:	00001637          	lui	a2,0x1
    80008254:	00100593          	li	a1,1
    80008258:	00048513          	mv	a0,s1
    8000825c:	00000097          	auipc	ra,0x0
    80008260:	50c080e7          	jalr	1292(ra) # 80008768 <__memset>
    80008264:	00093703          	ld	a4,0(s2)
    80008268:	016487b3          	add	a5,s1,s6
    8000826c:	00e4b023          	sd	a4,0(s1)
    80008270:	00993023          	sd	s1,0(s2)
    80008274:	fcfa76e3          	bgeu	s4,a5,80008240 <freerange+0x70>
    80008278:	03813083          	ld	ra,56(sp)
    8000827c:	03013403          	ld	s0,48(sp)
    80008280:	02813483          	ld	s1,40(sp)
    80008284:	02013903          	ld	s2,32(sp)
    80008288:	01813983          	ld	s3,24(sp)
    8000828c:	01013a03          	ld	s4,16(sp)
    80008290:	00813a83          	ld	s5,8(sp)
    80008294:	00013b03          	ld	s6,0(sp)
    80008298:	04010113          	addi	sp,sp,64
    8000829c:	00008067          	ret
    800082a0:	00001517          	auipc	a0,0x1
    800082a4:	48050513          	addi	a0,a0,1152 # 80009720 <digits+0x18>
    800082a8:	fffff097          	auipc	ra,0xfffff
    800082ac:	3d4080e7          	jalr	980(ra) # 8000767c <panic>

00000000800082b0 <kfree>:
    800082b0:	fe010113          	addi	sp,sp,-32
    800082b4:	00813823          	sd	s0,16(sp)
    800082b8:	00113c23          	sd	ra,24(sp)
    800082bc:	00913423          	sd	s1,8(sp)
    800082c0:	02010413          	addi	s0,sp,32
    800082c4:	03451793          	slli	a5,a0,0x34
    800082c8:	04079c63          	bnez	a5,80008320 <kfree+0x70>
    800082cc:	00005797          	auipc	a5,0x5
    800082d0:	f9478793          	addi	a5,a5,-108 # 8000d260 <end>
    800082d4:	00050493          	mv	s1,a0
    800082d8:	04f56463          	bltu	a0,a5,80008320 <kfree+0x70>
    800082dc:	01100793          	li	a5,17
    800082e0:	01b79793          	slli	a5,a5,0x1b
    800082e4:	02f57e63          	bgeu	a0,a5,80008320 <kfree+0x70>
    800082e8:	00001637          	lui	a2,0x1
    800082ec:	00100593          	li	a1,1
    800082f0:	00000097          	auipc	ra,0x0
    800082f4:	478080e7          	jalr	1144(ra) # 80008768 <__memset>
    800082f8:	00004797          	auipc	a5,0x4
    800082fc:	c1878793          	addi	a5,a5,-1000 # 8000bf10 <kmem>
    80008300:	0007b703          	ld	a4,0(a5)
    80008304:	01813083          	ld	ra,24(sp)
    80008308:	01013403          	ld	s0,16(sp)
    8000830c:	00e4b023          	sd	a4,0(s1)
    80008310:	0097b023          	sd	s1,0(a5)
    80008314:	00813483          	ld	s1,8(sp)
    80008318:	02010113          	addi	sp,sp,32
    8000831c:	00008067          	ret
    80008320:	00001517          	auipc	a0,0x1
    80008324:	40050513          	addi	a0,a0,1024 # 80009720 <digits+0x18>
    80008328:	fffff097          	auipc	ra,0xfffff
    8000832c:	354080e7          	jalr	852(ra) # 8000767c <panic>

0000000080008330 <kalloc>:
    80008330:	fe010113          	addi	sp,sp,-32
    80008334:	00813823          	sd	s0,16(sp)
    80008338:	00913423          	sd	s1,8(sp)
    8000833c:	00113c23          	sd	ra,24(sp)
    80008340:	02010413          	addi	s0,sp,32
    80008344:	00004797          	auipc	a5,0x4
    80008348:	bcc78793          	addi	a5,a5,-1076 # 8000bf10 <kmem>
    8000834c:	0007b483          	ld	s1,0(a5)
    80008350:	02048063          	beqz	s1,80008370 <kalloc+0x40>
    80008354:	0004b703          	ld	a4,0(s1)
    80008358:	00001637          	lui	a2,0x1
    8000835c:	00500593          	li	a1,5
    80008360:	00048513          	mv	a0,s1
    80008364:	00e7b023          	sd	a4,0(a5)
    80008368:	00000097          	auipc	ra,0x0
    8000836c:	400080e7          	jalr	1024(ra) # 80008768 <__memset>
    80008370:	01813083          	ld	ra,24(sp)
    80008374:	01013403          	ld	s0,16(sp)
    80008378:	00048513          	mv	a0,s1
    8000837c:	00813483          	ld	s1,8(sp)
    80008380:	02010113          	addi	sp,sp,32
    80008384:	00008067          	ret

0000000080008388 <initlock>:
    80008388:	ff010113          	addi	sp,sp,-16
    8000838c:	00813423          	sd	s0,8(sp)
    80008390:	01010413          	addi	s0,sp,16
    80008394:	00813403          	ld	s0,8(sp)
    80008398:	00b53423          	sd	a1,8(a0)
    8000839c:	00052023          	sw	zero,0(a0)
    800083a0:	00053823          	sd	zero,16(a0)
    800083a4:	01010113          	addi	sp,sp,16
    800083a8:	00008067          	ret

00000000800083ac <acquire>:
    800083ac:	fe010113          	addi	sp,sp,-32
    800083b0:	00813823          	sd	s0,16(sp)
    800083b4:	00913423          	sd	s1,8(sp)
    800083b8:	00113c23          	sd	ra,24(sp)
    800083bc:	01213023          	sd	s2,0(sp)
    800083c0:	02010413          	addi	s0,sp,32
    800083c4:	00050493          	mv	s1,a0
    800083c8:	10002973          	csrr	s2,sstatus
    800083cc:	100027f3          	csrr	a5,sstatus
    800083d0:	ffd7f793          	andi	a5,a5,-3
    800083d4:	10079073          	csrw	sstatus,a5
    800083d8:	fffff097          	auipc	ra,0xfffff
    800083dc:	8e8080e7          	jalr	-1816(ra) # 80006cc0 <mycpu>
    800083e0:	07852783          	lw	a5,120(a0)
    800083e4:	06078e63          	beqz	a5,80008460 <acquire+0xb4>
    800083e8:	fffff097          	auipc	ra,0xfffff
    800083ec:	8d8080e7          	jalr	-1832(ra) # 80006cc0 <mycpu>
    800083f0:	07852783          	lw	a5,120(a0)
    800083f4:	0004a703          	lw	a4,0(s1)
    800083f8:	0017879b          	addiw	a5,a5,1
    800083fc:	06f52c23          	sw	a5,120(a0)
    80008400:	04071063          	bnez	a4,80008440 <acquire+0x94>
    80008404:	00100713          	li	a4,1
    80008408:	00070793          	mv	a5,a4
    8000840c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80008410:	0007879b          	sext.w	a5,a5
    80008414:	fe079ae3          	bnez	a5,80008408 <acquire+0x5c>
    80008418:	0ff0000f          	fence
    8000841c:	fffff097          	auipc	ra,0xfffff
    80008420:	8a4080e7          	jalr	-1884(ra) # 80006cc0 <mycpu>
    80008424:	01813083          	ld	ra,24(sp)
    80008428:	01013403          	ld	s0,16(sp)
    8000842c:	00a4b823          	sd	a0,16(s1)
    80008430:	00013903          	ld	s2,0(sp)
    80008434:	00813483          	ld	s1,8(sp)
    80008438:	02010113          	addi	sp,sp,32
    8000843c:	00008067          	ret
    80008440:	0104b903          	ld	s2,16(s1)
    80008444:	fffff097          	auipc	ra,0xfffff
    80008448:	87c080e7          	jalr	-1924(ra) # 80006cc0 <mycpu>
    8000844c:	faa91ce3          	bne	s2,a0,80008404 <acquire+0x58>
    80008450:	00001517          	auipc	a0,0x1
    80008454:	2d850513          	addi	a0,a0,728 # 80009728 <digits+0x20>
    80008458:	fffff097          	auipc	ra,0xfffff
    8000845c:	224080e7          	jalr	548(ra) # 8000767c <panic>
    80008460:	00195913          	srli	s2,s2,0x1
    80008464:	fffff097          	auipc	ra,0xfffff
    80008468:	85c080e7          	jalr	-1956(ra) # 80006cc0 <mycpu>
    8000846c:	00197913          	andi	s2,s2,1
    80008470:	07252e23          	sw	s2,124(a0)
    80008474:	f75ff06f          	j	800083e8 <acquire+0x3c>

0000000080008478 <release>:
    80008478:	fe010113          	addi	sp,sp,-32
    8000847c:	00813823          	sd	s0,16(sp)
    80008480:	00113c23          	sd	ra,24(sp)
    80008484:	00913423          	sd	s1,8(sp)
    80008488:	01213023          	sd	s2,0(sp)
    8000848c:	02010413          	addi	s0,sp,32
    80008490:	00052783          	lw	a5,0(a0)
    80008494:	00079a63          	bnez	a5,800084a8 <release+0x30>
    80008498:	00001517          	auipc	a0,0x1
    8000849c:	29850513          	addi	a0,a0,664 # 80009730 <digits+0x28>
    800084a0:	fffff097          	auipc	ra,0xfffff
    800084a4:	1dc080e7          	jalr	476(ra) # 8000767c <panic>
    800084a8:	01053903          	ld	s2,16(a0)
    800084ac:	00050493          	mv	s1,a0
    800084b0:	fffff097          	auipc	ra,0xfffff
    800084b4:	810080e7          	jalr	-2032(ra) # 80006cc0 <mycpu>
    800084b8:	fea910e3          	bne	s2,a0,80008498 <release+0x20>
    800084bc:	0004b823          	sd	zero,16(s1)
    800084c0:	0ff0000f          	fence
    800084c4:	0f50000f          	fence	iorw,ow
    800084c8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800084cc:	ffffe097          	auipc	ra,0xffffe
    800084d0:	7f4080e7          	jalr	2036(ra) # 80006cc0 <mycpu>
    800084d4:	100027f3          	csrr	a5,sstatus
    800084d8:	0027f793          	andi	a5,a5,2
    800084dc:	04079a63          	bnez	a5,80008530 <release+0xb8>
    800084e0:	07852783          	lw	a5,120(a0)
    800084e4:	02f05e63          	blez	a5,80008520 <release+0xa8>
    800084e8:	fff7871b          	addiw	a4,a5,-1
    800084ec:	06e52c23          	sw	a4,120(a0)
    800084f0:	00071c63          	bnez	a4,80008508 <release+0x90>
    800084f4:	07c52783          	lw	a5,124(a0)
    800084f8:	00078863          	beqz	a5,80008508 <release+0x90>
    800084fc:	100027f3          	csrr	a5,sstatus
    80008500:	0027e793          	ori	a5,a5,2
    80008504:	10079073          	csrw	sstatus,a5
    80008508:	01813083          	ld	ra,24(sp)
    8000850c:	01013403          	ld	s0,16(sp)
    80008510:	00813483          	ld	s1,8(sp)
    80008514:	00013903          	ld	s2,0(sp)
    80008518:	02010113          	addi	sp,sp,32
    8000851c:	00008067          	ret
    80008520:	00001517          	auipc	a0,0x1
    80008524:	23050513          	addi	a0,a0,560 # 80009750 <digits+0x48>
    80008528:	fffff097          	auipc	ra,0xfffff
    8000852c:	154080e7          	jalr	340(ra) # 8000767c <panic>
    80008530:	00001517          	auipc	a0,0x1
    80008534:	20850513          	addi	a0,a0,520 # 80009738 <digits+0x30>
    80008538:	fffff097          	auipc	ra,0xfffff
    8000853c:	144080e7          	jalr	324(ra) # 8000767c <panic>

0000000080008540 <holding>:
    80008540:	00052783          	lw	a5,0(a0)
    80008544:	00079663          	bnez	a5,80008550 <holding+0x10>
    80008548:	00000513          	li	a0,0
    8000854c:	00008067          	ret
    80008550:	fe010113          	addi	sp,sp,-32
    80008554:	00813823          	sd	s0,16(sp)
    80008558:	00913423          	sd	s1,8(sp)
    8000855c:	00113c23          	sd	ra,24(sp)
    80008560:	02010413          	addi	s0,sp,32
    80008564:	01053483          	ld	s1,16(a0)
    80008568:	ffffe097          	auipc	ra,0xffffe
    8000856c:	758080e7          	jalr	1880(ra) # 80006cc0 <mycpu>
    80008570:	01813083          	ld	ra,24(sp)
    80008574:	01013403          	ld	s0,16(sp)
    80008578:	40a48533          	sub	a0,s1,a0
    8000857c:	00153513          	seqz	a0,a0
    80008580:	00813483          	ld	s1,8(sp)
    80008584:	02010113          	addi	sp,sp,32
    80008588:	00008067          	ret

000000008000858c <push_off>:
    8000858c:	fe010113          	addi	sp,sp,-32
    80008590:	00813823          	sd	s0,16(sp)
    80008594:	00113c23          	sd	ra,24(sp)
    80008598:	00913423          	sd	s1,8(sp)
    8000859c:	02010413          	addi	s0,sp,32
    800085a0:	100024f3          	csrr	s1,sstatus
    800085a4:	100027f3          	csrr	a5,sstatus
    800085a8:	ffd7f793          	andi	a5,a5,-3
    800085ac:	10079073          	csrw	sstatus,a5
    800085b0:	ffffe097          	auipc	ra,0xffffe
    800085b4:	710080e7          	jalr	1808(ra) # 80006cc0 <mycpu>
    800085b8:	07852783          	lw	a5,120(a0)
    800085bc:	02078663          	beqz	a5,800085e8 <push_off+0x5c>
    800085c0:	ffffe097          	auipc	ra,0xffffe
    800085c4:	700080e7          	jalr	1792(ra) # 80006cc0 <mycpu>
    800085c8:	07852783          	lw	a5,120(a0)
    800085cc:	01813083          	ld	ra,24(sp)
    800085d0:	01013403          	ld	s0,16(sp)
    800085d4:	0017879b          	addiw	a5,a5,1
    800085d8:	06f52c23          	sw	a5,120(a0)
    800085dc:	00813483          	ld	s1,8(sp)
    800085e0:	02010113          	addi	sp,sp,32
    800085e4:	00008067          	ret
    800085e8:	0014d493          	srli	s1,s1,0x1
    800085ec:	ffffe097          	auipc	ra,0xffffe
    800085f0:	6d4080e7          	jalr	1748(ra) # 80006cc0 <mycpu>
    800085f4:	0014f493          	andi	s1,s1,1
    800085f8:	06952e23          	sw	s1,124(a0)
    800085fc:	fc5ff06f          	j	800085c0 <push_off+0x34>

0000000080008600 <pop_off>:
    80008600:	ff010113          	addi	sp,sp,-16
    80008604:	00813023          	sd	s0,0(sp)
    80008608:	00113423          	sd	ra,8(sp)
    8000860c:	01010413          	addi	s0,sp,16
    80008610:	ffffe097          	auipc	ra,0xffffe
    80008614:	6b0080e7          	jalr	1712(ra) # 80006cc0 <mycpu>
    80008618:	100027f3          	csrr	a5,sstatus
    8000861c:	0027f793          	andi	a5,a5,2
    80008620:	04079663          	bnez	a5,8000866c <pop_off+0x6c>
    80008624:	07852783          	lw	a5,120(a0)
    80008628:	02f05a63          	blez	a5,8000865c <pop_off+0x5c>
    8000862c:	fff7871b          	addiw	a4,a5,-1
    80008630:	06e52c23          	sw	a4,120(a0)
    80008634:	00071c63          	bnez	a4,8000864c <pop_off+0x4c>
    80008638:	07c52783          	lw	a5,124(a0)
    8000863c:	00078863          	beqz	a5,8000864c <pop_off+0x4c>
    80008640:	100027f3          	csrr	a5,sstatus
    80008644:	0027e793          	ori	a5,a5,2
    80008648:	10079073          	csrw	sstatus,a5
    8000864c:	00813083          	ld	ra,8(sp)
    80008650:	00013403          	ld	s0,0(sp)
    80008654:	01010113          	addi	sp,sp,16
    80008658:	00008067          	ret
    8000865c:	00001517          	auipc	a0,0x1
    80008660:	0f450513          	addi	a0,a0,244 # 80009750 <digits+0x48>
    80008664:	fffff097          	auipc	ra,0xfffff
    80008668:	018080e7          	jalr	24(ra) # 8000767c <panic>
    8000866c:	00001517          	auipc	a0,0x1
    80008670:	0cc50513          	addi	a0,a0,204 # 80009738 <digits+0x30>
    80008674:	fffff097          	auipc	ra,0xfffff
    80008678:	008080e7          	jalr	8(ra) # 8000767c <panic>

000000008000867c <push_on>:
    8000867c:	fe010113          	addi	sp,sp,-32
    80008680:	00813823          	sd	s0,16(sp)
    80008684:	00113c23          	sd	ra,24(sp)
    80008688:	00913423          	sd	s1,8(sp)
    8000868c:	02010413          	addi	s0,sp,32
    80008690:	100024f3          	csrr	s1,sstatus
    80008694:	100027f3          	csrr	a5,sstatus
    80008698:	0027e793          	ori	a5,a5,2
    8000869c:	10079073          	csrw	sstatus,a5
    800086a0:	ffffe097          	auipc	ra,0xffffe
    800086a4:	620080e7          	jalr	1568(ra) # 80006cc0 <mycpu>
    800086a8:	07852783          	lw	a5,120(a0)
    800086ac:	02078663          	beqz	a5,800086d8 <push_on+0x5c>
    800086b0:	ffffe097          	auipc	ra,0xffffe
    800086b4:	610080e7          	jalr	1552(ra) # 80006cc0 <mycpu>
    800086b8:	07852783          	lw	a5,120(a0)
    800086bc:	01813083          	ld	ra,24(sp)
    800086c0:	01013403          	ld	s0,16(sp)
    800086c4:	0017879b          	addiw	a5,a5,1
    800086c8:	06f52c23          	sw	a5,120(a0)
    800086cc:	00813483          	ld	s1,8(sp)
    800086d0:	02010113          	addi	sp,sp,32
    800086d4:	00008067          	ret
    800086d8:	0014d493          	srli	s1,s1,0x1
    800086dc:	ffffe097          	auipc	ra,0xffffe
    800086e0:	5e4080e7          	jalr	1508(ra) # 80006cc0 <mycpu>
    800086e4:	0014f493          	andi	s1,s1,1
    800086e8:	06952e23          	sw	s1,124(a0)
    800086ec:	fc5ff06f          	j	800086b0 <push_on+0x34>

00000000800086f0 <pop_on>:
    800086f0:	ff010113          	addi	sp,sp,-16
    800086f4:	00813023          	sd	s0,0(sp)
    800086f8:	00113423          	sd	ra,8(sp)
    800086fc:	01010413          	addi	s0,sp,16
    80008700:	ffffe097          	auipc	ra,0xffffe
    80008704:	5c0080e7          	jalr	1472(ra) # 80006cc0 <mycpu>
    80008708:	100027f3          	csrr	a5,sstatus
    8000870c:	0027f793          	andi	a5,a5,2
    80008710:	04078463          	beqz	a5,80008758 <pop_on+0x68>
    80008714:	07852783          	lw	a5,120(a0)
    80008718:	02f05863          	blez	a5,80008748 <pop_on+0x58>
    8000871c:	fff7879b          	addiw	a5,a5,-1
    80008720:	06f52c23          	sw	a5,120(a0)
    80008724:	07853783          	ld	a5,120(a0)
    80008728:	00079863          	bnez	a5,80008738 <pop_on+0x48>
    8000872c:	100027f3          	csrr	a5,sstatus
    80008730:	ffd7f793          	andi	a5,a5,-3
    80008734:	10079073          	csrw	sstatus,a5
    80008738:	00813083          	ld	ra,8(sp)
    8000873c:	00013403          	ld	s0,0(sp)
    80008740:	01010113          	addi	sp,sp,16
    80008744:	00008067          	ret
    80008748:	00001517          	auipc	a0,0x1
    8000874c:	03050513          	addi	a0,a0,48 # 80009778 <digits+0x70>
    80008750:	fffff097          	auipc	ra,0xfffff
    80008754:	f2c080e7          	jalr	-212(ra) # 8000767c <panic>
    80008758:	00001517          	auipc	a0,0x1
    8000875c:	00050513          	mv	a0,a0
    80008760:	fffff097          	auipc	ra,0xfffff
    80008764:	f1c080e7          	jalr	-228(ra) # 8000767c <panic>

0000000080008768 <__memset>:
    80008768:	ff010113          	addi	sp,sp,-16
    8000876c:	00813423          	sd	s0,8(sp)
    80008770:	01010413          	addi	s0,sp,16
    80008774:	1a060e63          	beqz	a2,80008930 <__memset+0x1c8>
    80008778:	40a007b3          	neg	a5,a0
    8000877c:	0077f793          	andi	a5,a5,7
    80008780:	00778693          	addi	a3,a5,7
    80008784:	00b00813          	li	a6,11
    80008788:	0ff5f593          	andi	a1,a1,255
    8000878c:	fff6071b          	addiw	a4,a2,-1
    80008790:	1b06e663          	bltu	a3,a6,8000893c <__memset+0x1d4>
    80008794:	1cd76463          	bltu	a4,a3,8000895c <__memset+0x1f4>
    80008798:	1a078e63          	beqz	a5,80008954 <__memset+0x1ec>
    8000879c:	00b50023          	sb	a1,0(a0) # 80009758 <digits+0x50>
    800087a0:	00100713          	li	a4,1
    800087a4:	1ae78463          	beq	a5,a4,8000894c <__memset+0x1e4>
    800087a8:	00b500a3          	sb	a1,1(a0)
    800087ac:	00200713          	li	a4,2
    800087b0:	1ae78a63          	beq	a5,a4,80008964 <__memset+0x1fc>
    800087b4:	00b50123          	sb	a1,2(a0)
    800087b8:	00300713          	li	a4,3
    800087bc:	18e78463          	beq	a5,a4,80008944 <__memset+0x1dc>
    800087c0:	00b501a3          	sb	a1,3(a0)
    800087c4:	00400713          	li	a4,4
    800087c8:	1ae78263          	beq	a5,a4,8000896c <__memset+0x204>
    800087cc:	00b50223          	sb	a1,4(a0)
    800087d0:	00500713          	li	a4,5
    800087d4:	1ae78063          	beq	a5,a4,80008974 <__memset+0x20c>
    800087d8:	00b502a3          	sb	a1,5(a0)
    800087dc:	00700713          	li	a4,7
    800087e0:	18e79e63          	bne	a5,a4,8000897c <__memset+0x214>
    800087e4:	00b50323          	sb	a1,6(a0)
    800087e8:	00700e93          	li	t4,7
    800087ec:	00859713          	slli	a4,a1,0x8
    800087f0:	00e5e733          	or	a4,a1,a4
    800087f4:	01059e13          	slli	t3,a1,0x10
    800087f8:	01c76e33          	or	t3,a4,t3
    800087fc:	01859313          	slli	t1,a1,0x18
    80008800:	006e6333          	or	t1,t3,t1
    80008804:	02059893          	slli	a7,a1,0x20
    80008808:	40f60e3b          	subw	t3,a2,a5
    8000880c:	011368b3          	or	a7,t1,a7
    80008810:	02859813          	slli	a6,a1,0x28
    80008814:	0108e833          	or	a6,a7,a6
    80008818:	03059693          	slli	a3,a1,0x30
    8000881c:	003e589b          	srliw	a7,t3,0x3
    80008820:	00d866b3          	or	a3,a6,a3
    80008824:	03859713          	slli	a4,a1,0x38
    80008828:	00389813          	slli	a6,a7,0x3
    8000882c:	00f507b3          	add	a5,a0,a5
    80008830:	00e6e733          	or	a4,a3,a4
    80008834:	000e089b          	sext.w	a7,t3
    80008838:	00f806b3          	add	a3,a6,a5
    8000883c:	00e7b023          	sd	a4,0(a5)
    80008840:	00878793          	addi	a5,a5,8
    80008844:	fed79ce3          	bne	a5,a3,8000883c <__memset+0xd4>
    80008848:	ff8e7793          	andi	a5,t3,-8
    8000884c:	0007871b          	sext.w	a4,a5
    80008850:	01d787bb          	addw	a5,a5,t4
    80008854:	0ce88e63          	beq	a7,a4,80008930 <__memset+0x1c8>
    80008858:	00f50733          	add	a4,a0,a5
    8000885c:	00b70023          	sb	a1,0(a4)
    80008860:	0017871b          	addiw	a4,a5,1
    80008864:	0cc77663          	bgeu	a4,a2,80008930 <__memset+0x1c8>
    80008868:	00e50733          	add	a4,a0,a4
    8000886c:	00b70023          	sb	a1,0(a4)
    80008870:	0027871b          	addiw	a4,a5,2
    80008874:	0ac77e63          	bgeu	a4,a2,80008930 <__memset+0x1c8>
    80008878:	00e50733          	add	a4,a0,a4
    8000887c:	00b70023          	sb	a1,0(a4)
    80008880:	0037871b          	addiw	a4,a5,3
    80008884:	0ac77663          	bgeu	a4,a2,80008930 <__memset+0x1c8>
    80008888:	00e50733          	add	a4,a0,a4
    8000888c:	00b70023          	sb	a1,0(a4)
    80008890:	0047871b          	addiw	a4,a5,4
    80008894:	08c77e63          	bgeu	a4,a2,80008930 <__memset+0x1c8>
    80008898:	00e50733          	add	a4,a0,a4
    8000889c:	00b70023          	sb	a1,0(a4)
    800088a0:	0057871b          	addiw	a4,a5,5
    800088a4:	08c77663          	bgeu	a4,a2,80008930 <__memset+0x1c8>
    800088a8:	00e50733          	add	a4,a0,a4
    800088ac:	00b70023          	sb	a1,0(a4)
    800088b0:	0067871b          	addiw	a4,a5,6
    800088b4:	06c77e63          	bgeu	a4,a2,80008930 <__memset+0x1c8>
    800088b8:	00e50733          	add	a4,a0,a4
    800088bc:	00b70023          	sb	a1,0(a4)
    800088c0:	0077871b          	addiw	a4,a5,7
    800088c4:	06c77663          	bgeu	a4,a2,80008930 <__memset+0x1c8>
    800088c8:	00e50733          	add	a4,a0,a4
    800088cc:	00b70023          	sb	a1,0(a4)
    800088d0:	0087871b          	addiw	a4,a5,8
    800088d4:	04c77e63          	bgeu	a4,a2,80008930 <__memset+0x1c8>
    800088d8:	00e50733          	add	a4,a0,a4
    800088dc:	00b70023          	sb	a1,0(a4)
    800088e0:	0097871b          	addiw	a4,a5,9
    800088e4:	04c77663          	bgeu	a4,a2,80008930 <__memset+0x1c8>
    800088e8:	00e50733          	add	a4,a0,a4
    800088ec:	00b70023          	sb	a1,0(a4)
    800088f0:	00a7871b          	addiw	a4,a5,10
    800088f4:	02c77e63          	bgeu	a4,a2,80008930 <__memset+0x1c8>
    800088f8:	00e50733          	add	a4,a0,a4
    800088fc:	00b70023          	sb	a1,0(a4)
    80008900:	00b7871b          	addiw	a4,a5,11
    80008904:	02c77663          	bgeu	a4,a2,80008930 <__memset+0x1c8>
    80008908:	00e50733          	add	a4,a0,a4
    8000890c:	00b70023          	sb	a1,0(a4)
    80008910:	00c7871b          	addiw	a4,a5,12
    80008914:	00c77e63          	bgeu	a4,a2,80008930 <__memset+0x1c8>
    80008918:	00e50733          	add	a4,a0,a4
    8000891c:	00b70023          	sb	a1,0(a4)
    80008920:	00d7879b          	addiw	a5,a5,13
    80008924:	00c7f663          	bgeu	a5,a2,80008930 <__memset+0x1c8>
    80008928:	00f507b3          	add	a5,a0,a5
    8000892c:	00b78023          	sb	a1,0(a5)
    80008930:	00813403          	ld	s0,8(sp)
    80008934:	01010113          	addi	sp,sp,16
    80008938:	00008067          	ret
    8000893c:	00b00693          	li	a3,11
    80008940:	e55ff06f          	j	80008794 <__memset+0x2c>
    80008944:	00300e93          	li	t4,3
    80008948:	ea5ff06f          	j	800087ec <__memset+0x84>
    8000894c:	00100e93          	li	t4,1
    80008950:	e9dff06f          	j	800087ec <__memset+0x84>
    80008954:	00000e93          	li	t4,0
    80008958:	e95ff06f          	j	800087ec <__memset+0x84>
    8000895c:	00000793          	li	a5,0
    80008960:	ef9ff06f          	j	80008858 <__memset+0xf0>
    80008964:	00200e93          	li	t4,2
    80008968:	e85ff06f          	j	800087ec <__memset+0x84>
    8000896c:	00400e93          	li	t4,4
    80008970:	e7dff06f          	j	800087ec <__memset+0x84>
    80008974:	00500e93          	li	t4,5
    80008978:	e75ff06f          	j	800087ec <__memset+0x84>
    8000897c:	00600e93          	li	t4,6
    80008980:	e6dff06f          	j	800087ec <__memset+0x84>

0000000080008984 <__memmove>:
    80008984:	ff010113          	addi	sp,sp,-16
    80008988:	00813423          	sd	s0,8(sp)
    8000898c:	01010413          	addi	s0,sp,16
    80008990:	0e060863          	beqz	a2,80008a80 <__memmove+0xfc>
    80008994:	fff6069b          	addiw	a3,a2,-1
    80008998:	0006881b          	sext.w	a6,a3
    8000899c:	0ea5e863          	bltu	a1,a0,80008a8c <__memmove+0x108>
    800089a0:	00758713          	addi	a4,a1,7
    800089a4:	00a5e7b3          	or	a5,a1,a0
    800089a8:	40a70733          	sub	a4,a4,a0
    800089ac:	0077f793          	andi	a5,a5,7
    800089b0:	00f73713          	sltiu	a4,a4,15
    800089b4:	00174713          	xori	a4,a4,1
    800089b8:	0017b793          	seqz	a5,a5
    800089bc:	00e7f7b3          	and	a5,a5,a4
    800089c0:	10078863          	beqz	a5,80008ad0 <__memmove+0x14c>
    800089c4:	00900793          	li	a5,9
    800089c8:	1107f463          	bgeu	a5,a6,80008ad0 <__memmove+0x14c>
    800089cc:	0036581b          	srliw	a6,a2,0x3
    800089d0:	fff8081b          	addiw	a6,a6,-1
    800089d4:	02081813          	slli	a6,a6,0x20
    800089d8:	01d85893          	srli	a7,a6,0x1d
    800089dc:	00858813          	addi	a6,a1,8
    800089e0:	00058793          	mv	a5,a1
    800089e4:	00050713          	mv	a4,a0
    800089e8:	01088833          	add	a6,a7,a6
    800089ec:	0007b883          	ld	a7,0(a5)
    800089f0:	00878793          	addi	a5,a5,8
    800089f4:	00870713          	addi	a4,a4,8
    800089f8:	ff173c23          	sd	a7,-8(a4)
    800089fc:	ff0798e3          	bne	a5,a6,800089ec <__memmove+0x68>
    80008a00:	ff867713          	andi	a4,a2,-8
    80008a04:	02071793          	slli	a5,a4,0x20
    80008a08:	0207d793          	srli	a5,a5,0x20
    80008a0c:	00f585b3          	add	a1,a1,a5
    80008a10:	40e686bb          	subw	a3,a3,a4
    80008a14:	00f507b3          	add	a5,a0,a5
    80008a18:	06e60463          	beq	a2,a4,80008a80 <__memmove+0xfc>
    80008a1c:	0005c703          	lbu	a4,0(a1)
    80008a20:	00e78023          	sb	a4,0(a5)
    80008a24:	04068e63          	beqz	a3,80008a80 <__memmove+0xfc>
    80008a28:	0015c603          	lbu	a2,1(a1)
    80008a2c:	00100713          	li	a4,1
    80008a30:	00c780a3          	sb	a2,1(a5)
    80008a34:	04e68663          	beq	a3,a4,80008a80 <__memmove+0xfc>
    80008a38:	0025c603          	lbu	a2,2(a1)
    80008a3c:	00200713          	li	a4,2
    80008a40:	00c78123          	sb	a2,2(a5)
    80008a44:	02e68e63          	beq	a3,a4,80008a80 <__memmove+0xfc>
    80008a48:	0035c603          	lbu	a2,3(a1)
    80008a4c:	00300713          	li	a4,3
    80008a50:	00c781a3          	sb	a2,3(a5)
    80008a54:	02e68663          	beq	a3,a4,80008a80 <__memmove+0xfc>
    80008a58:	0045c603          	lbu	a2,4(a1)
    80008a5c:	00400713          	li	a4,4
    80008a60:	00c78223          	sb	a2,4(a5)
    80008a64:	00e68e63          	beq	a3,a4,80008a80 <__memmove+0xfc>
    80008a68:	0055c603          	lbu	a2,5(a1)
    80008a6c:	00500713          	li	a4,5
    80008a70:	00c782a3          	sb	a2,5(a5)
    80008a74:	00e68663          	beq	a3,a4,80008a80 <__memmove+0xfc>
    80008a78:	0065c703          	lbu	a4,6(a1)
    80008a7c:	00e78323          	sb	a4,6(a5)
    80008a80:	00813403          	ld	s0,8(sp)
    80008a84:	01010113          	addi	sp,sp,16
    80008a88:	00008067          	ret
    80008a8c:	02061713          	slli	a4,a2,0x20
    80008a90:	02075713          	srli	a4,a4,0x20
    80008a94:	00e587b3          	add	a5,a1,a4
    80008a98:	f0f574e3          	bgeu	a0,a5,800089a0 <__memmove+0x1c>
    80008a9c:	02069613          	slli	a2,a3,0x20
    80008aa0:	02065613          	srli	a2,a2,0x20
    80008aa4:	fff64613          	not	a2,a2
    80008aa8:	00e50733          	add	a4,a0,a4
    80008aac:	00c78633          	add	a2,a5,a2
    80008ab0:	fff7c683          	lbu	a3,-1(a5)
    80008ab4:	fff78793          	addi	a5,a5,-1
    80008ab8:	fff70713          	addi	a4,a4,-1
    80008abc:	00d70023          	sb	a3,0(a4)
    80008ac0:	fec798e3          	bne	a5,a2,80008ab0 <__memmove+0x12c>
    80008ac4:	00813403          	ld	s0,8(sp)
    80008ac8:	01010113          	addi	sp,sp,16
    80008acc:	00008067          	ret
    80008ad0:	02069713          	slli	a4,a3,0x20
    80008ad4:	02075713          	srli	a4,a4,0x20
    80008ad8:	00170713          	addi	a4,a4,1
    80008adc:	00e50733          	add	a4,a0,a4
    80008ae0:	00050793          	mv	a5,a0
    80008ae4:	0005c683          	lbu	a3,0(a1)
    80008ae8:	00178793          	addi	a5,a5,1
    80008aec:	00158593          	addi	a1,a1,1
    80008af0:	fed78fa3          	sb	a3,-1(a5)
    80008af4:	fee798e3          	bne	a5,a4,80008ae4 <__memmove+0x160>
    80008af8:	f89ff06f          	j	80008a80 <__memmove+0xfc>

0000000080008afc <__putc>:
    80008afc:	fe010113          	addi	sp,sp,-32
    80008b00:	00813823          	sd	s0,16(sp)
    80008b04:	00113c23          	sd	ra,24(sp)
    80008b08:	02010413          	addi	s0,sp,32
    80008b0c:	00050793          	mv	a5,a0
    80008b10:	fef40593          	addi	a1,s0,-17
    80008b14:	00100613          	li	a2,1
    80008b18:	00000513          	li	a0,0
    80008b1c:	fef407a3          	sb	a5,-17(s0)
    80008b20:	fffff097          	auipc	ra,0xfffff
    80008b24:	b3c080e7          	jalr	-1220(ra) # 8000765c <console_write>
    80008b28:	01813083          	ld	ra,24(sp)
    80008b2c:	01013403          	ld	s0,16(sp)
    80008b30:	02010113          	addi	sp,sp,32
    80008b34:	00008067          	ret

0000000080008b38 <__getc>:
    80008b38:	fe010113          	addi	sp,sp,-32
    80008b3c:	00813823          	sd	s0,16(sp)
    80008b40:	00113c23          	sd	ra,24(sp)
    80008b44:	02010413          	addi	s0,sp,32
    80008b48:	fe840593          	addi	a1,s0,-24
    80008b4c:	00100613          	li	a2,1
    80008b50:	00000513          	li	a0,0
    80008b54:	fffff097          	auipc	ra,0xfffff
    80008b58:	ae8080e7          	jalr	-1304(ra) # 8000763c <console_read>
    80008b5c:	fe844503          	lbu	a0,-24(s0)
    80008b60:	01813083          	ld	ra,24(sp)
    80008b64:	01013403          	ld	s0,16(sp)
    80008b68:	02010113          	addi	sp,sp,32
    80008b6c:	00008067          	ret

0000000080008b70 <console_handler>:
    80008b70:	fe010113          	addi	sp,sp,-32
    80008b74:	00813823          	sd	s0,16(sp)
    80008b78:	00113c23          	sd	ra,24(sp)
    80008b7c:	00913423          	sd	s1,8(sp)
    80008b80:	02010413          	addi	s0,sp,32
    80008b84:	14202773          	csrr	a4,scause
    80008b88:	100027f3          	csrr	a5,sstatus
    80008b8c:	0027f793          	andi	a5,a5,2
    80008b90:	06079e63          	bnez	a5,80008c0c <console_handler+0x9c>
    80008b94:	00074c63          	bltz	a4,80008bac <console_handler+0x3c>
    80008b98:	01813083          	ld	ra,24(sp)
    80008b9c:	01013403          	ld	s0,16(sp)
    80008ba0:	00813483          	ld	s1,8(sp)
    80008ba4:	02010113          	addi	sp,sp,32
    80008ba8:	00008067          	ret
    80008bac:	0ff77713          	andi	a4,a4,255
    80008bb0:	00900793          	li	a5,9
    80008bb4:	fef712e3          	bne	a4,a5,80008b98 <console_handler+0x28>
    80008bb8:	ffffe097          	auipc	ra,0xffffe
    80008bbc:	6dc080e7          	jalr	1756(ra) # 80007294 <plic_claim>
    80008bc0:	00a00793          	li	a5,10
    80008bc4:	00050493          	mv	s1,a0
    80008bc8:	02f50c63          	beq	a0,a5,80008c00 <console_handler+0x90>
    80008bcc:	fc0506e3          	beqz	a0,80008b98 <console_handler+0x28>
    80008bd0:	00050593          	mv	a1,a0
    80008bd4:	00001517          	auipc	a0,0x1
    80008bd8:	aac50513          	addi	a0,a0,-1364 # 80009680 <CONSOLE_STATUS+0x670>
    80008bdc:	fffff097          	auipc	ra,0xfffff
    80008be0:	afc080e7          	jalr	-1284(ra) # 800076d8 <__printf>
    80008be4:	01013403          	ld	s0,16(sp)
    80008be8:	01813083          	ld	ra,24(sp)
    80008bec:	00048513          	mv	a0,s1
    80008bf0:	00813483          	ld	s1,8(sp)
    80008bf4:	02010113          	addi	sp,sp,32
    80008bf8:	ffffe317          	auipc	t1,0xffffe
    80008bfc:	6d430067          	jr	1748(t1) # 800072cc <plic_complete>
    80008c00:	fffff097          	auipc	ra,0xfffff
    80008c04:	3e0080e7          	jalr	992(ra) # 80007fe0 <uartintr>
    80008c08:	fddff06f          	j	80008be4 <console_handler+0x74>
    80008c0c:	00001517          	auipc	a0,0x1
    80008c10:	b7450513          	addi	a0,a0,-1164 # 80009780 <digits+0x78>
    80008c14:	fffff097          	auipc	ra,0xfffff
    80008c18:	a68080e7          	jalr	-1432(ra) # 8000767c <panic>
	...
