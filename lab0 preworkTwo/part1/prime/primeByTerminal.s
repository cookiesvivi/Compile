	.arch armv7-a
	.fpu vfpv3-d16
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"prime.c"
	.text
	.global	__aeabi_idivmod
	.section	.rodata
	.align	2
.LC0:
	.ascii	"YES\000"
	.align	2
.LC1:
	.ascii	"NO\000"
	.text
	.align	2
	.global	IsPrime
	.syntax unified
	.arm
	.type	IsPrime, %function
IsPrime:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	mov	r3, #1
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-16]
	cmp	r3, #1
	bgt	.L2
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L3
.L2:
	mov	r3, #2
	str	r3, [fp, #-8]
	b	.L4
.L6:
	ldr	r3, [fp, #-16]
	ldr	r1, [fp, #-8]
	mov	r0, r3
	bl	__aeabi_idivmod
	mov	r3, r1
	cmp	r3, #0
	bne	.L5
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L3
.L5:
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L4:
	ldr	r3, [fp, #-8]
	mul	r3, r3, r3
	ldr	r2, [fp, #-16]
	cmp	r2, r3
	bge	.L6
.L3:
	ldr	r3, [fp, #-12]
	cmp	r3, #0
	beq	.L7
	movw	r0, #:lower16:.LC0
	movt	r0, #:upper16:.LC0
	bl	puts
	b	.L9
.L7:
	movw	r0, #:lower16:.LC1
	movt	r0, #:upper16:.LC1
	bl	puts
.L9:
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	IsPrime, .-IsPrime
	.section	.rodata
	.align	2
.LC2:
	.ascii	"%d\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r3, .L13
	ldr	r3, [r3]
	str	r3, [fp, #-8]
	mov	r3, #0
	sub	r3, fp, #12
	mov	r1, r3
	movw	r0, #:lower16:.LC2
	movt	r0, #:upper16:.LC2
	bl	__isoc99_scanf
	ldr	r3, [fp, #-12]
	mov	r0, r3
	bl	IsPrime
	mov	r3, #0
	ldr	r2, .L13
	ldr	r1, [r2]
	ldr	r2, [fp, #-8]
	eors	r1, r2, r1
	mov	r2, #0
	beq	.L12
	bl	__stack_chk_fail
.L12:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L14:
	.align	2
.L13:
	.word	__stack_chk_guard
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",%progbits
