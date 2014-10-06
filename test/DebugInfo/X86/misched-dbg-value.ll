; RUN: llc %s -mtriple=x86_64-apple-darwin -filetype=obj -o %t -enable-misched
; RUN: llvm-dwarfdump %t | FileCheck %s

; rdar://13183203
; Make sure when misched is enabled, we still have location information for
; function parameters.
; CHECK: .debug_info contents:
; CHECK: DW_TAG_compile_unit
; CHECK:   DW_TAG_subprogram
; CHECK-NOT: DW_TAG
; CHECK:     DW_AT_name {{.*}} "Proc8"
; CHECK-NOT: {{DW_TAG|NULL}}
; CHECK:     DW_TAG_formal_parameter
; CHECK-NOT: DW_TAG
; CHECK:       DW_AT_location
; CHECK-NOT: DW_TAG
; CHECK:       DW_AT_name {{.*}} "Array1Par"
; CHECK-NOT: {{DW_TAG|NULL}}
; CHECK:     DW_TAG_formal_parameter
; CHECK-NOT: DW_TAG
; CHECK:       DW_AT_location
; CHECK-NOT: DW_TAG
; CHECK:       DW_AT_name {{.*}} "Array2Par"
; CHECK-NOT: {{DW_TAG|NULL}}
; CHECK:     DW_TAG_formal_parameter
; CHECK-NOT: DW_TAG
; CHECK:       DW_AT_location
; CHECK-NOT: DW_TAG
; CHECK:       DW_AT_name {{.*}} "IntParI1"
; CHECK-NOT: {{DW_TAG|NULL}}
; CHECK:     DW_TAG_formal_parameter
; CHECK-NOT: DW_TAG
; CHECK:       DW_AT_location
; CHECK-NOT: DW_TAG
; CHECK:       DW_AT_name {{.*}} "IntParI2"

%struct.Record = type { %struct.Record*, i32, i32, i32, [31 x i8] }

@Version = global [4 x i8] c"1.1\00", align 1
@IntGlob = common global i32 0, align 4
@BoolGlob = common global i32 0, align 4
@Char1Glob = common global i8 0, align 1
@Char2Glob = common global i8 0, align 1
@Array1Glob = common global [51 x i32] zeroinitializer, align 16
@Array2Glob = common global [51 x [51 x i32]] zeroinitializer, align 16
@PtrGlb = common global %struct.Record* null, align 8
@PtrGlbNext = common global %struct.Record* null, align 8

