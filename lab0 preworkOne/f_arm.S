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
	.file	"fibonacci.cpp"
	.text
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,4
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
    main:
    .fnstart                     ; 函数开始
.LFB1719:
    @ args = 0, pretend = 0, frame = 24
    @ frame_needed = 1, uses_anonymous_args = 0
    push    {r4, r7, lr}          ; 保存寄存器r4、r7、lr到栈中，以便后续调用
    .save {r4, r7, lr}           ; 保存寄存器r4、r7、lr
    .pad #28                     ; 填充，保持栈的对齐
    sub sp, sp, #28              ; 分配28字节的栈空间，用于局部变量
    .setfp r7, sp, #0            ; 设置r7为当前栈指针
    add r7, sp, #0              ; 将栈指针的值传给r7，建立新的栈帧

    ldr r4, .L6                  ; 将标签.L6的地址加载到r4寄存器
.LPIC0:
    add r4, pc                  ; 计算出一个位置无关的代码（PIC）的地址

    ldr r2, .L6+4                ; 将标签.L6+4的地址加载到r2寄存器
.LPIC1:
    add r2, pc                  ; 计算出一个位置无关的代码（PIC）的地址
    ldr r3, .L6+8                ; 将标签.L6+8的地址加载到r3寄存器
    ldr r3, [r2, r3]            ; 加载[r2 + r3]地址存储的值到r3寄存器
    ldr r3, [r3]                ; 加载[r3]地址存储的值到r3寄存器
    str r3, [r7, #20]           ; 将r3的值存储到[r7 + #20]地址

    mov r3, #0                  ; 将0存储到r3寄存器
    movs r3, #0                 ; 设置标志位，清零r3寄存器
    str r3, [r7, #4]            ; 将r3的值存储到[r7 + #4]地址

    movs r3, #1                 ; 设置r3为1
    str r3, [r7, #8]            ; 将r3的值存储到[r7 + #8]地址

    movs r3, #1                 ; 设置r3为1
    str r3, [r7, #12]           ; 将r3的值存储到[r7 + #12]地址

    mov r3, r7                  ; 将r7的值传给r3
    mov r1, r3                  ; 将r3的值传给r1
    ldr r3, .L6+12              ; 将标签.L6+12的地址加载到r3寄存器
    ldr r3, [r4, r3]            ; 加载[r4 + r3]地址存储的值到r3寄存器
    mov r0, r3                  ; 将r3的值传给r0
    bl _ZNSirsERi(PLT)          ; 调用函数_ZNSirsERi，用r0和[r1]作为参数

    ldr r1, [r7, #4]            ; 将[r7 + #4]地址存储的值加载到r1寄存器

    ldr r3, .L6+16              ; 将标签.L6+16的地址加载到r3寄存器
    ldr r3, [r4, r3]            ; 加载[r4 + r3]地址存储的值到r3寄存器

    mov r0, r3                  ; 将r3的值传给r0
    bl _ZNSolsEi(PLT)           ; 调用函数_ZNSolsEi，用r0作为参数

    mov r2, r0                  ; 将r0的值传给r2
    ldr r3, .L6+20              ; 将标签.L6+20的地址加载到r3寄存器
    ldr r3, [r4, r3]            ; 加载[r4 + r3]地址存储的值到r3寄存器

    mov r1, r3                  ; 将r3的值传给r1
    mov r0, r2                  ; 将r2的值传给r0

    bl _ZNSolsEPFRSoS_E(PLT)    ; 调用函数_ZNSolsEPFRSoS_E，用r0和[r1]作为参数

    ldr r1, [r7, #8]            ; 将[r7 + #8]地址存储的值加载到r1寄存器

    ldr r3, .L6+16              ; 将标签.L6+16的地址加载到r3寄存器
    ldr r3, [r4, r3]            ; 加载[r4 + r3]地址存储的值到r3寄存器

    mov r0, r3                  ; 将r3的值传给r0
    bl _ZNSolsEi(PLT)           ; 调用函数_ZNSolsEi，用r0作为参数

    mov r2, r0                  ; 将r0的值传给r2
    ldr r3, .L6+20              ; 将标签.L6+20的地址加载到r3寄存器
    ldr r3, [r4, r3]            ; 加载[r4 + r3]地址存储的值到r3寄存器

    mov r1, r3                  ; 将r3的值传给r1
    mov r0, r2                  ; 将r2的值传给r0

    bl _ZNSolsEPFRSoS_E(PLT)    ; 调用函数_ZNSolsEPFRSoS_E，用r0和[r1]作为参数

    b .L2                       ; 无条件跳转到.L2

.L3:
	ldr	r3, [r7, #8]        ; 从[r7 + #8]地址加载值到r3寄存器
	str	r3, [r7, #16]       ; 将r3的值存储到[r7 + #16]地址
	ldr	r2, [r7, #8]        ; 从[r7 + #8]地址加载值到r2寄存器
	ldr	r3, [r7, #4]        ; 从[r7 + #4]地址加载值到r3寄存器
	add	r3, r3, r2         ; 计算r3 = r3 + r2
	str	r3, [r7, #8]        ; 将r3的值存储到[r7 + #8]地址
	ldr	r1, [r7, #8]        ; 从[r7 + #8]地址加载值到r1寄存器
	ldr	r3, .L6+16          ; 将标签.L6+16的地址加载到r3寄存器
	ldr	r3, [r4, r3]        ; 从[r4 + r3]地址加载值到r3寄存器
	mov	r0, r3              ; 将r3的值传给r0
	bl	_ZNSolsEi(PLT)       ; 调用函数_ZNSolsEi，用r0作为参数
	mov	r2, r0              ; 将r0的值传给r2
	ldr	r3, .L6+20          ; 将标签.L6+20的地址加载到r3寄存器
	ldr	r3, [r4, r3]        ; 从[r4 + r3]地址加载值到r3寄存器
	mov	r1, r3              ; 将r3的值传给r1
	mov	r0, r2              ; 将r2的值传给r0
	bl	_ZNSolsEPFRSoS_E(PLT)  ; 调用函数_ZNSolsEPFRSoS_E，用r0和[r1]作为参数
	ldr	r3, [r7, #16]       ; 从[r7 + #16]地址加载值到r3寄存器
	str	r3, [r7, #4]        ; 将r3的值存储到[r7 + #4]地址
	ldr	r3, [r7, #12]       ; 从[r7 + #12]地址加载值到r3寄存器
	adds	r3, r3, #1          ; r3 = r3 + 1
	str	r3, [r7, #12]       ; 将r3的值存储到[r7 + #12]地址
.L2:
	ldr	r3, [r7]            ; 从[r7]地址加载值到r3寄存器
	ldr	r2, [r7, #12]       ; 从[r7 + #12]地址加载值到r2寄存器
	cmp	r2, r3              ; 比较r2和r3
	blt	.L3                  ; 如果 r2 < r3，则跳转到 .L3
	movs	r3, #0              ; 将0存储到r3寄存器
	ldr	r1, .L6+24          ; 将标签.L6+24的地址加载到r1寄存器
.LPIC2:
	add	r1, pc              ; 计算出一个位置无关的代码（PIC）的地址
	ldr	r2, .L6+8           ; 将标签.L6+8的地址加载到r2寄存器
	ldr	r2, [r1, r2]        ; 从[r1 + r2]地址加载值到r2寄存器
	ldr	r1, [r2]            ; 从[r2]地址加载值到r1寄存器
	ldr	r2, [r7, #20]       ; 从[r7 + #20]地址加载值到r2寄存器
	eors	r1, r2, r1          ; 异或运算 r1 = r2 XOR r1
	mov	r2, #0              ; 将0存储到r2寄存器
	beq	.L5                  ; 如果 r1 == 0，跳转到.L5
	bl	__stack_chk_fail(PLT)  ; 调用 __stack_chk_fail 函数
.L5:
	mov	r0, r3              ; 将r3的值传给r0
	adds	r7, r7, #28        ; r7 = r7 + 28，恢复栈帧
	mov	sp, r7              ; 恢复栈指针
	@ sp needed
	pop	{r4, r7, pc}         ; 恢复寄存器r4，r7和程序计数器pc并返回
.L7:
	.align	2                    ; 对齐到2字节

.L6:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC0+4)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC1+4)
	.word	__stack_chk_guard(GOT)
	.word	_ZSt3cin(GOT)
	.word	_ZSt4cout(GOT)
	.word	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(GOT)
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC2+4)
	.fnend
	.size	main, .-main
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	_Z41__static_initialization_and_destruction_0ii, %function
_Z41__static_initialization_and_destruction_0ii:
	.fnstart
.LFB2222:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}
	sub	sp, sp, #12
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]
	ldr	r4, .L11
.LPIC5:
	add	r4, pc
	ldr	r3, [r7, #4]
	cmp	r3, #1
	bne	.L10
	ldr	r3, [r7]
	movw	r2, #65535
	cmp	r3, r2
	bne	.L10
	ldr	r3, .L11+4
.LPIC3:
	add	r3, pc
	mov	r0, r3
	bl	_ZNSt8ios_base4InitC1Ev(PLT)
	ldr	r3, .L11+8
.LPIC4:
	add	r3, pc
	mov	r2, r3
	ldr	r3, .L11+12
	ldr	r3, [r4, r3]
	mov	r1, r3
	ldr	r3, .L11+16
.LPIC6:
	add	r3, pc
	mov	r0, r3
	bl	__aeabi_atexit(PLT)
.L10:
	nop
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r4, r7, pc}
.L12:
	.align	2
.L11:
	.word	_GLOBAL_OFFSET_TABLE_-(.LPIC5+4)
	.word	_ZStL8__ioinit-(.LPIC3+4)
	.word	__dso_handle-(.LPIC4+4)
	.word	_ZNSt8ios_base4InitD1Ev(GOT)
	.word	_ZStL8__ioinit-(.LPIC6+4)
	.cantunwind
	.fnend
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	_GLOBAL__sub_I_main, %function
_GLOBAL__sub_I_main:
	.fnstart
.LFB2223:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
	movw	r1, #65535
	movs	r0, #1
	bl	_Z41__static_initialization_and_destruction_0ii(PLT)
	pop	{r7, pc}
	.cantunwind
	.fnend
	.size	_GLOBAL__sub_I_main, .-_GLOBAL__sub_I_main
	.section	.init_array,"aw",%init_array
	.align	2
	.word	_GLOBAL__sub_I_main(target1)
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",%progbits

