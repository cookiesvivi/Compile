.file "fibonacci.cpp"       ; 源文件名
.text                      ; 代码段开始
.local _ZStL8__ioinit      ; 本地符号，通常是C++标准库的初始化
.comm _ZStL8__ioinit,1,1   ; 分配一个字节的未初始化的共享内存，通常是C++标准库的初始化
.globl main               ; 将 main 函数标记为全局可见
.type main, @function      ; 声明 main 为一个函数
main:                      ; 函数入口
.LFB1731:                  ; 标记这是一个函数块的开始
.cfi_startproc             ; 声明一个过程的开始
endbr64                    ; 设置endbr64保护
pushq %rbp                 ; 保存调用者的栈帧指针
.cfi_def_cfa_offset 16     ; 设置CFA（规范化堆栈指针）的偏移量
.cfi_offset 6, -16         ; 保存rbp到CFA的偏移量
movq %rsp, %rbp            ; 将栈指针rsp的值传给rbp，建立新的栈帧
.cfi_def_cfa_register 6    ; 声明CFA是rbp寄存器
subq $32, %rsp             ; 为局部变量分配32字节的栈空间
movq %fs:40, %rax          ; 将fs段寄存器偏移40字节处的值加载到rax寄存器
movq %rax, -8(%rbp)        ; 将rax寄存器的值存储到rbp偏移为-8的位置
xorl %eax, %eax            ; 将eax寄存器清零
movl $0, -28(%rbp)         ; 将0存储到rbp偏移为-28的位置
movl $1, -24(%rbp)         ; 将1存储到rbp偏移为-24的位置
movl $1, -20(%rbp)         ; 将1存储到rbp偏移为-20的位置
leaq -32(%rbp), %rax       ; 计算出一个地址，即rbp减去32，将地址存储到rax寄存器
movq %rax, %rsi            ; 将rax寄存器的值传给rsi寄存器
leaq _ZSt3cin(%rip), %rax  ; 将cin的地址传给rax寄存器
movq %rax, %rdi            ; 将cin的地址传给rdi寄存器
call _ZNSirsERi@PLT        ; 调用cin的操作符>>函数，将输入的值存储到rsi寄存器指向的地址
movl -28(%rbp), %eax       ; 将-28(%rbp)地址存储的值传给eax寄存器
movl %eax, %esi            ; 将eax寄存器的值传给esi寄存器
leaq _ZSt4cout(%rip), %rax ; 将cout的地址传给rax寄存器
movq %rax, %rdi            ; 将cout的地址传给rdi寄存器
call _ZNSolsEi@PLT         ; 调用cout的操作符<<函数，输出esi寄存器的值
movq _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rdx ; 获取endl的地址
movq %rdx, %rsi            ; 将endl的地址传给rsi寄存器
movq %rax, %rdi            ; 将cout的地址传给rdi寄存器
call _ZNSolsEPFRSoS_E@PLT   ; 调用endl
movl -24(%rbp), %eax       ; 将-24(%rbp)地址存储的值传给eax寄存器
movl %eax, %esi            ; 将eax寄存器的值传给esi寄存器
leaq _ZSt4cout(%rip), %rax ; 将cout的地址传给rax寄存器
movq %rax, %rdi            ; 将cout的地址传给rdi寄存器
call _ZNSolsEi@PLT         ; 调用cout的操作符<<函数，输出esi寄存器的值
movq _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rdx ; 获取endl的地址
movq %rdx, %rsi            ; 将endl的地址传给rsi寄存器
movq %rax, %rdi            ; 将cout的地址传给rdi寄存器
call _ZNSolsEPFRSoS_E@PLT   ; 调用endl
jmp .L2                     ; 无条件跳转到.L2