define void @Proc8(i32* nocapture %Array1Par, [51 x i32]* nocapture %Array2Par, i32 %IntParI1, i32 %IntParI2) nounwind optsize {
entry:
  tail call void @llvm.dbg.value(metadata !{i32* %Array1Par}, i64 0, metadata !23, metadata !{metadata !"0x102"}), !dbg !64
  tail call void @llvm.dbg.value(metadata !{[51 x i32]* %Array2Par}, i64 0, metadata !24, metadata !{metadata !"0x102"}), !dbg !65
  tail call void @llvm.dbg.value(metadata !{i32 %IntParI1}, i64 0, metadata !25, metadata !{metadata !"0x102"}), !dbg !66
  tail call void @llvm.dbg.value(metadata !{i32 %IntParI2}, i64 0, metadata !26, metadata !{metadata !"0x102"}), !dbg !67
  %add = add i32 %IntParI1, 5, !dbg !68
  tail call void @llvm.dbg.value(metadata !{i32 %add}, i64 0, metadata !27, metadata !{metadata !"0x102"}), !dbg !68
  %idxprom = sext i32 %add to i64, !dbg !69
  %arrayidx = getelementptr inbounds i32* %Array1Par, i64 %idxprom, !dbg !69
  store i32 %IntParI2, i32* %arrayidx, align 4, !dbg !69
  %add3 = add nsw i32 %IntParI1, 6, !dbg !73
  %idxprom4 = sext i32 %add3 to i64, !dbg !73
  %arrayidx5 = getelementptr inbounds i32* %Array1Par, i64 %idxprom4, !dbg !73
  store i32 %IntParI2, i32* %arrayidx5, align 4, !dbg !73
  %add6 = add nsw i32 %IntParI1, 35, !dbg !74
  %idxprom7 = sext i32 %add6 to i64, !dbg !74
  %arrayidx8 = getelementptr inbounds i32* %Array1Par, i64 %idxprom7, !dbg !74
  store i32 %add, i32* %arrayidx8, align 4, !dbg !74
  tail call void @llvm.dbg.value(metadata !{i32 %add}, i64 0, metadata !28, metadata !{metadata !"0x102"}), !dbg !75
  br label %for.body, !dbg !75

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ %idxprom, %entry ], [ %indvars.iv.next, %for.body ]
  %IntIndex.046 = phi i32 [ %add, %entry ], [ %inc, %for.body ]
  %arrayidx13 = getelementptr inbounds [51 x i32]* %Array2Par, i64 %idxprom, i64 %indvars.iv, !dbg !77
  store i32 %add, i32* %arrayidx13, align 4, !dbg !77
  %inc = add nsw i32 %IntIndex.046, 1, !dbg !75
  tail call void @llvm.dbg.value(metadata !{i32 %inc}, i64 0, metadata !28, metadata !{metadata !"0x102"}), !dbg !75
  %cmp = icmp sgt i32 %inc, %add3, !dbg !75
  %indvars.iv.next = add i64 %indvars.iv, 1, !dbg !75
  br i1 %cmp, label %for.end, label %for.body, !dbg !75

for.end:                                          ; preds = %for.body
  %sub = add nsw i32 %IntParI1, 4, !dbg !78
  %idxprom14 = sext i32 %sub to i64, !dbg !78
  %arrayidx17 = getelementptr inbounds [51 x i32]* %Array2Par, i64 %idxprom, i64 %idxprom14, !dbg !78
  %0 = load i32* %arrayidx17, align 4, !dbg !78
  %inc18 = add nsw i32 %0, 1, !dbg !78
  store i32 %inc18, i32* %arrayidx17, align 4, !dbg !78
  %1 = load i32* %arrayidx, align 4, !dbg !79
  %add22 = add nsw i32 %IntParI1, 25, !dbg !79
  %idxprom23 = sext i32 %add22 to i64, !dbg !79
  %arrayidx25 = getelementptr inbounds [51 x i32]* %Array2Par, i64 %idxprom23, i64 %idxprom, !dbg !79
  store i32 %1, i32* %arrayidx25, align 4, !dbg !79
  store i32 5, i32* @IntGlob, align 4, !dbg !80
  ret void, !dbg !81
}

declare void @llvm.dbg.value(metadata, i64, metadata, metadata) nounwind readnone

attributes #0 = { nounwind optsize ssp uwtable }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!83}

