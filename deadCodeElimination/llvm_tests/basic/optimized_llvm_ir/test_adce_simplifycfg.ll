; ModuleID = '<stdin>'
source_filename = "../test.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@global = global i32 0, align 4
@.str = private unnamed_addr constant [9 x i8] c"%d %d %f\00", align 1

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca float, align 4
  %6 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i32 0, i32 0), i32* %3, i32* %4, float* %5)
  %7 = load i32, i32* %3, align 4
  %8 = load i32, i32* %4, align 4
  %9 = icmp sgt i32 %7, %8
  %10 = load i32, i32* %3, align 4
  %11 = load i32, i32* %4, align 4
  br i1 %9, label %12, label %17

; <label>:12:                                     ; preds = %2
  %13 = add nsw i32 %10, %11
  %14 = sitofp i32 %13 to float
  %15 = load float, float* %5, align 4
  %16 = fmul float %15, %14
  store float %16, float* %5, align 4
  br label %22

; <label>:17:                                     ; preds = %2
  %18 = sdiv i32 %10, %11
  %19 = sitofp i32 %18 to float
  %20 = load float, float* %5, align 4
  %21 = fsub float %20, %19
  store float %21, float* %5, align 4
  br label %22

; <label>:22:                                     ; preds = %17, %12
  store i32 5, i32* %3, align 4
  store i32 5, i32* %4, align 4
  store float 5.000000e+00, float* %5, align 4
  store i32 1, i32* @global, align 4
  ret i32 1
}

declare i32 @__isoc99_scanf(i8*, ...) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
