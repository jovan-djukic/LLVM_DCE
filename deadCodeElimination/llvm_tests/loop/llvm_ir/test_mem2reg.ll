; ModuleID = 'test.ll'
source_filename = "../test.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@global = global i32 0, align 4
@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 {
  %3 = alloca [10 x i32], align 16
  %4 = bitcast [10 x i32]* %3 to i8*
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 40, i32 16, i1 false)
  br label %5

; <label>:5:                                      ; preds = %11, %2
  %.02 = phi i32 [ 0, %2 ], [ %12, %11 ]
  %6 = icmp slt i32 %.02, 10
  br i1 %6, label %7, label %13

; <label>:7:                                      ; preds = %5
  %8 = sext i32 %.02 to i64
  %9 = getelementptr inbounds [10 x i32], [10 x i32]* %3, i64 0, i64 %8
  %10 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0), i32* %9)
  br label %11

; <label>:11:                                     ; preds = %7
  %12 = add nsw i32 %.02, 1
  br label %5

; <label>:13:                                     ; preds = %5
  br label %14

; <label>:14:                                     ; preds = %21, %13
  %.01 = phi i32 [ 0, %13 ], [ %20, %21 ]
  %.0 = phi i32 [ 0, %13 ], [ %22, %21 ]
  %15 = icmp slt i32 %.0, 10
  br i1 %15, label %16, label %23

; <label>:16:                                     ; preds = %14
  %17 = sext i32 %.0 to i64
  %18 = getelementptr inbounds [10 x i32], [10 x i32]* %3, i64 0, i64 %17
  %19 = load i32, i32* %18, align 4
  %20 = add nsw i32 %.01, %19
  br label %21

; <label>:21:                                     ; preds = %16
  %22 = add nsw i32 %.0, 1
  br label %14

; <label>:23:                                     ; preds = %14
  store i32 1, i32* @global, align 4
  ret i32 1
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #1

declare i32 @__isoc99_scanf(i8*, ...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