!0 = metadata !{metadata !"0x11\0012\00clang version 3.3 (trunk 175015)\001\00\000\00\001", metadata !82, metadata !1, metadata !10, metadata !11, metadata !29,  metadata !10} ; [ DW_TAG_compile_unit ] [/Users/manmanren/test-Nov/rdar_13183203/test2/dry.c] [DW_LANG_C99]
!1 = metadata !{metadata !2}
!2 = metadata !{metadata !"0x4\00\00128\0032\0032\000\000\000", metadata !82, null, null, metadata !4, null, null, null} ; [ DW_TAG_enumeration_type ] [line 128, size 32, align 32, offset 0] [def] [from ]
!3 = metadata !{metadata !"0x29", metadata !82} ; [ DW_TAG_file_type ]
!4 = metadata !{metadata !5, metadata !6, metadata !7, metadata !8, metadata !9}
!5 = metadata !{metadata !"0x28\00Ident1\000"} ; [ DW_TAG_enumerator ] [Ident1 :: 0]
!6 = metadata !{metadata !"0x28\00Ident2\0010000"} ; [ DW_TAG_enumerator ] [Ident2 :: 10000]
!7 = metadata !{metadata !"0x28\00Ident3\0010001"} ; [ DW_TAG_enumerator ] [Ident3 :: 10001]
!8 = metadata !{metadata !"0x28\00Ident4\0010002"} ; [ DW_TAG_enumerator ] [Ident4 :: 10002]
!9 = metadata !{metadata !"0x28\00Ident5\0010003"} ; [ DW_TAG_enumerator ] [Ident5 :: 10003]
!10 = metadata !{}
!11 = metadata !{metadata !12}
!12 = metadata !{metadata !"0x2e\00Proc8\00Proc8\00\00180\000\001\000\006\000\001\00185", metadata !82, metadata !3, metadata !13, null, void (i32*, [51 x i32]*, i32, i32)* @Proc8, null, null, metadata !22} ; [ DW_TAG_subprogram ] [line 180] [def] [scope 185] [Proc8]
!13 = metadata !{metadata !"0x15\00\000\000\000\000\000\000", i32 0, null, null, metadata !14, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!14 = metadata !{null, metadata !15, metadata !17, metadata !21, metadata !21}
!15 = metadata !{metadata !"0xf\00\000\0064\0064\000\000", null, null, metadata !16} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!16 = metadata !{metadata !"0x24\00int\000\0032\0032\000\000\005", null, null} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!17 = metadata !{metadata !"0xf\00\000\0064\0064\000\000", null, null, metadata !18} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!18 = metadata !{metadata !"0x1\00\000\001632\0032\000\000", null, null, metadata !16, metadata !19, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 1632, align 32, offset 0] [from int]
!19 = metadata !{metadata !20}
!20 = metadata !{metadata !"0x21\000\0051"}       ; [ DW_TAG_subrange_type ] [0, 50]
!21 = metadata !{metadata !"0x16\00OneToFifty\00132\000\000\000\000", metadata !82, null, metadata !16} ; [ DW_TAG_typedef ] [OneToFifty] [line 132, size 0, align 0, offset 0] [from int]
!22 = metadata !{metadata !23, metadata !24, metadata !25, metadata !26, metadata !27, metadata !28}
!23 = metadata !{metadata !"0x101\00Array1Par\0016777397\000", metadata !12, metadata !3, metadata !15} ; [ DW_TAG_arg_variable ] [Array1Par] [line 181]
!24 = metadata !{metadata !"0x101\00Array2Par\0033554614\000", metadata !12, metadata !3, metadata !17} ; [ DW_TAG_arg_variable ] [Array2Par] [line 182]
!25 = metadata !{metadata !"0x101\00IntParI1\0050331831\000", metadata !12, metadata !3, metadata !21} ; [ DW_TAG_arg_variable ] [IntParI1] [line 183]
!26 = metadata !{metadata !"0x101\00IntParI2\0067109048\000", metadata !12, metadata !3, metadata !21} ; [ DW_TAG_arg_variable ] [IntParI2] [line 184]
!27 = metadata !{metadata !"0x100\00IntLoc\00186\000", metadata !12, metadata !3, metadata !21} ; [ DW_TAG_auto_variable ] [IntLoc] [line 186]
!28 = metadata !{metadata !"0x100\00IntIndex\00187\000", metadata !12, metadata !3, metadata !21} ; [ DW_TAG_auto_variable ] [IntIndex] [line 187]
!29 = metadata !{metadata !30, metadata !35, metadata !36, metadata !38, metadata !39, metadata !40, metadata !42, metadata !46, metadata !63}
!30 = metadata !{metadata !"0x34\00Version\00Version\00\00111\000\001", null, metadata !3, metadata !31, [4 x i8]* @Version, null} ; [ DW_TAG_variable ] [Version] [line 111] [def]
!31 = metadata !{metadata !"0x1\00\000\0032\008\000\000", null, null, metadata !32, metadata !33, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 32, align 8, offset 0] [from char]
!32 = metadata !{metadata !"0x24\00char\000\008\008\000\000\006", null, null} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!33 = metadata !{metadata !34}
!34 = metadata !{metadata !"0x21\000\004"}        ; [ DW_TAG_subrange_type ] [0, 3]
!35 = metadata !{metadata !"0x34\00IntGlob\00IntGlob\00\00171\000\001", null, metadata !3, metadata !16, i32* @IntGlob, null} ; [ DW_TAG_variable ] [IntGlob] [line 171] [def]
!36 = metadata !{metadata !"0x34\00BoolGlob\00BoolGlob\00\00172\000\001", null, metadata !3, metadata !37, i32* @BoolGlob, null} ; [ DW_TAG_variable ] [BoolGlob] [line 172] [def]
!37 = metadata !{metadata !"0x16\00boolean\00149\000\000\000\000", metadata !82, null, metadata !16} ; [ DW_TAG_typedef ] [boolean] [line 149, size 0, align 0, offset 0] [from int]
!38 = metadata !{metadata !"0x34\00Char1Glob\00Char1Glob\00\00173\000\001", null, metadata !3, metadata !32, i8* @Char1Glob, null} ; [ DW_TAG_variable ] [Char1Glob] [line 173] [def]
!39 = metadata !{metadata !"0x34\00Char2Glob\00Char2Glob\00\00174\000\001", null, metadata !3, metadata !32, i8* @Char2Glob, null} ; [ DW_TAG_variable ] [Char2Glob] [line 174] [def]
!40 = metadata !{metadata !"0x34\00Array1Glob\00Array1Glob\00\00175\000\001", null, metadata !3, metadata !41, [51 x i32]* @Array1Glob, null} ; [ DW_TAG_variable ] [Array1Glob] [line 175] [def]
!41 = metadata !{metadata !"0x16\00Array1Dim\00135\000\000\000\000", metadata !82, null, metadata !18} ; [ DW_TAG_typedef ] [Array1Dim] [line 135, size 0, align 0, offset 0] [from ]
!42 = metadata !{metadata !"0x34\00Array2Glob\00Array2Glob\00\00176\000\001", null, metadata !3, metadata !43, [51 x [51 x i32]]* @Array2Glob, null} ; [ DW_TAG_variable ] [Array2Glob] [line 176] [def]
!43 = metadata !{metadata !"0x16\00Array2Dim\00136\000\000\000\000", metadata !82, null, metadata !44} ; [ DW_TAG_typedef ] [Array2Dim] [line 136, size 0, align 0, offset 0] [from ]
!44 = metadata !{metadata !"0x1\00\000\0083232\0032\000\000", null, null, metadata !16, metadata !45, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 83232, align 32, offset 0] [from int]
!45 = metadata !{metadata !20, metadata !20}
!46 = metadata !{metadata !"0x34\00PtrGlb\00PtrGlb\00\00177\000\001", null, metadata !3, metadata !47, %struct.Record** @PtrGlb, null} ; [ DW_TAG_variable ] [PtrGlb] [line 177] [def]
!47 = metadata !{metadata !"0x16\00RecordPtr\00148\000\000\000\000", metadata !82, null, metadata !48} ; [ DW_TAG_typedef ] [RecordPtr] [line 148, size 0, align 0, offset 0] [from ]
!48 = metadata !{metadata !"0xf\00\000\0064\0064\000\000", null, null, metadata !49} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from RecordType]
!49 = metadata !{metadata !"0x16\00RecordType\00147\000\000\000\000", metadata !82, null, metadata !50} ; [ DW_TAG_typedef ] [RecordType] [line 147, size 0, align 0, offset 0] [from Record]
!50 = metadata !{metadata !"0x13\00Record\00138\00448\0064\000\000\000", metadata !82, null, null, metadata !51, null, i32 0, null} ; [ DW_TAG_structure_type ] [Record] [line 138, size 448, align 64, offset 0] [def] [from ]
!51 = metadata !{metadata !52, metadata !54, metadata !56, metadata !57, metadata !58}
!52 = metadata !{metadata !"0xd\00PtrComp\00140\0064\0064\000\000", metadata !82, metadata !50, metadata !53} ; [ DW_TAG_member ] [PtrComp] [line 140, size 64, align 64, offset 0] [from ]
!53 = metadata !{metadata !"0xf\00\000\0064\0064\000\000", null, null, metadata !50} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from Record]
!54 = metadata !{metadata !"0xd\00Discr\00141\0032\0032\0064\000", metadata !82, metadata !50, metadata !55} ; [ DW_TAG_member ] [Discr] [line 141, size 32, align 32, offset 64] [from Enumeration]
!55 = metadata !{metadata !"0x16\00Enumeration\00128\000\000\000\000", metadata !82, null, metadata !2} ; [ DW_TAG_typedef ] [Enumeration] [line 128, size 0, align 0, offset 0] [from ]
!56 = metadata !{metadata !"0xd\00EnumComp\00142\0032\0032\0096\000", metadata !82, metadata !50, metadata !55} ; [ DW_TAG_member ] [EnumComp] [line 142, size 32, align 32, offset 96] [from Enumeration]
!57 = metadata !{metadata !"0xd\00IntComp\00143\0032\0032\00128\000", metadata !82, metadata !50, metadata !21} ; [ DW_TAG_member ] [IntComp] [line 143, size 32, align 32, offset 128] [from OneToFifty]
!58 = metadata !{metadata !"0xd\00StringComp\00144\00248\008\00160\000", metadata !82, metadata !50, metadata !59} ; [ DW_TAG_member ] [StringComp] [line 144, size 248, align 8, offset 160] [from String30]
!59 = metadata !{metadata !"0x16\00String30\00134\000\000\000\000", metadata !82, null, metadata !60} ; [ DW_TAG_typedef ] [String30] [line 134, size 0, align 0, offset 0] [from ]
!60 = metadata !{metadata !"0x1\00\000\00248\008\000\000", null, null, metadata !32, metadata !61, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 248, align 8, offset 0] [from char]
!61 = metadata !{metadata !62}
!62 = metadata !{metadata !"0x21\000\0031"}       ; [ DW_TAG_subrange_type ] [0, 30]
!63 = metadata !{metadata !"0x34\00PtrGlbNext\00PtrGlbNext\00\00178\000\001", null, metadata !3, metadata !47, %struct.Record** @PtrGlbNext, null} ; [ DW_TAG_variable ] [PtrGlbNext] [line 178] [def]
!64 = metadata !{i32 181, i32 0, metadata !12, null}
!65 = metadata !{i32 182, i32 0, metadata !12, null}
!66 = metadata !{i32 183, i32 0, metadata !12, null}
!67 = metadata !{i32 184, i32 0, metadata !12, null}
!68 = metadata !{i32 189, i32 0, metadata !12, null}
!69 = metadata !{i32 190, i32 0, metadata !12, null}
!73 = metadata !{i32 191, i32 0, metadata !12, null}
!74 = metadata !{i32 192, i32 0, metadata !12, null}
!75 = metadata !{i32 193, i32 0, metadata !76, null}
!76 = metadata !{metadata !"0xb\00193\000\000", metadata !82, metadata !12} ; [ DW_TAG_lexical_block ] [/Users/manmanren/test-Nov/rdar_13183203/test2/dry.c]
!77 = metadata !{i32 194, i32 0, metadata !76, null}
!78 = metadata !{i32 195, i32 0, metadata !12, null}
!79 = metadata !{i32 196, i32 0, metadata !12, null}
!80 = metadata !{i32 197, i32 0, metadata !12, null}
!81 = metadata !{i32 198, i32 0, metadata !12, null}
!82 = metadata !{metadata !"dry.c", metadata !"/Users/manmanren/test-Nov/rdar_13183203/test2"}
!83 = metadata !{i32 1, metadata !"Debug Info Version", i32 2}