.L3:
movl -24(%rbp), %eax        ; 将-24(%rbp)地址存储的值传给eax寄存器
movl %eax, -12(%rbp)        ; 将eax寄存器的值存储到-12(%rbp)地址
movl -28(%rbp), %eax        ; 将-28(%rbp)地址存储的值传给eax寄存器
addl %eax, -24(%rbp)        ; 将eax寄存器的值加到-24(%rbp)地址存储的值上
movl -24(%rbp), %eax        ; 将-24(%rbp)地址存储的值传给eax寄存器
movl %eax, %esi             ; 将eax寄存器的值传给esi寄存器
leaq _ZSt4cout(%rip), %rax  ; 将cout的地址传给rax寄存器
movq %rax, %rdi             ; 将cout的地址传给rdi寄存器
call _ZNSolsEi@PLT          ; 调用cout的操作符<<函数，输出esi寄存器的值
movq _ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rdx ; 获取endl的地址
movq %rdx, %rsi             ; 将endl的地址传给rsi寄存器
movq %rax, %rdi             ; 将cout的地址传给rdi寄存器
call _ZNSolsEPFRSoS_E@PLT    ; 调用endl
movl -12(%rbp), %eax        ; 将-12(%rbp)地址存储的值传给eax寄存器
movl %eax, -28(%rbp)        ; 将eax寄存器的值存储到-28(%rbp)地址
addl $1, -20(%rbp)          ; -20(%rbp)地址存储的值加1

.L2:
movl -32(%rbp), %eax        ; 将-32(%rbp)地址存储的值传给eax寄存器
cmpl %eax, -20(%rbp)        ; 比较eax寄存器和-20(%rbp)地址存储的值
jl .L3                      ; 如果小于，则跳转到.L3

movl $0, -16(%rbp)          ; 将0存储到-16(%rbp)地址

jmp .L4                      ; 无条件跳转到.L4

.L5:
addl $1, -16(%rbp)          ; -16(%rbp)地址存储的值加1

.L4:
cmpl $0, -16(%rbp)          ; 比较-16(%rbp)地址存储的值和0

jne .L5                      ; 如果不等于，则跳转到.L5

movl $0, %eax                ; 将0传给eax寄存器
movq -8(%rbp), %rdx          ; 将-8(%rbp)地址存储的值传给rdx寄存器
subq %fs:40, %rdx            ; 将fs段寄存器偏移40字节处的值减去rdx寄存器的值

je .L7                       ; 如果等于，则跳转到.L7

call __stack_chk_fail@PLT   ; 调用__stack_chk_fail函数，通常用于堆栈溢出检查

.L7:
leave                        ; 函数结束前的清理工作
.cfi_def_cfa 7, 8            ; 声明CFA
ret                          ; 返回
.cfi_endproc                 ; 声明过程结束
.LFE1731:                    ; 标记这是一个函数块的结束
.size main, .-main           ; 函数main的大小
.type _Z41__static_initialization_and_destruction_0ii, @function  ; 声明一个名为_Z41__static_initialization_and_destruction_0ii的函数
_Z41__static_initialization_and_destruction_0ii:
.LFB2231:                   ; 标记这是一个函数块的开始
.cfi_startproc              ; 声明一个过程的开始
endbr64                     ; 设置endbr64保护
pushq %rbp                  ; 保存调用者的栈帧指针
.cfi_def_cfa_offset 16      ; 设置CFA（规范化堆栈指针）的偏移量
.cfi_offset 6, -16          ; 保存rbp到CFA的偏移量
movq %rsp, %rbp             ; 将栈指针rsp的值传给rbp，建立新的栈帧
.cfi_def_cfa_register 6     ; 声明CFA是rbp寄存器
subq $16, %rsp              ; 为局部变量分配16字节的栈空间
movl %edi, -4(%rbp)         ; 将edi寄存器的值存储到-4(%rbp)地址
movl %esi, -8(%rbp)         ; 将esi寄存器的值存储到-8(%rbp)地址
cmpl $1, -4(%rbp)           ; 比较-4(%rbp)地址存储的值和1
jne .L10                     ; 如果不等于，则跳转到.L10

