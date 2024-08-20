; ModuleID = '<stdin>'
source_filename = "../test.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@global = global i32 0, align 4
@.str = private unnamed_addr constant [9 x i8] c"%d %d %f\00", align 1
@0 = private unnamed_addr constant [261 x i8] c"USE NUMBER 3 : \0A\09  %6 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i32 0, i32 0), i32* %3, i32* %4, float* %5)\0ADEFINITIONS: \0A \09  %3 = alloca i32, align 4\0A\09  %4 = alloca i32, align 4\0A\09  %5 = alloca float, align 4\0A\00"
@1 = private unnamed_addr constant [95 x i8] c"USE NUMBER 4 : \0A\09  %7 = load i32, i32* %3, align 4\0ADEFINITIONS: \0A \09  %3 = alloca i32, align 4\0A\00"
@2 = private unnamed_addr constant [95 x i8] c"USE NUMBER 5 : \0A\09  %8 = load i32, i32* %4, align 4\0ADEFINITIONS: \0A \09  %4 = alloca i32, align 4\0A\00"
@3 = private unnamed_addr constant [130 x i8] c"USE NUMBER 6 : \0A\09  %9 = icmp sgt i32 %7, %8\0ADEFINITIONS: \0A \09  %7 = load i32, i32* %3, align 4\0A\09  %8 = load i32, i32* %4, align 4\0A\00"
@4 = private unnamed_addr constant [94 x i8] c"USE NUMBER 7 : \0A\09  br i1 %9, label %10, label %17\0ADEFINITIONS: \0A \09  %9 = icmp sgt i32 %7, %8\0A\00"
@5 = private unnamed_addr constant [96 x i8] c"USE NUMBER 8 : \0A\09  %11 = load i32, i32* %3, align 4\0ADEFINITIONS: \0A \09  %3 = alloca i32, align 4\0A\00"
@6 = private unnamed_addr constant [96 x i8] c"USE NUMBER 9 : \0A\09  %12 = load i32, i32* %4, align 4\0ADEFINITIONS: \0A \09  %4 = alloca i32, align 4\0A\00"
@7 = private unnamed_addr constant [135 x i8] c"USE NUMBER 10 : \0A\09  %13 = add nsw i32 %11, %12\0ADEFINITIONS: \0A \09  %11 = load i32, i32* %3, align 4\0A\09  %12 = load i32, i32* %4, align 4\0A\00"
@8 = private unnamed_addr constant [96 x i8] c"USE NUMBER 11 : \0A\09  %14 = sitofp i32 %13 to float\0ADEFINITIONS: \0A \09  %13 = add nsw i32 %11, %12\0A\00"
@9 = private unnamed_addr constant [103 x i8] c"USE NUMBER 12 : \0A\09  %15 = load float, float* %5, align 4\0ADEFINITIONS: \0A \09  %5 = alloca float, align 4\0A\00"
@10 = private unnamed_addr constant [135 x i8] c"USE NUMBER 13 : \0A\09  %16 = fmul float %15, %14\0ADEFINITIONS: \0A \09  %15 = load float, float* %5, align 4\0A\09  %14 = sitofp i32 %13 to float\0A\00"
@11 = private unnamed_addr constant [131 x i8] c"USE NUMBER 14 : \0A\09  store float %16, float* %5, align 4\0ADEFINITIONS: \0A \09  %16 = fmul float %15, %14\0A\09  %5 = alloca float, align 4\0A\00"
@12 = private unnamed_addr constant [97 x i8] c"USE NUMBER 16 : \0A\09  %18 = load i32, i32* %3, align 4\0ADEFINITIONS: \0A \09  %3 = alloca i32, align 4\0A\00"
@13 = private unnamed_addr constant [97 x i8] c"USE NUMBER 17 : \0A\09  %19 = load i32, i32* %4, align 4\0ADEFINITIONS: \0A \09  %4 = alloca i32, align 4\0A\00"
@14 = private unnamed_addr constant [132 x i8] c"USE NUMBER 18 : \0A\09  %20 = sdiv i32 %18, %19\0ADEFINITIONS: \0A \09  %18 = load i32, i32* %3, align 4\0A\09  %19 = load i32, i32* %4, align 4\0A\00"
@15 = private unnamed_addr constant [93 x i8] c"USE NUMBER 19 : \0A\09  %21 = sitofp i32 %20 to float\0ADEFINITIONS: \0A \09  %20 = sdiv i32 %18, %19\0A\00"
@16 = private unnamed_addr constant [103 x i8] c"USE NUMBER 20 : \0A\09  %22 = load float, float* %5, align 4\0ADEFINITIONS: \0A \09  %5 = alloca float, align 4\0A\00"
@17 = private unnamed_addr constant [135 x i8] c"USE NUMBER 21 : \0A\09  %23 = fsub float %22, %21\0ADEFINITIONS: \0A \09  %22 = load float, float* %5, align 4\0A\09  %21 = sitofp i32 %20 to float\0A\00"
@18 = private unnamed_addr constant [131 x i8] c"USE NUMBER 22 : \0A\09  store float %23, float* %5, align 4\0ADEFINITIONS: \0A \09  %23 = fsub float %22, %21\0A\09  %5 = alloca float, align 4\0A\00"
@19 = private unnamed_addr constant [94 x i8] c"USE NUMBER 24 : \0A\09  store i32 5, i32* %3, align 4\0ADEFINITIONS: \0A \09  %3 = alloca i32, align 4\0A\00"
@20 = private unnamed_addr constant [94 x i8] c"USE NUMBER 25 : \0A\09  store i32 5, i32* %4, align 4\0ADEFINITIONS: \0A \09  %4 = alloca i32, align 4\0A\00"
@21 = private unnamed_addr constant [111 x i8] c"USE NUMBER 26 : \0A\09  store float 5.000000e+00, float* %5, align 4\0ADEFINITIONS: \0A \09  %5 = alloca float, align 4\0A\00"

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca float, align 4
  call void @__print_du_chain(i8* getelementptr inbounds ([261 x i8], [261 x i8]* @0, i32 0, i32 0))
  %6 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i32 0, i32 0), i32* %3, i32* %4, float* %5)
  call void @__print_du_chain(i8* getelementptr inbounds ([95 x i8], [95 x i8]* @1, i32 0, i32 0))
  %7 = load i32, i32* %3, align 4
  call void @__print_du_chain(i8* getelementptr inbounds ([95 x i8], [95 x i8]* @2, i32 0, i32 0))
  %8 = load i32, i32* %4, align 4
  call void @__print_du_chain(i8* getelementptr inbounds ([130 x i8], [130 x i8]* @3, i32 0, i32 0))
  %9 = icmp sgt i32 %7, %8
  call void @__print_du_chain(i8* getelementptr inbounds ([94 x i8], [94 x i8]* @4, i32 0, i32 0))
  br i1 %9, label %10, label %17

