; RUN: llc -mcpu=corei7 -mtriple=x86_64-linux < %s | FileCheck %s -check-prefix=CHECK
; RUN: llc -mcpu=corei7 -mtriple=x86_64-linux -outline-optional-branches < %s | FileCheck %s -check-prefix=CHECK-OUTLINE

define void @foo(i32 %t1, i32 %t2) {
; Test that we lift the call to 'c' up to immediately follow the call to 'b'
; when we disable the cfg conflict check.
;
; CHECK-LABEL: foo:
; CHECK: callq a
; CHECK: callq b
; CHECK: callq c
; CHECK: callq d
;
; CHECK-OUTLINE-LABEL: foo:
; CHECK-OUTLINE: callq b
; CHECK-OUTLINE: callq c
; CHECK-OUTLINE: callq d
; CHECK-OUTLINE: callq a

entry:
  %cmp = icmp eq i32 %t1, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:
  call void @a()
  br label %if.end

if.end:
  call void @b()
  br label %hotbranch

hotbranch:
  %cmp2 = icmp eq i32 %t2, 0
  br i1 %cmp2, label %if.then2, label %if.end2, !prof !1

if.then2:
  call void @c()
  br label %if.end2

if.end2:
  call void @d()
  ret void
}

declare void @a()
declare void @b()
declare void @c()
declare void @d()

!1 = !{!"branch_weights", i32 64, i32 4}
