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

	.text
	.global	__aeabi_idivmod

	.section	.rodata
    .align	2
_str0:
	.ascii	"YES\n\0"
    .align	2
_str1:
	.ascii	"NO\n\0"
    .align	2
_str2:
	.ascii	"%d\0"

	.text
	.align	2
	.global	IsPrime
	.syntax unified
	.arm
	.type	IsPrime, %function
IsPrime:
    push {fp, lr}
	add	fp, sp, #4       @开辟新栈桢
	sub	sp, sp, #16      @开辟局部变量空间
	str	r0, [fp, #-16]   @n值
	mov	r2, #1
	str	r2, [fp, #-12]   @isPrime值，初始为1
	ldr	r2, [fp, #-16]
	cmp	r2, #1
	bgt	.check_prime     @如果r3(n)的值大于1，跳转到L2，准备去执行else语句里的操作

.set_not_prime:          @否则将isPrime至0后就可以去最后的输出部分了
	mov	r2, #0           
	str	r2, [fp, #-12]
	b	.print_result

.check_prime:             @i值，初始为2
	mov	r2, #2
	str	r2, [fp, #-8]
	b	.loop_condition

.loop_body:               @循环体
	ldr	r2, [fp, #-16]
	ldr	r1, [fp, #-8]
	mov	r0, r2
	bl	__aeabi_idivmod
	mov	r2, r1
	cmp	r2, #0
	bne	.not_divisible    @如果n%i不等于0,跳到not_divisible
	mov	r2, #0
	str	r2, [fp, #-12]    @如果整除了将isPrime至0，不是素数，跳到打印结果处
	b	.print_result

.not_divisible:           @如果不能整除说明还有可能是素数，i自增后继续判断
	ldr	r2, [fp, #-8]
	add	r2, r2, #1
	str	r2, [fp, #-8]

.loop_condition:
	ldr	r3, [fp, #-8]     @判断i*i<=n,仍满足的时候就跳到loop_body继续循环
	mul	r3, r3, r3
	ldr	r2, [fp, #-16]
	cmp	r2, r3
	bge	.loop_body
    
.print_result:
    ldr r2, [fp, #-12]
    cmp r2, #1
    bne .is_not_prime  @为1就输出YES，否则输出NO
    ldr r0, _bridge
    bl  printf
    b   .end

.is_not_prime:
    ldr r0, _bridge+4
    bl  printf

.end:
	sub	sp, fp, #4
	pop	{fp, pc}
	.size	IsPrime, .-IsPrime

	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.type	main, %function
main:
	push {fp, lr}
	add	fp, sp, #4  @开辟新栈桢
	sub	sp, sp, #8  @开辟局部变量
	sub	r3, fp, #8
	mov	r1, r3         @输入的n
    ldr r0, _bridge+8
	bl	__isoc99_scanf @调用scanf函数
	ldr	r3, [fp, #-8]
	mov	r0, r3      @加载n到r0中，即将调用的IsPrime函数的参数
	bl	IsPrime
	mov	r3, #0
	mov	r0, r3      @main的返回值，return 0
	sub	sp, fp, #4  @栈桢恢复
	pop	{fp, pc}
	.size	main, .-main

	_bridge:
    .word  _str0
    .word  _str1
    .word  _str2

	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",%progbits
