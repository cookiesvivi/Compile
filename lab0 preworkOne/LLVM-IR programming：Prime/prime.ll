target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"YES\0A\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"NO\0A\00", align 1

define i32 @main() {

  %1 = alloca i32, align 4   ;返回值
  %2 = alloca i32, align 4   ;n
  %3 = alloca i32, align 4   ;isprime
  %4 = alloca i32, align 4   ;i
  store i32 0, i32* %1, align 4  ;返回值预设
  store i32 1, i32* %3, align 4  ;isprime预设为1
  %5 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32* noundef %2)
  %6 = load i32, i32* %2, align 4 ;加载n
  %7 = icmp sle i32 %6, 1   ;n与1的比较结果
  br i1 %7, label %8, label %9  ;有条件跳转，n小于等于(%7为1)跳到label %8,否则跳到label %9

8:                                                ; preds = %0
  store i32 0, i32* %3, align 4    ;isprime设为0          
  br label %27   ;无条件跳转，已判断结束，直接跳到输出

9:                                                ; preds = %0
  store i32 2, i32* %4, align 4   ;将i设置为2，为for循环做准备
  br label %10   ;无条件跳转，判断未结束

10:                                               ; preds = %23, %9
  %11 = load i32, i32* %4, align 4   ;加载i
  %12 = load i32, i32* %4, align 4   ;加载i
  %13 = mul nsw i32 %11, %12         ;i*i
  %14 = load i32, i32* %2, align 4   ;加载n
  %15 = icmp sle i32 %13, %14        ;for语句的循环条件判断，i*i<=n
  br i1 %15, label %16, label %26    ;条件跳转，继续循环或跳出循环

16:                                               ; preds = %10
  %17 = load i32, i32* %2, align 4   ;加载n 
  %18 = load i32, i32* %4, align 4   ;加载i 
  %19 = srem i32 %17, %18            ;n%i的结构
  %20 = icmp eq i32 %19, 0           ;比较n%i的结果是否为0
  br i1 %20, label %21, label %22    ;条件跳转，继续循环或跳出循环

21:                                               ; preds = %16
  store i32 0, i32* %3, align 4      ;isprime设为0 
  br label %26

22:                                               ; preds = %16
  br label %23

23:                                               ; preds = %22
  %24 = load i32, i32* %4, align 4   ;加载i 
  %25 = add nsw i32 %24, 1           ;i++
  store i32 %25, i32* %4, align 4    ;更新i
  br label %10                       ;循环

26:                                               ; preds = %21, %10
  br label %27

27:                                               ; preds = %26, %8
  %28 = load i32, i32* %3, align 4 
  %29 = icmp ne i32 %28, 0          ;根据isprime的值判断是不是素数
  br i1 %29, label %30, label %32

30:                                               ; preds = %27
  %31 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0))
  br label %34

32:                                               ; preds = %27
  %33 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i64 0, i64 0))
  br label %34

34:                                               ; preds = %32, %30
  ret i32 0
}

declare i32 @__isoc99_scanf(i8* noundef, ...) 

declare i32 @printf(i8* noundef, ...) 


