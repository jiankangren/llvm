; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s

; FIXME: The vzeroupper added by the VZeroUpperInserter pass is unnecessary in these tests.

define <4 x float> @zeroupper_v4f32(<8 x float> *%x, <8 x float> %y) nounwind {
; CHECK-LABEL: zeroupper_v4f32:
; CHECK:       # BB#0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $48, %rsp
; CHECK-NEXT:    vmovups %ymm0, (%rsp) # 32-byte Spill
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq the_unknown
; CHECK-NEXT:    vmovups (%rsp), %ymm0 # 32-byte Reload
; CHECK-NEXT:    vaddps (%rbx), %ymm0, %ymm0
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm1
; CHECK-NEXT:    vaddps %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    addq $48, %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  call void @llvm.x86.avx.vzeroupper()
  call void @the_unknown()
  %loadx = load <8 x float>, <8 x float> *%x, align 32
  %sum = fadd <8 x float> %loadx, %y
  %lo = shufflevector <8 x float> %sum, <8 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %hi = shufflevector <8 x float> %sum, <8 x float> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %res = fadd <4 x float> %lo, %hi
  ret <4 x float> %res
}

define <8 x float> @zeroupper_v8f32(<8 x float> %x) nounwind {
; CHECK-LABEL: zeroupper_v8f32:
; CHECK:       # BB#0:
; CHECK-NEXT:    subq $56, %rsp
; CHECK-NEXT:    vmovups %ymm0, (%rsp) # 32-byte Spill
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq the_unknown
; CHECK-NEXT:    vmovups (%rsp), %ymm0 # 32-byte Reload
; CHECK-NEXT:    addq $56, %rsp
; CHECK-NEXT:    retq
  call void @llvm.x86.avx.vzeroupper()
  call void @the_unknown()
  ret <8 x float> %x
}

define <4 x float> @zeroall_v4f32(<8 x float> *%x, <8 x float> %y) nounwind {
; CHECK-LABEL: zeroall_v4f32:
; CHECK:       # BB#0:
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    subq $48, %rsp
; CHECK-NEXT:    vmovups %ymm0, (%rsp) # 32-byte Spill
; CHECK-NEXT:    movq %rdi, %rbx
; CHECK-NEXT:    vzeroall
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq the_unknown
; CHECK-NEXT:    vmovups (%rsp), %ymm0 # 32-byte Reload
; CHECK-NEXT:    vaddps (%rbx), %ymm0, %ymm0
; CHECK-NEXT:    vextractf128 $1, %ymm0, %xmm1
; CHECK-NEXT:    vaddps %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    addq $48, %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  call void @llvm.x86.avx.vzeroall()
  call void @the_unknown()
  %loadx = load <8 x float>, <8 x float> *%x, align 32
  %sum = fadd <8 x float> %loadx, %y
  %lo = shufflevector <8 x float> %sum, <8 x float> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %hi = shufflevector <8 x float> %sum, <8 x float> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %res = fadd <4 x float> %lo, %hi
  ret <4 x float> %res
}

define <8 x float> @zeroall_v8f32(<8 x float> %x) nounwind {
; CHECK-LABEL: zeroall_v8f32:
; CHECK:       # BB#0:
; CHECK-NEXT:    subq $56, %rsp
; CHECK-NEXT:    vmovups %ymm0, (%rsp) # 32-byte Spill
; CHECK-NEXT:    vzeroall
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq the_unknown
; CHECK-NEXT:    vmovups (%rsp), %ymm0 # 32-byte Reload
; CHECK-NEXT:    addq $56, %rsp
; CHECK-NEXT:    retq
  call void @llvm.x86.avx.vzeroall()
  call void @the_unknown()
  ret <8 x float> %x
}

declare void @llvm.x86.avx.vzeroupper() nounwind readnone
declare void @llvm.x86.avx.vzeroall() nounwind readnone
declare void @the_unknown() nounwind