; <label>:10:                                     ; preds = %2
  call void @__print_du_chain(i8* getelementptr inbounds ([96 x i8], [96 x i8]* @5, i32 0, i32 0))
  %11 = load i32, i32* %3, align 4
  call void @__print_du_chain(i8* getelementptr inbounds ([96 x i8], [96 x i8]* @6, i32 0, i32 0))
  %12 = load i32, i32* %4, align 4
  call void @__print_du_chain(i8* getelementptr inbounds ([135 x i8], [135 x i8]* @7, i32 0, i32 0))
  %13 = add nsw i32 %11, %12
  call void @__print_du_chain(i8* getelementptr inbounds ([96 x i8], [96 x i8]* @8, i32 0, i32 0))
  %14 = sitofp i32 %13 to float
  call void @__print_du_chain(i8* getelementptr inbounds ([103 x i8], [103 x i8]* @9, i32 0, i32 0))
  %15 = load float, float* %5, align 4
  call void @__print_du_chain(i8* getelementptr inbounds ([135 x i8], [135 x i8]* @10, i32 0, i32 0))
  %16 = fmul float %15, %14
  call void @__print_du_chain(i8* getelementptr inbounds ([131 x i8], [131 x i8]* @11, i32 0, i32 0))
  store float %16, float* %5, align 4
  br label %24

; <label>:17:                                     ; preds = %2
  call void @__print_du_chain(i8* getelementptr inbounds ([97 x i8], [97 x i8]* @12, i32 0, i32 0))
  %18 = load i32, i32* %3, align 4
  call void @__print_du_chain(i8* getelementptr inbounds ([97 x i8], [97 x i8]* @13, i32 0, i32 0))
  %19 = load i32, i32* %4, align 4
  call void @__print_du_chain(i8* getelementptr inbounds ([132 x i8], [132 x i8]* @14, i32 0, i32 0))
  %20 = sdiv i32 %18, %19
  call void @__print_du_chain(i8* getelementptr inbounds ([93 x i8], [93 x i8]* @15, i32 0, i32 0))
  %21 = sitofp i32 %20 to float
  call void @__print_du_chain(i8* getelementptr inbounds ([103 x i8], [103 x i8]* @16, i32 0, i32 0))
  %22 = load float, float* %5, align 4
  call void @__print_du_chain(i8* getelementptr inbounds ([135 x i8], [135 x i8]* @17, i32 0, i32 0))
  %23 = fsub float %22, %21
  call void @__print_du_chain(i8* getelementptr inbounds ([131 x i8], [131 x i8]* @18, i32 0, i32 0))
  store float %23, float* %5, align 4
  br label %24

; <label>:24:                                     ; preds = %17, %10
  call void @__print_du_chain(i8* getelementptr inbounds ([94 x i8], [94 x i8]* @19, i32 0, i32 0))
  store i32 5, i32* %3, align 4
  call void @__print_du_chain(i8* getelementptr inbounds ([94 x i8], [94 x i8]* @20, i32 0, i32 0))
  store i32 5, i32* %4, align 4
  call void @__print_du_chain(i8* getelementptr inbounds ([111 x i8], [111 x i8]* @21, i32 0, i32 0))
  store float 5.000000e+00, float* %5, align 4
  store i32 1, i32* @global, align 4
  ret i32 1
}

declare i32 @__isoc99_scanf(i8*, ...) #1

declare void @__print_du_chain(i8*)

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