cmpl $65535, -8(%rbp)       ; 比较-8(%rbp)地址存储的值和65535
jne .L10                     ; 如果不等于，则跳转到.L10

leaq _ZStL8__ioinit(%rip), %rax  ; 将_ZStL8__ioinit的地址传给rax寄存器
movq %rax, %rdi             ; 将_ZStL8__ioinit的地址传给rdi寄存器
call _ZNSt8ios_base4InitC1Ev@PLT  ; 调用ios_base的InitC1构造函数
leaq __dso_handle(%rip), %rax    ; 将__dso_handle的地址传给rax寄存器
movq %rax, %rdx             ; 将__dso_handle的地址传给rdx寄存器
leaq _ZStL8__ioinit(%rip), %rax  ; 将_ZStL8__ioinit的地址传给rax寄存器
movq %rax, %rsi             ; 将_ZStL8__ioinit的地址传给rsi寄存器
movq _ZNSt8ios_base4InitD1Ev@GOTPCREL(%rip), %rax  ; 获取ios_base的InitD1析构函数的地址
movq %rax, %rdi             ; 将ios_base的InitD1析构函数的地址传给rdi寄存器
call __cxa_atexit@PLT       ; 调用__cxa_atexit函数

.L10:                        ; .L10标记
nop                          ; 什么也不做
leave                        ; 函数结束前的清理工作
.cfi_def_cfa 7, 8            ; 声明CFA
ret                          ; 返回
.cfi_endproc                 ; 声明过程结束
.LFE2231:                    ; 标记这是一个函数块的结束
.size _Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii  ; 函数的大小
.type _GLOBAL__sub_I_main, @function  ; 声明一个名为_GLOBAL__sub_I_main的函数
_GLOBAL__sub_I_main:
.LFB2232:                   ; 标记这是一个函数块的开始
.cfi_startproc              ; 声明一个过程的开始
endbr64                     ; 设置endbr64保护
pushq %rbp                  ; 保存调用者的栈帧指针
.cfi_def_cfa_offset 16      ; 设置CFA（规范化堆栈指针）的偏移量
.cfi_offset 6, -16          ; 保存rbp到CFA的偏移量
movq %rsp, %rbp             ; 将栈指针rsp的值传给rbp，建立新的栈帧
.cfi_def_cfa_register 6     ; 声明CFA是rbp寄存器
movl $65535, %esi           ; 将65535传给esi寄存器
movl $1, %edi               ; 将1传给edi寄存器
call _Z41__static_initialization_and_destruction_0ii  ; 调用_Z41__static_initialization_and_destruction_0ii函数
popq %rbp                   ; 恢复调用者的栈帧指针
.cfi_def_cfa 7, 8           ; 声明CFA
ret                         ; 返回
.cfi_endproc                 ; 声明过程结束
.LFE2232:                    ; 标记这是一个函数块的结束
.size _GLOBAL__sub_I_main, .-_GLOBAL__sub_I_main  ; 函数的大小
.section .init_array,"aw"   ; .init_array节的开始
.align 8                    ; 对齐到8字节
.quad _GLOBAL__sub_I_main   ; 将_GLOBAL__sub_I_main函数的地址存储在.init_array中
.hidden __dso_handle        ; 隐藏__dso_handle符号
.ident "GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"  ; 编译器版本信息
.section .note.GNU-stack,"",@progbits  ; .note.GNU-stack节
.section .note.gnu.property,"a"  ; .note.gnu.property节

.align 8                    ; 对齐到8字节
.long 1f - 0f                ; 下一个节的偏移量减去当前节的偏移量
.long 4f - 1f                ; 下一个节的偏移量减去当前节的偏移量
.long 5                     ; 属性标记
0:
.string "GNU"                ; 字符串 "GNU"
1:
.align 8                    ; 对齐到8字节
.long 0xc0000002            ; 属性标记
.long 3f - 2f                ; 下一个节的偏移量减去当前节的偏移量
2:
.long 0x3                   ; 属性标记
3:
.align 8                    ; 对齐到8字节
4:
