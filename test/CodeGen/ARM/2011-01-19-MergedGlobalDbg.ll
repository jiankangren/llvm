; RUN: llc -filetype=obj < %s | llvm-dwarfdump -debug-dump=info - | FileCheck %s

target datalayout = "e-p:32:32:32-i1:8:32-i8:8:32-i16:16:32-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:32:64-v128:32:128-a0:0:32-n32"
target triple = "thumbv7-apple-darwin10"

@x1 = internal global i8 1, align 1
@x2 = internal global i8 1, align 1
@x3 = internal global i8 1, align 1
@x4 = internal global i8 1, align 1
@x5 = global i8 1, align 1

; Check debug info output for merged global.
; DW_AT_location
; 0x03 DW_OP_addr
; 0x.. .long __MergedGlobals
; 0x10 DW_OP_constu
; 0x.. offset
; 0x22 DW_OP_plus

; CHECK: DW_TAG_variable
; CHECK-NOT: DW_TAG
; CHECK:    DW_AT_name {{.*}} "x1"
; CHECK-NOT: {{DW_TAG|NULL}}
; CHECK:    DW_AT_location [DW_FORM_exprloc]        (<0x8> 03 [[ADDR:.. .. .. ..]] 10 00 22  )
; CHECK: DW_TAG_variable
; CHECK-NOT: DW_TAG
; CHECK:    DW_AT_name {{.*}} "x2"
; CHECK-NOT: {{DW_TAG|NULL}}
; CHECK:    DW_AT_location [DW_FORM_exprloc]        (<0x8> 03 [[ADDR]] 10 01 22  )

define zeroext i8 @get1(i8 zeroext %a) nounwind optsize {
entry:
  tail call void @llvm.dbg.value(metadata !{i8 %a}, i64 0, metadata !10, metadata !{metadata !"0x102"}), !dbg !30
  %0 = load i8* @x1, align 4, !dbg !30
  tail call void @llvm.dbg.value(metadata !{i8 %0}, i64 0, metadata !11, metadata !{metadata !"0x102"}), !dbg !30
  store i8 %a, i8* @x1, align 4, !dbg !30
  ret i8 %0, !dbg !31
}

declare void @llvm.dbg.value(metadata, i64, metadata, metadata) nounwind readnone

define zeroext i8 @get2(i8 zeroext %a) nounwind optsize {
entry:
  tail call void @llvm.dbg.value(metadata !{i8 %a}, i64 0, metadata !18, metadata !{metadata !"0x102"}), !dbg !32
  %0 = load i8* @x2, align 4, !dbg !32
  tail call void @llvm.dbg.value(metadata !{i8 %0}, i64 0, metadata !19, metadata !{metadata !"0x102"}), !dbg !32
  store i8 %a, i8* @x2, align 4, !dbg !32
  ret i8 %0, !dbg !33
}

define zeroext i8 @get3(i8 zeroext %a) nounwind optsize {
entry:
  tail call void @llvm.dbg.value(metadata !{i8 %a}, i64 0, metadata !21, metadata !{metadata !"0x102"}), !dbg !34
  %0 = load i8* @x3, align 4, !dbg !34
  tail call void @llvm.dbg.value(metadata !{i8 %0}, i64 0, metadata !22, metadata !{metadata !"0x102"}), !dbg !34
  store i8 %a, i8* @x3, align 4, !dbg !34
  ret i8 %0, !dbg !35
}

define zeroext i8 @get4(i8 zeroext %a) nounwind optsize {
entry:
  tail call void @llvm.dbg.value(metadata !{i8 %a}, i64 0, metadata !24, metadata !{metadata !"0x102"}), !dbg !36
  %0 = load i8* @x4, align 4, !dbg !36
  tail call void @llvm.dbg.value(metadata !{i8 %0}, i64 0, metadata !25, metadata !{metadata !"0x102"}), !dbg !36
  store i8 %a, i8* @x4, align 4, !dbg !36
  ret i8 %0, !dbg !37
}

define zeroext i8 @get5(i8 zeroext %a) nounwind optsize {
entry:
  tail call void @llvm.dbg.value(metadata !{i8 %a}, i64 0, metadata !27, metadata !{metadata !"0x102"}), !dbg !38
  %0 = load i8* @x5, align 4, !dbg !38
  tail call void @llvm.dbg.value(metadata !{i8 %0}, i64 0, metadata !28, metadata !{metadata !"0x102"}), !dbg !38
  store i8 %a, i8* @x5, align 4, !dbg !38
  ret i8 %0, !dbg !39
}

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!49}

!0 = metadata !{metadata !"0x2e\00get1\00get1\00get1\004\000\001\000\006\00256\001\004", metadata !47, metadata !1, metadata !3, null, i8 (i8)* @get1, null, null, metadata !42} ; [ DW_TAG_subprogram ]
!1 = metadata !{metadata !"0x29", metadata !47} ; [ DW_TAG_file_type ]
!2 = metadata !{metadata !"0x11\001\004.2.1 (Based on Apple Inc. build 5658) (LLVM build 2369.8)\001\00\000\00\000", metadata !47, metadata !48, metadata !48, metadata !40, metadata !41,  metadata !48} ; [ DW_TAG_compile_unit ]
!3 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", metadata !47, metadata !1, null, metadata !4, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!4 = metadata !{metadata !5, metadata !5}
!5 = metadata !{metadata !"0x24\00_Bool\000\008\008\000\000\002", metadata !47, metadata !1} ; [ DW_TAG_base_type ]
!6 = metadata !{metadata !"0x2e\00get2\00get2\00get2\007\000\001\000\006\00256\001\007", metadata !47, metadata !1, metadata !3, null, i8 (i8)* @get2, null, null, metadata !43} ; [ DW_TAG_subprogram ]
!7 = metadata !{metadata !"0x2e\00get3\00get3\00get3\0010\000\001\000\006\00256\001\0010", metadata !47, metadata !1, metadata !3, null, i8 (i8)* @get3, null, null, metadata !44} ; [ DW_TAG_subprogram ]
!8 = metadata !{metadata !"0x2e\00get4\00get4\00get4\0013\000\001\000\006\00256\001\0013", metadata !47, metadata !1, metadata !3, null, i8 (i8)* @get4, null, null, metadata !45} ; [ DW_TAG_subprogram ]
!9 = metadata !{metadata !"0x2e\00get5\00get5\00get5\0016\000\001\000\006\00256\001\0016", metadata !47, metadata !1, metadata !3, null, i8 (i8)* @get5, null, null, metadata !46} ; [ DW_TAG_subprogram ]
!10 = metadata !{metadata !"0x101\00a\004\000", metadata !0, metadata !1, metadata !5} ; [ DW_TAG_arg_variable ]
!11 = metadata !{metadata !"0x100\00b\004\000", metadata !12, metadata !1, metadata !5} ; [ DW_TAG_auto_variable ]
!12 = metadata !{metadata !"0xb\004\000\000", metadata !47, metadata !0} ; [ DW_TAG_lexical_block ]
!13 = metadata !{metadata !"0x34\00x1\00x1\00\003\001\001", metadata !1, metadata !1, metadata !5, i8* @x1, null} ; [ DW_TAG_variable ]
!14 = metadata !{metadata !"0x34\00x2\00x2\00\006\001\001", metadata !1, metadata !1, metadata !5, i8* @x2, null} ; [ DW_TAG_variable ]
!15 = metadata !{metadata !"0x34\00x3\00x3\00\009\001\001", metadata !1, metadata !1, metadata !5, i8* @x3, null} ; [ DW_TAG_variable ]
!16 = metadata !{metadata !"0x34\00x4\00x4\00\0012\001\001", metadata !1, metadata !1, metadata !5, i8* @x4, null} ; [ DW_TAG_variable ]
!17 = metadata !{metadata !"0x34\00x5\00x5\00\0015\000\001", metadata !1, metadata !1, metadata !5, i8* @x5, null} ; [ DW_TAG_variable ]
!18 = metadata !{metadata !"0x101\00a\007\000", metadata !6, metadata !1, metadata !5} ; [ DW_TAG_arg_variable ]
!19 = metadata !{metadata !"0x100\00b\007\000", metadata !20, metadata !1, metadata !5} ; [ DW_TAG_auto_variable ]
!20 = metadata !{metadata !"0xb\007\000\001", metadata !47, metadata !6} ; [ DW_TAG_lexical_block ]
!21 = metadata !{metadata !"0x101\00a\0010\000", metadata !7, metadata !1, metadata !5} ; [ DW_TAG_arg_variable ]
!22 = metadata !{metadata !"0x100\00b\0010\000", metadata !23, metadata !1, metadata !5} ; [ DW_TAG_auto_variable ]
!23 = metadata !{metadata !"0xb\0010\000\002", metadata !47, metadata !7} ; [ DW_TAG_lexical_block ]
!24 = metadata !{metadata !"0x101\00a\0013\000", metadata !8, metadata !1, metadata !5} ; [ DW_TAG_arg_variable ]
!25 = metadata !{metadata !"0x100\00b\0013\000", metadata !26, metadata !1, metadata !5} ; [ DW_TAG_auto_variable ]
!26 = metadata !{metadata !"0xb\0013\000\003", metadata !47, metadata !8} ; [ DW_TAG_lexical_block ]
!27 = metadata !{metadata !"0x101\00a\0016\000", metadata !9, metadata !1, metadata !5} ; [ DW_TAG_arg_variable ]
!28 = metadata !{metadata !"0x100\00b\0016\000", metadata !29, metadata !1, metadata !5} ; [ DW_TAG_auto_variable ]
!29 = metadata !{metadata !"0xb\0016\000\004", metadata !47, metadata !9} ; [ DW_TAG_lexical_block ]
!30 = metadata !{i32 4, i32 0, metadata !0, null}
!31 = metadata !{i32 4, i32 0, metadata !12, null}
!32 = metadata !{i32 7, i32 0, metadata !6, null}
!33 = metadata !{i32 7, i32 0, metadata !20, null}
!34 = metadata !{i32 10, i32 0, metadata !7, null}
!35 = metadata !{i32 10, i32 0, metadata !23, null}
!36 = metadata !{i32 13, i32 0, metadata !8, null}
!37 = metadata !{i32 13, i32 0, metadata !26, null}
!38 = metadata !{i32 16, i32 0, metadata !9, null}
!39 = metadata !{i32 16, i32 0, metadata !29, null}
!40 = metadata !{metadata !0, metadata !6, metadata !7, metadata !8, metadata !9}
!41 = metadata !{metadata !13, metadata !14, metadata !15, metadata !16, metadata !17}
!42 = metadata !{metadata !10, metadata !11}
!43 = metadata !{metadata !18, metadata !19}
!44 = metadata !{metadata !21, metadata !22}
!45 = metadata !{metadata !24, metadata !25}
!46 = metadata !{metadata !27, metadata !28}
!47 = metadata !{metadata !"foo.c", metadata !"/tmp/"}
!48 = metadata !{}
!49 = metadata !{i32 1, metadata !"Debug Info Version", i32 2}
