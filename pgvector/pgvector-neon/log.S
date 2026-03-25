
test:     file format elf64-littleaarch64


Disassembly of section .interp:

0000000000000238 <.interp>:
 238:	62696c2f 	.inst	0x62696c2f ; undefined
 23c:	2d646c2f 	ldp	s15, s27, [x1, #-224]
 240:	756e696c 	.inst	0x756e696c ; undefined
 244:	61612d78 	.inst	0x61612d78 ; undefined
 248:	36686372 	tbz	w18, #13, eb4 <_Z20test_vector_distancev+0x2d4>
 24c:	6f732e34 	.inst	0x6f732e34 ; undefined
 250:	Address 0x250 is out of bounds.


Disassembly of section .note.gnu.build-id:

0000000000000254 <.note.gnu.build-id>:
 254:	00000004 	udf	#4
 258:	00000014 	udf	#20
 25c:	00000003 	udf	#3
 260:	00554e47 	.inst	0x00554e47 ; undefined
 264:	4aa54a77 	eon	w23, w19, w5, asr #18
 268:	3794226f 	tbnz	w15, #18, ffffffffffff86b4 <__bss_end__+0xfffffffffffd863c>
 26c:	d79ba0d8 	.inst	0xd79ba0d8 ; undefined
 270:	9f96e7b6 	.inst	0x9f96e7b6 ; undefined
 274:	2d64514b 	ldp	s11, s20, [x10, #-224]

Disassembly of section .note.ABI-tag:

0000000000000278 <__abi_tag>:
 278:	00000004 	udf	#4
 27c:	00000010 	udf	#16
 280:	00000001 	udf	#1
 284:	00554e47 	.inst	0x00554e47 ; undefined
 288:	00000000 	udf	#0
 28c:	00000003 	udf	#3
 290:	00000007 	udf	#7
 294:	00000000 	udf	#0

Disassembly of section .gnu.hash:

0000000000000298 <.gnu.hash>:
 298:	00000001 	udf	#1
 29c:	00000001 	udf	#1
 2a0:	00000001 	udf	#1
	...

Disassembly of section .dynsym:

00000000000002b8 <.dynsym>:
	...
 2d4:	000b0003 	.inst	0x000b0003 ; undefined
 2d8:	000007e8 	udf	#2024
	...
 2ec:	00170003 	.inst	0x00170003 ; undefined
 2f0:	00020058 	.inst	0x00020058 ; undefined
	...
 300:	0000006b 	udf	#107
 304:	00000012 	udf	#18
	...
 318:	00000046 	udf	#70
 31c:	00000012 	udf	#18
	...
 330:	0000009e 	udf	#158
 334:	00000012 	udf	#18
	...
 348:	000000b5 	udf	#181
 34c:	00000022 	udf	#34
	...
 360:	000000a3 	udf	#163
 364:	00000012 	udf	#18
	...
 378:	00000071 	udf	#113
 37c:	00000012 	udf	#18
	...
 390:	00000078 	udf	#120
 394:	00000012 	udf	#18
	...
 3a8:	000000cb 	udf	#203
 3ac:	00000012 	udf	#18
	...
 3c0:	00000010 	udf	#16
 3c4:	00000020 	udf	#32
	...
 3d8:	00000001 	udf	#1
 3dc:	00000020 	udf	#32
	...
 3f0:	0000002c 	udf	#44
 3f4:	00000020 	udf	#32
	...
 408:	000000c4 	udf	#196
 40c:	00000012 	udf	#18
	...
 420:	00000099 	udf	#153
 424:	00000012 	udf	#18
	...

Disassembly of section .dynstr:

0000000000000438 <.dynstr>:
 438:	675f5f00 	.inst	0x675f5f00 ; undefined
 43c:	5f6e6f6d 	.inst	0x5f6e6f6d ; undefined
 440:	72617473 	.inst	0x72617473 ; undefined
 444:	005f5f74 	.inst	0x005f5f74 ; undefined
 448:	4d54495f 	.inst	0x4d54495f ; undefined
 44c:	7265645f 	.inst	0x7265645f ; undefined
 450:	73696765 	.inst	0x73696765 ; undefined
 454:	54726574 	bc.mi	e5100 <__bss_end__+0xc5088>  // bc.first
 458:	6f6c434d 	mls	v13.8h, v26.8h, v12.h[2]
 45c:	6154656e 	.inst	0x6154656e ; undefined
 460:	00656c62 	.inst	0x00656c62 ; undefined
 464:	4d54495f 	.inst	0x4d54495f ; undefined
 468:	6765725f 	.inst	0x6765725f ; undefined
 46c:	65747369 	fnmls	z9.h, p4/m, z27.h, z20.h
 470:	434d5472 	.inst	0x434d5472 ; undefined
 474:	656e6f6c 	fnmls	z12.h, p3/m, z27.h, z14.h
 478:	6c626154 	ldnp	d20, d24, [x10, #-480]
 47c:	5a5f0065 	.inst	0x5a5f0065 ; undefined
 480:	3674534e 	tbz	w14, #14, ffffffffffff8ee8 <__bss_end__+0xfffffffffffd8e70>
 484:	6f726863 	umlsl2	v3.4s, v3.8h, v2.h[7]
 488:	5f336f6e 	.inst	0x5f336f6e ; undefined
 48c:	32313256 	orr	w22, w18, #0xfff8000
 490:	74737973 	.inst	0x74737973 ; undefined
 494:	635f6d65 	.inst	0x635f6d65 ; undefined
 498:	6b636f6c 	.inst	0x6b636f6c ; undefined
 49c:	776f6e33 	.inst	0x776f6e33 ; undefined
 4a0:	5f007645 	.inst	0x5f007645 ; undefined
 4a4:	6d616e5a 	ldp	d26, d27, [x18, #-496]
 4a8:	645a5f00 	fcmla	z0.h, p7/m, z24.h, z26.h, #180
 4ac:	00765061 	.inst	0x00765061 ; undefined
 4b0:	78635f5f 	.inst	0x78635f5f ; undefined
 4b4:	68745f61 	.inst	0x68745f61 ; undefined
 4b8:	5f776f72 	.inst	0x5f776f72 ; undefined
 4bc:	5f646162 	.inst	0x5f646162 ; undefined
 4c0:	61727261 	.inst	0x61727261 ; undefined
 4c4:	656e5f79 	fnmla	z25.h, p7/m, z27.h, z14.h
 4c8:	656c5f77 	fnmla	z23.h, p7/m, z27.h, z12.h
 4cc:	6874676e 	.inst	0x6874676e ; undefined
 4d0:	72717300 	.inst	0x72717300 ; undefined
 4d4:	75700074 	.inst	0x75700074 ; undefined
 4d8:	5f007374 	.inst	0x5f007374 ; undefined
 4dc:	62696c5f 	.inst	0x62696c5f ; undefined
 4e0:	74735f63 	.inst	0x74735f63 ; undefined
 4e4:	5f747261 	sqdmlsl	s1, h19, v4.h[3]
 4e8:	6e69616d 	rsubhn2	v13.8h, v11.4s, v9.4s
 4ec:	635f5f00 	.inst	0x635f5f00 ; undefined
 4f0:	665f6178 	.inst	0x665f6178 ; undefined
 4f4:	6c616e69 	ldnp	d9, d27, [x19, #-496]
 4f8:	00657a69 	.inst	0x00657a69 ; undefined
 4fc:	6e697270 	uabdl2	v16.4s, v19.8h, v9.8h
 500:	61006674 	.inst	0x61006674 ; undefined
 504:	74726f62 	.inst	0x74726f62 ; undefined
 508:	62696c00 	.inst	0x62696c00 ; undefined
 50c:	63647473 	.inst	0x63647473 ; undefined
 510:	732e2b2b 	.inst	0x732e2b2b ; undefined
 514:	00362e6f 	.inst	0x00362e6f ; NYI
 518:	6d62696c 	ldp	d12, d26, [x11, #-480]
 51c:	2e6f732e 	uabdl	v14.4s, v25.4h, v15.4h
 520:	696c0036 	ldpsw	x22, x0, [x1, #-160]
 524:	732e6362 	.inst	0x732e6362 ; undefined
 528:	00362e6f 	.inst	0x00362e6f ; NYI
 52c:	42494c47 	.inst	0x42494c47 ; undefined
 530:	2e325f43 	uqrshl	v3.8b, v26.8b, v18.8b
 534:	47003731 	.inst	0x47003731 ; undefined
 538:	4342494c 	.inst	0x4342494c ; undefined
 53c:	332e325f 	.inst	0x332e325f ; undefined
 540:	58430034 	ldr	x20, 86544 <__bss_end__+0x664cc>
 544:	49424158 	.inst	0x49424158 ; undefined
 548:	332e315f 	.inst	0x332e315f ; undefined
 54c:	4700382e 	.inst	0x4700382e ; undefined
 550:	4342494c 	.inst	0x4342494c ; undefined
 554:	335f5858 	.inst	0x335f5858 ; undefined
 558:	312e342e 	adds	w14, w1, #0xb8d
 55c:	4c470039 	.inst	0x4c470039 ; undefined
 560:	58434249 	ldr	x9, 86da8 <__bss_end__+0x66d30>
 564:	2e335f58 	uqrshl	v24.8b, v26.8b, v19.8b
 568:	Address 0x568 is out of bounds.


Disassembly of section .gnu.version:

000000000000056a <.gnu.version>:
 56a:	00000000 	udf	#0
 56e:	00020000 	.inst	0x00020000 ; undefined
 572:	00040003 	.inst	0x00040003 ; undefined
 576:	00050004 	.inst	0x00050004 ; undefined
 57a:	00060002 	.inst	0x00060002 ; undefined
 57e:	00010004 	.inst	0x00010004 ; undefined
 582:	00010001 	.inst	0x00010001 ; undefined
 586:	00070004 	.inst	0x00070004 ; undefined

Disassembly of section .gnu.version_r:

0000000000000590 <.gnu.version_r>:
 590:	00010001 	.inst	0x00010001 ; undefined
 594:	000000e0 	udf	#224
 598:	00000010 	udf	#16
 59c:	00000020 	udf	#32
 5a0:	06969197 	.inst	0x06969197 ; undefined
 5a4:	00070000 	.inst	0x00070000 ; undefined
 5a8:	000000f4 	udf	#244
 5ac:	00000000 	udf	#0
 5b0:	00020001 	.inst	0x00020001 ; undefined
 5b4:	000000ea 	udf	#234
 5b8:	00000010 	udf	#16
 5bc:	00000030 	udf	#48
 5c0:	069691b4 	.inst	0x069691b4 ; undefined
 5c4:	00050000 	.inst	0x00050000 ; undefined
 5c8:	000000ff 	udf	#255
 5cc:	00000010 	udf	#16
 5d0:	06969197 	.inst	0x06969197 ; undefined
 5d4:	00040000 	.inst	0x00040000 ; undefined
 5d8:	000000f4 	udf	#244
 5dc:	00000000 	udf	#0
 5e0:	00030001 	.inst	0x00030001 ; undefined
 5e4:	000000d1 	udf	#209
 5e8:	00000010 	udf	#16
 5ec:	00000000 	udf	#0
 5f0:	0bafd178 	.inst	0x0bafd178 ; undefined
 5f4:	00060000 	.inst	0x00060000 ; undefined
 5f8:	0000010a 	udf	#266
 5fc:	00000010 	udf	#16
 600:	0297f869 	.inst	0x0297f869 ; undefined
 604:	00030000 	.inst	0x00030000 ; undefined
 608:	00000117 	udf	#279
 60c:	00000010 	udf	#16
 610:	08922974 	stllrb	w20, [x11]
 614:	00020000 	.inst	0x00020000 ; undefined
 618:	00000126 	udf	#294
 61c:	00000000 	udf	#0

Disassembly of section .rela.dyn:

0000000000000620 <.rela.dyn>:
 620:	0001fda8 	.inst	0x0001fda8 ; undefined
 624:	00000000 	udf	#0
 628:	00000403 	udf	#1027
 62c:	00000000 	udf	#0
 630:	00000a90 	udf	#2704
 634:	00000000 	udf	#0
 638:	0001fdb0 	.inst	0x0001fdb0 ; undefined
 63c:	00000000 	udf	#0
 640:	00000403 	udf	#1027
 644:	00000000 	udf	#0
 648:	00000a40 	udf	#2624
 64c:	00000000 	udf	#0
 650:	0001ffc0 	.inst	0x0001ffc0 ; undefined
 654:	00000000 	udf	#0
 658:	00000403 	udf	#1027
 65c:	00000000 	udf	#0
 660:	00000900 	udf	#2304
 664:	00000000 	udf	#0
 668:	00020060 	.inst	0x00020060 ; undefined
 66c:	00000000 	udf	#0
 670:	00000403 	udf	#1027
 674:	00000000 	udf	#0
 678:	00020060 	.inst	0x00020060 ; undefined
 67c:	00000000 	udf	#0
 680:	0001ffc8 	.inst	0x0001ffc8 ; undefined
 684:	00000000 	udf	#0
 688:	00000401 	udf	#1025
 68c:	00000006 	udf	#6
	...
 698:	0001ffd0 	.inst	0x0001ffd0 ; undefined
 69c:	00000000 	udf	#0
 6a0:	00000401 	udf	#1025
 6a4:	0000000b 	udf	#11
	...
 6b0:	0001ffd8 	.inst	0x0001ffd8 ; undefined
 6b4:	00000000 	udf	#0
 6b8:	00000401 	udf	#1025
 6bc:	0000000c 	udf	#12
	...
 6c8:	0001ffe0 	.inst	0x0001ffe0 ; undefined
 6cc:	00000000 	udf	#0
 6d0:	00000401 	udf	#1025
 6d4:	0000000d 	udf	#13
	...

Disassembly of section .rela.plt:

00000000000006e0 <.rela.plt>:
 6e0:	00020000 	.inst	0x00020000 ; undefined
 6e4:	00000000 	udf	#0
 6e8:	00000402 	udf	#1026
 6ec:	00000003 	udf	#3
	...
 6f8:	00020008 	.inst	0x00020008 ; undefined
 6fc:	00000000 	udf	#0
 700:	00000402 	udf	#1026
 704:	00000004 	udf	#4
	...
 710:	00020010 	.inst	0x00020010 ; undefined
 714:	00000000 	udf	#0
 718:	00000402 	udf	#1026
 71c:	00000005 	udf	#5
	...
 728:	00020018 	.inst	0x00020018 ; undefined
 72c:	00000000 	udf	#0
 730:	00000402 	udf	#1026
 734:	00000006 	udf	#6
	...
 740:	00020020 	.inst	0x00020020 ; undefined
 744:	00000000 	udf	#0
 748:	00000402 	udf	#1026
 74c:	00000007 	udf	#7
	...
 758:	00020028 	.inst	0x00020028 ; undefined
 75c:	00000000 	udf	#0
 760:	00000402 	udf	#1026
 764:	00000008 	udf	#8
	...
 770:	00020030 	.inst	0x00020030 ; undefined
 774:	00000000 	udf	#0
 778:	00000402 	udf	#1026
 77c:	00000009 	udf	#9
	...
 788:	00020038 	.inst	0x00020038 ; undefined
 78c:	00000000 	udf	#0
 790:	00000402 	udf	#1026
 794:	0000000a 	udf	#10
	...
 7a0:	00020040 	.inst	0x00020040 ; undefined
 7a4:	00000000 	udf	#0
 7a8:	00000402 	udf	#1026
 7ac:	0000000c 	udf	#12
	...
 7b8:	00020048 	.inst	0x00020048 ; undefined
 7bc:	00000000 	udf	#0
 7c0:	00000402 	udf	#1026
 7c4:	0000000e 	udf	#14
	...
 7d0:	00020050 	.inst	0x00020050 ; undefined
 7d4:	00000000 	udf	#0
 7d8:	00000402 	udf	#1026
 7dc:	0000000f 	udf	#15
	...

Disassembly of section .init:

00000000000007e8 <_init>:
 7e8:	d503201f 	nop
 7ec:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
 7f0:	910003fd 	mov	x29, sp
 7f4:	94000070 	bl	9b4 <call_weak_fn>
 7f8:	a8c17bfd 	ldp	x29, x30, [sp], #16
 7fc:	d65f03c0 	ret

Disassembly of section .plt:

0000000000000800 <.plt>:
 800:	a9bf7bf0 	stp	x16, x30, [sp, #-16]!
 804:	f00000f0 	adrp	x16, 1f000 <__FRAME_END__+0x1a8dc>
 808:	f947fe11 	ldr	x17, [x16, #4088]
 80c:	913fe210 	add	x16, x16, #0xff8
 810:	d61f0220 	br	x17
 814:	d503201f 	nop
 818:	d503201f 	nop
 81c:	d503201f 	nop

0000000000000820 <_Znam@plt>:
 820:	90000110 	adrp	x16, 20000 <_Znam@GLIBCXX_3.4>
 824:	f9400211 	ldr	x17, [x16]
 828:	91000210 	add	x16, x16, #0x0
 82c:	d61f0220 	br	x17

0000000000000830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>:
 830:	90000110 	adrp	x16, 20000 <_Znam@GLIBCXX_3.4>
 834:	f9400611 	ldr	x17, [x16, #8]
 838:	91002210 	add	x16, x16, #0x8
 83c:	d61f0220 	br	x17

0000000000000840 <puts@plt>:
 840:	90000110 	adrp	x16, 20000 <_Znam@GLIBCXX_3.4>
 844:	f9400a11 	ldr	x17, [x16, #16]
 848:	91004210 	add	x16, x16, #0x10
 84c:	d61f0220 	br	x17

0000000000000850 <__cxa_finalize@plt>:
 850:	90000110 	adrp	x16, 20000 <_Znam@GLIBCXX_3.4>
 854:	f9400e11 	ldr	x17, [x16, #24]
 858:	91006210 	add	x16, x16, #0x18
 85c:	d61f0220 	br	x17

0000000000000860 <__libc_start_main@plt>:
 860:	90000110 	adrp	x16, 20000 <_Znam@GLIBCXX_3.4>
 864:	f9401211 	ldr	x17, [x16, #32]
 868:	91008210 	add	x16, x16, #0x20
 86c:	d61f0220 	br	x17

0000000000000870 <_ZdaPv@plt>:
 870:	90000110 	adrp	x16, 20000 <_Znam@GLIBCXX_3.4>
 874:	f9401611 	ldr	x17, [x16, #40]
 878:	9100a210 	add	x16, x16, #0x28
 87c:	d61f0220 	br	x17

0000000000000880 <__cxa_throw_bad_array_new_length@plt>:
 880:	90000110 	adrp	x16, 20000 <_Znam@GLIBCXX_3.4>
 884:	f9401a11 	ldr	x17, [x16, #48]
 888:	9100c210 	add	x16, x16, #0x30
 88c:	d61f0220 	br	x17

0000000000000890 <abort@plt>:
 890:	90000110 	adrp	x16, 20000 <_Znam@GLIBCXX_3.4>
 894:	f9401e11 	ldr	x17, [x16, #56]
 898:	9100e210 	add	x16, x16, #0x38
 89c:	d61f0220 	br	x17

00000000000008a0 <__gmon_start__@plt>:
 8a0:	90000110 	adrp	x16, 20000 <_Znam@GLIBCXX_3.4>
 8a4:	f9402211 	ldr	x17, [x16, #64]
 8a8:	91010210 	add	x16, x16, #0x40
 8ac:	d61f0220 	br	x17

00000000000008b0 <printf@plt>:
 8b0:	90000110 	adrp	x16, 20000 <_Znam@GLIBCXX_3.4>
 8b4:	f9402611 	ldr	x17, [x16, #72]
 8b8:	91012210 	add	x16, x16, #0x48
 8bc:	d61f0220 	br	x17

00000000000008c0 <sqrt@plt>:
 8c0:	90000110 	adrp	x16, 20000 <_Znam@GLIBCXX_3.4>
 8c4:	f9402a11 	ldr	x17, [x16, #80]
 8c8:	91014210 	add	x16, x16, #0x50
 8cc:	d61f0220 	br	x17

Disassembly of section .text:

0000000000000900 <main>:
     900:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     904:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     908:	913a0000 	add	x0, x0, #0xe80
     90c:	910003fd 	mov	x29, sp
     910:	f9000bf3 	str	x19, [sp, #16]
     914:	97ffffcb 	bl	840 <puts@plt>
     918:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     91c:	913a8000 	add	x0, x0, #0xea0
     920:	97ffffc8 	bl	840 <puts@plt>
     924:	90000113 	adrp	x19, 20000 <_Znam@GLIBCXX_3.4>
     928:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     92c:	913b0000 	add	x0, x0, #0xec0
     930:	97ffffc4 	bl	840 <puts@plt>
     934:	940001ec 	bl	10e4 <_Z18test_half_distancev>
     938:	9400033e 	bl	1630 <_Z17test_bit_distancev>
     93c:	940000a9 	bl	be0 <_Z20test_vector_distancev>
     940:	940003c1 	bl	1844 <_Z13run_benchmarkv>
     944:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     948:	913b4000 	add	x0, x0, #0xed0
     94c:	97ffffbd 	bl	840 <puts@plt>
     950:	9101b261 	add	x1, x19, #0x6c
     954:	b9406e62 	ldr	w2, [x19, #108]
     958:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     95c:	913be000 	add	x0, x0, #0xef8
     960:	b9400421 	ldr	w1, [x1, #4]
     964:	97ffffd3 	bl	8b0 <printf@plt>
     968:	b9406e60 	ldr	w0, [x19, #108]
     96c:	f9400bf3 	ldr	x19, [sp, #16]
     970:	7100001f 	cmp	w0, #0x0
     974:	1a9fd7e0 	cset	w0, gt
     978:	a8c27bfd 	ldp	x29, x30, [sp], #32
     97c:	d65f03c0 	ret

0000000000000980 <_start>:
     980:	d503201f 	nop
     984:	d280001d 	mov	x29, #0x0                   	// #0
     988:	d280001e 	mov	x30, #0x0                   	// #0
     98c:	aa0003e5 	mov	x5, x0
     990:	f94003e1 	ldr	x1, [sp]
     994:	910023e2 	add	x2, sp, #0x8
     998:	910003e6 	mov	x6, sp
     99c:	f00000e0 	adrp	x0, 1f000 <__FRAME_END__+0x1a8dc>
     9a0:	f947e000 	ldr	x0, [x0, #4032]
     9a4:	d2800003 	mov	x3, #0x0                   	// #0
     9a8:	d2800004 	mov	x4, #0x0                   	// #0
     9ac:	97ffffad 	bl	860 <__libc_start_main@plt>
     9b0:	97ffffb8 	bl	890 <abort@plt>

00000000000009b4 <call_weak_fn>:
     9b4:	f00000e0 	adrp	x0, 1f000 <__FRAME_END__+0x1a8dc>
     9b8:	f947ec00 	ldr	x0, [x0, #4056]
     9bc:	b4000040 	cbz	x0, 9c4 <call_weak_fn+0x10>
     9c0:	17ffffb8 	b	8a0 <__gmon_start__@plt>
     9c4:	d65f03c0 	ret
     9c8:	d503201f 	nop
     9cc:	d503201f 	nop

00000000000009d0 <deregister_tm_clones>:
     9d0:	90000100 	adrp	x0, 20000 <_Znam@GLIBCXX_3.4>
     9d4:	9101a000 	add	x0, x0, #0x68
     9d8:	90000101 	adrp	x1, 20000 <_Znam@GLIBCXX_3.4>
     9dc:	9101a021 	add	x1, x1, #0x68
     9e0:	eb00003f 	cmp	x1, x0
     9e4:	540000c0 	b.eq	9fc <deregister_tm_clones+0x2c>  // b.none
     9e8:	f00000e1 	adrp	x1, 1f000 <__FRAME_END__+0x1a8dc>
     9ec:	f947e821 	ldr	x1, [x1, #4048]
     9f0:	b4000061 	cbz	x1, 9fc <deregister_tm_clones+0x2c>
     9f4:	aa0103f0 	mov	x16, x1
     9f8:	d61f0200 	br	x16
     9fc:	d65f03c0 	ret

0000000000000a00 <register_tm_clones>:
     a00:	90000100 	adrp	x0, 20000 <_Znam@GLIBCXX_3.4>
     a04:	9101a000 	add	x0, x0, #0x68
     a08:	90000101 	adrp	x1, 20000 <_Znam@GLIBCXX_3.4>
     a0c:	9101a021 	add	x1, x1, #0x68
     a10:	cb000021 	sub	x1, x1, x0
     a14:	d37ffc22 	lsr	x2, x1, #63
     a18:	8b810c41 	add	x1, x2, x1, asr #3
     a1c:	9341fc21 	asr	x1, x1, #1
     a20:	b40000c1 	cbz	x1, a38 <register_tm_clones+0x38>
     a24:	f00000e2 	adrp	x2, 1f000 <__FRAME_END__+0x1a8dc>
     a28:	f947f042 	ldr	x2, [x2, #4064]
     a2c:	b4000062 	cbz	x2, a38 <register_tm_clones+0x38>
     a30:	aa0203f0 	mov	x16, x2
     a34:	d61f0200 	br	x16
     a38:	d65f03c0 	ret
     a3c:	d503201f 	nop

0000000000000a40 <__do_global_dtors_aux>:
     a40:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     a44:	910003fd 	mov	x29, sp
     a48:	f9000bf3 	str	x19, [sp, #16]
     a4c:	90000113 	adrp	x19, 20000 <_Znam@GLIBCXX_3.4>
     a50:	3941a260 	ldrb	w0, [x19, #104]
     a54:	35000140 	cbnz	w0, a7c <__do_global_dtors_aux+0x3c>
     a58:	f00000e0 	adrp	x0, 1f000 <__FRAME_END__+0x1a8dc>
     a5c:	f947e400 	ldr	x0, [x0, #4040]
     a60:	b4000080 	cbz	x0, a70 <__do_global_dtors_aux+0x30>
     a64:	90000100 	adrp	x0, 20000 <_Znam@GLIBCXX_3.4>
     a68:	f9403000 	ldr	x0, [x0, #96]
     a6c:	97ffff79 	bl	850 <__cxa_finalize@plt>
     a70:	97ffffd8 	bl	9d0 <deregister_tm_clones>
     a74:	52800020 	mov	w0, #0x1                   	// #1
     a78:	3901a260 	strb	w0, [x19, #104]
     a7c:	f9400bf3 	ldr	x19, [sp, #16]
     a80:	a8c27bfd 	ldp	x29, x30, [sp], #32
     a84:	d65f03c0 	ret
     a88:	d503201f 	nop
     a8c:	d503201f 	nop

0000000000000a90 <frame_dummy>:
     a90:	17ffffdc 	b	a00 <register_tm_clones>
     a94:	d503201f 	nop
     a98:	d503201f 	nop
     a9c:	d503201f 	nop

0000000000000aa0 <_Z16gen_random_floatiPf>:
     aa0:	d2827c0c 	mov	x12, #0x13e0                	// #5088
     aa4:	cb2c63ff 	sub	sp, sp, x12
     aa8:	d2800546 	mov	x6, #0x2a                  	// #42
     aac:	d2912ca5 	mov	x5, #0x8965                	// #35173
     ab0:	aa0603e2 	mov	x2, x6
     ab4:	d2800023 	mov	x3, #0x1                   	// #1
     ab8:	a9007bfd 	stp	x29, x30, [sp]
     abc:	910003fd 	mov	x29, sp
     ac0:	f2ad80e5 	movk	x5, #0x6c07, lsl #16
     ac4:	a90153f3 	stp	x19, x20, [sp, #16]
     ac8:	910163f4 	add	x20, sp, #0x58
     acc:	91002284 	add	x4, x20, #0x8
     ad0:	a9025bf5 	stp	x21, x22, [sp, #32]
     ad4:	f9002fe6 	str	x6, [sp, #88]
     ad8:	ca427842 	eor	x2, x2, x2, lsr #30
     adc:	1b050c42 	madd	w2, w2, w5, w3
     ae0:	91000463 	add	x3, x3, #0x1
     ae4:	f8008482 	str	x2, [x4], #8
     ae8:	f109c07f 	cmp	x3, #0x270
     aec:	54ffff61 	b.ne	ad8 <_Z16gen_random_floatiPf+0x38>  // b.any
     af0:	f909efe3 	str	x3, [sp, #5080]
     af4:	aa0103f3 	mov	x19, x1
     af8:	8b20c835 	add	x21, x1, w0, sxtw #2
     afc:	7100001f 	cmp	w0, #0x0
     b00:	5400064d 	b.le	bc8 <_Z16gen_random_floatiPf+0x128>
     b04:	52a5f000 	mov	w0, #0x2f800000            	// #796917760
     b08:	f9001bf7 	str	x23, [sp, #48]
     b0c:	d28ad017 	mov	x23, #0x5680                	// #22144
     b10:	52a86901 	mov	w1, #0x43480000            	// #1128792064
     b14:	d2bdf8d6 	mov	x22, #0xefc60000            	// #4022730752
     b18:	f2b3a597 	movk	x23, #0x9d2c, lsl #16
     b1c:	fd001fea 	str	d10, [sp, #56]
     b20:	1e27002a 	fmov	s10, w1
     b24:	6d0427e8 	stp	d8, d9, [sp, #64]
     b28:	1e270008 	fmov	s8, w0
     b2c:	52b85900 	mov	w0, #0xc2c80000            	// #-1027080192
     b30:	1e270009 	fmov	s9, w0
     b34:	14000017 	b	b90 <_Z16gen_random_floatiPf+0xf0>
     b38:	f8637a81 	ldr	x1, [x20, x3, lsl #3]
     b3c:	91000462 	add	x2, x3, #0x1
     b40:	aa0203e3 	mov	x3, x2
     b44:	f909efe2 	str	x2, [sp, #5080]
     b48:	0f000402 	movi	v2.2s, #0x0
     b4c:	1e2e1001 	fmov	s1, #1.000000000000000000e+00
     b50:	d34ba822 	ubfx	x2, x1, #11, #32
     b54:	ca020021 	eor	x1, x1, x2
     b58:	8a011ee2 	and	x2, x23, x1, lsl #7
     b5c:	ca020021 	eor	x1, x1, x2
     b60:	8a013ec2 	and	x2, x22, x1, lsl #15
     b64:	ca020021 	eor	x1, x1, x2
     b68:	ca414821 	eor	x1, x1, x1, lsr #18
     b6c:	9e230020 	ucvtf	s0, x1
     b70:	1e222800 	fadd	s0, s0, s2
     b74:	1e280800 	fmul	s0, s0, s8
     b78:	1e212010 	fcmpe	s0, s1
     b7c:	5400016a 	b.ge	ba8 <_Z16gen_random_floatiPf+0x108>  // b.tcont
     b80:	1f0a2400 	fmadd	s0, s0, s10, s9
     b84:	bc004660 	str	s0, [x19], #4
     b88:	eb15027f 	cmp	x19, x21
     b8c:	54000180 	b.eq	bbc <_Z16gen_random_floatiPf+0x11c>  // b.none
     b90:	f109bc7f 	cmp	x3, #0x26f
     b94:	54fffd29 	b.ls	b38 <_Z16gen_random_floatiPf+0x98>  // b.plast
     b98:	aa1403e0 	mov	x0, x20
     b9c:	94000451 	bl	1ce0 <_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv>
     ba0:	f949efe3 	ldr	x3, [sp, #5080]
     ba4:	17ffffe5 	b	b38 <_Z16gen_random_floatiPf+0x98>
     ba8:	529fffc0 	mov	w0, #0xfffe                	// #65534
     bac:	72a858e0 	movk	w0, #0x42c7, lsl #16
     bb0:	b8004660 	str	w0, [x19], #4
     bb4:	eb1302bf 	cmp	x21, x19
     bb8:	54fffec1 	b.ne	b90 <_Z16gen_random_floatiPf+0xf0>  // b.any
     bbc:	f9401bf7 	ldr	x23, [sp, #48]
     bc0:	6d4427e8 	ldp	d8, d9, [sp, #64]
     bc4:	fd401fea 	ldr	d10, [sp, #56]
     bc8:	a9407bfd 	ldp	x29, x30, [sp]
     bcc:	d2827c0c 	mov	x12, #0x13e0                	// #5088
     bd0:	a94153f3 	ldp	x19, x20, [sp, #16]
     bd4:	a9425bf5 	ldp	x21, x22, [sp, #32]
     bd8:	8b2c63ff 	add	sp, sp, x12
     bdc:	d65f03c0 	ret

0000000000000be0 <_Z20test_vector_distancev>:
     be0:	a9b57bfd 	stp	x29, x30, [sp, #-176]!
     be4:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     be8:	912f2000 	add	x0, x0, #0xbc8
     bec:	910003fd 	mov	x29, sp
     bf0:	a90153f3 	stp	x19, x20, [sp, #16]
     bf4:	a9025bf5 	stp	x21, x22, [sp, #32]
     bf8:	90000116 	adrp	x22, 20000 <_Znam@GLIBCXX_3.4>
     bfc:	a90363f7 	stp	x23, x24, [sp, #48]
     c00:	9101b2d8 	add	x24, x22, #0x6c
     c04:	a9046bf9 	stp	x25, x26, [sp, #64]
     c08:	9102b3fa 	add	x26, sp, #0xac
     c0c:	b27feff9 	mov	x25, #0x1ffffffffffffffe    	// #2305843009213693950
     c10:	6d0527e8 	stp	d8, d9, [sp, #80]
     c14:	6d062fea 	stp	d10, d11, [sp, #96]
     c18:	6d0737ec 	stp	d12, d13, [sp, #112]
     c1c:	6d083fee 	stp	d14, d15, [sp, #128]
     c20:	97ffff08 	bl	840 <puts@plt>
     c24:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     c28:	913de000 	add	x0, x0, #0xf78
     c2c:	910263e1 	add	x1, sp, #0x98
     c30:	5296e2e4 	mov	w4, #0xb717                	// #46871
     c34:	aa0103f7 	mov	x23, x1
     c38:	72a71a24 	movk	w4, #0x38d1, lsl #16
     c3c:	1e27008d 	fmov	s13, w4
     c40:	a9400c02 	ldp	x2, x3, [x0]
     c44:	a9098fe2 	stp	x2, x3, [sp, #152]
     c48:	b9401000 	ldr	w0, [x0, #16]
     c4c:	b900abe0 	str	w0, [sp, #168]
     c50:	b94002f5 	ldr	w21, [x23]
     c54:	93407eb3 	sxtw	x19, w21
     c58:	eb19027f 	cmp	x19, x25
     c5c:	54001548 	b.hi	f04 <_Z20test_vector_distancev+0x324>  // b.pmore
     c60:	d37ef673 	lsl	x19, x19, #2
     c64:	aa1303e0 	mov	x0, x19
     c68:	97fffeee 	bl	820 <_Znam@plt>
     c6c:	aa0003f4 	mov	x20, x0
     c70:	aa1303e0 	mov	x0, x19
     c74:	97fffeeb 	bl	820 <_Znam@plt>
     c78:	aa0003f3 	mov	x19, x0
     c7c:	aa1403e1 	mov	x1, x20
     c80:	2a1503e0 	mov	w0, w21
     c84:	97ffff87 	bl	aa0 <_Z16gen_random_floatiPf>
     c88:	aa1303e1 	mov	x1, x19
     c8c:	2a1503e0 	mov	w0, w21
     c90:	97ffff84 	bl	aa0 <_Z16gen_random_floatiPf>
     c94:	aa1303e2 	mov	x2, x19
     c98:	aa1403e1 	mov	x1, x20
     c9c:	2a1503e0 	mov	w0, w21
     ca0:	940009c4 	bl	33b0 <_Z33vector_l2_squared_distance_nativeiPKfS0_>
     ca4:	1e20400a 	fmov	s10, s0
     ca8:	aa1303e2 	mov	x2, x19
     cac:	aa1403e1 	mov	x1, x20
     cb0:	2a1503e0 	mov	w0, w21
     cb4:	940009f7 	bl	3490 <_Z27vector_inner_product_nativeiPKfS0_>
     cb8:	1e20400b 	fmov	s11, s0
     cbc:	aa1303e2 	mov	x2, x19
     cc0:	aa1403e1 	mov	x1, x20
     cc4:	2a1503e0 	mov	w0, w21
     cc8:	94000a26 	bl	3560 <_Z31vector_cosine_similarity_nativeiPKfS0_>
     ccc:	1e604009 	fmov	d9, d0
     cd0:	aa1303e2 	mov	x2, x19
     cd4:	aa1403e1 	mov	x1, x20
     cd8:	2a1503e0 	mov	w0, w21
     cdc:	94000a46 	bl	35f4 <_Z25vector_l1_distance_nativeiPKfS0_>
     ce0:	1e20400c 	fmov	s12, s0
     ce4:	aa1303e2 	mov	x2, x19
     ce8:	aa1403e1 	mov	x1, x20
     cec:	2a1503e0 	mov	w0, w21
     cf0:	94000a78 	bl	36d0 <_Z31vector_l2_squared_distance_neoniPKfS0_>
     cf4:	1e20400e 	fmov	s14, s0
     cf8:	aa1303e2 	mov	x2, x19
     cfc:	aa1403e1 	mov	x1, x20
     d00:	2a1503e0 	mov	w0, w21
     d04:	94000ac7 	bl	3820 <_Z25vector_inner_product_neoniPKfS0_>
     d08:	1e20400f 	fmov	s15, s0
     d0c:	aa1303e2 	mov	x2, x19
     d10:	aa1403e1 	mov	x1, x20
     d14:	2a1503e0 	mov	w0, w21
     d18:	94000b0e 	bl	3950 <_Z29vector_cosine_similarity_neoniPKfS0_>
     d1c:	1e604008 	fmov	d8, d0
     d20:	aa1303e2 	mov	x2, x19
     d24:	aa1403e1 	mov	x1, x20
     d28:	2a1503e0 	mov	w0, w21
     d2c:	94000b52 	bl	3a74 <_Z23vector_l1_distance_neoniPKfS0_>
     d30:	7eaed541 	fabd	s1, s10, s14
     d34:	1e20400e 	fmov	s14, s0
     d38:	1e2d2030 	fcmpe	s1, s13
     d3c:	54000ccc 	b.gt	ed4 <_Z20test_vector_distancev+0x2f4>
     d40:	b9400700 	ldr	w0, [x24, #4]
     d44:	11000400 	add	w0, w0, #0x1
     d48:	b9000700 	str	w0, [x24, #4]
     d4c:	7eafd56f 	fabd	s15, s11, s15
     d50:	1e2d21f0 	fcmpe	s15, s13
     d54:	54000a8c 	b.gt	ea4 <_Z20test_vector_distancev+0x2c4>
     d58:	9101b2c1 	add	x1, x22, #0x6c
     d5c:	b9400420 	ldr	w0, [x1, #4]
     d60:	11000400 	add	w0, w0, #0x1
     d64:	b9000420 	str	w0, [x1, #4]
     d68:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     d6c:	7ee8d520 	fabd	d0, d9, d8
     d70:	fd47b001 	ldr	d1, [x0, #3936]
     d74:	1e612010 	fcmpe	d0, d1
     d78:	5400080c 	b.gt	e78 <_Z20test_vector_distancev+0x298>
     d7c:	9101b2c1 	add	x1, x22, #0x6c
     d80:	b9400420 	ldr	w0, [x1, #4]
     d84:	11000400 	add	w0, w0, #0x1
     d88:	b9000420 	str	w0, [x1, #4]
     d8c:	7eaed584 	fabd	s4, s12, s14
     d90:	1e2d2090 	fcmpe	s4, s13
     d94:	540003cc 	b.gt	e0c <_Z20test_vector_distancev+0x22c>
     d98:	9101b2c3 	add	x3, x22, #0x6c
     d9c:	1e22c183 	fcvt	d3, s12
     da0:	1e22c161 	fcvt	d1, s11
     da4:	1e22c140 	fcvt	d0, s10
     da8:	1e604122 	fmov	d2, d9
     dac:	2a1503e1 	mov	w1, w21
     db0:	b9400462 	ldr	w2, [x3, #4]
     db4:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     db8:	9131e000 	add	x0, x0, #0xc78
     dbc:	910012f7 	add	x23, x23, #0x4
     dc0:	11000442 	add	w2, w2, #0x1
     dc4:	b9000462 	str	w2, [x3, #4]
     dc8:	97fffeba 	bl	8b0 <printf@plt>
     dcc:	aa1403e0 	mov	x0, x20
     dd0:	97fffea8 	bl	870 <_ZdaPv@plt>
     dd4:	aa1303e0 	mov	x0, x19
     dd8:	97fffea6 	bl	870 <_ZdaPv@plt>
     ddc:	eb17035f 	cmp	x26, x23
     de0:	54fff381 	b.ne	c50 <_Z20test_vector_distancev+0x70>  // b.any
     de4:	a94153f3 	ldp	x19, x20, [sp, #16]
     de8:	a9425bf5 	ldp	x21, x22, [sp, #32]
     dec:	a94363f7 	ldp	x23, x24, [sp, #48]
     df0:	a9446bf9 	ldp	x25, x26, [sp, #64]
     df4:	6d4527e8 	ldp	d8, d9, [sp, #80]
     df8:	6d462fea 	ldp	d10, d11, [sp, #96]
     dfc:	6d4737ec 	ldp	d12, d13, [sp, #112]
     e00:	6d483fee 	ldp	d14, d15, [sp, #128]
     e04:	a8cb7bfd 	ldp	x29, x30, [sp], #176
     e08:	d65f03c0 	ret
     e0c:	1e22c080 	fcvt	d0, s4
     e10:	f0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     e14:	f0000001 	adrp	x1, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     e18:	91318042 	add	x2, x2, #0xc60
     e1c:	9131a021 	add	x1, x1, #0xc68
     e20:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     e24:	91304000 	add	x0, x0, #0xc10
     e28:	910012f7 	add	x23, x23, #0x4
     e2c:	97fffea1 	bl	8b0 <printf@plt>
     e30:	1e22c183 	fcvt	d3, s12
     e34:	b9406ec2 	ldr	w2, [x22, #108]
     e38:	1e22c161 	fcvt	d1, s11
     e3c:	1e22c140 	fcvt	d0, s10
     e40:	1e604122 	fmov	d2, d9
     e44:	11000442 	add	w2, w2, #0x1
     e48:	2a1503e1 	mov	w1, w21
     e4c:	b9006ec2 	str	w2, [x22, #108]
     e50:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     e54:	9131e000 	add	x0, x0, #0xc78
     e58:	97fffe96 	bl	8b0 <printf@plt>
     e5c:	aa1403e0 	mov	x0, x20
     e60:	97fffe84 	bl	870 <_ZdaPv@plt>
     e64:	aa1303e0 	mov	x0, x19
     e68:	97fffe82 	bl	870 <_ZdaPv@plt>
     e6c:	eb1a02ff 	cmp	x23, x26
     e70:	54ffef01 	b.ne	c50 <_Z20test_vector_distancev+0x70>  // b.any
     e74:	17ffffdc 	b	de4 <_Z20test_vector_distancev+0x204>
     e78:	f0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     e7c:	f0000001 	adrp	x1, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     e80:	91312042 	add	x2, x2, #0xc48
     e84:	91314021 	add	x1, x1, #0xc50
     e88:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     e8c:	91304000 	add	x0, x0, #0xc10
     e90:	97fffe88 	bl	8b0 <printf@plt>
     e94:	b9406ec0 	ldr	w0, [x22, #108]
     e98:	11000400 	add	w0, w0, #0x1
     e9c:	b9006ec0 	str	w0, [x22, #108]
     ea0:	17ffffbb 	b	d8c <_Z20test_vector_distancev+0x1ac>
     ea4:	1e22c1e0 	fcvt	d0, s15
     ea8:	f0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     eac:	f0000001 	adrp	x1, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     eb0:	9130c042 	add	x2, x2, #0xc30
     eb4:	9130e021 	add	x1, x1, #0xc38
     eb8:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     ebc:	91304000 	add	x0, x0, #0xc10
     ec0:	97fffe7c 	bl	8b0 <printf@plt>
     ec4:	b9406ec0 	ldr	w0, [x22, #108]
     ec8:	11000400 	add	w0, w0, #0x1
     ecc:	b9006ec0 	str	w0, [x22, #108]
     ed0:	17ffffa6 	b	d68 <_Z20test_vector_distancev+0x188>
     ed4:	1e22c020 	fcvt	d0, s1
     ed8:	f0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     edc:	f0000001 	adrp	x1, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     ee0:	912fe042 	add	x2, x2, #0xbf8
     ee4:	91300021 	add	x1, x1, #0xc00
     ee8:	f0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
     eec:	91304000 	add	x0, x0, #0xc10
     ef0:	97fffe70 	bl	8b0 <printf@plt>
     ef4:	b9400300 	ldr	w0, [x24]
     ef8:	11000400 	add	w0, w0, #0x1
     efc:	b9000300 	str	w0, [x24]
     f00:	17ffff93 	b	d4c <_Z20test_vector_distancev+0x16c>
     f04:	97fffe5f 	bl	880 <__cxa_throw_bad_array_new_length@plt>
     f08:	d503201f 	nop
     f0c:	d503201f 	nop

0000000000000f10 <_Z15gen_random_halfiPt>:
     f10:	d2827c0c 	mov	x12, #0x13e0                	// #5088
     f14:	cb2c63ff 	sub	sp, sp, x12
     f18:	d2800546 	mov	x6, #0x2a                  	// #42
     f1c:	d2912ca5 	mov	x5, #0x8965                	// #35173
     f20:	aa0603e2 	mov	x2, x6
     f24:	d2800023 	mov	x3, #0x1                   	// #1
     f28:	a9007bfd 	stp	x29, x30, [sp]
     f2c:	910003fd 	mov	x29, sp
     f30:	f2ad80e5 	movk	x5, #0x6c07, lsl #16
     f34:	a90153f3 	stp	x19, x20, [sp, #16]
     f38:	910163f4 	add	x20, sp, #0x58
     f3c:	91002284 	add	x4, x20, #0x8
     f40:	a9025bf5 	stp	x21, x22, [sp, #32]
     f44:	f9002fe6 	str	x6, [sp, #88]
     f48:	ca427842 	eor	x2, x2, x2, lsr #30
     f4c:	1b050c42 	madd	w2, w2, w5, w3
     f50:	91000463 	add	x3, x3, #0x1
     f54:	f8008482 	str	x2, [x4], #8
     f58:	f109c07f 	cmp	x3, #0x270
     f5c:	54ffff61 	b.ne	f48 <_Z15gen_random_halfiPt+0x38>  // b.any
     f60:	f909efe3 	str	x3, [sp, #5080]
     f64:	aa0103f3 	mov	x19, x1
     f68:	8b20c435 	add	x21, x1, w0, sxtw #1
     f6c:	7100001f 	cmp	w0, #0x0
     f70:	5400068d 	b.le	1040 <_Z15gen_random_halfiPt+0x130>
     f74:	d28ad016 	mov	x22, #0x5680                	// #22144
     f78:	52a5f000 	mov	w0, #0x2f800000            	// #796917760
     f7c:	f2b3a596 	movk	x22, #0x9d2c, lsl #16
     f80:	f9001bf7 	str	x23, [sp, #48]
     f84:	d2bdf8d7 	mov	x23, #0xefc60000            	// #4022730752
     f88:	fd001fea 	str	d10, [sp, #56]
     f8c:	0f00040a 	movi	v10.2s, #0x0
     f90:	6d0427e8 	stp	d8, d9, [sp, #64]
     f94:	1e270008 	fmov	s8, w0
     f98:	1e2e1009 	fmov	s9, #1.000000000000000000e+00
     f9c:	14000004 	b	fac <_Z15gen_random_halfiPt+0x9c>
     fa0:	78002661 	strh	w1, [x19], #2
     fa4:	eb15027f 	cmp	x19, x21
     fa8:	54000460 	b.eq	1034 <_Z15gen_random_halfiPt+0x124>  // b.none
     fac:	aa0303e1 	mov	x1, x3
     fb0:	f109bc7f 	cmp	x3, #0x26f
     fb4:	54000528 	b.hi	1058 <_Z15gen_random_halfiPt+0x148>  // b.pmore
     fb8:	91000423 	add	x3, x1, #0x1
     fbc:	f909efe3 	str	x3, [sp, #5080]
     fc0:	f8617a81 	ldr	x1, [x20, x1, lsl #3]
     fc4:	d34ba822 	ubfx	x2, x1, #11, #32
     fc8:	ca020021 	eor	x1, x1, x2
     fcc:	8a011ec2 	and	x2, x22, x1, lsl #7
     fd0:	ca020021 	eor	x1, x1, x2
     fd4:	8a013ee2 	and	x2, x23, x1, lsl #15
     fd8:	ca020021 	eor	x1, x1, x2
     fdc:	ca414821 	eor	x1, x1, x1, lsr #18
     fe0:	9e230020 	ucvtf	s0, x1
     fe4:	1e2a2800 	fadd	s0, s0, s10
     fe8:	1e280800 	fmul	s0, s0, s8
     fec:	1e292010 	fcmpe	s0, s9
     ff0:	5400054a 	b.ge	1098 <_Z15gen_random_halfiPt+0x188>  // b.tcont
     ff4:	1e269002 	fmov	s2, #2.000000000000000000e+01
     ff8:	1e349001 	fmov	s1, #-1.000000000000000000e+01
     ffc:	1f020400 	fmadd	s0, s0, s2, s1
    1000:	1e260002 	fmov	w2, s0
    1004:	d3577845 	ubfx	x5, x2, #23, #8
    1008:	531f7c41 	lsr	w1, w2, #31
    100c:	5101fca4 	sub	w4, w5, #0x7f
    1010:	53114021 	lsl	w1, w1, #15
    1014:	3100609f 	cmn	w4, #0x18
    1018:	54fffc4b 	b.lt	fa0 <_Z15gen_random_halfiPt+0x90>  // b.tstop
    101c:	71003c9f 	cmp	w4, #0xf
    1020:	5400024d 	b.le	1068 <_Z15gen_random_halfiPt+0x158>
    1024:	32161021 	orr	w1, w1, #0x7c00
    1028:	78002661 	strh	w1, [x19], #2
    102c:	eb15027f 	cmp	x19, x21
    1030:	54fffbe1 	b.ne	fac <_Z15gen_random_halfiPt+0x9c>  // b.any
    1034:	f9401bf7 	ldr	x23, [sp, #48]
    1038:	6d4427e8 	ldp	d8, d9, [sp, #64]
    103c:	fd401fea 	ldr	d10, [sp, #56]
    1040:	a9407bfd 	ldp	x29, x30, [sp]
    1044:	d2827c0c 	mov	x12, #0x13e0                	// #5088
    1048:	a94153f3 	ldp	x19, x20, [sp, #16]
    104c:	a9425bf5 	ldp	x21, x22, [sp, #32]
    1050:	8b2c63ff 	add	sp, sp, x12
    1054:	d65f03c0 	ret
    1058:	aa1403e0 	mov	x0, x20
    105c:	94000321 	bl	1ce0 <_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv>
    1060:	f949efe1 	ldr	x1, [sp, #5080]
    1064:	17ffffd5 	b	fb8 <_Z15gen_random_halfiPt+0xa8>
    1068:	3100389f 	cmn	w4, #0xe
    106c:	54fff9ab 	b.lt	fa0 <_Z15gen_random_halfiPt+0x90>  // b.tstop
    1070:	5101c0a0 	sub	w0, w5, #0x70
    1074:	d34c3046 	ubfx	x6, x2, #12, #1
    1078:	d34d5844 	ubfx	x4, x2, #13, #10
    107c:	f2402c5f 	tst	x2, #0xfff
    1080:	540001a0 	b.eq	10b4 <_Z15gen_random_halfiPt+0x1a4>  // b.none
    1084:	350001c6 	cbnz	w6, 10bc <_Z15gen_random_halfiPt+0x1ac>
    1088:	2a002880 	orr	w0, w4, w0, lsl #10
    108c:	2a000021 	orr	w1, w1, w0
    1090:	12003c21 	and	w1, w1, #0xffff
    1094:	17ffffc3 	b	fa0 <_Z15gen_random_halfiPt+0x90>
    1098:	52800001 	mov	w1, #0x0                   	// #0
    109c:	52800240 	mov	w0, #0x12                  	// #18
    10a0:	52802002 	mov	w2, #0x100                 	// #256
    10a4:	2a002820 	orr	w0, w1, w0, lsl #10
    10a8:	2a020000 	orr	w0, w0, w2
    10ac:	12003c01 	and	w1, w0, #0xffff
    10b0:	17ffffbc 	b	fa0 <_Z15gen_random_halfiPt+0x90>
    10b4:	34fffea6 	cbz	w6, 1088 <_Z15gen_random_halfiPt+0x178>
    10b8:	3607fe84 	tbz	w4, #0, 1088 <_Z15gen_random_halfiPt+0x178>
    10bc:	11000482 	add	w2, w4, #0x1
    10c0:	710ffc9f 	cmp	w4, #0x3ff
    10c4:	54ffff01 	b.ne	10a4 <_Z15gen_random_halfiPt+0x194>  // b.any
    10c8:	5101bca5 	sub	w5, w5, #0x6f
    10cc:	32161020 	orr	w0, w1, #0x7c00
    10d0:	71007cbf 	cmp	w5, #0x1f
    10d4:	2a052825 	orr	w5, w1, w5, lsl #10
    10d8:	12003ca1 	and	w1, w5, #0xffff
    10dc:	1a810001 	csel	w1, w0, w1, eq	// eq = none
    10e0:	17ffffb0 	b	fa0 <_Z15gen_random_halfiPt+0x90>

00000000000010e4 <_Z18test_half_distancev>:
    10e4:	a9b57bfd 	stp	x29, x30, [sp, #-176]!
    10e8:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    10ec:	9132c000 	add	x0, x0, #0xcb0
    10f0:	910003fd 	mov	x29, sp
    10f4:	a90153f3 	stp	x19, x20, [sp, #16]
    10f8:	a9025bf5 	stp	x21, x22, [sp, #32]
    10fc:	f00000f6 	adrp	x22, 20000 <_Znam@GLIBCXX_3.4>
    1100:	a90363f7 	stp	x23, x24, [sp, #48]
    1104:	9101b2d8 	add	x24, x22, #0x6c
    1108:	a9046bf9 	stp	x25, x26, [sp, #64]
    110c:	9102b3fa 	add	x26, sp, #0xac
    1110:	b27eeff9 	mov	x25, #0x3ffffffffffffffc    	// #4611686018427387900
    1114:	6d0527e8 	stp	d8, d9, [sp, #80]
    1118:	6d062fea 	stp	d10, d11, [sp, #96]
    111c:	6d0737ec 	stp	d12, d13, [sp, #112]
    1120:	6d083fee 	stp	d14, d15, [sp, #128]
    1124:	97fffdc7 	bl	840 <puts@plt>
    1128:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    112c:	913de000 	add	x0, x0, #0xf78
    1130:	910263e1 	add	x1, sp, #0x98
    1134:	5296e2e4 	mov	w4, #0xb717                	// #46871
    1138:	aa0103f7 	mov	x23, x1
    113c:	72a71a24 	movk	w4, #0x38d1, lsl #16
    1140:	1e27008d 	fmov	s13, w4
    1144:	a9400c02 	ldp	x2, x3, [x0]
    1148:	a9098fe2 	stp	x2, x3, [sp, #152]
    114c:	b9401000 	ldr	w0, [x0, #16]
    1150:	b900abe0 	str	w0, [sp, #168]
    1154:	d503201f 	nop
    1158:	b94002f5 	ldr	w21, [x23]
    115c:	93407eb3 	sxtw	x19, w21
    1160:	eb19027f 	cmp	x19, x25
    1164:	54001548 	b.hi	140c <_Z18test_half_distancev+0x328>  // b.pmore
    1168:	d37ffa73 	lsl	x19, x19, #1
    116c:	aa1303e0 	mov	x0, x19
    1170:	97fffdac 	bl	820 <_Znam@plt>
    1174:	aa0003f4 	mov	x20, x0
    1178:	aa1303e0 	mov	x0, x19
    117c:	97fffda9 	bl	820 <_Znam@plt>
    1180:	aa0003f3 	mov	x19, x0
    1184:	aa1403e1 	mov	x1, x20
    1188:	2a1503e0 	mov	w0, w21
    118c:	97ffff61 	bl	f10 <_Z15gen_random_halfiPt>
    1190:	aa1303e1 	mov	x1, x19
    1194:	2a1503e0 	mov	w0, w21
    1198:	97ffff5e 	bl	f10 <_Z15gen_random_halfiPt>
    119c:	aa1303e2 	mov	x2, x19
    11a0:	aa1403e1 	mov	x1, x20
    11a4:	2a1503e0 	mov	w0, w21
    11a8:	9400031a 	bl	1e10 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_>
    11ac:	1e20400a 	fmov	s10, s0
    11b0:	aa1303e2 	mov	x2, x19
    11b4:	aa1403e1 	mov	x1, x20
    11b8:	2a1503e0 	mov	w0, w21
    11bc:	94000361 	bl	1f40 <_Z28halfvec_inner_product_nativeiPKtS0_>
    11c0:	1e20400b 	fmov	s11, s0
    11c4:	aa1303e2 	mov	x2, x19
    11c8:	aa1403e1 	mov	x1, x20
    11cc:	2a1503e0 	mov	w0, w21
    11d0:	940003a8 	bl	2070 <_Z32halfvec_cosine_similarity_nativeiPKtS0_>
    11d4:	1e604009 	fmov	d9, d0
    11d8:	aa1303e2 	mov	x2, x19
    11dc:	aa1403e1 	mov	x1, x20
    11e0:	2a1503e0 	mov	w0, w21
    11e4:	94000400 	bl	21e4 <_Z26halfvec_l1_distance_nativeiPKtS0_>
    11e8:	1e20400c 	fmov	s12, s0
    11ec:	aa1303e2 	mov	x2, x19
    11f0:	aa1403e1 	mov	x1, x20
    11f4:	2a1503e0 	mov	w0, w21
    11f8:	94000446 	bl	2310 <_Z32halfvec_l2_squared_distance_neoniPKtS0_>
    11fc:	1e20400e 	fmov	s14, s0
    1200:	aa1303e2 	mov	x2, x19
    1204:	aa1403e1 	mov	x1, x20
    1208:	2a1503e0 	mov	w0, w21
    120c:	940004ad 	bl	24c0 <_Z26halfvec_inner_product_neoniPKtS0_>
    1210:	1e20400f 	fmov	s15, s0
    1214:	aa1303e2 	mov	x2, x19
    1218:	aa1403e1 	mov	x1, x20
    121c:	2a1503e0 	mov	w0, w21
    1220:	94000510 	bl	2660 <_Z30halfvec_cosine_similarity_neoniPKtS0_>
    1224:	1e604008 	fmov	d8, d0
    1228:	aa1303e2 	mov	x2, x19
    122c:	aa1403e1 	mov	x1, x20
    1230:	2a1503e0 	mov	w0, w21
    1234:	94000593 	bl	2880 <_Z24halfvec_l1_distance_neoniPKtS0_>
    1238:	7eaed541 	fabd	s1, s10, s14
    123c:	1e20400e 	fmov	s14, s0
    1240:	1e2d2030 	fcmpe	s1, s13
    1244:	54000ccc 	b.gt	13dc <_Z18test_half_distancev+0x2f8>
    1248:	b9400700 	ldr	w0, [x24, #4]
    124c:	11000400 	add	w0, w0, #0x1
    1250:	b9000700 	str	w0, [x24, #4]
    1254:	7eafd56f 	fabd	s15, s11, s15
    1258:	1e2d21f0 	fcmpe	s15, s13
    125c:	54000a8c 	b.gt	13ac <_Z18test_half_distancev+0x2c8>
    1260:	9101b2c1 	add	x1, x22, #0x6c
    1264:	b9400420 	ldr	w0, [x1, #4]
    1268:	11000400 	add	w0, w0, #0x1
    126c:	b9000420 	str	w0, [x1, #4]
    1270:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1274:	7ee8d520 	fabd	d0, d9, d8
    1278:	fd47b001 	ldr	d1, [x0, #3936]
    127c:	1e612010 	fcmpe	d0, d1
    1280:	5400080c 	b.gt	1380 <_Z18test_half_distancev+0x29c>
    1284:	9101b2c1 	add	x1, x22, #0x6c
    1288:	b9400420 	ldr	w0, [x1, #4]
    128c:	11000400 	add	w0, w0, #0x1
    1290:	b9000420 	str	w0, [x1, #4]
    1294:	7eaed584 	fabd	s4, s12, s14
    1298:	1e2d2090 	fcmpe	s4, s13
    129c:	540003cc 	b.gt	1314 <_Z18test_half_distancev+0x230>
    12a0:	9101b2c3 	add	x3, x22, #0x6c
    12a4:	1e22c183 	fcvt	d3, s12
    12a8:	1e22c161 	fcvt	d1, s11
    12ac:	1e22c140 	fcvt	d0, s10
    12b0:	1e604122 	fmov	d2, d9
    12b4:	2a1503e1 	mov	w1, w21
    12b8:	b9400462 	ldr	w2, [x3, #4]
    12bc:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    12c0:	9131e000 	add	x0, x0, #0xc78
    12c4:	910012f7 	add	x23, x23, #0x4
    12c8:	11000442 	add	w2, w2, #0x1
    12cc:	b9000462 	str	w2, [x3, #4]
    12d0:	97fffd78 	bl	8b0 <printf@plt>
    12d4:	aa1403e0 	mov	x0, x20
    12d8:	97fffd66 	bl	870 <_ZdaPv@plt>
    12dc:	aa1303e0 	mov	x0, x19
    12e0:	97fffd64 	bl	870 <_ZdaPv@plt>
    12e4:	eb17035f 	cmp	x26, x23
    12e8:	54fff381 	b.ne	1158 <_Z18test_half_distancev+0x74>  // b.any
    12ec:	a94153f3 	ldp	x19, x20, [sp, #16]
    12f0:	a9425bf5 	ldp	x21, x22, [sp, #32]
    12f4:	a94363f7 	ldp	x23, x24, [sp, #48]
    12f8:	a9446bf9 	ldp	x25, x26, [sp, #64]
    12fc:	6d4527e8 	ldp	d8, d9, [sp, #80]
    1300:	6d462fea 	ldp	d10, d11, [sp, #96]
    1304:	6d4737ec 	ldp	d12, d13, [sp, #112]
    1308:	6d483fee 	ldp	d14, d15, [sp, #128]
    130c:	a8cb7bfd 	ldp	x29, x30, [sp], #176
    1310:	d65f03c0 	ret
    1314:	1e22c080 	fcvt	d0, s4
    1318:	d0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    131c:	d0000001 	adrp	x1, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1320:	91318042 	add	x2, x2, #0xc60
    1324:	9131a021 	add	x1, x1, #0xc68
    1328:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    132c:	91304000 	add	x0, x0, #0xc10
    1330:	910012f7 	add	x23, x23, #0x4
    1334:	97fffd5f 	bl	8b0 <printf@plt>
    1338:	1e22c183 	fcvt	d3, s12
    133c:	b9406ec2 	ldr	w2, [x22, #108]
    1340:	1e22c161 	fcvt	d1, s11
    1344:	1e22c140 	fcvt	d0, s10
    1348:	1e604122 	fmov	d2, d9
    134c:	11000442 	add	w2, w2, #0x1
    1350:	2a1503e1 	mov	w1, w21
    1354:	b9006ec2 	str	w2, [x22, #108]
    1358:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    135c:	9131e000 	add	x0, x0, #0xc78
    1360:	97fffd54 	bl	8b0 <printf@plt>
    1364:	aa1403e0 	mov	x0, x20
    1368:	97fffd42 	bl	870 <_ZdaPv@plt>
    136c:	aa1303e0 	mov	x0, x19
    1370:	97fffd40 	bl	870 <_ZdaPv@plt>
    1374:	eb1a02ff 	cmp	x23, x26
    1378:	54ffef01 	b.ne	1158 <_Z18test_half_distancev+0x74>  // b.any
    137c:	17ffffdc 	b	12ec <_Z18test_half_distancev+0x208>
    1380:	d0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1384:	d0000001 	adrp	x1, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1388:	91312042 	add	x2, x2, #0xc48
    138c:	91314021 	add	x1, x1, #0xc50
    1390:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1394:	91304000 	add	x0, x0, #0xc10
    1398:	97fffd46 	bl	8b0 <printf@plt>
    139c:	b9406ec0 	ldr	w0, [x22, #108]
    13a0:	11000400 	add	w0, w0, #0x1
    13a4:	b9006ec0 	str	w0, [x22, #108]
    13a8:	17ffffbb 	b	1294 <_Z18test_half_distancev+0x1b0>
    13ac:	1e22c1e0 	fcvt	d0, s15
    13b0:	d0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    13b4:	d0000001 	adrp	x1, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    13b8:	9130c042 	add	x2, x2, #0xc30
    13bc:	9130e021 	add	x1, x1, #0xc38
    13c0:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    13c4:	91304000 	add	x0, x0, #0xc10
    13c8:	97fffd3a 	bl	8b0 <printf@plt>
    13cc:	b9406ec0 	ldr	w0, [x22, #108]
    13d0:	11000400 	add	w0, w0, #0x1
    13d4:	b9006ec0 	str	w0, [x22, #108]
    13d8:	17ffffa6 	b	1270 <_Z18test_half_distancev+0x18c>
    13dc:	1e22c020 	fcvt	d0, s1
    13e0:	d0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    13e4:	d0000001 	adrp	x1, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    13e8:	912fe042 	add	x2, x2, #0xbf8
    13ec:	91300021 	add	x1, x1, #0xc00
    13f0:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    13f4:	91304000 	add	x0, x0, #0xc10
    13f8:	97fffd2e 	bl	8b0 <printf@plt>
    13fc:	b9400300 	ldr	w0, [x24]
    1400:	11000400 	add	w0, w0, #0x1
    1404:	b9000300 	str	w0, [x24]
    1408:	17ffff93 	b	1254 <_Z18test_half_distancev+0x170>
    140c:	97fffd1d 	bl	880 <__cxa_throw_bad_array_new_length@plt>

0000000000001410 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0>:
    1410:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    1414:	b27f7be1 	mov	x1, #0xfffffffe            	// #4294967294
    1418:	910003fd 	mov	x29, sp
    141c:	a90153f3 	stp	x19, x20, [sp, #16]
    1420:	a9025bf5 	stp	x21, x22, [sp, #32]
    1424:	aa0003f6 	mov	x22, x0
    1428:	a90363f7 	stp	x23, x24, [sp, #48]
    142c:	93407c57 	sxtw	x23, w2
    1430:	eb0102ff 	cmp	x23, x1
    1434:	54000429 	b.ls	14b8 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0+0xa8>  // b.plast
    1438:	d28ad015 	mov	x21, #0x5680                	// #22144
    143c:	d2bdf8d4 	mov	x20, #0xefc60000            	// #4022730752
    1440:	f2b3a595 	movk	x21, #0x9d2c, lsl #16
    1444:	52800001 	mov	w1, #0x0                   	// #0
    1448:	aa1603e0 	mov	x0, x22
    144c:	12800002 	mov	w2, #0xffffffff            	// #-1
    1450:	97fffff0 	bl	1410 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0>
    1454:	f949c2c1 	ldr	x1, [x22, #4992]
    1458:	d3607c13 	lsl	x19, x0, #32
    145c:	f109bc3f 	cmp	x1, #0x26f
    1460:	54000089 	b.ls	1470 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0+0x60>  // b.plast
    1464:	aa1603e0 	mov	x0, x22
    1468:	9400021e 	bl	1ce0 <_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv>
    146c:	f949c2c1 	ldr	x1, [x22, #4992]
    1470:	91000420 	add	x0, x1, #0x1
    1474:	f8617ac1 	ldr	x1, [x22, x1, lsl #3]
    1478:	f909c2c0 	str	x0, [x22, #4992]
    147c:	d34ba820 	ubfx	x0, x1, #11, #32
    1480:	ca000021 	eor	x1, x1, x0
    1484:	8a011ea0 	and	x0, x21, x1, lsl #7
    1488:	ca000021 	eor	x1, x1, x0
    148c:	8a013e80 	and	x0, x20, x1, lsl #15
    1490:	ca000021 	eor	x1, x1, x0
    1494:	ca414821 	eor	x1, x1, x1, lsr #18
    1498:	ab010260 	adds	x0, x19, x1
    149c:	fa4032e0 	ccmp	x23, x0, #0x0, cc	// cc = lo, ul, last
    14a0:	54fffd23 	b.cc	1444 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0+0x34>  // b.lo, b.ul, b.last
    14a4:	a94153f3 	ldp	x19, x20, [sp, #16]
    14a8:	a9425bf5 	ldp	x21, x22, [sp, #32]
    14ac:	a94363f7 	ldp	x23, x24, [sp, #48]
    14b0:	a8c47bfd 	ldp	x29, x30, [sp], #64
    14b4:	d65f03c0 	ret
    14b8:	f949c001 	ldr	x1, [x0, #4992]
    14bc:	910006f7 	add	x23, x23, #0x1
    14c0:	f109bc3f 	cmp	x1, #0x26f
    14c4:	54000628 	b.hi	1588 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0+0x178>  // b.pmore
    14c8:	f8617ad3 	ldr	x19, [x22, x1, lsl #3]
    14cc:	91000420 	add	x0, x1, #0x1
    14d0:	d28ad014 	mov	x20, #0x5680                	// #22144
    14d4:	d2bdf8d5 	mov	x21, #0xefc60000            	// #4022730752
    14d8:	f2b3a594 	movk	x20, #0x9d2c, lsl #16
    14dc:	f909c2c0 	str	x0, [x22, #4992]
    14e0:	d34baa61 	ubfx	x1, x19, #11, #32
    14e4:	ca010273 	eor	x19, x19, x1
    14e8:	8a131e81 	and	x1, x20, x19, lsl #7
    14ec:	ca010273 	eor	x19, x19, x1
    14f0:	8a133ea1 	and	x1, x21, x19, lsl #15
    14f4:	ca010273 	eor	x19, x19, x1
    14f8:	ca534a73 	eor	x19, x19, x19, lsr #18
    14fc:	9b177e73 	mul	x19, x19, x23
    1500:	6b1302ff 	cmp	w23, w19
    1504:	54000369 	b.ls	1570 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0+0x160>  // b.plast
    1508:	4b1703e1 	neg	w1, w23
    150c:	1ad70838 	udiv	w24, w1, w23
    1510:	1b178718 	msub	w24, w24, w23, w1
    1514:	6b18027f 	cmp	w19, w24
    1518:	540001e3 	b.cc	1554 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0+0x144>  // b.lo, b.ul, b.last
    151c:	14000015 	b	1570 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0+0x160>
    1520:	f8617ad3 	ldr	x19, [x22, x1, lsl #3]
    1524:	91000420 	add	x0, x1, #0x1
    1528:	f909c2c0 	str	x0, [x22, #4992]
    152c:	d34baa61 	ubfx	x1, x19, #11, #32
    1530:	ca010273 	eor	x19, x19, x1
    1534:	8a131e81 	and	x1, x20, x19, lsl #7
    1538:	ca010273 	eor	x19, x19, x1
    153c:	8a133ea1 	and	x1, x21, x19, lsl #15
    1540:	ca010273 	eor	x19, x19, x1
    1544:	ca534a73 	eor	x19, x19, x19, lsr #18
    1548:	9b177e73 	mul	x19, x19, x23
    154c:	6b13031f 	cmp	w24, w19
    1550:	54000109 	b.ls	1570 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0+0x160>  // b.plast
    1554:	aa0003e1 	mov	x1, x0
    1558:	f109bc1f 	cmp	x0, #0x26f
    155c:	54fffe29 	b.ls	1520 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0+0x110>  // b.plast
    1560:	aa1603e0 	mov	x0, x22
    1564:	940001df 	bl	1ce0 <_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv>
    1568:	f949c2c1 	ldr	x1, [x22, #4992]
    156c:	17ffffed 	b	1520 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0+0x110>
    1570:	a9425bf5 	ldp	x21, x22, [sp, #32]
    1574:	d360fe60 	lsr	x0, x19, #32
    1578:	a94153f3 	ldp	x19, x20, [sp, #16]
    157c:	a94363f7 	ldp	x23, x24, [sp, #48]
    1580:	a8c47bfd 	ldp	x29, x30, [sp], #64
    1584:	d65f03c0 	ret
    1588:	940001d6 	bl	1ce0 <_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv>
    158c:	f949c2c1 	ldr	x1, [x22, #4992]
    1590:	17ffffce 	b	14c8 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0+0xb8>

0000000000001594 <_Z15gen_random_bitsjPh>:
    1594:	d282780c 	mov	x12, #0x13c0                	// #5056
    1598:	cb2c63ff 	sub	sp, sp, x12
    159c:	d2800546 	mov	x6, #0x2a                  	// #42
    15a0:	d2912ca5 	mov	x5, #0x8965                	// #35173
    15a4:	aa0603e2 	mov	x2, x6
    15a8:	d2800023 	mov	x3, #0x1                   	// #1
    15ac:	a9007bfd 	stp	x29, x30, [sp]
    15b0:	910003fd 	mov	x29, sp
    15b4:	f2ad80e5 	movk	x5, #0x6c07, lsl #16
    15b8:	a90153f3 	stp	x19, x20, [sp, #16]
    15bc:	9100e3f4 	add	x20, sp, #0x38
    15c0:	91002284 	add	x4, x20, #0x8
    15c4:	f9001fe6 	str	x6, [sp, #56]
    15c8:	ca427842 	eor	x2, x2, x2, lsr #30
    15cc:	1b050c42 	madd	w2, w2, w5, w3
    15d0:	91000463 	add	x3, x3, #0x1
    15d4:	f8008482 	str	x2, [x4], #8
    15d8:	f109c07f 	cmp	x3, #0x270
    15dc:	54ffff61 	b.ne	15c8 <_Z15gen_random_bitsjPh+0x34>  // b.any
    15e0:	f909dfe3 	str	x3, [sp, #5048]
    15e4:	340001a0 	cbz	w0, 1618 <_Z15gen_random_bitsjPh+0x84>
    15e8:	aa0103f3 	mov	x19, x1
    15ec:	f90013f5 	str	x21, [sp, #32]
    15f0:	8b204035 	add	x21, x1, w0, uxtw
    15f4:	d503201f 	nop
    15f8:	aa1403e0 	mov	x0, x20
    15fc:	52801fe2 	mov	w2, #0xff                  	// #255
    1600:	52800001 	mov	w1, #0x0                   	// #0
    1604:	97ffff83 	bl	1410 <_ZNSt24uniform_int_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE.constprop.0.isra.0>
    1608:	38001660 	strb	w0, [x19], #1
    160c:	eb1302bf 	cmp	x21, x19
    1610:	54ffff41 	b.ne	15f8 <_Z15gen_random_bitsjPh+0x64>  // b.any
    1614:	f94013f5 	ldr	x21, [sp, #32]
    1618:	d282780c 	mov	x12, #0x13c0                	// #5056
    161c:	a9407bfd 	ldp	x29, x30, [sp]
    1620:	a94153f3 	ldp	x19, x20, [sp, #16]
    1624:	8b2c63ff 	add	sp, sp, x12
    1628:	d65f03c0 	ret
    162c:	d503201f 	nop

0000000000001630 <_Z17test_bit_distancev>:
    1630:	a9b57bfd 	stp	x29, x30, [sp, #-176]!
    1634:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1638:	91334000 	add	x0, x0, #0xcd0
    163c:	910003fd 	mov	x29, sp
    1640:	a90153f3 	stp	x19, x20, [sp, #16]
    1644:	a9025bf5 	stp	x21, x22, [sp, #32]
    1648:	a90363f7 	stp	x23, x24, [sp, #48]
    164c:	f00000f8 	adrp	x24, 20000 <_Znam@GLIBCXX_3.4>
    1650:	a9046bf9 	stp	x25, x26, [sp, #64]
    1654:	d0000019 	adrp	x25, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1658:	d000001a 	adrp	x26, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    165c:	a90573fb 	stp	x27, x28, [sp, #80]
    1660:	9133c35a 	add	x26, x26, #0xcf0
    1664:	9102b3fc 	add	x28, sp, #0xac
    1668:	6d0627e8 	stp	d8, d9, [sp, #96]
    166c:	d000001b 	adrp	x27, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1670:	fd003bea 	str	d10, [sp, #112]
    1674:	97fffc73 	bl	840 <puts@plt>
    1678:	91340324 	add	x4, x25, #0xd00
    167c:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1680:	913de000 	add	x0, x0, #0xf78
    1684:	f90047e4 	str	x4, [sp, #136]
    1688:	d0000004 	adrp	x4, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    168c:	910263e1 	add	x1, sp, #0x98
    1690:	aa0103f7 	mov	x23, x1
    1694:	a9418c02 	ldp	x2, x3, [x0, #24]
    1698:	a9098fe2 	stp	x2, x3, [sp, #152]
    169c:	b9402800 	ldr	w0, [x0, #40]
    16a0:	fd47b48a 	ldr	d10, [x4, #3944]
    16a4:	b900abe0 	str	w0, [sp, #168]
    16a8:	b94002f5 	ldr	w21, [x23]
    16ac:	2a1503f3 	mov	w19, w21
    16b0:	aa1303e0 	mov	x0, x19
    16b4:	97fffc5b 	bl	820 <_Znam@plt>
    16b8:	aa0003f4 	mov	x20, x0
    16bc:	aa1303e0 	mov	x0, x19
    16c0:	97fffc58 	bl	820 <_Znam@plt>
    16c4:	aa0003f3 	mov	x19, x0
    16c8:	aa1403e1 	mov	x1, x20
    16cc:	2a1503e0 	mov	w0, w21
    16d0:	97ffffb1 	bl	1594 <_Z15gen_random_bitsjPh>
    16d4:	aa1303e1 	mov	x1, x19
    16d8:	2a1503e0 	mov	w0, w21
    16dc:	97ffffae 	bl	1594 <_Z15gen_random_bitsjPh>
    16e0:	aa1303e2 	mov	x2, x19
    16e4:	aa1403e1 	mov	x1, x20
    16e8:	2a1503e0 	mov	w0, w21
    16ec:	940004d1 	bl	2a30 <_Z27bit_hamming_distance_nativejPKhS0_>
    16f0:	aa1303e2 	mov	x2, x19
    16f4:	aa0003f6 	mov	x22, x0
    16f8:	aa1403e1 	mov	x1, x20
    16fc:	2a1503e0 	mov	w0, w21
    1700:	94000520 	bl	2b80 <_Z27bit_jaccard_distance_nativejPKhS0_>
    1704:	1e604009 	fmov	d9, d0
    1708:	aa1303e2 	mov	x2, x19
    170c:	aa1403e1 	mov	x1, x20
    1710:	2a1503e0 	mov	w0, w21
    1714:	94000597 	bl	2d70 <_Z25bit_hamming_distance_neonjPKhS0_>
    1718:	aa0003f9 	mov	x25, x0
    171c:	aa1303e2 	mov	x2, x19
    1720:	aa1403e1 	mov	x1, x20
    1724:	2a1503e0 	mov	w0, w21
    1728:	94000623 	bl	2fb4 <_Z25bit_jaccard_distance_neonjPKhS0_>
    172c:	cb1902c3 	sub	x3, x22, x25
    1730:	1e604008 	fmov	d8, d0
    1734:	f94047e1 	ldr	x1, [sp, #136]
    1738:	9e630061 	ucvtf	d1, x3
    173c:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1740:	aa1a03e2 	mov	x2, x26
    1744:	91304000 	add	x0, x0, #0xc10
    1748:	1e602038 	fcmpe	d1, #0.0
    174c:	1e604020 	fmov	d0, d1
    1750:	5400042c 	b.gt	17d4 <_Z17test_bit_distancev+0x1a4>
    1754:	9101b301 	add	x1, x24, #0x6c
    1758:	b9400420 	ldr	w0, [x1, #4]
    175c:	11000400 	add	w0, w0, #0x1
    1760:	b9000420 	str	w0, [x1, #4]
    1764:	7ee8d520 	fabd	d0, d9, d8
    1768:	1e6a2010 	fcmpe	d0, d10
    176c:	540003ec 	b.gt	17e8 <_Z17test_bit_distancev+0x1b8>
    1770:	9101b304 	add	x4, x24, #0x6c
    1774:	1e604120 	fmov	d0, d9
    1778:	aa1603e2 	mov	x2, x22
    177c:	2a1503e1 	mov	w1, w21
    1780:	9134c360 	add	x0, x27, #0xd30
    1784:	910012f7 	add	x23, x23, #0x4
    1788:	b9400483 	ldr	w3, [x4, #4]
    178c:	11000463 	add	w3, w3, #0x1
    1790:	b9000483 	str	w3, [x4, #4]
    1794:	97fffc47 	bl	8b0 <printf@plt>
    1798:	aa1403e0 	mov	x0, x20
    179c:	97fffc35 	bl	870 <_ZdaPv@plt>
    17a0:	aa1303e0 	mov	x0, x19
    17a4:	97fffc33 	bl	870 <_ZdaPv@plt>
    17a8:	eb1c02ff 	cmp	x23, x28
    17ac:	54fff7e1 	b.ne	16a8 <_Z17test_bit_distancev+0x78>  // b.any
    17b0:	a94153f3 	ldp	x19, x20, [sp, #16]
    17b4:	a9425bf5 	ldp	x21, x22, [sp, #32]
    17b8:	a94363f7 	ldp	x23, x24, [sp, #48]
    17bc:	a9446bf9 	ldp	x25, x26, [sp, #64]
    17c0:	a94573fb 	ldp	x27, x28, [sp, #80]
    17c4:	6d4627e8 	ldp	d8, d9, [sp, #96]
    17c8:	fd403bea 	ldr	d10, [sp, #112]
    17cc:	a8cb7bfd 	ldp	x29, x30, [sp], #176
    17d0:	d65f03c0 	ret
    17d4:	97fffc37 	bl	8b0 <printf@plt>
    17d8:	b9406f00 	ldr	w0, [x24, #108]
    17dc:	11000400 	add	w0, w0, #0x1
    17e0:	b9006f00 	str	w0, [x24, #108]
    17e4:	17ffffe0 	b	1764 <_Z17test_bit_distancev+0x134>
    17e8:	d0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    17ec:	d0000001 	adrp	x1, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    17f0:	91344042 	add	x2, x2, #0xd10
    17f4:	91348021 	add	x1, x1, #0xd20
    17f8:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    17fc:	91304000 	add	x0, x0, #0xc10
    1800:	97fffc2c 	bl	8b0 <printf@plt>
    1804:	1e604120 	fmov	d0, d9
    1808:	b9406f03 	ldr	w3, [x24, #108]
    180c:	aa1603e2 	mov	x2, x22
    1810:	2a1503e1 	mov	w1, w21
    1814:	9134c360 	add	x0, x27, #0xd30
    1818:	11000463 	add	w3, w3, #0x1
    181c:	b9006f03 	str	w3, [x24, #108]
    1820:	910012f7 	add	x23, x23, #0x4
    1824:	97fffc23 	bl	8b0 <printf@plt>
    1828:	aa1403e0 	mov	x0, x20
    182c:	97fffc11 	bl	870 <_ZdaPv@plt>
    1830:	aa1303e0 	mov	x0, x19
    1834:	97fffc0f 	bl	870 <_ZdaPv@plt>
    1838:	eb17039f 	cmp	x28, x23
    183c:	54fff361 	b.ne	16a8 <_Z17test_bit_distancev+0x78>  // b.any
    1840:	17ffffdc 	b	17b0 <_Z17test_bit_distancev+0x180>

0000000000001844 <_Z13run_benchmarkv>:
    1844:	a9b67bfd 	stp	x29, x30, [sp, #-160]!
    1848:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    184c:	91358000 	add	x0, x0, #0xd60
    1850:	910003fd 	mov	x29, sp
    1854:	a90153f3 	stp	x19, x20, [sp, #16]
    1858:	a9025bf5 	stp	x21, x22, [sp, #32]
    185c:	a90363f7 	stp	x23, x24, [sp, #48]
    1860:	910203f8 	add	x24, sp, #0x80
    1864:	d2800077 	mov	x23, #0x3                   	// #3
    1868:	a9046bf9 	stp	x25, x26, [sp, #64]
    186c:	d0000019 	adrp	x25, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1870:	9137c339 	add	x25, x25, #0xdf0
    1874:	a90573fb 	stp	x27, x28, [sp, #80]
    1878:	b27feffa 	mov	x26, #0x1ffffffffffffffe    	// #2305843009213693950
    187c:	6d0627e8 	stp	d8, d9, [sp, #96]
    1880:	fd003bea 	str	d10, [sp, #112]
    1884:	97fffbef 	bl	840 <puts@plt>
    1888:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    188c:	91360000 	add	x0, x0, #0xd80
    1890:	97fffbec 	bl	840 <puts@plt>
    1894:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1898:	9136e000 	add	x0, x0, #0xdb8
    189c:	97fffbe9 	bl	840 <puts@plt>
    18a0:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    18a4:	d2c80002 	mov	x2, #0x400000000000        	// #70368744177664
    18a8:	d2d10001 	mov	x1, #0x880000000000        	// #149533581377536
    18ac:	f2e811e2 	movk	x2, #0x408f, lsl #48
    18b0:	fd47b800 	ldr	d0, [x0, #3952]
    18b4:	f2e81861 	movk	x1, #0x40c3, lsl #48
    18b8:	52808000 	mov	w0, #0x400                 	// #1024
    18bc:	9e67004a 	fmov	d10, x2
    18c0:	9e670029 	fmov	d9, x1
    18c4:	b9008be0 	str	w0, [sp, #136]
    18c8:	fd0043e0 	str	d0, [sp, #128]
    18cc:	b9400315 	ldr	w21, [x24]
    18d0:	93407eb3 	sxtw	x19, w21
    18d4:	eb1a027f 	cmp	x19, x26
    18d8:	54001fc8 	b.hi	1cd0 <_Z13run_benchmarkv+0x48c>  // b.pmore
    18dc:	d37ef673 	lsl	x19, x19, #2
    18e0:	52800156 	mov	w22, #0xa                   	// #10
    18e4:	aa1303e0 	mov	x0, x19
    18e8:	97fffbce 	bl	820 <_Znam@plt>
    18ec:	aa0003f4 	mov	x20, x0
    18f0:	aa1303e0 	mov	x0, x19
    18f4:	97fffbcb 	bl	820 <_Znam@plt>
    18f8:	aa0003f3 	mov	x19, x0
    18fc:	aa1403e1 	mov	x1, x20
    1900:	2a1503e0 	mov	w0, w21
    1904:	97fffc67 	bl	aa0 <_Z16gen_random_floatiPf>
    1908:	aa1303e1 	mov	x1, x19
    190c:	2a1503e0 	mov	w0, w21
    1910:	97fffc64 	bl	aa0 <_Z16gen_random_floatiPf>
    1914:	d503201f 	nop
    1918:	aa1303e2 	mov	x2, x19
    191c:	aa1403e1 	mov	x1, x20
    1920:	2a1503e0 	mov	w0, w21
    1924:	940006a3 	bl	33b0 <_Z33vector_l2_squared_distance_nativeiPKfS0_>
    1928:	710006d6 	subs	w22, w22, #0x1
    192c:	54ffff61 	b.ne	1918 <_Z13run_benchmarkv+0xd4>  // b.any
    1930:	97fffbc0 	bl	830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>
    1934:	aa0003fb 	mov	x27, x0
    1938:	5284e216 	mov	w22, #0x2710                	// #10000
    193c:	d503201f 	nop
    1940:	aa1303e2 	mov	x2, x19
    1944:	aa1403e1 	mov	x1, x20
    1948:	2a1503e0 	mov	w0, w21
    194c:	94000699 	bl	33b0 <_Z33vector_l2_squared_distance_nativeiPKfS0_>
    1950:	710006d6 	subs	w22, w22, #0x1
    1954:	54ffff61 	b.ne	1940 <_Z13run_benchmarkv+0xfc>  // b.any
    1958:	97fffbb6 	bl	830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>
    195c:	cb1b0000 	sub	x0, x0, x27
    1960:	52800156 	mov	w22, #0xa                   	// #10
    1964:	9e620008 	scvtf	d8, x0
    1968:	1e6a1908 	fdiv	d8, d8, d10
    196c:	1e691908 	fdiv	d8, d8, d9
    1970:	aa1303e2 	mov	x2, x19
    1974:	aa1403e1 	mov	x1, x20
    1978:	2a1503e0 	mov	w0, w21
    197c:	94000755 	bl	36d0 <_Z31vector_l2_squared_distance_neoniPKfS0_>
    1980:	710006d6 	subs	w22, w22, #0x1
    1984:	54ffff61 	b.ne	1970 <_Z13run_benchmarkv+0x12c>  // b.any
    1988:	97fffbaa 	bl	830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>
    198c:	aa0003fb 	mov	x27, x0
    1990:	5284e216 	mov	w22, #0x2710                	// #10000
    1994:	d503201f 	nop
    1998:	aa1303e2 	mov	x2, x19
    199c:	aa1403e1 	mov	x1, x20
    19a0:	2a1503e0 	mov	w0, w21
    19a4:	9400074b 	bl	36d0 <_Z31vector_l2_squared_distance_neoniPKfS0_>
    19a8:	710006d6 	subs	w22, w22, #0x1
    19ac:	54ffff61 	b.ne	1998 <_Z13run_benchmarkv+0x154>  // b.any
    19b0:	97fffba0 	bl	830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>
    19b4:	cb1b0002 	sub	x2, x0, x27
    19b8:	1e604100 	fmov	d0, d8
    19bc:	2a1503e1 	mov	w1, w21
    19c0:	9e620041 	scvtf	d1, x2
    19c4:	aa1903e0 	mov	x0, x25
    19c8:	91001318 	add	x24, x24, #0x4
    19cc:	1e6a1821 	fdiv	d1, d1, d10
    19d0:	1e691821 	fdiv	d1, d1, d9
    19d4:	1e611902 	fdiv	d2, d8, d1
    19d8:	97fffbb6 	bl	8b0 <printf@plt>
    19dc:	aa1403e0 	mov	x0, x20
    19e0:	97fffba4 	bl	870 <_ZdaPv@plt>
    19e4:	aa1303e0 	mov	x0, x19
    19e8:	97fffba2 	bl	870 <_ZdaPv@plt>
    19ec:	f10006f7 	subs	x23, x23, #0x1
    19f0:	54fff6e1 	b.ne	18cc <_Z13run_benchmarkv+0x88>  // b.any
    19f4:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    19f8:	910243f7 	add	x23, sp, #0x90
    19fc:	d000001a 	adrp	x26, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1a00:	d2c80002 	mov	x2, #0x400000000000        	// #70368744177664
    1a04:	fd47b800 	ldr	d0, [x0, #3952]
    1a08:	d2d10001 	mov	x1, #0x880000000000        	// #149533581377536
    1a0c:	aa1703f9 	mov	x25, x23
    1a10:	9138835a 	add	x26, x26, #0xe20
    1a14:	52808000 	mov	w0, #0x400                 	// #1024
    1a18:	f2e811e2 	movk	x2, #0x408f, lsl #48
    1a1c:	f2e81861 	movk	x1, #0x40c3, lsl #48
    1a20:	9e67004a 	fmov	d10, x2
    1a24:	9e670029 	fmov	d9, x1
    1a28:	d2800078 	mov	x24, #0x3                   	// #3
    1a2c:	b27eeffb 	mov	x27, #0x3ffffffffffffffc    	// #4611686018427387900
    1a30:	b9009be0 	str	w0, [sp, #152]
    1a34:	fd004be0 	str	d0, [sp, #144]
    1a38:	b9400335 	ldr	w21, [x25]
    1a3c:	93407eb3 	sxtw	x19, w21
    1a40:	eb1b027f 	cmp	x19, x27
    1a44:	54001468 	b.hi	1cd0 <_Z13run_benchmarkv+0x48c>  // b.pmore
    1a48:	d37ffa73 	lsl	x19, x19, #1
    1a4c:	52800156 	mov	w22, #0xa                   	// #10
    1a50:	aa1303e0 	mov	x0, x19
    1a54:	97fffb73 	bl	820 <_Znam@plt>
    1a58:	aa0003f4 	mov	x20, x0
    1a5c:	aa1303e0 	mov	x0, x19
    1a60:	97fffb70 	bl	820 <_Znam@plt>
    1a64:	aa0003f3 	mov	x19, x0
    1a68:	aa1403e1 	mov	x1, x20
    1a6c:	2a1503e0 	mov	w0, w21
    1a70:	97fffd28 	bl	f10 <_Z15gen_random_halfiPt>
    1a74:	aa1303e1 	mov	x1, x19
    1a78:	2a1503e0 	mov	w0, w21
    1a7c:	97fffd25 	bl	f10 <_Z15gen_random_halfiPt>
    1a80:	aa1303e2 	mov	x2, x19
    1a84:	aa1403e1 	mov	x1, x20
    1a88:	2a1503e0 	mov	w0, w21
    1a8c:	940000e1 	bl	1e10 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_>
    1a90:	710006d6 	subs	w22, w22, #0x1
    1a94:	54ffff61 	b.ne	1a80 <_Z13run_benchmarkv+0x23c>  // b.any
    1a98:	97fffb66 	bl	830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>
    1a9c:	aa0003fc 	mov	x28, x0
    1aa0:	5284e216 	mov	w22, #0x2710                	// #10000
    1aa4:	d503201f 	nop
    1aa8:	aa1303e2 	mov	x2, x19
    1aac:	aa1403e1 	mov	x1, x20
    1ab0:	2a1503e0 	mov	w0, w21
    1ab4:	940000d7 	bl	1e10 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_>
    1ab8:	710006d6 	subs	w22, w22, #0x1
    1abc:	54ffff61 	b.ne	1aa8 <_Z13run_benchmarkv+0x264>  // b.any
    1ac0:	97fffb5c 	bl	830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>
    1ac4:	cb1c0000 	sub	x0, x0, x28
    1ac8:	52800156 	mov	w22, #0xa                   	// #10
    1acc:	9e620008 	scvtf	d8, x0
    1ad0:	1e6a1908 	fdiv	d8, d8, d10
    1ad4:	1e691908 	fdiv	d8, d8, d9
    1ad8:	aa1303e2 	mov	x2, x19
    1adc:	aa1403e1 	mov	x1, x20
    1ae0:	2a1503e0 	mov	w0, w21
    1ae4:	9400020b 	bl	2310 <_Z32halfvec_l2_squared_distance_neoniPKtS0_>
    1ae8:	710006d6 	subs	w22, w22, #0x1
    1aec:	54ffff61 	b.ne	1ad8 <_Z13run_benchmarkv+0x294>  // b.any
    1af0:	97fffb50 	bl	830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>
    1af4:	aa0003fc 	mov	x28, x0
    1af8:	5284e216 	mov	w22, #0x2710                	// #10000
    1afc:	d503201f 	nop
    1b00:	aa1303e2 	mov	x2, x19
    1b04:	aa1403e1 	mov	x1, x20
    1b08:	2a1503e0 	mov	w0, w21
    1b0c:	94000201 	bl	2310 <_Z32halfvec_l2_squared_distance_neoniPKtS0_>
    1b10:	710006d6 	subs	w22, w22, #0x1
    1b14:	54ffff61 	b.ne	1b00 <_Z13run_benchmarkv+0x2bc>  // b.any
    1b18:	97fffb46 	bl	830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>
    1b1c:	cb1c0002 	sub	x2, x0, x28
    1b20:	1e604100 	fmov	d0, d8
    1b24:	2a1503e1 	mov	w1, w21
    1b28:	9e620041 	scvtf	d1, x2
    1b2c:	aa1a03e0 	mov	x0, x26
    1b30:	91001339 	add	x25, x25, #0x4
    1b34:	1e6a1821 	fdiv	d1, d1, d10
    1b38:	1e691821 	fdiv	d1, d1, d9
    1b3c:	1e611902 	fdiv	d2, d8, d1
    1b40:	97fffb5c 	bl	8b0 <printf@plt>
    1b44:	aa1403e0 	mov	x0, x20
    1b48:	97fffb4a 	bl	870 <_ZdaPv@plt>
    1b4c:	aa1303e0 	mov	x0, x19
    1b50:	97fffb48 	bl	870 <_ZdaPv@plt>
    1b54:	f1000718 	subs	x24, x24, #0x1
    1b58:	54fff701 	b.ne	1a38 <_Z13run_benchmarkv+0x1f4>  // b.any
    1b5c:	d0000000 	adrp	x0, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1b60:	d0000019 	adrp	x25, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1b64:	d2c80002 	mov	x2, #0x400000000000        	// #70368744177664
    1b68:	d2d10001 	mov	x1, #0x880000000000        	// #149533581377536
    1b6c:	fd47b800 	ldr	d0, [x0, #3952]
    1b70:	91394339 	add	x25, x25, #0xe50
    1b74:	52808000 	mov	w0, #0x400                 	// #1024
    1b78:	f2e811e2 	movk	x2, #0x408f, lsl #48
    1b7c:	f2e81861 	movk	x1, #0x40c3, lsl #48
    1b80:	9e67004a 	fmov	d10, x2
    1b84:	9e670029 	fmov	d9, x1
    1b88:	d2800078 	mov	x24, #0x3                   	// #3
    1b8c:	b9009be0 	str	w0, [sp, #152]
    1b90:	fd004be0 	str	d0, [sp, #144]
    1b94:	b94002f5 	ldr	w21, [x23]
    1b98:	52800156 	mov	w22, #0xa                   	// #10
    1b9c:	2a1503f3 	mov	w19, w21
    1ba0:	aa1303e0 	mov	x0, x19
    1ba4:	97fffb1f 	bl	820 <_Znam@plt>
    1ba8:	aa0003f4 	mov	x20, x0
    1bac:	aa1303e0 	mov	x0, x19
    1bb0:	97fffb1c 	bl	820 <_Znam@plt>
    1bb4:	aa0003f3 	mov	x19, x0
    1bb8:	aa1403e1 	mov	x1, x20
    1bbc:	2a1503e0 	mov	w0, w21
    1bc0:	97fffe75 	bl	1594 <_Z15gen_random_bitsjPh>
    1bc4:	aa1303e1 	mov	x1, x19
    1bc8:	2a1503e0 	mov	w0, w21
    1bcc:	97fffe72 	bl	1594 <_Z15gen_random_bitsjPh>
    1bd0:	aa1303e2 	mov	x2, x19
    1bd4:	aa1403e1 	mov	x1, x20
    1bd8:	2a1503e0 	mov	w0, w21
    1bdc:	94000395 	bl	2a30 <_Z27bit_hamming_distance_nativejPKhS0_>
    1be0:	710006d6 	subs	w22, w22, #0x1
    1be4:	54ffff61 	b.ne	1bd0 <_Z13run_benchmarkv+0x38c>  // b.any
    1be8:	97fffb12 	bl	830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>
    1bec:	aa0003fa 	mov	x26, x0
    1bf0:	5284e216 	mov	w22, #0x2710                	// #10000
    1bf4:	d503201f 	nop
    1bf8:	aa1303e2 	mov	x2, x19
    1bfc:	aa1403e1 	mov	x1, x20
    1c00:	2a1503e0 	mov	w0, w21
    1c04:	9400038b 	bl	2a30 <_Z27bit_hamming_distance_nativejPKhS0_>
    1c08:	710006d6 	subs	w22, w22, #0x1
    1c0c:	54ffff61 	b.ne	1bf8 <_Z13run_benchmarkv+0x3b4>  // b.any
    1c10:	97fffb08 	bl	830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>
    1c14:	cb1a0000 	sub	x0, x0, x26
    1c18:	52800156 	mov	w22, #0xa                   	// #10
    1c1c:	9e620008 	scvtf	d8, x0
    1c20:	1e6a1908 	fdiv	d8, d8, d10
    1c24:	1e691908 	fdiv	d8, d8, d9
    1c28:	aa1303e2 	mov	x2, x19
    1c2c:	aa1403e1 	mov	x1, x20
    1c30:	2a1503e0 	mov	w0, w21
    1c34:	9400044f 	bl	2d70 <_Z25bit_hamming_distance_neonjPKhS0_>
    1c38:	710006d6 	subs	w22, w22, #0x1
    1c3c:	54ffff61 	b.ne	1c28 <_Z13run_benchmarkv+0x3e4>  // b.any
    1c40:	97fffafc 	bl	830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>
    1c44:	aa0003fa 	mov	x26, x0
    1c48:	5284e216 	mov	w22, #0x2710                	// #10000
    1c4c:	d503201f 	nop
    1c50:	aa1303e2 	mov	x2, x19
    1c54:	aa1403e1 	mov	x1, x20
    1c58:	2a1503e0 	mov	w0, w21
    1c5c:	94000445 	bl	2d70 <_Z25bit_hamming_distance_neonjPKhS0_>
    1c60:	710006d6 	subs	w22, w22, #0x1
    1c64:	54ffff61 	b.ne	1c50 <_Z13run_benchmarkv+0x40c>  // b.any
    1c68:	97fffaf2 	bl	830 <_ZNSt6chrono3_V212system_clock3nowEv@plt>
    1c6c:	cb1a0002 	sub	x2, x0, x26
    1c70:	1e604100 	fmov	d0, d8
    1c74:	2a1503e1 	mov	w1, w21
    1c78:	9e620041 	scvtf	d1, x2
    1c7c:	aa1903e0 	mov	x0, x25
    1c80:	910012f7 	add	x23, x23, #0x4
    1c84:	1e6a1821 	fdiv	d1, d1, d10
    1c88:	1e691821 	fdiv	d1, d1, d9
    1c8c:	1e611902 	fdiv	d2, d8, d1
    1c90:	97fffb08 	bl	8b0 <printf@plt>
    1c94:	aa1403e0 	mov	x0, x20
    1c98:	97fffaf6 	bl	870 <_ZdaPv@plt>
    1c9c:	aa1303e0 	mov	x0, x19
    1ca0:	97fffaf4 	bl	870 <_ZdaPv@plt>
    1ca4:	f1000718 	subs	x24, x24, #0x1
    1ca8:	54fff761 	b.ne	1b94 <_Z13run_benchmarkv+0x350>  // b.any
    1cac:	a94153f3 	ldp	x19, x20, [sp, #16]
    1cb0:	a9425bf5 	ldp	x21, x22, [sp, #32]
    1cb4:	a94363f7 	ldp	x23, x24, [sp, #48]
    1cb8:	a9446bf9 	ldp	x25, x26, [sp, #64]
    1cbc:	a94573fb 	ldp	x27, x28, [sp, #80]
    1cc0:	6d4627e8 	ldp	d8, d9, [sp, #96]
    1cc4:	fd403bea 	ldr	d10, [sp, #112]
    1cc8:	a8ca7bfd 	ldp	x29, x30, [sp], #160
    1ccc:	d65f03c0 	ret
    1cd0:	97fffaec 	bl	880 <__cxa_throw_bad_array_new_length@plt>
    1cd4:	d503201f 	nop
    1cd8:	d503201f 	nop
    1cdc:	d503201f 	nop

0000000000001ce0 <_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv>:
    1ce0:	d0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1ce4:	d0000001 	adrp	x1, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1ce8:	911c6005 	add	x5, x0, #0x718
    1cec:	3dc3cc45 	ldr	q5, [x2, #3888]
    1cf0:	d0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1cf4:	3dc3c826 	ldr	q6, [x1, #3872]
    1cf8:	91002001 	add	x1, x0, #0x8
    1cfc:	3dc3d044 	ldr	q4, [x2, #3904]
    1d00:	d0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1d04:	3dc3d441 	ldr	q1, [x2, #3920]
    1d08:	91004021 	add	x1, x1, #0x10
    1d0c:	3cde8020 	ldur	q0, [x1, #-24]
    1d10:	3cdf0023 	ldur	q3, [x1, #-16]
    1d14:	4e261c00 	and	v0.16b, v0.16b, v6.16b
    1d18:	3dc31422 	ldr	q2, [x1, #3152]
    1d1c:	4e251c63 	and	v3.16b, v3.16b, v5.16b
    1d20:	4ea31c00 	orr	v0.16b, v0.16b, v3.16b
    1d24:	6f7f0403 	ushr	v3.2d, v0.2d, #1
    1d28:	4e241c00 	and	v0.16b, v0.16b, v4.16b
    1d2c:	6e231c42 	eor	v2.16b, v2.16b, v3.16b
    1d30:	4ee09800 	cmeq	v0.2d, v0.2d, #0
    1d34:	6e211c43 	eor	v3.16b, v2.16b, v1.16b
    1d38:	6e631c40 	bsl	v0.16b, v2.16b, v3.16b
    1d3c:	3c9e8020 	stur	q0, [x1, #-24]
    1d40:	eb0100bf 	cmp	x5, x1
    1d44:	54fffe21 	b.ne	1d08 <_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv+0x28>  // b.any
    1d48:	f9438802 	ldr	x2, [x0, #1808]
    1d4c:	911c8006 	add	x6, x0, #0x720
    1d50:	f9438c04 	ldr	x4, [x0, #1816]
    1d54:	d2800003 	mov	x3, #0x0                   	// #0
    1d58:	f949bc01 	ldr	x1, [x0, #4984]
    1d5c:	b3407882 	bfxil	x2, x4, #0, #31
    1d60:	d0000004 	adrp	x4, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1d64:	ca420421 	eor	x1, x1, x2, lsr #1
    1d68:	f240005f 	tst	x2, #0x1
    1d6c:	d0000002 	adrp	x2, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1d70:	3dc3c886 	ldr	q6, [x4, #3872]
    1d74:	d0000004 	adrp	x4, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1d78:	3dc3d044 	ldr	q4, [x2, #3904]
    1d7c:	9e660022 	fmov	x2, d1
    1d80:	3dc3cc85 	ldr	q5, [x4, #3888]
    1d84:	d0000004 	adrp	x4, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    1d88:	3dc3d483 	ldr	q3, [x4, #3920]
    1d8c:	ca020022 	eor	x2, x1, x2
    1d90:	9a811041 	csel	x1, x2, x1, ne	// ne = any
    1d94:	f9038801 	str	x1, [x0, #1808]
    1d98:	3ce368a0 	ldr	q0, [x5, x3]
    1d9c:	3ce368c2 	ldr	q2, [x6, x3]
    1da0:	4e261c00 	and	v0.16b, v0.16b, v6.16b
    1da4:	3ce36801 	ldr	q1, [x0, x3]
    1da8:	4e251c42 	and	v2.16b, v2.16b, v5.16b
    1dac:	4ea21c00 	orr	v0.16b, v0.16b, v2.16b
    1db0:	6f7f0402 	ushr	v2.2d, v0.2d, #1
    1db4:	4e241c00 	and	v0.16b, v0.16b, v4.16b
    1db8:	6e221c21 	eor	v1.16b, v1.16b, v2.16b
    1dbc:	4ee09800 	cmeq	v0.2d, v0.2d, #0
    1dc0:	6e231c22 	eor	v2.16b, v1.16b, v3.16b
    1dc4:	6e621c20 	bsl	v0.16b, v1.16b, v2.16b
    1dc8:	3ca368a0 	str	q0, [x5, x3]
    1dcc:	91004063 	add	x3, x3, #0x10
    1dd0:	f131807f 	cmp	x3, #0xc60
    1dd4:	54fffe21 	b.ne	1d98 <_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv+0xb8>  // b.any
    1dd8:	f9400003 	ldr	x3, [x0]
    1ddc:	f909c01f 	str	xzr, [x0, #4992]
    1de0:	f949bc01 	ldr	x1, [x0, #4984]
    1de4:	f9463002 	ldr	x2, [x0, #3168]
    1de8:	b3407861 	bfxil	x1, x3, #0, #31
    1dec:	ca410442 	eor	x2, x2, x1, lsr #1
    1df0:	f240003f 	tst	x1, #0x1
    1df4:	9e660061 	fmov	x1, d3
    1df8:	ca010041 	eor	x1, x2, x1
    1dfc:	9a821022 	csel	x2, x1, x2, ne	// ne = any
    1e00:	f909bc02 	str	x2, [x0, #4984]
    1e04:	d65f03c0 	ret
    1e08:	d503201f 	nop
    1e0c:	d503201f 	nop

0000000000001e10 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_>:
    1e10:	0f000400 	movi	v0.2s, #0x0
    1e14:	7100001f 	cmp	w0, #0x0
    1e18:	540005ad 	b.le	1ecc <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0xbc>
    1e1c:	937f7c08 	sbfiz	x8, x0, #1, #32
    1e20:	d2800005 	mov	x5, #0x0                   	// #0
    1e24:	d503201f 	nop
    1e28:	78656824 	ldrh	w4, [x1, x5]
    1e2c:	12002483 	and	w3, w4, #0x3ff
    1e30:	530f7c80 	lsr	w0, w4, #15
    1e34:	d34a3884 	ubfx	x4, x4, #10, #5
    1e38:	53010000 	lsl	w0, w0, #31
    1e3c:	350004a4 	cbnz	w4, 1ed0 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0xc0>
    1e40:	34000163 	cbz	w3, 1e6c <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0x5c>
    1e44:	128001a4 	mov	w4, #0xfffffff2            	// #-14
    1e48:	2a0303e7 	mov	w7, w3
    1e4c:	2a0403e6 	mov	w6, w4
    1e50:	531f7863 	lsl	w3, w3, #1
    1e54:	51000484 	sub	w4, w4, #0x1
    1e58:	3657ff83 	tbz	w3, #10, 1e48 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0x38>
    1e5c:	1101f8c6 	add	w6, w6, #0x7e
    1e60:	531220e7 	ubfiz	w7, w7, #14, #9
    1e64:	2a065ce6 	orr	w6, w7, w6, lsl #23
    1e68:	2a060000 	orr	w0, w0, w6
    1e6c:	78656843 	ldrh	w3, [x2, x5]
    1e70:	1e270001 	fmov	s1, w0
    1e74:	12002460 	and	w0, w3, #0x3ff
    1e78:	530f7c64 	lsr	w4, w3, #15
    1e7c:	d34a3863 	ubfx	x3, x3, #10, #5
    1e80:	53010084 	lsl	w4, w4, #31
    1e84:	350003e3 	cbnz	w3, 1f00 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0xf0>
    1e88:	34000160 	cbz	w0, 1eb4 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0xa4>
    1e8c:	128001a3 	mov	w3, #0xfffffff2            	// #-14
    1e90:	2a0003e7 	mov	w7, w0
    1e94:	2a0303e6 	mov	w6, w3
    1e98:	531f7800 	lsl	w0, w0, #1
    1e9c:	51000463 	sub	w3, w3, #0x1
    1ea0:	3657ff80 	tbz	w0, #10, 1e90 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0x80>
    1ea4:	1101f8c6 	add	w6, w6, #0x7e
    1ea8:	531220e7 	ubfiz	w7, w7, #14, #9
    1eac:	2a065ce6 	orr	w6, w7, w6, lsl #23
    1eb0:	2a060084 	orr	w4, w4, w6
    1eb4:	1e270082 	fmov	s2, w4
    1eb8:	910008a5 	add	x5, x5, #0x2
    1ebc:	1e223821 	fsub	s1, s1, s2
    1ec0:	1f010020 	fmadd	s0, s1, s1, s0
    1ec4:	eb0800bf 	cmp	x5, x8
    1ec8:	54fffb01 	b.ne	1e28 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0x18>  // b.any
    1ecc:	d65f03c0 	ret
    1ed0:	71007c9f 	cmp	w4, #0x1f
    1ed4:	54000220 	b.eq	1f18 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0x108>  // b.none
    1ed8:	2a033400 	orr	w0, w0, w3, lsl #13
    1edc:	78656843 	ldrh	w3, [x2, x5]
    1ee0:	1101c084 	add	w4, w4, #0x70
    1ee4:	2a045c00 	orr	w0, w0, w4, lsl #23
    1ee8:	530f7c64 	lsr	w4, w3, #15
    1eec:	1e270001 	fmov	s1, w0
    1ef0:	12002460 	and	w0, w3, #0x3ff
    1ef4:	53010084 	lsl	w4, w4, #31
    1ef8:	d34a3863 	ubfx	x3, x3, #10, #5
    1efc:	34fffc63 	cbz	w3, 1e88 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0x78>
    1f00:	71007c7f 	cmp	w3, #0x1f
    1f04:	54000140 	b.eq	1f2c <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0x11c>  // b.none
    1f08:	1101c063 	add	w3, w3, #0x70
    1f0c:	2a003484 	orr	w4, w4, w0, lsl #13
    1f10:	2a035c84 	orr	w4, w4, w3, lsl #23
    1f14:	17ffffe8 	b	1eb4 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0xa4>
    1f18:	7100007f 	cmp	w3, #0x0
    1f1c:	32091c03 	orr	w3, w0, #0x7f800000
    1f20:	320a2000 	orr	w0, w0, #0x7fc00000
    1f24:	1a831000 	csel	w0, w0, w3, ne	// ne = any
    1f28:	17ffffd1 	b	1e6c <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0x5c>
    1f2c:	7100001f 	cmp	w0, #0x0
    1f30:	32091c80 	orr	w0, w4, #0x7f800000
    1f34:	320a2084 	orr	w4, w4, #0x7fc00000
    1f38:	1a801084 	csel	w4, w4, w0, ne	// ne = any
    1f3c:	17ffffde 	b	1eb4 <_Z34halfvec_l2_squared_distance_nativeiPKtS0_+0xa4>

0000000000001f40 <_Z28halfvec_inner_product_nativeiPKtS0_>:
    1f40:	0f000400 	movi	v0.2s, #0x0
    1f44:	7100001f 	cmp	w0, #0x0
    1f48:	5400058d 	b.le	1ff8 <_Z28halfvec_inner_product_nativeiPKtS0_+0xb8>
    1f4c:	937f7c08 	sbfiz	x8, x0, #1, #32
    1f50:	d2800005 	mov	x5, #0x0                   	// #0
    1f54:	d503201f 	nop
    1f58:	78656824 	ldrh	w4, [x1, x5]
    1f5c:	12002480 	and	w0, w4, #0x3ff
    1f60:	530f7c83 	lsr	w3, w4, #15
    1f64:	d34a3884 	ubfx	x4, x4, #10, #5
    1f68:	53010063 	lsl	w3, w3, #31
    1f6c:	35000484 	cbnz	w4, 1ffc <_Z28halfvec_inner_product_nativeiPKtS0_+0xbc>
    1f70:	34000160 	cbz	w0, 1f9c <_Z28halfvec_inner_product_nativeiPKtS0_+0x5c>
    1f74:	128001a4 	mov	w4, #0xfffffff2            	// #-14
    1f78:	2a0003e7 	mov	w7, w0
    1f7c:	2a0403e6 	mov	w6, w4
    1f80:	531f7800 	lsl	w0, w0, #1
    1f84:	51000484 	sub	w4, w4, #0x1
    1f88:	3657ff80 	tbz	w0, #10, 1f78 <_Z28halfvec_inner_product_nativeiPKtS0_+0x38>
    1f8c:	1101f8c6 	add	w6, w6, #0x7e
    1f90:	531220e7 	ubfiz	w7, w7, #14, #9
    1f94:	2a065ce6 	orr	w6, w7, w6, lsl #23
    1f98:	2a060063 	orr	w3, w3, w6
    1f9c:	78656844 	ldrh	w4, [x2, x5]
    1fa0:	1e270061 	fmov	s1, w3
    1fa4:	12002480 	and	w0, w4, #0x3ff
    1fa8:	530f7c83 	lsr	w3, w4, #15
    1fac:	d34a3884 	ubfx	x4, x4, #10, #5
    1fb0:	53010063 	lsl	w3, w3, #31
    1fb4:	350003c4 	cbnz	w4, 202c <_Z28halfvec_inner_product_nativeiPKtS0_+0xec>
    1fb8:	34000160 	cbz	w0, 1fe4 <_Z28halfvec_inner_product_nativeiPKtS0_+0xa4>
    1fbc:	128001a4 	mov	w4, #0xfffffff2            	// #-14
    1fc0:	2a0003e7 	mov	w7, w0
    1fc4:	2a0403e6 	mov	w6, w4
    1fc8:	531f7800 	lsl	w0, w0, #1
    1fcc:	51000484 	sub	w4, w4, #0x1
    1fd0:	3657ff80 	tbz	w0, #10, 1fc0 <_Z28halfvec_inner_product_nativeiPKtS0_+0x80>
    1fd4:	1101f8c6 	add	w6, w6, #0x7e
    1fd8:	531220e7 	ubfiz	w7, w7, #14, #9
    1fdc:	2a065ce6 	orr	w6, w7, w6, lsl #23
    1fe0:	2a060063 	orr	w3, w3, w6
    1fe4:	1e270062 	fmov	s2, w3
    1fe8:	910008a5 	add	x5, x5, #0x2
    1fec:	1f020020 	fmadd	s0, s1, s2, s0
    1ff0:	eb0800bf 	cmp	x5, x8
    1ff4:	54fffb21 	b.ne	1f58 <_Z28halfvec_inner_product_nativeiPKtS0_+0x18>  // b.any
    1ff8:	d65f03c0 	ret
    1ffc:	71007c9f 	cmp	w4, #0x1f
    2000:	54000220 	b.eq	2044 <_Z28halfvec_inner_product_nativeiPKtS0_+0x104>  // b.none
    2004:	1101c084 	add	w4, w4, #0x70
    2008:	2a003463 	orr	w3, w3, w0, lsl #13
    200c:	2a045c63 	orr	w3, w3, w4, lsl #23
    2010:	78656844 	ldrh	w4, [x2, x5]
    2014:	1e270061 	fmov	s1, w3
    2018:	12002480 	and	w0, w4, #0x3ff
    201c:	530f7c83 	lsr	w3, w4, #15
    2020:	d34a3884 	ubfx	x4, x4, #10, #5
    2024:	53010063 	lsl	w3, w3, #31
    2028:	34fffc84 	cbz	w4, 1fb8 <_Z28halfvec_inner_product_nativeiPKtS0_+0x78>
    202c:	71007c9f 	cmp	w4, #0x1f
    2030:	54000140 	b.eq	2058 <_Z28halfvec_inner_product_nativeiPKtS0_+0x118>  // b.none
    2034:	1101c084 	add	w4, w4, #0x70
    2038:	2a003463 	orr	w3, w3, w0, lsl #13
    203c:	2a045c63 	orr	w3, w3, w4, lsl #23
    2040:	17ffffe9 	b	1fe4 <_Z28halfvec_inner_product_nativeiPKtS0_+0xa4>
    2044:	7100001f 	cmp	w0, #0x0
    2048:	32091c60 	orr	w0, w3, #0x7f800000
    204c:	320a2063 	orr	w3, w3, #0x7fc00000
    2050:	1a801063 	csel	w3, w3, w0, ne	// ne = any
    2054:	17ffffd2 	b	1f9c <_Z28halfvec_inner_product_nativeiPKtS0_+0x5c>
    2058:	7100001f 	cmp	w0, #0x0
    205c:	32091c60 	orr	w0, w3, #0x7f800000
    2060:	320a2063 	orr	w3, w3, #0x7fc00000
    2064:	1a801063 	csel	w3, w3, w0, ne	// ne = any
    2068:	17ffffdf 	b	1fe4 <_Z28halfvec_inner_product_nativeiPKtS0_+0xa4>
    206c:	d503201f 	nop

0000000000002070 <_Z32halfvec_cosine_similarity_nativeiPKtS0_>:
    2070:	7100001f 	cmp	w0, #0x0
    2074:	54000b0d 	b.le	21d4 <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0x164>
    2078:	0f000403 	movi	v3.2s, #0x0
    207c:	937f7c08 	sbfiz	x8, x0, #1, #32
    2080:	d2800005 	mov	x5, #0x0                   	// #0
    2084:	1e204062 	fmov	s2, s3
    2088:	1e204064 	fmov	s4, s3
    208c:	d503201f 	nop
    2090:	78656824 	ldrh	w4, [x1, x5]
    2094:	12002483 	and	w3, w4, #0x3ff
    2098:	530f7c80 	lsr	w0, w4, #15
    209c:	d34a3884 	ubfx	x4, x4, #10, #5
    20a0:	53010000 	lsl	w0, w0, #31
    20a4:	35000784 	cbnz	w4, 2194 <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0x124>
    20a8:	34000163 	cbz	w3, 20d4 <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0x64>
    20ac:	128001a4 	mov	w4, #0xfffffff2            	// #-14
    20b0:	2a0303e7 	mov	w7, w3
    20b4:	2a0403e6 	mov	w6, w4
    20b8:	531f7863 	lsl	w3, w3, #1
    20bc:	51000484 	sub	w4, w4, #0x1
    20c0:	3657ff83 	tbz	w3, #10, 20b0 <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0x40>
    20c4:	1101f8c6 	add	w6, w6, #0x7e
    20c8:	531220e7 	ubfiz	w7, w7, #14, #9
    20cc:	2a065ce6 	orr	w6, w7, w6, lsl #23
    20d0:	2a060000 	orr	w0, w0, w6
    20d4:	78656844 	ldrh	w4, [x2, x5]
    20d8:	1e270001 	fmov	s1, w0
    20dc:	12002483 	and	w3, w4, #0x3ff
    20e0:	530f7c80 	lsr	w0, w4, #15
    20e4:	d34a3884 	ubfx	x4, x4, #10, #5
    20e8:	53010000 	lsl	w0, w0, #31
    20ec:	35000484 	cbnz	w4, 217c <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0x10c>
    20f0:	34000163 	cbz	w3, 211c <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0xac>
    20f4:	128001a4 	mov	w4, #0xfffffff2            	// #-14
    20f8:	2a0303e7 	mov	w7, w3
    20fc:	2a0403e6 	mov	w6, w4
    2100:	531f7863 	lsl	w3, w3, #1
    2104:	51000484 	sub	w4, w4, #0x1
    2108:	3657ff83 	tbz	w3, #10, 20f8 <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0x88>
    210c:	1101f8c6 	add	w6, w6, #0x7e
    2110:	531220e7 	ubfiz	w7, w7, #14, #9
    2114:	2a065ce6 	orr	w6, w7, w6, lsl #23
    2118:	2a060000 	orr	w0, w0, w6
    211c:	1e270000 	fmov	s0, w0
    2120:	910008a5 	add	x5, x5, #0x2
    2124:	1f010822 	fmadd	s2, s1, s1, s2
    2128:	1f011004 	fmadd	s4, s0, s1, s4
    212c:	1f000c03 	fmadd	s3, s0, s0, s3
    2130:	eb0800bf 	cmp	x5, x8
    2134:	54fffae1 	b.ne	2090 <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0x20>  // b.any
    2138:	1e22c040 	fcvt	d0, s2
    213c:	1e22c063 	fcvt	d3, s3
    2140:	1e22c084 	fcvt	d4, s4
    2144:	1e630800 	fmul	d0, d0, d3
    2148:	1e602008 	fcmp	d0, #0.0
    214c:	54000125 	b.pl	2170 <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0x100>  // b.nfrst
    2150:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    2154:	910003fd 	mov	x29, sp
    2158:	fd000fe4 	str	d4, [sp, #24]
    215c:	97fff9d9 	bl	8c0 <sqrt@plt>
    2160:	fd400fe4 	ldr	d4, [sp, #24]
    2164:	a8c27bfd 	ldp	x29, x30, [sp], #32
    2168:	1e601880 	fdiv	d0, d4, d0
    216c:	d65f03c0 	ret
    2170:	1e61c000 	fsqrt	d0, d0
    2174:	1e601880 	fdiv	d0, d4, d0
    2178:	d65f03c0 	ret
    217c:	71007c9f 	cmp	w4, #0x1f
    2180:	54000160 	b.eq	21ac <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0x13c>  // b.none
    2184:	1101c084 	add	w4, w4, #0x70
    2188:	2a033400 	orr	w0, w0, w3, lsl #13
    218c:	2a045c00 	orr	w0, w0, w4, lsl #23
    2190:	17ffffe3 	b	211c <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0xac>
    2194:	71007c9f 	cmp	w4, #0x1f
    2198:	54000140 	b.eq	21c0 <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0x150>  // b.none
    219c:	1101c084 	add	w4, w4, #0x70
    21a0:	2a033400 	orr	w0, w0, w3, lsl #13
    21a4:	2a045c00 	orr	w0, w0, w4, lsl #23
    21a8:	17ffffcb 	b	20d4 <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0x64>
    21ac:	7100007f 	cmp	w3, #0x0
    21b0:	32091c03 	orr	w3, w0, #0x7f800000
    21b4:	320a2000 	orr	w0, w0, #0x7fc00000
    21b8:	1a831000 	csel	w0, w0, w3, ne	// ne = any
    21bc:	17ffffd8 	b	211c <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0xac>
    21c0:	7100007f 	cmp	w3, #0x0
    21c4:	32091c03 	orr	w3, w0, #0x7f800000
    21c8:	320a2000 	orr	w0, w0, #0x7fc00000
    21cc:	1a831000 	csel	w0, w0, w3, ne	// ne = any
    21d0:	17ffffc1 	b	20d4 <_Z32halfvec_cosine_similarity_nativeiPKtS0_+0x64>
    21d4:	2f00e400 	movi	d0, #0x0
    21d8:	1e604004 	fmov	d4, d0
    21dc:	1e601880 	fdiv	d0, d4, d0
    21e0:	d65f03c0 	ret

00000000000021e4 <_Z26halfvec_l1_distance_nativeiPKtS0_>:
    21e4:	0f000400 	movi	v0.2s, #0x0
    21e8:	7100001f 	cmp	w0, #0x0
    21ec:	5400058d 	b.le	229c <_Z26halfvec_l1_distance_nativeiPKtS0_+0xb8>
    21f0:	937f7c08 	sbfiz	x8, x0, #1, #32
    21f4:	d2800005 	mov	x5, #0x0                   	// #0
    21f8:	78656824 	ldrh	w4, [x1, x5]
    21fc:	12002483 	and	w3, w4, #0x3ff
    2200:	530f7c80 	lsr	w0, w4, #15
    2204:	d34a3884 	ubfx	x4, x4, #10, #5
    2208:	53010000 	lsl	w0, w0, #31
    220c:	350004a4 	cbnz	w4, 22a0 <_Z26halfvec_l1_distance_nativeiPKtS0_+0xbc>
    2210:	34000163 	cbz	w3, 223c <_Z26halfvec_l1_distance_nativeiPKtS0_+0x58>
    2214:	128001a4 	mov	w4, #0xfffffff2            	// #-14
    2218:	2a0303e7 	mov	w7, w3
    221c:	2a0403e6 	mov	w6, w4
    2220:	531f7863 	lsl	w3, w3, #1
    2224:	51000484 	sub	w4, w4, #0x1
    2228:	3657ff83 	tbz	w3, #10, 2218 <_Z26halfvec_l1_distance_nativeiPKtS0_+0x34>
    222c:	1101f8c6 	add	w6, w6, #0x7e
    2230:	531220e7 	ubfiz	w7, w7, #14, #9
    2234:	2a065ce6 	orr	w6, w7, w6, lsl #23
    2238:	2a060000 	orr	w0, w0, w6
    223c:	78656843 	ldrh	w3, [x2, x5]
    2240:	1e270001 	fmov	s1, w0
    2244:	12002460 	and	w0, w3, #0x3ff
    2248:	530f7c64 	lsr	w4, w3, #15
    224c:	d34a3863 	ubfx	x3, x3, #10, #5
    2250:	53010084 	lsl	w4, w4, #31
    2254:	350003e3 	cbnz	w3, 22d0 <_Z26halfvec_l1_distance_nativeiPKtS0_+0xec>
    2258:	34000160 	cbz	w0, 2284 <_Z26halfvec_l1_distance_nativeiPKtS0_+0xa0>
    225c:	128001a3 	mov	w3, #0xfffffff2            	// #-14
    2260:	2a0003e7 	mov	w7, w0
    2264:	2a0303e6 	mov	w6, w3
    2268:	531f7800 	lsl	w0, w0, #1
    226c:	51000463 	sub	w3, w3, #0x1
    2270:	3657ff80 	tbz	w0, #10, 2260 <_Z26halfvec_l1_distance_nativeiPKtS0_+0x7c>
    2274:	1101f8c6 	add	w6, w6, #0x7e
    2278:	531220e7 	ubfiz	w7, w7, #14, #9
    227c:	2a065ce6 	orr	w6, w7, w6, lsl #23
    2280:	2a060084 	orr	w4, w4, w6
    2284:	1e270082 	fmov	s2, w4
    2288:	910008a5 	add	x5, x5, #0x2
    228c:	7ea2d421 	fabd	s1, s1, s2
    2290:	1e212800 	fadd	s0, s0, s1
    2294:	eb0800bf 	cmp	x5, x8
    2298:	54fffb01 	b.ne	21f8 <_Z26halfvec_l1_distance_nativeiPKtS0_+0x14>  // b.any
    229c:	d65f03c0 	ret
    22a0:	71007c9f 	cmp	w4, #0x1f
    22a4:	54000220 	b.eq	22e8 <_Z26halfvec_l1_distance_nativeiPKtS0_+0x104>  // b.none
    22a8:	2a033400 	orr	w0, w0, w3, lsl #13
    22ac:	78656843 	ldrh	w3, [x2, x5]
    22b0:	1101c084 	add	w4, w4, #0x70
    22b4:	2a045c00 	orr	w0, w0, w4, lsl #23
    22b8:	530f7c64 	lsr	w4, w3, #15
    22bc:	1e270001 	fmov	s1, w0
    22c0:	12002460 	and	w0, w3, #0x3ff
    22c4:	53010084 	lsl	w4, w4, #31
    22c8:	d34a3863 	ubfx	x3, x3, #10, #5
    22cc:	34fffc63 	cbz	w3, 2258 <_Z26halfvec_l1_distance_nativeiPKtS0_+0x74>
    22d0:	71007c7f 	cmp	w3, #0x1f
    22d4:	54000140 	b.eq	22fc <_Z26halfvec_l1_distance_nativeiPKtS0_+0x118>  // b.none
    22d8:	1101c063 	add	w3, w3, #0x70
    22dc:	2a003484 	orr	w4, w4, w0, lsl #13
    22e0:	2a035c84 	orr	w4, w4, w3, lsl #23
    22e4:	17ffffe8 	b	2284 <_Z26halfvec_l1_distance_nativeiPKtS0_+0xa0>
    22e8:	7100007f 	cmp	w3, #0x0
    22ec:	32091c03 	orr	w3, w0, #0x7f800000
    22f0:	320a2000 	orr	w0, w0, #0x7fc00000
    22f4:	1a831000 	csel	w0, w0, w3, ne	// ne = any
    22f8:	17ffffd1 	b	223c <_Z26halfvec_l1_distance_nativeiPKtS0_+0x58>
    22fc:	7100001f 	cmp	w0, #0x0
    2300:	32091c80 	orr	w0, w4, #0x7f800000
    2304:	320a2084 	orr	w4, w4, #0x7fc00000
    2308:	1a801084 	csel	w4, w4, w0, ne	// ne = any
    230c:	17ffffde 	b	2284 <_Z26halfvec_l1_distance_nativeiPKtS0_+0xa0>

0000000000002310 <_Z32halfvec_l2_squared_distance_neoniPKtS0_>:
    2310:	6b0003e3 	negs	w3, w0
    2314:	12000404 	and	w4, w0, #0x3
    2318:	12000463 	and	w3, w3, #0x3
    231c:	5a834483 	csneg	w3, w4, w3, mi	// mi = first
    2320:	4b030003 	sub	w3, w0, w3
    2324:	7100007f 	cmp	w3, #0x0
    2328:	54000c4d 	b.le	24b0 <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0x1a0>
    232c:	4f000400 	movi	v0.4s, #0x0
    2330:	51000466 	sub	w6, w3, #0x1
    2334:	d2800003 	mov	x3, #0x0                   	// #0
    2338:	53027cc6 	lsr	w6, w6, #2
    233c:	110004c4 	add	w4, w6, #0x1
    2340:	aa0403e6 	mov	x6, x4
    2344:	d503201f 	nop
    2348:	fc637842 	ldr	d2, [x2, x3, lsl #3]
    234c:	fc637821 	ldr	d1, [x1, x3, lsl #3]
    2350:	91000463 	add	x3, x3, #0x1
    2354:	0e217842 	fcvtl	v2.4s, v2.4h
    2358:	0e217821 	fcvtl	v1.4s, v1.4h
    235c:	4ea2d421 	fsub	v1.4s, v1.4s, v2.4s
    2360:	6e21dc21 	fmul	v1.4s, v1.4s, v1.4s
    2364:	4e21d400 	fadd	v0.4s, v0.4s, v1.4s
    2368:	eb04007f 	cmp	x3, x4
    236c:	54fffee1 	b.ne	2348 <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0x38>  // b.any
    2370:	6e20d400 	faddp	v0.4s, v0.4s, v0.4s
    2374:	531e74c6 	lsl	w6, w6, #2
    2378:	6e20d400 	faddp	v0.4s, v0.4s, v0.4s
    237c:	6b06001f 	cmp	w0, w6
    2380:	540005ed 	b.le	243c <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0x12c>
    2384:	4b060000 	sub	w0, w0, w6
    2388:	937f7cc5 	sbfiz	x5, x6, #1, #32
    238c:	8b26c006 	add	x6, x0, w6, sxtw
    2390:	d37ff8c6 	lsl	x6, x6, #1
    2394:	d503201f 	nop
    2398:	78656824 	ldrh	w4, [x1, x5]
    239c:	12002483 	and	w3, w4, #0x3ff
    23a0:	530f7c80 	lsr	w0, w4, #15
    23a4:	d34a3884 	ubfx	x4, x4, #10, #5
    23a8:	53010000 	lsl	w0, w0, #31
    23ac:	350004a4 	cbnz	w4, 2440 <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0x130>
    23b0:	34000163 	cbz	w3, 23dc <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0xcc>
    23b4:	128001a4 	mov	w4, #0xfffffff2            	// #-14
    23b8:	2a0303e8 	mov	w8, w3
    23bc:	2a0403e7 	mov	w7, w4
    23c0:	531f7863 	lsl	w3, w3, #1
    23c4:	51000484 	sub	w4, w4, #0x1
    23c8:	3657ff83 	tbz	w3, #10, 23b8 <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0xa8>
    23cc:	1101f8e7 	add	w7, w7, #0x7e
    23d0:	53122108 	ubfiz	w8, w8, #14, #9
    23d4:	2a075d07 	orr	w7, w8, w7, lsl #23
    23d8:	2a070000 	orr	w0, w0, w7
    23dc:	78656843 	ldrh	w3, [x2, x5]
    23e0:	1e270001 	fmov	s1, w0
    23e4:	12002460 	and	w0, w3, #0x3ff
    23e8:	530f7c64 	lsr	w4, w3, #15
    23ec:	d34a3863 	ubfx	x3, x3, #10, #5
    23f0:	53010084 	lsl	w4, w4, #31
    23f4:	350003e3 	cbnz	w3, 2470 <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0x160>
    23f8:	34000160 	cbz	w0, 2424 <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0x114>
    23fc:	128001a3 	mov	w3, #0xfffffff2            	// #-14
    2400:	2a0003e8 	mov	w8, w0
    2404:	2a0303e7 	mov	w7, w3
    2408:	531f7800 	lsl	w0, w0, #1
    240c:	51000463 	sub	w3, w3, #0x1
    2410:	3657ff80 	tbz	w0, #10, 2400 <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0xf0>
    2414:	1101f8e7 	add	w7, w7, #0x7e
    2418:	53122108 	ubfiz	w8, w8, #14, #9
    241c:	2a075d07 	orr	w7, w8, w7, lsl #23
    2420:	2a070084 	orr	w4, w4, w7
    2424:	1e270082 	fmov	s2, w4
    2428:	910008a5 	add	x5, x5, #0x2
    242c:	1e223821 	fsub	s1, s1, s2
    2430:	1f010020 	fmadd	s0, s1, s1, s0
    2434:	eb0600bf 	cmp	x5, x6
    2438:	54fffb01 	b.ne	2398 <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0x88>  // b.any
    243c:	d65f03c0 	ret
    2440:	71007c9f 	cmp	w4, #0x1f
    2444:	54000220 	b.eq	2488 <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0x178>  // b.none
    2448:	2a033400 	orr	w0, w0, w3, lsl #13
    244c:	78656843 	ldrh	w3, [x2, x5]
    2450:	1101c084 	add	w4, w4, #0x70
    2454:	2a045c00 	orr	w0, w0, w4, lsl #23
    2458:	530f7c64 	lsr	w4, w3, #15
    245c:	1e270001 	fmov	s1, w0
    2460:	12002460 	and	w0, w3, #0x3ff
    2464:	53010084 	lsl	w4, w4, #31
    2468:	d34a3863 	ubfx	x3, x3, #10, #5
    246c:	34fffc63 	cbz	w3, 23f8 <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0xe8>
    2470:	71007c7f 	cmp	w3, #0x1f
    2474:	54000140 	b.eq	249c <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0x18c>  // b.none
    2478:	1101c063 	add	w3, w3, #0x70
    247c:	2a003484 	orr	w4, w4, w0, lsl #13
    2480:	2a035c84 	orr	w4, w4, w3, lsl #23
    2484:	17ffffe8 	b	2424 <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0x114>
    2488:	7100007f 	cmp	w3, #0x0
    248c:	32091c03 	orr	w3, w0, #0x7f800000
    2490:	320a2000 	orr	w0, w0, #0x7fc00000
    2494:	1a831000 	csel	w0, w0, w3, ne	// ne = any
    2498:	17ffffd1 	b	23dc <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0xcc>
    249c:	7100001f 	cmp	w0, #0x0
    24a0:	32091c80 	orr	w0, w4, #0x7f800000
    24a4:	320a2084 	orr	w4, w4, #0x7fc00000
    24a8:	1a801084 	csel	w4, w4, w0, ne	// ne = any
    24ac:	17ffffde 	b	2424 <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0x114>
    24b0:	0f000400 	movi	v0.2s, #0x0
    24b4:	52800006 	mov	w6, #0x0                   	// #0
    24b8:	17ffffb1 	b	237c <_Z32halfvec_l2_squared_distance_neoniPKtS0_+0x6c>
    24bc:	d503201f 	nop

00000000000024c0 <_Z26halfvec_inner_product_neoniPKtS0_>:
    24c0:	6b0003e3 	negs	w3, w0
    24c4:	12000404 	and	w4, w0, #0x3
    24c8:	12000463 	and	w3, w3, #0x3
    24cc:	5a834483 	csneg	w3, w4, w3, mi	// mi = first
    24d0:	4b030003 	sub	w3, w0, w3
    24d4:	7100007f 	cmp	w3, #0x0
    24d8:	54000bed 	b.le	2654 <_Z26halfvec_inner_product_neoniPKtS0_+0x194>
    24dc:	4f000400 	movi	v0.4s, #0x0
    24e0:	51000466 	sub	w6, w3, #0x1
    24e4:	d2800003 	mov	x3, #0x0                   	// #0
    24e8:	53027cc6 	lsr	w6, w6, #2
    24ec:	110004c4 	add	w4, w6, #0x1
    24f0:	aa0403e6 	mov	x6, x4
    24f4:	d503201f 	nop
    24f8:	fc637842 	ldr	d2, [x2, x3, lsl #3]
    24fc:	fc637821 	ldr	d1, [x1, x3, lsl #3]
    2500:	91000463 	add	x3, x3, #0x1
    2504:	0e217842 	fcvtl	v2.4s, v2.4h
    2508:	0e217821 	fcvtl	v1.4s, v1.4h
    250c:	6e22dc21 	fmul	v1.4s, v1.4s, v2.4s
    2510:	4e21d400 	fadd	v0.4s, v0.4s, v1.4s
    2514:	eb04007f 	cmp	x3, x4
    2518:	54ffff01 	b.ne	24f8 <_Z26halfvec_inner_product_neoniPKtS0_+0x38>  // b.any
    251c:	6e20d400 	faddp	v0.4s, v0.4s, v0.4s
    2520:	531e74c6 	lsl	w6, w6, #2
    2524:	6e20d400 	faddp	v0.4s, v0.4s, v0.4s
    2528:	6b06001f 	cmp	w0, w6
    252c:	540005ad 	b.le	25e0 <_Z26halfvec_inner_product_neoniPKtS0_+0x120>
    2530:	4b060000 	sub	w0, w0, w6
    2534:	937f7cc5 	sbfiz	x5, x6, #1, #32
    2538:	8b26c006 	add	x6, x0, w6, sxtw
    253c:	d37ff8c6 	lsl	x6, x6, #1
    2540:	78656824 	ldrh	w4, [x1, x5]
    2544:	12002480 	and	w0, w4, #0x3ff
    2548:	530f7c83 	lsr	w3, w4, #15
    254c:	d34a3884 	ubfx	x4, x4, #10, #5
    2550:	53010063 	lsl	w3, w3, #31
    2554:	35000484 	cbnz	w4, 25e4 <_Z26halfvec_inner_product_neoniPKtS0_+0x124>
    2558:	34000160 	cbz	w0, 2584 <_Z26halfvec_inner_product_neoniPKtS0_+0xc4>
    255c:	128001a4 	mov	w4, #0xfffffff2            	// #-14
    2560:	2a0003e8 	mov	w8, w0
    2564:	2a0403e7 	mov	w7, w4
    2568:	531f7800 	lsl	w0, w0, #1
    256c:	51000484 	sub	w4, w4, #0x1
    2570:	3657ff80 	tbz	w0, #10, 2560 <_Z26halfvec_inner_product_neoniPKtS0_+0xa0>
    2574:	1101f8e7 	add	w7, w7, #0x7e
    2578:	53122108 	ubfiz	w8, w8, #14, #9
    257c:	2a075d07 	orr	w7, w8, w7, lsl #23
    2580:	2a070063 	orr	w3, w3, w7
    2584:	78656844 	ldrh	w4, [x2, x5]
    2588:	1e270061 	fmov	s1, w3
    258c:	12002480 	and	w0, w4, #0x3ff
    2590:	530f7c83 	lsr	w3, w4, #15
    2594:	d34a3884 	ubfx	x4, x4, #10, #5
    2598:	53010063 	lsl	w3, w3, #31
    259c:	350003c4 	cbnz	w4, 2614 <_Z26halfvec_inner_product_neoniPKtS0_+0x154>
    25a0:	34000160 	cbz	w0, 25cc <_Z26halfvec_inner_product_neoniPKtS0_+0x10c>
    25a4:	128001a4 	mov	w4, #0xfffffff2            	// #-14
    25a8:	2a0003e8 	mov	w8, w0
    25ac:	2a0403e7 	mov	w7, w4
    25b0:	531f7800 	lsl	w0, w0, #1
    25b4:	51000484 	sub	w4, w4, #0x1
    25b8:	3657ff80 	tbz	w0, #10, 25a8 <_Z26halfvec_inner_product_neoniPKtS0_+0xe8>
    25bc:	1101f8e7 	add	w7, w7, #0x7e
    25c0:	53122108 	ubfiz	w8, w8, #14, #9
    25c4:	2a075d07 	orr	w7, w8, w7, lsl #23
    25c8:	2a070063 	orr	w3, w3, w7
    25cc:	1e270062 	fmov	s2, w3
    25d0:	910008a5 	add	x5, x5, #0x2
    25d4:	1f020020 	fmadd	s0, s1, s2, s0
    25d8:	eb0600bf 	cmp	x5, x6
    25dc:	54fffb21 	b.ne	2540 <_Z26halfvec_inner_product_neoniPKtS0_+0x80>  // b.any
    25e0:	d65f03c0 	ret
    25e4:	71007c9f 	cmp	w4, #0x1f
    25e8:	54000220 	b.eq	262c <_Z26halfvec_inner_product_neoniPKtS0_+0x16c>  // b.none
    25ec:	1101c084 	add	w4, w4, #0x70
    25f0:	2a003463 	orr	w3, w3, w0, lsl #13
    25f4:	2a045c63 	orr	w3, w3, w4, lsl #23
    25f8:	78656844 	ldrh	w4, [x2, x5]
    25fc:	1e270061 	fmov	s1, w3
    2600:	12002480 	and	w0, w4, #0x3ff
    2604:	530f7c83 	lsr	w3, w4, #15
    2608:	d34a3884 	ubfx	x4, x4, #10, #5
    260c:	53010063 	lsl	w3, w3, #31
    2610:	34fffc84 	cbz	w4, 25a0 <_Z26halfvec_inner_product_neoniPKtS0_+0xe0>
    2614:	71007c9f 	cmp	w4, #0x1f
    2618:	54000140 	b.eq	2640 <_Z26halfvec_inner_product_neoniPKtS0_+0x180>  // b.none
    261c:	1101c084 	add	w4, w4, #0x70
    2620:	2a003463 	orr	w3, w3, w0, lsl #13
    2624:	2a045c63 	orr	w3, w3, w4, lsl #23
    2628:	17ffffe9 	b	25cc <_Z26halfvec_inner_product_neoniPKtS0_+0x10c>
    262c:	7100001f 	cmp	w0, #0x0
    2630:	32091c60 	orr	w0, w3, #0x7f800000
    2634:	320a2063 	orr	w3, w3, #0x7fc00000
    2638:	1a801063 	csel	w3, w3, w0, ne	// ne = any
    263c:	17ffffd2 	b	2584 <_Z26halfvec_inner_product_neoniPKtS0_+0xc4>
    2640:	7100001f 	cmp	w0, #0x0
    2644:	32091c60 	orr	w0, w3, #0x7f800000
    2648:	320a2063 	orr	w3, w3, #0x7fc00000
    264c:	1a801063 	csel	w3, w3, w0, ne	// ne = any
    2650:	17ffffdf 	b	25cc <_Z26halfvec_inner_product_neoniPKtS0_+0x10c>
    2654:	0f000400 	movi	v0.2s, #0x0
    2658:	52800006 	mov	w6, #0x0                   	// #0
    265c:	17ffffb3 	b	2528 <_Z26halfvec_inner_product_neoniPKtS0_+0x68>

0000000000002660 <_Z30halfvec_cosine_similarity_neoniPKtS0_>:
    2660:	6b0003e3 	negs	w3, w0
    2664:	12000404 	and	w4, w0, #0x3
    2668:	12000463 	and	w3, w3, #0x3
    266c:	5a834483 	csneg	w3, w4, w3, mi	// mi = first
    2670:	4b030003 	sub	w3, w0, w3
    2674:	7100007f 	cmp	w3, #0x0
    2678:	54000f6d 	b.le	2864 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x204>
    267c:	4f000403 	movi	v3.4s, #0x0
    2680:	51000466 	sub	w6, w3, #0x1
    2684:	d2800003 	mov	x3, #0x0                   	// #0
    2688:	53027cc6 	lsr	w6, w6, #2
    268c:	110004c4 	add	w4, w6, #0x1
    2690:	4ea31c62 	mov	v2.16b, v3.16b
    2694:	aa0403e6 	mov	x6, x4
    2698:	4ea31c64 	mov	v4.16b, v3.16b
    269c:	d503201f 	nop
    26a0:	fc637841 	ldr	d1, [x2, x3, lsl #3]
    26a4:	fc637820 	ldr	d0, [x1, x3, lsl #3]
    26a8:	91000463 	add	x3, x3, #0x1
    26ac:	0e217821 	fcvtl	v1.4s, v1.4h
    26b0:	0e217800 	fcvtl	v0.4s, v0.4h
    26b4:	6e21dc25 	fmul	v5.4s, v1.4s, v1.4s
    26b8:	6e21dc01 	fmul	v1.4s, v0.4s, v1.4s
    26bc:	6e20dc00 	fmul	v0.4s, v0.4s, v0.4s
    26c0:	4e25d463 	fadd	v3.4s, v3.4s, v5.4s
    26c4:	4e21d484 	fadd	v4.4s, v4.4s, v1.4s
    26c8:	4e20d442 	fadd	v2.4s, v2.4s, v0.4s
    26cc:	eb04007f 	cmp	x3, x4
    26d0:	54fffe81 	b.ne	26a0 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x40>  // b.any
    26d4:	6e23d463 	faddp	v3.4s, v3.4s, v3.4s
    26d8:	531e74c6 	lsl	w6, w6, #2
    26dc:	6e22d442 	faddp	v2.4s, v2.4s, v2.4s
    26e0:	6e24d484 	faddp	v4.4s, v4.4s, v4.4s
    26e4:	6e23d463 	faddp	v3.4s, v3.4s, v3.4s
    26e8:	6e22d442 	faddp	v2.4s, v2.4s, v2.4s
    26ec:	6e24d484 	faddp	v4.4s, v4.4s, v4.4s
    26f0:	6b06001f 	cmp	w0, w6
    26f4:	540005ed 	b.le	27b0 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x150>
    26f8:	4b060000 	sub	w0, w0, w6
    26fc:	937f7cc5 	sbfiz	x5, x6, #1, #32
    2700:	8b26c006 	add	x6, x0, w6, sxtw
    2704:	d37ff8c6 	lsl	x6, x6, #1
    2708:	78656824 	ldrh	w4, [x1, x5]
    270c:	12002483 	and	w3, w4, #0x3ff
    2710:	530f7c80 	lsr	w0, w4, #15
    2714:	d34a3884 	ubfx	x4, x4, #10, #5
    2718:	53010000 	lsl	w0, w0, #31
    271c:	350006c4 	cbnz	w4, 27f4 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x194>
    2720:	34000163 	cbz	w3, 274c <_Z30halfvec_cosine_similarity_neoniPKtS0_+0xec>
    2724:	128001a4 	mov	w4, #0xfffffff2            	// #-14
    2728:	2a0303e8 	mov	w8, w3
    272c:	2a0403e7 	mov	w7, w4
    2730:	531f7863 	lsl	w3, w3, #1
    2734:	51000484 	sub	w4, w4, #0x1
    2738:	3657ff83 	tbz	w3, #10, 2728 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0xc8>
    273c:	1101f8e7 	add	w7, w7, #0x7e
    2740:	53122108 	ubfiz	w8, w8, #14, #9
    2744:	2a075d07 	orr	w7, w8, w7, lsl #23
    2748:	2a070000 	orr	w0, w0, w7
    274c:	78656844 	ldrh	w4, [x2, x5]
    2750:	1e270001 	fmov	s1, w0
    2754:	12002483 	and	w3, w4, #0x3ff
    2758:	530f7c80 	lsr	w0, w4, #15
    275c:	d34a3884 	ubfx	x4, x4, #10, #5
    2760:	53010000 	lsl	w0, w0, #31
    2764:	35000604 	cbnz	w4, 2824 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x1c4>
    2768:	34000163 	cbz	w3, 2794 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x134>
    276c:	128001a4 	mov	w4, #0xfffffff2            	// #-14
    2770:	2a0303e8 	mov	w8, w3
    2774:	2a0403e7 	mov	w7, w4
    2778:	531f7863 	lsl	w3, w3, #1
    277c:	51000484 	sub	w4, w4, #0x1
    2780:	3657ff83 	tbz	w3, #10, 2770 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x110>
    2784:	1101f8e7 	add	w7, w7, #0x7e
    2788:	53122108 	ubfiz	w8, w8, #14, #9
    278c:	2a075d07 	orr	w7, w8, w7, lsl #23
    2790:	2a070000 	orr	w0, w0, w7
    2794:	1e270000 	fmov	s0, w0
    2798:	910008a5 	add	x5, x5, #0x2
    279c:	1f010822 	fmadd	s2, s1, s1, s2
    27a0:	1f011004 	fmadd	s4, s0, s1, s4
    27a4:	1f000c03 	fmadd	s3, s0, s0, s3
    27a8:	eb0600bf 	cmp	x5, x6
    27ac:	54fffae1 	b.ne	2708 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0xa8>  // b.any
    27b0:	1e22c040 	fcvt	d0, s2
    27b4:	1e22c063 	fcvt	d3, s3
    27b8:	1e22c084 	fcvt	d4, s4
    27bc:	1e630800 	fmul	d0, d0, d3
    27c0:	1e602008 	fcmp	d0, #0.0
    27c4:	54000125 	b.pl	27e8 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x188>  // b.nfrst
    27c8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    27cc:	910003fd 	mov	x29, sp
    27d0:	fd000fe4 	str	d4, [sp, #24]
    27d4:	97fff83b 	bl	8c0 <sqrt@plt>
    27d8:	fd400fe4 	ldr	d4, [sp, #24]
    27dc:	a8c27bfd 	ldp	x29, x30, [sp], #32
    27e0:	1e601880 	fdiv	d0, d4, d0
    27e4:	d65f03c0 	ret
    27e8:	1e61c000 	fsqrt	d0, d0
    27ec:	1e601880 	fdiv	d0, d4, d0
    27f0:	d65f03c0 	ret
    27f4:	71007c9f 	cmp	w4, #0x1f
    27f8:	54000220 	b.eq	283c <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x1dc>  // b.none
    27fc:	1101c084 	add	w4, w4, #0x70
    2800:	2a033400 	orr	w0, w0, w3, lsl #13
    2804:	2a045c00 	orr	w0, w0, w4, lsl #23
    2808:	78656844 	ldrh	w4, [x2, x5]
    280c:	1e270001 	fmov	s1, w0
    2810:	12002483 	and	w3, w4, #0x3ff
    2814:	530f7c80 	lsr	w0, w4, #15
    2818:	d34a3884 	ubfx	x4, x4, #10, #5
    281c:	53010000 	lsl	w0, w0, #31
    2820:	34fffa44 	cbz	w4, 2768 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x108>
    2824:	71007c9f 	cmp	w4, #0x1f
    2828:	54000140 	b.eq	2850 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x1f0>  // b.none
    282c:	1101c084 	add	w4, w4, #0x70
    2830:	2a033400 	orr	w0, w0, w3, lsl #13
    2834:	2a045c00 	orr	w0, w0, w4, lsl #23
    2838:	17ffffd7 	b	2794 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x134>
    283c:	7100007f 	cmp	w3, #0x0
    2840:	32091c03 	orr	w3, w0, #0x7f800000
    2844:	320a2000 	orr	w0, w0, #0x7fc00000
    2848:	1a831000 	csel	w0, w0, w3, ne	// ne = any
    284c:	17ffffc0 	b	274c <_Z30halfvec_cosine_similarity_neoniPKtS0_+0xec>
    2850:	7100007f 	cmp	w3, #0x0
    2854:	32091c03 	orr	w3, w0, #0x7f800000
    2858:	320a2000 	orr	w0, w0, #0x7fc00000
    285c:	1a831000 	csel	w0, w0, w3, ne	// ne = any
    2860:	17ffffcd 	b	2794 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x134>
    2864:	0f000404 	movi	v4.2s, #0x0
    2868:	52800006 	mov	w6, #0x0                   	// #0
    286c:	1e204082 	fmov	s2, s4
    2870:	1e204083 	fmov	s3, s4
    2874:	17ffff9f 	b	26f0 <_Z30halfvec_cosine_similarity_neoniPKtS0_+0x90>
    2878:	d503201f 	nop
    287c:	d503201f 	nop

0000000000002880 <_Z24halfvec_l1_distance_neoniPKtS0_>:
    2880:	6b0003e3 	negs	w3, w0
    2884:	12000404 	and	w4, w0, #0x3
    2888:	12000463 	and	w3, w3, #0x3
    288c:	5a834483 	csneg	w3, w4, w3, mi	// mi = first
    2890:	4b030003 	sub	w3, w0, w3
    2894:	7100007f 	cmp	w3, #0x0
    2898:	54000c0d 	b.le	2a18 <_Z24halfvec_l1_distance_neoniPKtS0_+0x198>
    289c:	4f000400 	movi	v0.4s, #0x0
    28a0:	51000466 	sub	w6, w3, #0x1
    28a4:	d2800003 	mov	x3, #0x0                   	// #0
    28a8:	53027cc6 	lsr	w6, w6, #2
    28ac:	110004c4 	add	w4, w6, #0x1
    28b0:	aa0403e6 	mov	x6, x4
    28b4:	d503201f 	nop
    28b8:	fc637842 	ldr	d2, [x2, x3, lsl #3]
    28bc:	fc637821 	ldr	d1, [x1, x3, lsl #3]
    28c0:	91000463 	add	x3, x3, #0x1
    28c4:	0e217842 	fcvtl	v2.4s, v2.4h
    28c8:	0e217821 	fcvtl	v1.4s, v1.4h
    28cc:	6ea2d421 	fabd	v1.4s, v1.4s, v2.4s
    28d0:	4e21d400 	fadd	v0.4s, v0.4s, v1.4s
    28d4:	eb04007f 	cmp	x3, x4
    28d8:	54ffff01 	b.ne	28b8 <_Z24halfvec_l1_distance_neoniPKtS0_+0x38>  // b.any
    28dc:	6e20d400 	faddp	v0.4s, v0.4s, v0.4s
    28e0:	531e74c6 	lsl	w6, w6, #2
    28e4:	6e20d400 	faddp	v0.4s, v0.4s, v0.4s
    28e8:	6b06001f 	cmp	w0, w6
    28ec:	540005cd 	b.le	29a4 <_Z24halfvec_l1_distance_neoniPKtS0_+0x124>
    28f0:	4b060000 	sub	w0, w0, w6
    28f4:	937f7cc5 	sbfiz	x5, x6, #1, #32
    28f8:	8b26c006 	add	x6, x0, w6, sxtw
    28fc:	d37ff8c6 	lsl	x6, x6, #1
    2900:	78656824 	ldrh	w4, [x1, x5]
    2904:	12002483 	and	w3, w4, #0x3ff
    2908:	530f7c80 	lsr	w0, w4, #15
    290c:	d34a3884 	ubfx	x4, x4, #10, #5
    2910:	53010000 	lsl	w0, w0, #31
    2914:	350004a4 	cbnz	w4, 29a8 <_Z24halfvec_l1_distance_neoniPKtS0_+0x128>
    2918:	34000163 	cbz	w3, 2944 <_Z24halfvec_l1_distance_neoniPKtS0_+0xc4>
    291c:	128001a4 	mov	w4, #0xfffffff2            	// #-14
    2920:	2a0303e8 	mov	w8, w3
    2924:	2a0403e7 	mov	w7, w4
    2928:	531f7863 	lsl	w3, w3, #1
    292c:	51000484 	sub	w4, w4, #0x1
    2930:	3657ff83 	tbz	w3, #10, 2920 <_Z24halfvec_l1_distance_neoniPKtS0_+0xa0>
    2934:	1101f8e7 	add	w7, w7, #0x7e
    2938:	53122108 	ubfiz	w8, w8, #14, #9
    293c:	2a075d07 	orr	w7, w8, w7, lsl #23
    2940:	2a070000 	orr	w0, w0, w7
    2944:	78656843 	ldrh	w3, [x2, x5]
    2948:	1e270001 	fmov	s1, w0
    294c:	12002460 	and	w0, w3, #0x3ff
    2950:	530f7c64 	lsr	w4, w3, #15
    2954:	d34a3863 	ubfx	x3, x3, #10, #5
    2958:	53010084 	lsl	w4, w4, #31
    295c:	350003e3 	cbnz	w3, 29d8 <_Z24halfvec_l1_distance_neoniPKtS0_+0x158>
    2960:	34000160 	cbz	w0, 298c <_Z24halfvec_l1_distance_neoniPKtS0_+0x10c>
    2964:	128001a3 	mov	w3, #0xfffffff2            	// #-14
    2968:	2a0003e8 	mov	w8, w0
    296c:	2a0303e7 	mov	w7, w3
    2970:	531f7800 	lsl	w0, w0, #1
    2974:	51000463 	sub	w3, w3, #0x1
    2978:	3657ff80 	tbz	w0, #10, 2968 <_Z24halfvec_l1_distance_neoniPKtS0_+0xe8>
    297c:	1101f8e7 	add	w7, w7, #0x7e
    2980:	53122108 	ubfiz	w8, w8, #14, #9
    2984:	2a075d07 	orr	w7, w8, w7, lsl #23
    2988:	2a070084 	orr	w4, w4, w7
    298c:	1e270082 	fmov	s2, w4
    2990:	910008a5 	add	x5, x5, #0x2
    2994:	7ea2d421 	fabd	s1, s1, s2
    2998:	1e212800 	fadd	s0, s0, s1
    299c:	eb0600bf 	cmp	x5, x6
    29a0:	54fffb01 	b.ne	2900 <_Z24halfvec_l1_distance_neoniPKtS0_+0x80>  // b.any
    29a4:	d65f03c0 	ret
    29a8:	71007c9f 	cmp	w4, #0x1f
    29ac:	54000220 	b.eq	29f0 <_Z24halfvec_l1_distance_neoniPKtS0_+0x170>  // b.none
    29b0:	2a033400 	orr	w0, w0, w3, lsl #13
    29b4:	78656843 	ldrh	w3, [x2, x5]
    29b8:	1101c084 	add	w4, w4, #0x70
    29bc:	2a045c00 	orr	w0, w0, w4, lsl #23
    29c0:	530f7c64 	lsr	w4, w3, #15
    29c4:	1e270001 	fmov	s1, w0
    29c8:	12002460 	and	w0, w3, #0x3ff
    29cc:	53010084 	lsl	w4, w4, #31
    29d0:	d34a3863 	ubfx	x3, x3, #10, #5
    29d4:	34fffc63 	cbz	w3, 2960 <_Z24halfvec_l1_distance_neoniPKtS0_+0xe0>
    29d8:	71007c7f 	cmp	w3, #0x1f
    29dc:	54000140 	b.eq	2a04 <_Z24halfvec_l1_distance_neoniPKtS0_+0x184>  // b.none
    29e0:	1101c063 	add	w3, w3, #0x70
    29e4:	2a003484 	orr	w4, w4, w0, lsl #13
    29e8:	2a035c84 	orr	w4, w4, w3, lsl #23
    29ec:	17ffffe8 	b	298c <_Z24halfvec_l1_distance_neoniPKtS0_+0x10c>
    29f0:	7100007f 	cmp	w3, #0x0
    29f4:	32091c03 	orr	w3, w0, #0x7f800000
    29f8:	320a2000 	orr	w0, w0, #0x7fc00000
    29fc:	1a831000 	csel	w0, w0, w3, ne	// ne = any
    2a00:	17ffffd1 	b	2944 <_Z24halfvec_l1_distance_neoniPKtS0_+0xc4>
    2a04:	7100001f 	cmp	w0, #0x0
    2a08:	32091c80 	orr	w0, w4, #0x7f800000
    2a0c:	320a2084 	orr	w4, w4, #0x7fc00000
    2a10:	1a801084 	csel	w4, w4, w0, ne	// ne = any
    2a14:	17ffffde 	b	298c <_Z24halfvec_l1_distance_neoniPKtS0_+0x10c>
    2a18:	0f000400 	movi	v0.2s, #0x0
    2a1c:	52800006 	mov	w6, #0x0                   	// #0
    2a20:	17ffffb2 	b	28e8 <_Z24halfvec_l1_distance_neoniPKtS0_+0x68>
    2a24:	d503201f 	nop
    2a28:	d503201f 	nop
    2a2c:	d503201f 	nop

0000000000002a30 <_Z27bit_hamming_distance_nativejPKhS0_>:
    2a30:	2a0003e7 	mov	w7, w0
    2a34:	71001c1f 	cmp	w0, #0x7
    2a38:	540009e9 	b.ls	2b74 <_Z27bit_hamming_distance_nativejPKhS0_+0x144>  // b.plast
    2a3c:	51002005 	sub	w5, w0, #0x8
    2a40:	d2800004 	mov	x4, #0x0                   	// #0
    2a44:	d2800000 	mov	x0, #0x0                   	// #0
    2a48:	53037ca5 	lsr	w5, w5, #3
    2a4c:	110004a5 	add	w5, w5, #0x1
    2a50:	f8647823 	ldr	x3, [x1, x4, lsl #3]
    2a54:	f8647846 	ldr	x6, [x2, x4, lsl #3]
    2a58:	91000484 	add	x4, x4, #0x1
    2a5c:	ca060063 	eor	x3, x3, x6
    2a60:	9e670060 	fmov	d0, x3
    2a64:	0e205800 	cnt	v0.8b, v0.8b
    2a68:	0e31b800 	addv	b0, v0.8b
    2a6c:	9e660003 	fmov	x3, d0
    2a70:	8b030000 	add	x0, x0, x3
    2a74:	eb0400bf 	cmp	x5, x4
    2a78:	54fffec1 	b.ne	2a50 <_Z27bit_hamming_distance_nativejPKhS0_+0x20>  // b.any
    2a7c:	d37df0a5 	lsl	x5, x5, #3
    2a80:	120008e7 	and	w7, w7, #0x7
    2a84:	8b050021 	add	x1, x1, x5
    2a88:	8b050042 	add	x2, x2, x5
    2a8c:	34000727 	cbz	w7, 2b70 <_Z27bit_hamming_distance_nativejPKhS0_+0x140>
    2a90:	39400044 	ldrb	w4, [x2]
    2a94:	b0000003 	adrp	x3, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    2a98:	39400025 	ldrb	w5, [x1]
    2a9c:	913ec063 	add	x3, x3, #0xfb0
    2aa0:	4a050084 	eor	w4, w4, w5
    2aa4:	12001c84 	and	w4, w4, #0xff
    2aa8:	3864c864 	ldrb	w4, [x3, w4, sxtw]
    2aac:	8b040000 	add	x0, x0, x4
    2ab0:	710004ff 	cmp	w7, #0x1
    2ab4:	540005e0 	b.eq	2b70 <_Z27bit_hamming_distance_nativejPKhS0_+0x140>  // b.none
    2ab8:	39400444 	ldrb	w4, [x2, #1]
    2abc:	39400425 	ldrb	w5, [x1, #1]
    2ac0:	4a050084 	eor	w4, w4, w5
    2ac4:	12001c84 	and	w4, w4, #0xff
    2ac8:	3864c864 	ldrb	w4, [x3, w4, sxtw]
    2acc:	8b040000 	add	x0, x0, x4
    2ad0:	710008ff 	cmp	w7, #0x2
    2ad4:	540004e0 	b.eq	2b70 <_Z27bit_hamming_distance_nativejPKhS0_+0x140>  // b.none
    2ad8:	39400844 	ldrb	w4, [x2, #2]
    2adc:	39400825 	ldrb	w5, [x1, #2]
    2ae0:	4a050084 	eor	w4, w4, w5
    2ae4:	12001c84 	and	w4, w4, #0xff
    2ae8:	3864c864 	ldrb	w4, [x3, w4, sxtw]
    2aec:	8b040000 	add	x0, x0, x4
    2af0:	71000cff 	cmp	w7, #0x3
    2af4:	540003e0 	b.eq	2b70 <_Z27bit_hamming_distance_nativejPKhS0_+0x140>  // b.none
    2af8:	39400c24 	ldrb	w4, [x1, #3]
    2afc:	39400c45 	ldrb	w5, [x2, #3]
    2b00:	4a050084 	eor	w4, w4, w5
    2b04:	12001c84 	and	w4, w4, #0xff
    2b08:	3864c864 	ldrb	w4, [x3, w4, sxtw]
    2b0c:	8b040000 	add	x0, x0, x4
    2b10:	710010ff 	cmp	w7, #0x4
    2b14:	540002e0 	b.eq	2b70 <_Z27bit_hamming_distance_nativejPKhS0_+0x140>  // b.none
    2b18:	39401024 	ldrb	w4, [x1, #4]
    2b1c:	39401045 	ldrb	w5, [x2, #4]
    2b20:	4a050084 	eor	w4, w4, w5
    2b24:	12001c84 	and	w4, w4, #0xff
    2b28:	3864c864 	ldrb	w4, [x3, w4, sxtw]
    2b2c:	8b040000 	add	x0, x0, x4
    2b30:	710014ff 	cmp	w7, #0x5
    2b34:	540001e0 	b.eq	2b70 <_Z27bit_hamming_distance_nativejPKhS0_+0x140>  // b.none
    2b38:	39401424 	ldrb	w4, [x1, #5]
    2b3c:	39401445 	ldrb	w5, [x2, #5]
    2b40:	4a050084 	eor	w4, w4, w5
    2b44:	12001c84 	and	w4, w4, #0xff
    2b48:	3864c864 	ldrb	w4, [x3, w4, sxtw]
    2b4c:	8b040000 	add	x0, x0, x4
    2b50:	71001cff 	cmp	w7, #0x7
    2b54:	540000e1 	b.ne	2b70 <_Z27bit_hamming_distance_nativejPKhS0_+0x140>  // b.any
    2b58:	39401842 	ldrb	w2, [x2, #6]
    2b5c:	39401821 	ldrb	w1, [x1, #6]
    2b60:	4a010041 	eor	w1, w2, w1
    2b64:	12001c21 	and	w1, w1, #0xff
    2b68:	3861c861 	ldrb	w1, [x3, w1, sxtw]
    2b6c:	8b010000 	add	x0, x0, x1
    2b70:	d65f03c0 	ret
    2b74:	d2800000 	mov	x0, #0x0                   	// #0
    2b78:	17ffffc5 	b	2a8c <_Z27bit_hamming_distance_nativejPKhS0_+0x5c>
    2b7c:	d503201f 	nop

0000000000002b80 <_Z27bit_jaccard_distance_nativejPKhS0_>:
    2b80:	71001c1f 	cmp	w0, #0x7
    2b84:	54000ec9 	b.ls	2d5c <_Z27bit_jaccard_distance_nativejPKhS0_+0x1dc>  // b.plast
    2b88:	5100200a 	sub	w10, w0, #0x8
    2b8c:	d2800005 	mov	x5, #0x0                   	// #0
    2b90:	d2800009 	mov	x9, #0x0                   	// #0
    2b94:	d2800007 	mov	x7, #0x0                   	// #0
    2b98:	53037d4a 	lsr	w10, w10, #3
    2b9c:	d2800008 	mov	x8, #0x0                   	// #0
    2ba0:	1100054a 	add	w10, w10, #0x1
    2ba4:	d503201f 	nop
    2ba8:	fc657820 	ldr	d0, [x1, x5, lsl #3]
    2bac:	fc657841 	ldr	d1, [x2, x5, lsl #3]
    2bb0:	910004a5 	add	x5, x5, #0x1
    2bb4:	0e205802 	cnt	v2.8b, v0.8b
    2bb8:	0e211c00 	and	v0.8b, v0.8b, v1.8b
    2bbc:	0e205821 	cnt	v1.8b, v1.8b
    2bc0:	0e31b842 	addv	b2, v2.8b
    2bc4:	0e205800 	cnt	v0.8b, v0.8b
    2bc8:	0e31b821 	addv	b1, v1.8b
    2bcc:	9e660046 	fmov	x6, d2
    2bd0:	0e31b800 	addv	b0, v0.8b
    2bd4:	9e660024 	fmov	x4, d1
    2bd8:	8b0600e7 	add	x7, x7, x6
    2bdc:	9e660003 	fmov	x3, d0
    2be0:	8b040129 	add	x9, x9, x4
    2be4:	8b030108 	add	x8, x8, x3
    2be8:	eb05015f 	cmp	x10, x5
    2bec:	54fffde1 	b.ne	2ba8 <_Z27bit_jaccard_distance_nativejPKhS0_+0x28>  // b.any
    2bf0:	d37df14a 	lsl	x10, x10, #3
    2bf4:	12000800 	and	w0, w0, #0x7
    2bf8:	8b0a0021 	add	x1, x1, x10
    2bfc:	8b0a0042 	add	x2, x2, x10
    2c00:	340009c0 	cbz	w0, 2d38 <_Z27bit_jaccard_distance_nativejPKhS0_+0x1b8>
    2c04:	39400025 	ldrb	w5, [x1]
    2c08:	b0000003 	adrp	x3, 3000 <_Z25bit_jaccard_distance_neonjPKhS0_+0x4c>
    2c0c:	39400044 	ldrb	w4, [x2]
    2c10:	913ec063 	add	x3, x3, #0xfb0
    2c14:	0a05008a 	and	w10, w4, w5
    2c18:	3865c866 	ldrb	w6, [x3, w5, sxtw]
    2c1c:	3864c865 	ldrb	w5, [x3, w4, sxtw]
    2c20:	386ac864 	ldrb	w4, [x3, w10, sxtw]
    2c24:	8b0600e7 	add	x7, x7, x6
    2c28:	8b050129 	add	x9, x9, x5
    2c2c:	8b040108 	add	x8, x8, x4
    2c30:	7100041f 	cmp	w0, #0x1
    2c34:	54000820 	b.eq	2d38 <_Z27bit_jaccard_distance_nativejPKhS0_+0x1b8>  // b.none
    2c38:	39400425 	ldrb	w5, [x1, #1]
    2c3c:	39400444 	ldrb	w4, [x2, #1]
    2c40:	0a05008a 	and	w10, w4, w5
    2c44:	3865c866 	ldrb	w6, [x3, w5, sxtw]
    2c48:	3864c865 	ldrb	w5, [x3, w4, sxtw]
    2c4c:	386ac864 	ldrb	w4, [x3, w10, sxtw]
    2c50:	8b0600e7 	add	x7, x7, x6
    2c54:	8b050129 	add	x9, x9, x5
    2c58:	8b040108 	add	x8, x8, x4
    2c5c:	7100081f 	cmp	w0, #0x2
    2c60:	540006c0 	b.eq	2d38 <_Z27bit_jaccard_distance_nativejPKhS0_+0x1b8>  // b.none
    2c64:	39400825 	ldrb	w5, [x1, #2]
    2c68:	39400844 	ldrb	w4, [x2, #2]
    2c6c:	0a05008a 	and	w10, w4, w5
    2c70:	3865c866 	ldrb	w6, [x3, w5, sxtw]
    2c74:	3864c865 	ldrb	w5, [x3, w4, sxtw]
    2c78:	386ac864 	ldrb	w4, [x3, w10, sxtw]
    2c7c:	8b0600e7 	add	x7, x7, x6
    2c80:	8b050129 	add	x9, x9, x5
    2c84:	8b040108 	add	x8, x8, x4
    2c88:	71000c1f 	cmp	w0, #0x3
    2c8c:	54000560 	b.eq	2d38 <_Z27bit_jaccard_distance_nativejPKhS0_+0x1b8>  // b.none
    2c90:	39400c25 	ldrb	w5, [x1, #3]
    2c94:	39400c44 	ldrb	w4, [x2, #3]
    2c98:	0a05008a 	and	w10, w4, w5
    2c9c:	3865c866 	ldrb	w6, [x3, w5, sxtw]
    2ca0:	3864c865 	ldrb	w5, [x3, w4, sxtw]
    2ca4:	386ac864 	ldrb	w4, [x3, w10, sxtw]
    2ca8:	8b0600e7 	add	x7, x7, x6
    2cac:	8b050129 	add	x9, x9, x5
    2cb0:	8b040108 	add	x8, x8, x4
    2cb4:	7100101f 	cmp	w0, #0x4
    2cb8:	54000400 	b.eq	2d38 <_Z27bit_jaccard_distance_nativejPKhS0_+0x1b8>  // b.none
    2cbc:	39401025 	ldrb	w5, [x1, #4]
    2cc0:	39401044 	ldrb	w4, [x2, #4]
    2cc4:	0a0400aa 	and	w10, w5, w4
    2cc8:	3865c866 	ldrb	w6, [x3, w5, sxtw]
    2ccc:	3864c865 	ldrb	w5, [x3, w4, sxtw]
    2cd0:	386ac864 	ldrb	w4, [x3, w10, sxtw]
    2cd4:	8b0600e7 	add	x7, x7, x6
    2cd8:	8b050129 	add	x9, x9, x5
    2cdc:	8b040108 	add	x8, x8, x4
    2ce0:	7100141f 	cmp	w0, #0x5
    2ce4:	540002a0 	b.eq	2d38 <_Z27bit_jaccard_distance_nativejPKhS0_+0x1b8>  // b.none
    2ce8:	39401425 	ldrb	w5, [x1, #5]
    2cec:	39401444 	ldrb	w4, [x2, #5]
    2cf0:	0a0400aa 	and	w10, w5, w4
    2cf4:	3865c866 	ldrb	w6, [x3, w5, sxtw]
    2cf8:	3864c865 	ldrb	w5, [x3, w4, sxtw]
    2cfc:	386ac864 	ldrb	w4, [x3, w10, sxtw]
    2d00:	8b0600e7 	add	x7, x7, x6
    2d04:	8b050129 	add	x9, x9, x5
    2d08:	8b040108 	add	x8, x8, x4
    2d0c:	71001c1f 	cmp	w0, #0x7
    2d10:	54000141 	b.ne	2d38 <_Z27bit_jaccard_distance_nativejPKhS0_+0x1b8>  // b.any
    2d14:	39401840 	ldrb	w0, [x2, #6]
    2d18:	39401821 	ldrb	w1, [x1, #6]
    2d1c:	0a000024 	and	w4, w1, w0
    2d20:	3861c862 	ldrb	w2, [x3, w1, sxtw]
    2d24:	3860c861 	ldrb	w1, [x3, w0, sxtw]
    2d28:	3864c860 	ldrb	w0, [x3, w4, sxtw]
    2d2c:	8b0200e7 	add	x7, x7, x2
    2d30:	8b010129 	add	x9, x9, x1
    2d34:	8b000108 	add	x8, x8, x0
    2d38:	1e6e1000 	fmov	d0, #1.000000000000000000e+00
    2d3c:	b40000e8 	cbz	x8, 2d58 <_Z27bit_jaccard_distance_nativejPKhS0_+0x1d8>
    2d40:	8b0900e7 	add	x7, x7, x9
    2d44:	9e630102 	ucvtf	d2, x8
    2d48:	cb0800e7 	sub	x7, x7, x8
    2d4c:	9e6300e1 	ucvtf	d1, x7
    2d50:	1e611841 	fdiv	d1, d2, d1
    2d54:	1e613800 	fsub	d0, d0, d1
    2d58:	d65f03c0 	ret
    2d5c:	d2800009 	mov	x9, #0x0                   	// #0
    2d60:	d2800007 	mov	x7, #0x0                   	// #0
    2d64:	d2800008 	mov	x8, #0x0                   	// #0
    2d68:	17ffffa6 	b	2c00 <_Z27bit_jaccard_distance_nativejPKhS0_+0x80>
    2d6c:	d503201f 	nop

0000000000002d70 <_Z25bit_hamming_distance_neonjPKhS0_>:
    2d70:	2a0003e6 	mov	w6, w0
    2d74:	71003c1f 	cmp	w0, #0xf
    2d78:	54001169 	b.ls	2fa4 <_Z25bit_hamming_distance_neonjPKhS0_+0x234>  // b.plast
    2d7c:	d0000000 	adrp	x0, 4000 <_ZL14popcount_table+0x50>
    2d80:	52800205 	mov	w5, #0x10                  	// #16
    2d84:	4f00e5e3 	movi	v3.16b, #0xf
    2d88:	3dc02c02 	ldr	q2, [x0, #176]
    2d8c:	d2800000 	mov	x0, #0x0                   	// #0
    2d90:	510040a3 	sub	w3, w5, #0x10
    2d94:	2a0503e4 	mov	w4, w5
    2d98:	110040a5 	add	w5, w5, #0x10
    2d9c:	3ce34840 	ldr	q0, [x2, w3, uxtw]
    2da0:	3ce34821 	ldr	q1, [x1, w3, uxtw]
    2da4:	6e201c21 	eor	v1.16b, v1.16b, v0.16b
    2da8:	4e231c20 	and	v0.16b, v1.16b, v3.16b
    2dac:	6f0c0421 	ushr	v1.16b, v1.16b, #4
    2db0:	4e000040 	tbl	v0.16b, {v2.16b}, v0.16b
    2db4:	4e010041 	tbl	v1.16b, {v2.16b}, v1.16b
    2db8:	4e218400 	add	v0.16b, v0.16b, v1.16b
    2dbc:	6e202800 	uaddlp	v0.8h, v0.16b
    2dc0:	6e602800 	uaddlp	v0.4s, v0.8h
    2dc4:	4eb1b800 	addv	s0, v0.4s
    2dc8:	1e260003 	fmov	w3, s0
    2dcc:	8b234000 	add	x0, x0, w3, uxtw
    2dd0:	6b0500df 	cmp	w6, w5
    2dd4:	54fffde2 	b.cs	2d90 <_Z25bit_hamming_distance_neonjPKhS0_+0x20>  // b.hs, b.nlast
    2dd8:	11002085 	add	w5, w4, #0x8
    2ddc:	6b0500df 	cmp	w6, w5
    2de0:	54000062 	b.cs	2dec <_Z25bit_hamming_distance_neonjPKhS0_+0x7c>  // b.hs, b.nlast
    2de4:	1400006e 	b	2f9c <_Z25bit_hamming_distance_neonjPKhS0_+0x22c>
    2de8:	2a0703e5 	mov	w5, w7
    2dec:	f8644823 	ldr	x3, [x1, w4, uxtw]
    2df0:	110020a7 	add	w7, w5, #0x8
    2df4:	f8644848 	ldr	x8, [x2, w4, uxtw]
    2df8:	2a0503e4 	mov	w4, w5
    2dfc:	ca080063 	eor	x3, x3, x8
    2e00:	9e670060 	fmov	d0, x3
    2e04:	0e205800 	cnt	v0.8b, v0.8b
    2e08:	0e31b800 	addv	b0, v0.8b
    2e0c:	9e660003 	fmov	x3, d0
    2e10:	8b030000 	add	x0, x0, x3
    2e14:	6b0700df 	cmp	w6, w7
    2e18:	54fffe82 	b.cs	2de8 <_Z25bit_hamming_distance_neonjPKhS0_+0x78>  // b.hs, b.nlast
    2e1c:	6b0500df 	cmp	w6, w5
    2e20:	54000bc9 	b.ls	2f98 <_Z25bit_hamming_distance_neonjPKhS0_+0x228>  // b.plast
    2e24:	38654843 	ldrb	w3, [x2, w5, uxtw]
    2e28:	110004a4 	add	w4, w5, #0x1
    2e2c:	38654827 	ldrb	w7, [x1, w5, uxtw]
    2e30:	4a070063 	eor	w3, w3, w7
    2e34:	92401c63 	and	x3, x3, #0xff
    2e38:	9e670060 	fmov	d0, x3
    2e3c:	0e205800 	cnt	v0.8b, v0.8b
    2e40:	0e31b800 	addv	b0, v0.8b
    2e44:	9e660003 	fmov	x3, d0
    2e48:	8b030000 	add	x0, x0, x3
    2e4c:	6b0400df 	cmp	w6, w4
    2e50:	54000a49 	b.ls	2f98 <_Z25bit_hamming_distance_neonjPKhS0_+0x228>  // b.plast
    2e54:	38644843 	ldrb	w3, [x2, w4, uxtw]
    2e58:	110008a7 	add	w7, w5, #0x2
    2e5c:	38644824 	ldrb	w4, [x1, w4, uxtw]
    2e60:	4a040063 	eor	w3, w3, w4
    2e64:	92401c63 	and	x3, x3, #0xff
    2e68:	9e670060 	fmov	d0, x3
    2e6c:	0e205800 	cnt	v0.8b, v0.8b
    2e70:	0e31b800 	addv	b0, v0.8b
    2e74:	9e660003 	fmov	x3, d0
    2e78:	8b030000 	add	x0, x0, x3
    2e7c:	6b0700df 	cmp	w6, w7
    2e80:	540008c9 	b.ls	2f98 <_Z25bit_hamming_distance_neonjPKhS0_+0x228>  // b.plast
    2e84:	38674843 	ldrb	w3, [x2, w7, uxtw]
    2e88:	11000ca4 	add	w4, w5, #0x3
    2e8c:	38674827 	ldrb	w7, [x1, w7, uxtw]
    2e90:	4a070063 	eor	w3, w3, w7
    2e94:	92401c63 	and	x3, x3, #0xff
    2e98:	9e670060 	fmov	d0, x3
    2e9c:	0e205800 	cnt	v0.8b, v0.8b
    2ea0:	0e31b800 	addv	b0, v0.8b
    2ea4:	9e660003 	fmov	x3, d0
    2ea8:	8b030000 	add	x0, x0, x3
    2eac:	6b0400df 	cmp	w6, w4
    2eb0:	54000749 	b.ls	2f98 <_Z25bit_hamming_distance_neonjPKhS0_+0x228>  // b.plast
    2eb4:	38644843 	ldrb	w3, [x2, w4, uxtw]
    2eb8:	110010a7 	add	w7, w5, #0x4
    2ebc:	38644824 	ldrb	w4, [x1, w4, uxtw]
    2ec0:	4a040063 	eor	w3, w3, w4
    2ec4:	92401c63 	and	x3, x3, #0xff
    2ec8:	9e670060 	fmov	d0, x3
    2ecc:	0e205800 	cnt	v0.8b, v0.8b
    2ed0:	0e31b800 	addv	b0, v0.8b
    2ed4:	9e660003 	fmov	x3, d0
    2ed8:	8b030000 	add	x0, x0, x3
    2edc:	6b0700df 	cmp	w6, w7
    2ee0:	540005c9 	b.ls	2f98 <_Z25bit_hamming_distance_neonjPKhS0_+0x228>  // b.plast
    2ee4:	38674843 	ldrb	w3, [x2, w7, uxtw]
    2ee8:	110014a4 	add	w4, w5, #0x5
    2eec:	38674827 	ldrb	w7, [x1, w7, uxtw]
    2ef0:	4a070063 	eor	w3, w3, w7
    2ef4:	92401c63 	and	x3, x3, #0xff
    2ef8:	9e670060 	fmov	d0, x3
    2efc:	0e205800 	cnt	v0.8b, v0.8b
    2f00:	0e31b800 	addv	b0, v0.8b
    2f04:	9e660003 	fmov	x3, d0
    2f08:	8b030000 	add	x0, x0, x3
    2f0c:	6b0400df 	cmp	w6, w4
    2f10:	54000449 	b.ls	2f98 <_Z25bit_hamming_distance_neonjPKhS0_+0x228>  // b.plast
    2f14:	38644843 	ldrb	w3, [x2, w4, uxtw]
    2f18:	110018a7 	add	w7, w5, #0x6
    2f1c:	38644824 	ldrb	w4, [x1, w4, uxtw]
    2f20:	4a040063 	eor	w3, w3, w4
    2f24:	92401c63 	and	x3, x3, #0xff
    2f28:	9e670060 	fmov	d0, x3
    2f2c:	0e205800 	cnt	v0.8b, v0.8b
    2f30:	0e31b800 	addv	b0, v0.8b
    2f34:	9e660003 	fmov	x3, d0
    2f38:	8b030000 	add	x0, x0, x3
    2f3c:	6b0700df 	cmp	w6, w7
    2f40:	540002c9 	b.ls	2f98 <_Z25bit_hamming_distance_neonjPKhS0_+0x228>  // b.plast
    2f44:	38674843 	ldrb	w3, [x2, w7, uxtw]
    2f48:	11001ca5 	add	w5, w5, #0x7
    2f4c:	38674824 	ldrb	w4, [x1, w7, uxtw]
    2f50:	4a040063 	eor	w3, w3, w4
    2f54:	92401c63 	and	x3, x3, #0xff
    2f58:	9e670060 	fmov	d0, x3
    2f5c:	0e205800 	cnt	v0.8b, v0.8b
    2f60:	0e31b800 	addv	b0, v0.8b
    2f64:	9e660003 	fmov	x3, d0
    2f68:	8b030000 	add	x0, x0, x3
    2f6c:	6b0500df 	cmp	w6, w5
    2f70:	54000149 	b.ls	2f98 <_Z25bit_hamming_distance_neonjPKhS0_+0x228>  // b.plast
    2f74:	38654821 	ldrb	w1, [x1, w5, uxtw]
    2f78:	38654842 	ldrb	w2, [x2, w5, uxtw]
    2f7c:	4a020021 	eor	w1, w1, w2
    2f80:	92401c21 	and	x1, x1, #0xff
    2f84:	9e670020 	fmov	d0, x1
    2f88:	0e205800 	cnt	v0.8b, v0.8b
    2f8c:	0e31b800 	addv	b0, v0.8b
    2f90:	9e660001 	fmov	x1, d0
    2f94:	8b010000 	add	x0, x0, x1
    2f98:	d65f03c0 	ret
    2f9c:	2a0403e5 	mov	w5, w4
    2fa0:	17ffff9f 	b	2e1c <_Z25bit_hamming_distance_neonjPKhS0_+0xac>
    2fa4:	52800105 	mov	w5, #0x8                   	// #8
    2fa8:	52800004 	mov	w4, #0x0                   	// #0
    2fac:	d2800000 	mov	x0, #0x0                   	// #0
    2fb0:	17ffff8b 	b	2ddc <_Z25bit_hamming_distance_neonjPKhS0_+0x6c>

0000000000002fb4 <_Z25bit_jaccard_distance_neonjPKhS0_>:
    2fb4:	71003c1f 	cmp	w0, #0xf
    2fb8:	54001f09 	b.ls	3398 <_Z25bit_jaccard_distance_neonjPKhS0_+0x3e4>  // b.plast
    2fbc:	d0000003 	adrp	x3, 4000 <_ZL14popcount_table+0x50>
    2fc0:	5280020a 	mov	w10, #0x10                  	// #16
    2fc4:	4f00e5e7 	movi	v7.16b, #0xf
    2fc8:	d2800008 	mov	x8, #0x0                   	// #0
    2fcc:	3dc02c65 	ldr	q5, [x3, #176]
    2fd0:	d2800006 	mov	x6, #0x0                   	// #0
    2fd4:	d2800007 	mov	x7, #0x0                   	// #0
    2fd8:	51004143 	sub	w3, w10, #0x10
    2fdc:	2a0a03e9 	mov	w9, w10
    2fe0:	1100414a 	add	w10, w10, #0x10
    2fe4:	3ce34820 	ldr	q0, [x1, w3, uxtw]
    2fe8:	3ce34841 	ldr	q1, [x2, w3, uxtw]
    2fec:	4e271c02 	and	v2.16b, v0.16b, v7.16b
    2ff0:	6f0c0406 	ushr	v6.16b, v0.16b, #4
    2ff4:	4e211c03 	and	v3.16b, v0.16b, v1.16b
    2ff8:	6f0c0424 	ushr	v4.16b, v1.16b, #4
    2ffc:	4e271c20 	and	v0.16b, v1.16b, v7.16b
    3000:	4e0200a2 	tbl	v2.16b, {v5.16b}, v2.16b
    3004:	4e271c61 	and	v1.16b, v3.16b, v7.16b
    3008:	6f0c0463 	ushr	v3.16b, v3.16b, #4
    300c:	4e0600a6 	tbl	v6.16b, {v5.16b}, v6.16b
    3010:	4e0000a0 	tbl	v0.16b, {v5.16b}, v0.16b
    3014:	4e0100a1 	tbl	v1.16b, {v5.16b}, v1.16b
    3018:	4e0300a3 	tbl	v3.16b, {v5.16b}, v3.16b
    301c:	4e0400a4 	tbl	v4.16b, {v5.16b}, v4.16b
    3020:	4e268442 	add	v2.16b, v2.16b, v6.16b
    3024:	4e238421 	add	v1.16b, v1.16b, v3.16b
    3028:	4e248400 	add	v0.16b, v0.16b, v4.16b
    302c:	6e202842 	uaddlp	v2.8h, v2.16b
    3030:	6e202821 	uaddlp	v1.8h, v1.16b
    3034:	6e202800 	uaddlp	v0.8h, v0.16b
    3038:	6e602842 	uaddlp	v2.4s, v2.8h
    303c:	6e602821 	uaddlp	v1.4s, v1.8h
    3040:	6e602800 	uaddlp	v0.4s, v0.8h
    3044:	4eb1b842 	addv	s2, v2.4s
    3048:	4eb1b821 	addv	s1, v1.4s
    304c:	4eb1b800 	addv	s0, v0.4s
    3050:	1e260045 	fmov	w5, s2
    3054:	1e260024 	fmov	w4, s1
    3058:	1e260003 	fmov	w3, s0
    305c:	8b2540c6 	add	x6, x6, w5, uxtw
    3060:	8b2440e7 	add	x7, x7, w4, uxtw
    3064:	8b234108 	add	x8, x8, w3, uxtw
    3068:	6b0a001f 	cmp	w0, w10
    306c:	54fffb62 	b.cs	2fd8 <_Z25bit_jaccard_distance_neonjPKhS0_+0x24>  // b.hs, b.nlast
    3070:	11002125 	add	w5, w9, #0x8
    3074:	6b05001f 	cmp	w0, w5
    3078:	54000062 	b.cs	3084 <_Z25bit_jaccard_distance_neonjPKhS0_+0xd0>  // b.hs, b.nlast
    307c:	140000c5 	b	3390 <_Z25bit_jaccard_distance_neonjPKhS0_+0x3dc>
    3080:	2a0b03e5 	mov	w5, w11
    3084:	fc694820 	ldr	d0, [x1, w9, uxtw]
    3088:	110020ab 	add	w11, w5, #0x8
    308c:	fc694841 	ldr	d1, [x2, w9, uxtw]
    3090:	2a0503e9 	mov	w9, w5
    3094:	0e205802 	cnt	v2.8b, v0.8b
    3098:	0e211c00 	and	v0.8b, v0.8b, v1.8b
    309c:	0e205821 	cnt	v1.8b, v1.8b
    30a0:	0e31b842 	addv	b2, v2.8b
    30a4:	0e205800 	cnt	v0.8b, v0.8b
    30a8:	0e31b821 	addv	b1, v1.8b
    30ac:	9e66004a 	fmov	x10, d2
    30b0:	0e31b800 	addv	b0, v0.8b
    30b4:	9e660024 	fmov	x4, d1
    30b8:	8b0a00c6 	add	x6, x6, x10
    30bc:	9e660003 	fmov	x3, d0
    30c0:	8b040108 	add	x8, x8, x4
    30c4:	8b0300e7 	add	x7, x7, x3
    30c8:	6b0b001f 	cmp	w0, w11
    30cc:	54fffda2 	b.cs	3080 <_Z25bit_jaccard_distance_neonjPKhS0_+0xcc>  // b.hs, b.nlast
    30d0:	6b05001f 	cmp	w0, w5
    30d4:	540014c9 	b.ls	336c <_Z25bit_jaccard_distance_neonjPKhS0_+0x3b8>  // b.plast
    30d8:	3c654822 	ldr	b2, [x1, w5, uxtw]
    30dc:	110004aa 	add	w10, w5, #0x1
    30e0:	3c654841 	ldr	b1, [x2, w5, uxtw]
    30e4:	9e660043 	fmov	x3, d2
    30e8:	0e205842 	cnt	v2.8b, v2.8b
    30ec:	9e660024 	fmov	x4, d1
    30f0:	0e205821 	cnt	v1.8b, v1.8b
    30f4:	0e31b842 	addv	b2, v2.8b
    30f8:	0a040063 	and	w3, w3, w4
    30fc:	1e270060 	fmov	s0, w3
    3100:	0e31b821 	addv	b1, v1.8b
    3104:	0e205800 	cnt	v0.8b, v0.8b
    3108:	9e660049 	fmov	x9, d2
    310c:	9e660024 	fmov	x4, d1
    3110:	0e31b800 	addv	b0, v0.8b
    3114:	8b0900c6 	add	x6, x6, x9
    3118:	8b040108 	add	x8, x8, x4
    311c:	9e660003 	fmov	x3, d0
    3120:	8b0300e7 	add	x7, x7, x3
    3124:	6b0a001f 	cmp	w0, w10
    3128:	54001229 	b.ls	336c <_Z25bit_jaccard_distance_neonjPKhS0_+0x3b8>  // b.plast
    312c:	3c6a4822 	ldr	b2, [x1, w10, uxtw]
    3130:	110008ab 	add	w11, w5, #0x2
    3134:	3c6a4841 	ldr	b1, [x2, w10, uxtw]
    3138:	9e660043 	fmov	x3, d2
    313c:	0e205842 	cnt	v2.8b, v2.8b
    3140:	9e660024 	fmov	x4, d1
    3144:	0e205821 	cnt	v1.8b, v1.8b
    3148:	0e31b842 	addv	b2, v2.8b
    314c:	0a030083 	and	w3, w4, w3
    3150:	1e270060 	fmov	s0, w3
    3154:	0e31b821 	addv	b1, v1.8b
    3158:	0e205800 	cnt	v0.8b, v0.8b
    315c:	9e660049 	fmov	x9, d2
    3160:	9e660024 	fmov	x4, d1
    3164:	0e31b800 	addv	b0, v0.8b
    3168:	8b0900c6 	add	x6, x6, x9
    316c:	8b040108 	add	x8, x8, x4
    3170:	9e660003 	fmov	x3, d0
    3174:	8b0300e7 	add	x7, x7, x3
    3178:	6b0b001f 	cmp	w0, w11
    317c:	54000f89 	b.ls	336c <_Z25bit_jaccard_distance_neonjPKhS0_+0x3b8>  // b.plast
    3180:	3c6b4822 	ldr	b2, [x1, w11, uxtw]
    3184:	11000caa 	add	w10, w5, #0x3
    3188:	3c6b4841 	ldr	b1, [x2, w11, uxtw]
    318c:	9e660043 	fmov	x3, d2
    3190:	0e205842 	cnt	v2.8b, v2.8b
    3194:	9e660024 	fmov	x4, d1
    3198:	0e205821 	cnt	v1.8b, v1.8b
    319c:	0e31b842 	addv	b2, v2.8b
    31a0:	0a030083 	and	w3, w4, w3
    31a4:	1e270060 	fmov	s0, w3
    31a8:	0e31b821 	addv	b1, v1.8b
    31ac:	0e205800 	cnt	v0.8b, v0.8b
    31b0:	9e660049 	fmov	x9, d2
    31b4:	9e660024 	fmov	x4, d1
    31b8:	0e31b800 	addv	b0, v0.8b
    31bc:	8b0900c6 	add	x6, x6, x9
    31c0:	8b040108 	add	x8, x8, x4
    31c4:	9e660003 	fmov	x3, d0
    31c8:	8b0300e7 	add	x7, x7, x3
    31cc:	6b0a001f 	cmp	w0, w10
    31d0:	54000ce9 	b.ls	336c <_Z25bit_jaccard_distance_neonjPKhS0_+0x3b8>  // b.plast
    31d4:	3c6a4822 	ldr	b2, [x1, w10, uxtw]
    31d8:	110010ab 	add	w11, w5, #0x4
    31dc:	3c6a4841 	ldr	b1, [x2, w10, uxtw]
    31e0:	9e660043 	fmov	x3, d2
    31e4:	0e205842 	cnt	v2.8b, v2.8b
    31e8:	9e660024 	fmov	x4, d1
    31ec:	0e205821 	cnt	v1.8b, v1.8b
    31f0:	0e31b842 	addv	b2, v2.8b
    31f4:	0a030083 	and	w3, w4, w3
    31f8:	1e270060 	fmov	s0, w3
    31fc:	0e31b821 	addv	b1, v1.8b
    3200:	0e205800 	cnt	v0.8b, v0.8b
    3204:	9e660049 	fmov	x9, d2
    3208:	9e660024 	fmov	x4, d1
    320c:	0e31b800 	addv	b0, v0.8b
    3210:	8b0900c6 	add	x6, x6, x9
    3214:	8b040108 	add	x8, x8, x4
    3218:	9e660003 	fmov	x3, d0
    321c:	8b0300e7 	add	x7, x7, x3
    3220:	6b0b001f 	cmp	w0, w11
    3224:	54000a49 	b.ls	336c <_Z25bit_jaccard_distance_neonjPKhS0_+0x3b8>  // b.plast
    3228:	3c6b4822 	ldr	b2, [x1, w11, uxtw]
    322c:	110014aa 	add	w10, w5, #0x5
    3230:	3c6b4841 	ldr	b1, [x2, w11, uxtw]
    3234:	9e660043 	fmov	x3, d2
    3238:	0e205842 	cnt	v2.8b, v2.8b
    323c:	9e660024 	fmov	x4, d1
    3240:	0e205821 	cnt	v1.8b, v1.8b
    3244:	0e31b842 	addv	b2, v2.8b
    3248:	0a030083 	and	w3, w4, w3
    324c:	1e270060 	fmov	s0, w3
    3250:	0e31b821 	addv	b1, v1.8b
    3254:	0e205800 	cnt	v0.8b, v0.8b
    3258:	9e660049 	fmov	x9, d2
    325c:	9e660024 	fmov	x4, d1
    3260:	0e31b800 	addv	b0, v0.8b
    3264:	8b0900c6 	add	x6, x6, x9
    3268:	8b040108 	add	x8, x8, x4
    326c:	9e660003 	fmov	x3, d0
    3270:	8b0300e7 	add	x7, x7, x3
    3274:	6b0a001f 	cmp	w0, w10
    3278:	540007a9 	b.ls	336c <_Z25bit_jaccard_distance_neonjPKhS0_+0x3b8>  // b.plast
    327c:	3c6a4822 	ldr	b2, [x1, w10, uxtw]
    3280:	110018ab 	add	w11, w5, #0x6
    3284:	3c6a4841 	ldr	b1, [x2, w10, uxtw]
    3288:	9e660043 	fmov	x3, d2
    328c:	0e205842 	cnt	v2.8b, v2.8b
    3290:	9e660024 	fmov	x4, d1
    3294:	0e205821 	cnt	v1.8b, v1.8b
    3298:	0e31b842 	addv	b2, v2.8b
    329c:	0a030083 	and	w3, w4, w3
    32a0:	1e270060 	fmov	s0, w3
    32a4:	0e31b821 	addv	b1, v1.8b
    32a8:	0e205800 	cnt	v0.8b, v0.8b
    32ac:	9e660049 	fmov	x9, d2
    32b0:	9e660024 	fmov	x4, d1
    32b4:	0e31b800 	addv	b0, v0.8b
    32b8:	8b0900c6 	add	x6, x6, x9
    32bc:	8b040108 	add	x8, x8, x4
    32c0:	9e660003 	fmov	x3, d0
    32c4:	8b0300e7 	add	x7, x7, x3
    32c8:	6b0b001f 	cmp	w0, w11
    32cc:	54000509 	b.ls	336c <_Z25bit_jaccard_distance_neonjPKhS0_+0x3b8>  // b.plast
    32d0:	3c6b4822 	ldr	b2, [x1, w11, uxtw]
    32d4:	11001ca5 	add	w5, w5, #0x7
    32d8:	3c6b4841 	ldr	b1, [x2, w11, uxtw]
    32dc:	9e660043 	fmov	x3, d2
    32e0:	0e205842 	cnt	v2.8b, v2.8b
    32e4:	9e660024 	fmov	x4, d1
    32e8:	0e205821 	cnt	v1.8b, v1.8b
    32ec:	0e31b842 	addv	b2, v2.8b
    32f0:	0a030083 	and	w3, w4, w3
    32f4:	1e270060 	fmov	s0, w3
    32f8:	0e31b821 	addv	b1, v1.8b
    32fc:	0e205800 	cnt	v0.8b, v0.8b
    3300:	9e660049 	fmov	x9, d2
    3304:	9e660024 	fmov	x4, d1
    3308:	0e31b800 	addv	b0, v0.8b
    330c:	8b0900c6 	add	x6, x6, x9
    3310:	8b040108 	add	x8, x8, x4
    3314:	9e660003 	fmov	x3, d0
    3318:	8b0300e7 	add	x7, x7, x3
    331c:	6b05001f 	cmp	w0, w5
    3320:	54000269 	b.ls	336c <_Z25bit_jaccard_distance_neonjPKhS0_+0x3b8>  // b.plast
    3324:	3c654822 	ldr	b2, [x1, w5, uxtw]
    3328:	3c654841 	ldr	b1, [x2, w5, uxtw]
    332c:	9e660040 	fmov	x0, d2
    3330:	0e205842 	cnt	v2.8b, v2.8b
    3334:	9e660021 	fmov	x1, d1
    3338:	0e205821 	cnt	v1.8b, v1.8b
    333c:	0e31b842 	addv	b2, v2.8b
    3340:	0a010000 	and	w0, w0, w1
    3344:	1e270000 	fmov	s0, w0
    3348:	0e31b821 	addv	b1, v1.8b
    334c:	0e205800 	cnt	v0.8b, v0.8b
    3350:	9e660042 	fmov	x2, d2
    3354:	9e660021 	fmov	x1, d1
    3358:	0e31b800 	addv	b0, v0.8b
    335c:	8b0200c6 	add	x6, x6, x2
    3360:	8b010108 	add	x8, x8, x1
    3364:	9e660000 	fmov	x0, d0
    3368:	8b0000e7 	add	x7, x7, x0
    336c:	1e6e1000 	fmov	d0, #1.000000000000000000e+00
    3370:	b40000e7 	cbz	x7, 338c <_Z25bit_jaccard_distance_neonjPKhS0_+0x3d8>
    3374:	8b0800c6 	add	x6, x6, x8
    3378:	9e6300e2 	ucvtf	d2, x7
    337c:	cb0700c6 	sub	x6, x6, x7
    3380:	9e6300c1 	ucvtf	d1, x6
    3384:	1e611841 	fdiv	d1, d2, d1
    3388:	1e613800 	fsub	d0, d0, d1
    338c:	d65f03c0 	ret
    3390:	2a0903e5 	mov	w5, w9
    3394:	17ffff4f 	b	30d0 <_Z25bit_jaccard_distance_neonjPKhS0_+0x11c>
    3398:	52800105 	mov	w5, #0x8                   	// #8
    339c:	52800009 	mov	w9, #0x0                   	// #0
    33a0:	d2800008 	mov	x8, #0x0                   	// #0
    33a4:	d2800006 	mov	x6, #0x0                   	// #0
    33a8:	d2800007 	mov	x7, #0x0                   	// #0
    33ac:	17ffff32 	b	3074 <_Z25bit_jaccard_distance_neonjPKhS0_+0xc0>

00000000000033b0 <_Z33vector_l2_squared_distance_nativeiPKfS0_>:
    33b0:	7100001f 	cmp	w0, #0x0
    33b4:	5400062d 	b.le	3478 <_Z33vector_l2_squared_distance_nativeiPKfS0_+0xc8>
    33b8:	51000403 	sub	w3, w0, #0x1
    33bc:	7100087f 	cmp	w3, #0x2
    33c0:	54000609 	b.ls	3480 <_Z33vector_l2_squared_distance_nativeiPKfS0_+0xd0>  // b.plast
    33c4:	53027c04 	lsr	w4, w0, #2
    33c8:	0f000400 	movi	v0.2s, #0x0
    33cc:	d2800003 	mov	x3, #0x0                   	// #0
    33d0:	d37cec84 	lsl	x4, x4, #4
    33d4:	d503201f 	nop
    33d8:	3ce36842 	ldr	q2, [x2, x3]
    33dc:	3ce36821 	ldr	q1, [x1, x3]
    33e0:	91004063 	add	x3, x3, #0x10
    33e4:	4ea2d421 	fsub	v1.4s, v1.4s, v2.4s
    33e8:	6e21dc21 	fmul	v1.4s, v1.4s, v1.4s
    33ec:	5e0c0423 	mov	s3, v1.s[1]
    33f0:	1e212800 	fadd	s0, s0, s1
    33f4:	5e140422 	mov	s2, v1.s[2]
    33f8:	5e1c0421 	mov	s1, v1.s[3]
    33fc:	1e232800 	fadd	s0, s0, s3
    3400:	1e222800 	fadd	s0, s0, s2
    3404:	1e212800 	fadd	s0, s0, s1
    3408:	eb04007f 	cmp	x3, x4
    340c:	54fffe61 	b.ne	33d8 <_Z33vector_l2_squared_distance_nativeiPKfS0_+0x28>  // b.any
    3410:	121e7403 	and	w3, w0, #0xfffffffc
    3414:	f240041f 	tst	x0, #0x3
    3418:	540002e0 	b.eq	3474 <_Z33vector_l2_squared_distance_nativeiPKfS0_+0xc4>  // b.none
    341c:	93407c65 	sxtw	x5, w3
    3420:	11000466 	add	w6, w3, #0x1
    3424:	937e7c64 	sbfiz	x4, x3, #2, #32
    3428:	bc657821 	ldr	s1, [x1, x5, lsl #2]
    342c:	bc657842 	ldr	s2, [x2, x5, lsl #2]
    3430:	1e223821 	fsub	s1, s1, s2
    3434:	1f010020 	fmadd	s0, s1, s1, s0
    3438:	6b06001f 	cmp	w0, w6
    343c:	540001cd 	b.le	3474 <_Z33vector_l2_squared_distance_nativeiPKfS0_+0xc4>
    3440:	91001085 	add	x5, x4, #0x4
    3444:	11000863 	add	w3, w3, #0x2
    3448:	bc656821 	ldr	s1, [x1, x5]
    344c:	bc656842 	ldr	s2, [x2, x5]
    3450:	1e223821 	fsub	s1, s1, s2
    3454:	1f010020 	fmadd	s0, s1, s1, s0
    3458:	6b03001f 	cmp	w0, w3
    345c:	540000cd 	b.le	3474 <_Z33vector_l2_squared_distance_nativeiPKfS0_+0xc4>
    3460:	91002084 	add	x4, x4, #0x8
    3464:	bc646821 	ldr	s1, [x1, x4]
    3468:	bc646842 	ldr	s2, [x2, x4]
    346c:	1e223821 	fsub	s1, s1, s2
    3470:	1f010020 	fmadd	s0, s1, s1, s0
    3474:	d65f03c0 	ret
    3478:	0f000400 	movi	v0.2s, #0x0
    347c:	d65f03c0 	ret
    3480:	0f000400 	movi	v0.2s, #0x0
    3484:	52800003 	mov	w3, #0x0                   	// #0
    3488:	17ffffe5 	b	341c <_Z33vector_l2_squared_distance_nativeiPKfS0_+0x6c>
    348c:	d503201f 	nop

0000000000003490 <_Z27vector_inner_product_nativeiPKfS0_>:
    3490:	7100001f 	cmp	w0, #0x0
    3494:	540005ad 	b.le	3548 <_Z27vector_inner_product_nativeiPKfS0_+0xb8>
    3498:	51000403 	sub	w3, w0, #0x1
    349c:	7100087f 	cmp	w3, #0x2
    34a0:	54000589 	b.ls	3550 <_Z27vector_inner_product_nativeiPKfS0_+0xc0>  // b.plast
    34a4:	53027c04 	lsr	w4, w0, #2
    34a8:	0f000400 	movi	v0.2s, #0x0
    34ac:	d2800003 	mov	x3, #0x0                   	// #0
    34b0:	d37cec84 	lsl	x4, x4, #4
    34b4:	d503201f 	nop
    34b8:	3ce36842 	ldr	q2, [x2, x3]
    34bc:	3ce36821 	ldr	q1, [x1, x3]
    34c0:	91004063 	add	x3, x3, #0x10
    34c4:	6e22dc21 	fmul	v1.4s, v1.4s, v2.4s
    34c8:	5e0c0423 	mov	s3, v1.s[1]
    34cc:	1e212800 	fadd	s0, s0, s1
    34d0:	5e140422 	mov	s2, v1.s[2]
    34d4:	5e1c0421 	mov	s1, v1.s[3]
    34d8:	1e232800 	fadd	s0, s0, s3
    34dc:	1e222800 	fadd	s0, s0, s2
    34e0:	1e212800 	fadd	s0, s0, s1
    34e4:	eb03009f 	cmp	x4, x3
    34e8:	54fffe81 	b.ne	34b8 <_Z27vector_inner_product_nativeiPKfS0_+0x28>  // b.any
    34ec:	121e7403 	and	w3, w0, #0xfffffffc
    34f0:	f240041f 	tst	x0, #0x3
    34f4:	54000280 	b.eq	3544 <_Z27vector_inner_product_nativeiPKfS0_+0xb4>  // b.none
    34f8:	93407c65 	sxtw	x5, w3
    34fc:	11000466 	add	w6, w3, #0x1
    3500:	937e7c64 	sbfiz	x4, x3, #2, #32
    3504:	bc657822 	ldr	s2, [x1, x5, lsl #2]
    3508:	bc657841 	ldr	s1, [x2, x5, lsl #2]
    350c:	1f010040 	fmadd	s0, s2, s1, s0
    3510:	6b06001f 	cmp	w0, w6
    3514:	5400018d 	b.le	3544 <_Z27vector_inner_product_nativeiPKfS0_+0xb4>
    3518:	91001085 	add	x5, x4, #0x4
    351c:	11000863 	add	w3, w3, #0x2
    3520:	bc656822 	ldr	s2, [x1, x5]
    3524:	bc656841 	ldr	s1, [x2, x5]
    3528:	1f010040 	fmadd	s0, s2, s1, s0
    352c:	6b03001f 	cmp	w0, w3
    3530:	540000ad 	b.le	3544 <_Z27vector_inner_product_nativeiPKfS0_+0xb4>
    3534:	91002084 	add	x4, x4, #0x8
    3538:	bc646842 	ldr	s2, [x2, x4]
    353c:	bc646821 	ldr	s1, [x1, x4]
    3540:	1f010040 	fmadd	s0, s2, s1, s0
    3544:	d65f03c0 	ret
    3548:	0f000400 	movi	v0.2s, #0x0
    354c:	d65f03c0 	ret
    3550:	0f000400 	movi	v0.2s, #0x0
    3554:	52800003 	mov	w3, #0x0                   	// #0
    3558:	17ffffe8 	b	34f8 <_Z27vector_inner_product_nativeiPKfS0_+0x68>
    355c:	d503201f 	nop

0000000000003560 <_Z31vector_cosine_similarity_nativeiPKfS0_>:
    3560:	7100001f 	cmp	w0, #0x0
    3564:	5400040d 	b.le	35e4 <_Z31vector_cosine_similarity_nativeiPKfS0_+0x84>
    3568:	0f000403 	movi	v3.2s, #0x0
    356c:	937e7c03 	sbfiz	x3, x0, #2, #32
    3570:	d2800000 	mov	x0, #0x0                   	// #0
    3574:	1e204060 	fmov	s0, s3
    3578:	1e204064 	fmov	s4, s3
    357c:	d503201f 	nop
    3580:	bc606822 	ldr	s2, [x1, x0]
    3584:	bc606841 	ldr	s1, [x2, x0]
    3588:	91001000 	add	x0, x0, #0x4
    358c:	1f020040 	fmadd	s0, s2, s2, s0
    3590:	1f011044 	fmadd	s4, s2, s1, s4
    3594:	1f010c23 	fmadd	s3, s1, s1, s3
    3598:	eb00007f 	cmp	x3, x0
    359c:	54ffff21 	b.ne	3580 <_Z31vector_cosine_similarity_nativeiPKfS0_+0x20>  // b.any
    35a0:	1e22c000 	fcvt	d0, s0
    35a4:	1e22c063 	fcvt	d3, s3
    35a8:	1e22c084 	fcvt	d4, s4
    35ac:	1e630800 	fmul	d0, d0, d3
    35b0:	1e602008 	fcmp	d0, #0.0
    35b4:	54000125 	b.pl	35d8 <_Z31vector_cosine_similarity_nativeiPKfS0_+0x78>  // b.nfrst
    35b8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    35bc:	910003fd 	mov	x29, sp
    35c0:	fd000fe4 	str	d4, [sp, #24]
    35c4:	97fff4bf 	bl	8c0 <sqrt@plt>
    35c8:	fd400fe4 	ldr	d4, [sp, #24]
    35cc:	a8c27bfd 	ldp	x29, x30, [sp], #32
    35d0:	1e601880 	fdiv	d0, d4, d0
    35d4:	d65f03c0 	ret
    35d8:	1e61c000 	fsqrt	d0, d0
    35dc:	1e601880 	fdiv	d0, d4, d0
    35e0:	d65f03c0 	ret
    35e4:	2f00e400 	movi	d0, #0x0
    35e8:	1e604004 	fmov	d4, d0
    35ec:	1e601880 	fdiv	d0, d4, d0
    35f0:	d65f03c0 	ret

00000000000035f4 <_Z25vector_l1_distance_nativeiPKfS0_>:
    35f4:	7100001f 	cmp	w0, #0x0
    35f8:	540005ed 	b.le	36b4 <_Z25vector_l1_distance_nativeiPKfS0_+0xc0>
    35fc:	51000403 	sub	w3, w0, #0x1
    3600:	7100087f 	cmp	w3, #0x2
    3604:	540005c9 	b.ls	36bc <_Z25vector_l1_distance_nativeiPKfS0_+0xc8>  // b.plast
    3608:	53027c04 	lsr	w4, w0, #2
    360c:	0f000400 	movi	v0.2s, #0x0
    3610:	d2800003 	mov	x3, #0x0                   	// #0
    3614:	d37cec84 	lsl	x4, x4, #4
    3618:	3ce36842 	ldr	q2, [x2, x3]
    361c:	3ce36821 	ldr	q1, [x1, x3]
    3620:	91004063 	add	x3, x3, #0x10
    3624:	6ea2d421 	fabd	v1.4s, v1.4s, v2.4s
    3628:	5e0c0423 	mov	s3, v1.s[1]
    362c:	1e212800 	fadd	s0, s0, s1
    3630:	5e140422 	mov	s2, v1.s[2]
    3634:	5e1c0421 	mov	s1, v1.s[3]
    3638:	1e232800 	fadd	s0, s0, s3
    363c:	1e222800 	fadd	s0, s0, s2
    3640:	1e212800 	fadd	s0, s0, s1
    3644:	eb04007f 	cmp	x3, x4
    3648:	54fffe81 	b.ne	3618 <_Z25vector_l1_distance_nativeiPKfS0_+0x24>  // b.any
    364c:	121e7403 	and	w3, w0, #0xfffffffc
    3650:	f240041f 	tst	x0, #0x3
    3654:	540002e0 	b.eq	36b0 <_Z25vector_l1_distance_nativeiPKfS0_+0xbc>  // b.none
    3658:	93407c65 	sxtw	x5, w3
    365c:	11000466 	add	w6, w3, #0x1
    3660:	937e7c64 	sbfiz	x4, x3, #2, #32
    3664:	bc657821 	ldr	s1, [x1, x5, lsl #2]
    3668:	bc657842 	ldr	s2, [x2, x5, lsl #2]
    366c:	7ea2d421 	fabd	s1, s1, s2
    3670:	1e212800 	fadd	s0, s0, s1
    3674:	6b06001f 	cmp	w0, w6
    3678:	540001cd 	b.le	36b0 <_Z25vector_l1_distance_nativeiPKfS0_+0xbc>
    367c:	91001085 	add	x5, x4, #0x4
    3680:	11000863 	add	w3, w3, #0x2
    3684:	bc656821 	ldr	s1, [x1, x5]
    3688:	bc656842 	ldr	s2, [x2, x5]
    368c:	7ea2d421 	fabd	s1, s1, s2
    3690:	1e212800 	fadd	s0, s0, s1
    3694:	6b03001f 	cmp	w0, w3
    3698:	540000cd 	b.le	36b0 <_Z25vector_l1_distance_nativeiPKfS0_+0xbc>
    369c:	91002084 	add	x4, x4, #0x8
    36a0:	bc646821 	ldr	s1, [x1, x4]
    36a4:	bc646842 	ldr	s2, [x2, x4]
    36a8:	7ea2d421 	fabd	s1, s1, s2
    36ac:	1e212800 	fadd	s0, s0, s1
    36b0:	d65f03c0 	ret
    36b4:	0f000400 	movi	v0.2s, #0x0
    36b8:	d65f03c0 	ret
    36bc:	0f000400 	movi	v0.2s, #0x0
    36c0:	52800003 	mov	w3, #0x0                   	// #0
    36c4:	17ffffe5 	b	3658 <_Z25vector_l1_distance_nativeiPKfS0_+0x64>
    36c8:	d503201f 	nop
    36cc:	d503201f 	nop

00000000000036d0 <_Z31vector_l2_squared_distance_neoniPKfS0_>:
    36d0:	6b0003e3 	negs	w3, w0
    36d4:	12000404 	and	w4, w0, #0x3
    36d8:	12000463 	and	w3, w3, #0x3
    36dc:	5a834483 	csneg	w3, w4, w3, mi	// mi = first
    36e0:	4b030003 	sub	w3, w0, w3
    36e4:	7100007f 	cmp	w3, #0x0
    36e8:	5400092d 	b.le	380c <_Z31vector_l2_squared_distance_neoniPKfS0_+0x13c>
    36ec:	4f000400 	movi	v0.4s, #0x0
    36f0:	51000464 	sub	w4, w3, #0x1
    36f4:	d2800003 	mov	x3, #0x0                   	// #0
    36f8:	53027c84 	lsr	w4, w4, #2
    36fc:	11000484 	add	w4, w4, #0x1
    3700:	d37c7885 	ubfiz	x5, x4, #4, #31
    3704:	d503201f 	nop
    3708:	3ce36821 	ldr	q1, [x1, x3]
    370c:	3ce36842 	ldr	q2, [x2, x3]
    3710:	91004063 	add	x3, x3, #0x10
    3714:	4ea2d421 	fsub	v1.4s, v1.4s, v2.4s
    3718:	6e21dc21 	fmul	v1.4s, v1.4s, v1.4s
    371c:	4e21d400 	fadd	v0.4s, v0.4s, v1.4s
    3720:	eb05007f 	cmp	x3, x5
    3724:	54ffff21 	b.ne	3708 <_Z31vector_l2_squared_distance_neoniPKfS0_+0x38>  // b.any
    3728:	6e20d400 	faddp	v0.4s, v0.4s, v0.4s
    372c:	531e7484 	lsl	w4, w4, #2
    3730:	6e20d400 	faddp	v0.4s, v0.4s, v0.4s
    3734:	6b04001f 	cmp	w0, w4
    3738:	5400068d 	b.le	3808 <_Z31vector_l2_squared_distance_neoniPKfS0_+0x138>
    373c:	4b040008 	sub	w8, w0, w4
    3740:	51000503 	sub	w3, w8, #0x1
    3744:	7100087f 	cmp	w3, #0x2
    3748:	54000349 	b.ls	37b0 <_Z31vector_l2_squared_distance_neoniPKfS0_+0xe0>  // b.plast
    374c:	53027d05 	lsr	w5, w8, #2
    3750:	937e7c86 	sbfiz	x6, x4, #2, #32
    3754:	8b060027 	add	x7, x1, x6
    3758:	8b060046 	add	x6, x2, x6
    375c:	d37ceca5 	lsl	x5, x5, #4
    3760:	d2800003 	mov	x3, #0x0                   	// #0
    3764:	d503201f 	nop
    3768:	3ce368c2 	ldr	q2, [x6, x3]
    376c:	3ce368e1 	ldr	q1, [x7, x3]
    3770:	91004063 	add	x3, x3, #0x10
    3774:	4ea2d421 	fsub	v1.4s, v1.4s, v2.4s
    3778:	6e21dc21 	fmul	v1.4s, v1.4s, v1.4s
    377c:	5e0c0423 	mov	s3, v1.s[1]
    3780:	1e212800 	fadd	s0, s0, s1
    3784:	5e140422 	mov	s2, v1.s[2]
    3788:	5e1c0421 	mov	s1, v1.s[3]
    378c:	1e232800 	fadd	s0, s0, s3
    3790:	1e222800 	fadd	s0, s0, s2
    3794:	1e212800 	fadd	s0, s0, s1
    3798:	eb0300bf 	cmp	x5, x3
    379c:	54fffe61 	b.ne	3768 <_Z31vector_l2_squared_distance_neoniPKfS0_+0x98>  // b.any
    37a0:	f240051f 	tst	x8, #0x3
    37a4:	54000320 	b.eq	3808 <_Z31vector_l2_squared_distance_neoniPKfS0_+0x138>  // b.none
    37a8:	121e7508 	and	w8, w8, #0xfffffffc
    37ac:	0b080084 	add	w4, w4, w8
    37b0:	93407c85 	sxtw	x5, w4
    37b4:	11000486 	add	w6, w4, #0x1
    37b8:	937e7c83 	sbfiz	x3, x4, #2, #32
    37bc:	bc657821 	ldr	s1, [x1, x5, lsl #2]
    37c0:	bc657842 	ldr	s2, [x2, x5, lsl #2]
    37c4:	1e223821 	fsub	s1, s1, s2
    37c8:	1f010020 	fmadd	s0, s1, s1, s0
    37cc:	6b06001f 	cmp	w0, w6
    37d0:	540001cd 	b.le	3808 <_Z31vector_l2_squared_distance_neoniPKfS0_+0x138>
    37d4:	91001065 	add	x5, x3, #0x4
    37d8:	11000884 	add	w4, w4, #0x2
    37dc:	bc656821 	ldr	s1, [x1, x5]
    37e0:	bc656842 	ldr	s2, [x2, x5]
    37e4:	1e223821 	fsub	s1, s1, s2
    37e8:	1f010020 	fmadd	s0, s1, s1, s0
    37ec:	6b04001f 	cmp	w0, w4
    37f0:	540000cd 	b.le	3808 <_Z31vector_l2_squared_distance_neoniPKfS0_+0x138>
    37f4:	91002063 	add	x3, x3, #0x8
    37f8:	bc636821 	ldr	s1, [x1, x3]
    37fc:	bc636842 	ldr	s2, [x2, x3]
    3800:	1e223821 	fsub	s1, s1, s2
    3804:	1f010020 	fmadd	s0, s1, s1, s0
    3808:	d65f03c0 	ret
    380c:	0f000400 	movi	v0.2s, #0x0
    3810:	52800004 	mov	w4, #0x0                   	// #0
    3814:	17ffffc8 	b	3734 <_Z31vector_l2_squared_distance_neoniPKfS0_+0x64>
    3818:	d503201f 	nop
    381c:	d503201f 	nop

0000000000003820 <_Z25vector_inner_product_neoniPKfS0_>:
    3820:	6b0003e3 	negs	w3, w0
    3824:	12000404 	and	w4, w0, #0x3
    3828:	12000463 	and	w3, w3, #0x3
    382c:	5a834483 	csneg	w3, w4, w3, mi	// mi = first
    3830:	4b030003 	sub	w3, w0, w3
    3834:	7100007f 	cmp	w3, #0x0
    3838:	5400086d 	b.le	3944 <_Z25vector_inner_product_neoniPKfS0_+0x124>
    383c:	4f000400 	movi	v0.4s, #0x0
    3840:	51000464 	sub	w4, w3, #0x1
    3844:	d2800003 	mov	x3, #0x0                   	// #0
    3848:	53027c84 	lsr	w4, w4, #2
    384c:	11000484 	add	w4, w4, #0x1
    3850:	d37c7885 	ubfiz	x5, x4, #4, #31
    3854:	d503201f 	nop
    3858:	3ce36821 	ldr	q1, [x1, x3]
    385c:	3ce36842 	ldr	q2, [x2, x3]
    3860:	91004063 	add	x3, x3, #0x10
    3864:	6e22dc21 	fmul	v1.4s, v1.4s, v2.4s
    3868:	4e21d400 	fadd	v0.4s, v0.4s, v1.4s
    386c:	eb05007f 	cmp	x3, x5
    3870:	54ffff41 	b.ne	3858 <_Z25vector_inner_product_neoniPKfS0_+0x38>  // b.any
    3874:	6e20d400 	faddp	v0.4s, v0.4s, v0.4s
    3878:	531e7484 	lsl	w4, w4, #2
    387c:	6e20d400 	faddp	v0.4s, v0.4s, v0.4s
    3880:	6b04001f 	cmp	w0, w4
    3884:	540005ed 	b.le	3940 <_Z25vector_inner_product_neoniPKfS0_+0x120>
    3888:	4b040008 	sub	w8, w0, w4
    388c:	51000503 	sub	w3, w8, #0x1
    3890:	7100087f 	cmp	w3, #0x2
    3894:	54000309 	b.ls	38f4 <_Z25vector_inner_product_neoniPKfS0_+0xd4>  // b.plast
    3898:	53027d05 	lsr	w5, w8, #2
    389c:	937e7c86 	sbfiz	x6, x4, #2, #32
    38a0:	8b060027 	add	x7, x1, x6
    38a4:	8b060046 	add	x6, x2, x6
    38a8:	d37ceca5 	lsl	x5, x5, #4
    38ac:	d2800003 	mov	x3, #0x0                   	// #0
    38b0:	3ce368c2 	ldr	q2, [x6, x3]
    38b4:	3ce368e1 	ldr	q1, [x7, x3]
    38b8:	91004063 	add	x3, x3, #0x10
    38bc:	6e22dc21 	fmul	v1.4s, v1.4s, v2.4s
    38c0:	5e0c0423 	mov	s3, v1.s[1]
    38c4:	1e212800 	fadd	s0, s0, s1
    38c8:	5e140422 	mov	s2, v1.s[2]
    38cc:	5e1c0421 	mov	s1, v1.s[3]
    38d0:	1e232800 	fadd	s0, s0, s3
    38d4:	1e222800 	fadd	s0, s0, s2
    38d8:	1e212800 	fadd	s0, s0, s1
    38dc:	eb0300bf 	cmp	x5, x3
    38e0:	54fffe81 	b.ne	38b0 <_Z25vector_inner_product_neoniPKfS0_+0x90>  // b.any
    38e4:	f240051f 	tst	x8, #0x3
    38e8:	540002c0 	b.eq	3940 <_Z25vector_inner_product_neoniPKfS0_+0x120>  // b.none
    38ec:	121e7508 	and	w8, w8, #0xfffffffc
    38f0:	0b080084 	add	w4, w4, w8
    38f4:	93407c85 	sxtw	x5, w4
    38f8:	11000486 	add	w6, w4, #0x1
    38fc:	937e7c83 	sbfiz	x3, x4, #2, #32
    3900:	bc657822 	ldr	s2, [x1, x5, lsl #2]
    3904:	bc657841 	ldr	s1, [x2, x5, lsl #2]
    3908:	1f010040 	fmadd	s0, s2, s1, s0
    390c:	6b06001f 	cmp	w0, w6
    3910:	5400018d 	b.le	3940 <_Z25vector_inner_product_neoniPKfS0_+0x120>
    3914:	91001065 	add	x5, x3, #0x4
    3918:	11000884 	add	w4, w4, #0x2
    391c:	bc656822 	ldr	s2, [x1, x5]
    3920:	bc656841 	ldr	s1, [x2, x5]
    3924:	1f010040 	fmadd	s0, s2, s1, s0
    3928:	6b04001f 	cmp	w0, w4
    392c:	540000ad 	b.le	3940 <_Z25vector_inner_product_neoniPKfS0_+0x120>
    3930:	91002063 	add	x3, x3, #0x8
    3934:	bc636842 	ldr	s2, [x2, x3]
    3938:	bc636821 	ldr	s1, [x1, x3]
    393c:	1f010040 	fmadd	s0, s2, s1, s0
    3940:	d65f03c0 	ret
    3944:	0f000400 	movi	v0.2s, #0x0
    3948:	52800004 	mov	w4, #0x0                   	// #0
    394c:	17ffffcd 	b	3880 <_Z25vector_inner_product_neoniPKfS0_+0x60>

0000000000003950 <_Z29vector_cosine_similarity_neoniPKfS0_>:
    3950:	6b0003e3 	negs	w3, w0
    3954:	12000404 	and	w4, w0, #0x3
    3958:	12000463 	and	w3, w3, #0x3
    395c:	5a834483 	csneg	w3, w4, w3, mi	// mi = first
    3960:	4b030003 	sub	w3, w0, w3
    3964:	7100007f 	cmp	w3, #0x0
    3968:	5400074d 	b.le	3a50 <_Z29vector_cosine_similarity_neoniPKfS0_+0x100>
    396c:	4f000404 	movi	v4.4s, #0x0
    3970:	51000463 	sub	w3, w3, #0x1
    3974:	d2800004 	mov	x4, #0x0                   	// #0
    3978:	53027c63 	lsr	w3, w3, #2
    397c:	11000463 	add	w3, w3, #0x1
    3980:	4ea41c82 	mov	v2.16b, v4.16b
    3984:	4ea41c83 	mov	v3.16b, v4.16b
    3988:	d37c7865 	ubfiz	x5, x3, #4, #31
    398c:	d503201f 	nop
    3990:	3ce46821 	ldr	q1, [x1, x4]
    3994:	3ce46840 	ldr	q0, [x2, x4]
    3998:	91004084 	add	x4, x4, #0x10
    399c:	6e21dc25 	fmul	v5.4s, v1.4s, v1.4s
    39a0:	6e20dc21 	fmul	v1.4s, v1.4s, v0.4s
    39a4:	6e20dc00 	fmul	v0.4s, v0.4s, v0.4s
    39a8:	4e25d442 	fadd	v2.4s, v2.4s, v5.4s
    39ac:	4e21d463 	fadd	v3.4s, v3.4s, v1.4s
    39b0:	4e20d484 	fadd	v4.4s, v4.4s, v0.4s
    39b4:	eb0400bf 	cmp	x5, x4
    39b8:	54fffec1 	b.ne	3990 <_Z29vector_cosine_similarity_neoniPKfS0_+0x40>  // b.any
    39bc:	6e24d484 	faddp	v4.4s, v4.4s, v4.4s
    39c0:	531e7463 	lsl	w3, w3, #2
    39c4:	6e22d442 	faddp	v2.4s, v2.4s, v2.4s
    39c8:	6e23d463 	faddp	v3.4s, v3.4s, v3.4s
    39cc:	6e24d484 	faddp	v4.4s, v4.4s, v4.4s
    39d0:	6e22d442 	faddp	v2.4s, v2.4s, v2.4s
    39d4:	6e23d463 	faddp	v3.4s, v3.4s, v3.4s
    39d8:	6b03001f 	cmp	w0, w3
    39dc:	5400016d 	b.le	3a08 <_Z29vector_cosine_similarity_neoniPKfS0_+0xb8>
    39e0:	93407c63 	sxtw	x3, w3
    39e4:	d503201f 	nop
    39e8:	bc637821 	ldr	s1, [x1, x3, lsl #2]
    39ec:	bc637840 	ldr	s0, [x2, x3, lsl #2]
    39f0:	91000463 	add	x3, x3, #0x1
    39f4:	1f010822 	fmadd	s2, s1, s1, s2
    39f8:	1f000c23 	fmadd	s3, s1, s0, s3
    39fc:	1f001004 	fmadd	s4, s0, s0, s4
    3a00:	6b03001f 	cmp	w0, w3
    3a04:	54ffff2c 	b.gt	39e8 <_Z29vector_cosine_similarity_neoniPKfS0_+0x98>
    3a08:	1e22c042 	fcvt	d2, s2
    3a0c:	1e22c084 	fcvt	d4, s4
    3a10:	1e22c063 	fcvt	d3, s3
    3a14:	1e640842 	fmul	d2, d2, d4
    3a18:	1e602048 	fcmp	d2, #0.0
    3a1c:	54000145 	b.pl	3a44 <_Z29vector_cosine_similarity_neoniPKfS0_+0xf4>  // b.nfrst
    3a20:	1e604040 	fmov	d0, d2
    3a24:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    3a28:	910003fd 	mov	x29, sp
    3a2c:	fd000fe3 	str	d3, [sp, #24]
    3a30:	97fff3a4 	bl	8c0 <sqrt@plt>
    3a34:	fd400fe3 	ldr	d3, [sp, #24]
    3a38:	a8c27bfd 	ldp	x29, x30, [sp], #32
    3a3c:	1e601860 	fdiv	d0, d3, d0
    3a40:	d65f03c0 	ret
    3a44:	1e61c042 	fsqrt	d2, d2
    3a48:	1e621860 	fdiv	d0, d3, d2
    3a4c:	d65f03c0 	ret
    3a50:	2f00e402 	movi	d2, #0x0
    3a54:	1e604043 	fmov	d3, d2
    3a58:	7100001f 	cmp	w0, #0x0
    3a5c:	54ffff4d 	b.le	3a44 <_Z29vector_cosine_similarity_neoniPKfS0_+0xf4>
    3a60:	0f000403 	movi	v3.2s, #0x0
    3a64:	52800003 	mov	w3, #0x0                   	// #0
    3a68:	1e204062 	fmov	s2, s3
    3a6c:	1e204064 	fmov	s4, s3
    3a70:	17ffffdc 	b	39e0 <_Z29vector_cosine_similarity_neoniPKfS0_+0x90>

0000000000003a74 <_Z23vector_l1_distance_neoniPKfS0_>:
    3a74:	6b0003e3 	negs	w3, w0
    3a78:	12000404 	and	w4, w0, #0x3
    3a7c:	12000463 	and	w3, w3, #0x3
    3a80:	5a834483 	csneg	w3, w4, w3, mi	// mi = first
    3a84:	4b030003 	sub	w3, w0, w3
    3a88:	7100007f 	cmp	w3, #0x0
    3a8c:	540008ad 	b.le	3ba0 <_Z23vector_l1_distance_neoniPKfS0_+0x12c>
    3a90:	4f000400 	movi	v0.4s, #0x0
    3a94:	51000464 	sub	w4, w3, #0x1
    3a98:	d2800003 	mov	x3, #0x0                   	// #0
    3a9c:	53027c84 	lsr	w4, w4, #2
    3aa0:	11000484 	add	w4, w4, #0x1
    3aa4:	d37c7885 	ubfiz	x5, x4, #4, #31
    3aa8:	3ce36821 	ldr	q1, [x1, x3]
    3aac:	3ce36842 	ldr	q2, [x2, x3]
    3ab0:	91004063 	add	x3, x3, #0x10
    3ab4:	6ea2d421 	fabd	v1.4s, v1.4s, v2.4s
    3ab8:	4e21d400 	fadd	v0.4s, v0.4s, v1.4s
    3abc:	eb05007f 	cmp	x3, x5
    3ac0:	54ffff41 	b.ne	3aa8 <_Z23vector_l1_distance_neoniPKfS0_+0x34>  // b.any
    3ac4:	6e20d400 	faddp	v0.4s, v0.4s, v0.4s
    3ac8:	531e7484 	lsl	w4, w4, #2
    3acc:	6e20d400 	faddp	v0.4s, v0.4s, v0.4s
    3ad0:	6b04001f 	cmp	w0, w4
    3ad4:	5400064d 	b.le	3b9c <_Z23vector_l1_distance_neoniPKfS0_+0x128>
    3ad8:	4b040008 	sub	w8, w0, w4
    3adc:	51000503 	sub	w3, w8, #0x1
    3ae0:	7100087f 	cmp	w3, #0x2
    3ae4:	54000309 	b.ls	3b44 <_Z23vector_l1_distance_neoniPKfS0_+0xd0>  // b.plast
    3ae8:	53027d05 	lsr	w5, w8, #2
    3aec:	937e7c86 	sbfiz	x6, x4, #2, #32
    3af0:	8b060027 	add	x7, x1, x6
    3af4:	8b060046 	add	x6, x2, x6
    3af8:	d37ceca5 	lsl	x5, x5, #4
    3afc:	d2800003 	mov	x3, #0x0                   	// #0
    3b00:	3ce368c2 	ldr	q2, [x6, x3]
    3b04:	3ce368e1 	ldr	q1, [x7, x3]
    3b08:	91004063 	add	x3, x3, #0x10
    3b0c:	6ea2d421 	fabd	v1.4s, v1.4s, v2.4s
    3b10:	5e0c0423 	mov	s3, v1.s[1]
    3b14:	1e212800 	fadd	s0, s0, s1
    3b18:	5e140422 	mov	s2, v1.s[2]
    3b1c:	5e1c0421 	mov	s1, v1.s[3]
    3b20:	1e232800 	fadd	s0, s0, s3
    3b24:	1e222800 	fadd	s0, s0, s2
    3b28:	1e212800 	fadd	s0, s0, s1
    3b2c:	eb0300bf 	cmp	x5, x3
    3b30:	54fffe81 	b.ne	3b00 <_Z23vector_l1_distance_neoniPKfS0_+0x8c>  // b.any
    3b34:	f240051f 	tst	x8, #0x3
    3b38:	54000320 	b.eq	3b9c <_Z23vector_l1_distance_neoniPKfS0_+0x128>  // b.none
    3b3c:	121e7508 	and	w8, w8, #0xfffffffc
    3b40:	0b080084 	add	w4, w4, w8
    3b44:	93407c85 	sxtw	x5, w4
    3b48:	11000486 	add	w6, w4, #0x1
    3b4c:	937e7c83 	sbfiz	x3, x4, #2, #32
    3b50:	bc657821 	ldr	s1, [x1, x5, lsl #2]
    3b54:	bc657842 	ldr	s2, [x2, x5, lsl #2]
    3b58:	7ea2d421 	fabd	s1, s1, s2
    3b5c:	1e212800 	fadd	s0, s0, s1
    3b60:	6b0000df 	cmp	w6, w0
    3b64:	540001ca 	b.ge	3b9c <_Z23vector_l1_distance_neoniPKfS0_+0x128>  // b.tcont
    3b68:	91001065 	add	x5, x3, #0x4
    3b6c:	11000884 	add	w4, w4, #0x2
    3b70:	bc656821 	ldr	s1, [x1, x5]
    3b74:	bc656842 	ldr	s2, [x2, x5]
    3b78:	7ea2d421 	fabd	s1, s1, s2
    3b7c:	1e212800 	fadd	s0, s0, s1
    3b80:	6b04001f 	cmp	w0, w4
    3b84:	540000cd 	b.le	3b9c <_Z23vector_l1_distance_neoniPKfS0_+0x128>
    3b88:	91002063 	add	x3, x3, #0x8
    3b8c:	bc636821 	ldr	s1, [x1, x3]
    3b90:	bc636842 	ldr	s2, [x2, x3]
    3b94:	7ea2d421 	fabd	s1, s1, s2
    3b98:	1e212800 	fadd	s0, s0, s1
    3b9c:	d65f03c0 	ret
    3ba0:	0f000400 	movi	v0.2s, #0x0
    3ba4:	52800004 	mov	w4, #0x0                   	// #0
    3ba8:	17ffffca 	b	3ad0 <_Z23vector_l1_distance_neoniPKfS0_+0x5c>

Disassembly of section .fini:

0000000000003bac <_fini>:
    3bac:	d503201f 	nop
    3bb0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    3bb4:	910003fd 	mov	x29, sp
    3bb8:	a8c17bfd 	ldp	x29, x30, [sp], #16
    3bbc:	d65f03c0 	ret

Disassembly of section .rodata:

0000000000003bc0 <_IO_stdin_used>:
    3bc0:	00020001 	.inst	0x00020001 ; undefined
    3bc4:	00000000 	udf	#0
    3bc8:	3d3d3d0a 	str	b10, [x8, #3919]
    3bcc:	63655620 	.inst	0x63655620 ; undefined
    3bd0:	20726f74 	.inst	0x20726f74 ; undefined
    3bd4:	6f6c6628 	sqshlu	v8.2d, v17.2d, #44
    3bd8:	32337461 	orr	w1, w3, #0xffffe7ff
    3bdc:	69442029 	ldpsw	x9, x8, [x1, #32]
    3be0:	6e617473 	uabd	v19.8h, v3.8h, v1.8h
    3be4:	54206563 	b.cc	44890 <__bss_end__+0x24818>  // b.lo, b.ul, b.last
    3be8:	73747365 	.inst	0x73747365 ; undefined
    3bec:	3d3d3d20 	str	b0, [x9, #3919]
	...
    3bf8:	6e6f656e 	umax	v14.8h, v11.8h, v15.8h
    3bfc:	00326c5f 	.inst	0x00326c5f ; NYI
    3c00:	6974616e 	ldpsw	x14, x24, [x11, #-96]
    3c04:	6c5f6576 	ldnp	d22, d25, [x11, #496]
    3c08:	00000032 	udf	#50
    3c0c:	00000000 	udf	#0
    3c10:	4c494146 	.inst	0x4c494146 ; undefined
    3c14:	7325203a 	.inst	0x7325203a ; undefined
    3c18:	203d2120 	.inst	0x203d2120 ; undefined
    3c1c:	28207325 	stnp	w5, w28, [x25, #-256]
    3c20:	66666964 	.inst	0x66666964 ; undefined
    3c24:	2967253d 	ldp	w29, w9, [x9, #-200]
    3c28:	0000000a 	udf	#10
    3c2c:	00000000 	udf	#0
    3c30:	6e6f656e 	umax	v14.8h, v11.8h, v15.8h
    3c34:	0070695f 	.inst	0x0070695f ; undefined
    3c38:	6974616e 	ldpsw	x14, x24, [x11, #-96]
    3c3c:	695f6576 	ldpsw	x22, x25, [x11, #248]
    3c40:	00000070 	udf	#112
    3c44:	00000000 	udf	#0
    3c48:	6e6f656e 	umax	v14.8h, v11.8h, v15.8h
    3c4c:	0073635f 	.inst	0x0073635f ; undefined
    3c50:	6974616e 	ldpsw	x14, x24, [x11, #-96]
    3c54:	635f6576 	.inst	0x635f6576 ; undefined
    3c58:	00000073 	udf	#115
    3c5c:	00000000 	udf	#0
    3c60:	6e6f656e 	umax	v14.8h, v11.8h, v15.8h
    3c64:	00316c5f 	.inst	0x00316c5f ; NYI
    3c68:	6974616e 	ldpsw	x14, x24, [x11, #-96]
    3c6c:	6c5f6576 	ldnp	d22, d25, [x11, #496]
    3c70:	00000031 	udf	#49
    3c74:	00000000 	udf	#0
    3c78:	3d6d6964 	ldr	b4, [x11, #2906]
    3c7c:	3a643425 	.inst	0x3a643425 ; undefined
    3c80:	3d324c20 	str	b0, [x1, #3219]
    3c84:	342e3825 	cbz	w5, 60388 <__bss_end__+0x40310>
    3c88:	50492066 	adr	x6, 96096 <__bss_end__+0x7601e>
    3c8c:	2e38253d 	uhsub	v29.8b, v9.8b, v24.8b
    3c90:	43206634 	.inst	0x43206634 ; undefined
    3c94:	36253d53 	tbz	w19, #4, ffffffffffffe43c <__bss_end__+0xfffffffffffde3c4>
    3c98:	2066342e 	.inst	0x2066342e ; undefined
    3c9c:	253d314c 	whilewr	p12.b, x10, x29
    3ca0:	66342e38 	.inst	0x66342e38 ; undefined
    3ca4:	939ce220 	.inst	0x939ce220 ; undefined
    3ca8:	0000000a 	udf	#10
    3cac:	00000000 	udf	#0
    3cb0:	3d3d3d0a 	str	b10, [x8, #3919]
    3cb4:	6c614820 	ldnp	d0, d18, [x1, #-496]
    3cb8:	69442066 	ldpsw	x6, x8, [x3, #32]
    3cbc:	6e617473 	uabd	v19.8h, v3.8h, v1.8h
    3cc0:	54206563 	b.cc	4496c <__bss_end__+0x248f4>  // b.lo, b.ul, b.last
    3cc4:	73747365 	.inst	0x73747365 ; undefined
    3cc8:	3d3d3d20 	str	b0, [x9, #3919]
    3ccc:	00000000 	udf	#0
    3cd0:	3d3d3d0a 	str	b10, [x8, #3919]
    3cd4:	74694220 	.inst	0x74694220 ; undefined
    3cd8:	73694420 	.inst	0x73694420 ; undefined
    3cdc:	636e6174 	.inst	0x636e6174 ; undefined
    3ce0:	65542065 	.inst	0x65542065 ; undefined
    3ce4:	20737473 	.inst	0x20737473 ; undefined
    3ce8:	003d3d3d 	.inst	0x003d3d3d ; NYI
    3cec:	00000000 	udf	#0
    3cf0:	6e6f656e 	umax	v14.8h, v11.8h, v15.8h
    3cf4:	6d61685f 	ldp	d31, d26, [x2, #-496]
    3cf8:	676e696d 	.inst	0x676e696d ; undefined
    3cfc:	00000000 	udf	#0
    3d00:	6974616e 	ldpsw	x14, x24, [x11, #-96]
    3d04:	685f6576 	.inst	0x685f6576 ; undefined
    3d08:	696d6d61 	ldpsw	x1, x27, [x11, #-152]
    3d0c:	0000676e 	udf	#26478
    3d10:	6e6f656e 	umax	v14.8h, v11.8h, v15.8h
    3d14:	63616a5f 	.inst	0x63616a5f ; undefined
    3d18:	64726163 	.inst	0x64726163 ; undefined
    3d1c:	00000000 	udf	#0
    3d20:	6974616e 	ldpsw	x14, x24, [x11, #-96]
    3d24:	6a5f6576 	ands	w22, w11, wzr, lsr #25
    3d28:	61636361 	.inst	0x61636361 ; undefined
    3d2c:	00006472 	udf	#25714
    3d30:	65747962 	fnmls	z2.h, p6/m, z11.h, z20.h
    3d34:	34253d73 	cbz	w19, 4e4e0 <__bss_end__+0x2e468>
    3d38:	48203a64 	.inst	0x48203a64 ; undefined
    3d3c:	696d6d61 	ldpsw	x1, x27, [x11, #-152]
    3d40:	253d676e 	psel	p14, p9, p11.b[w13, 3]
    3d44:	20756c35 	.inst	0x20756c35 ; undefined
    3d48:	6363614a 	.inst	0x6363614a ; undefined
    3d4c:	3d647261 	ldr	b1, [x19, #2332]
    3d50:	342e3625 	cbz	w5, 60414 <__bss_end__+0x4039c>
    3d54:	9ce22066 	ldr	q6, fffffffffffc8160 <__bss_end__+0xfffffffffffa80e8>
    3d58:	00000a93 	udf	#2707
    3d5c:	00000000 	udf	#0
    3d60:	3d3d3d0a 	str	b10, [x8, #3919]
    3d64:	72655020 	.inst	0x72655020 ; undefined
    3d68:	6d726f66 	ldp	d6, d27, [x27, #-224]
    3d6c:	65636e61 	fnmls	z1.h, p3/m, z19.h, z3.h
    3d70:	6e654220 	raddhn2	v0.8h, v17.4s, v5.4s
    3d74:	616d6863 	.inst	0x616d6863 ; undefined
    3d78:	3d206b72 	str	b18, [x27, #2074]
    3d7c:	00003d3d 	udf	#15677
    3d80:	7546207c 	.inst	0x7546207c ; undefined
    3d84:	2020636e 	.inst	0x2020636e ; undefined
    3d88:	207c2020 	.inst	0x207c2020 ; undefined
    3d8c:	206d6944 	.inst	0x206d6944 ; undefined
    3d90:	207c2020 	.inst	0x207c2020 ; undefined
    3d94:	6974614e 	ldpsw	x14, x24, [x10, #-96]
    3d98:	28206576 	stnp	w22, w25, [x11, #-256]
    3d9c:	20297375 	.inst	0x20297375 ; undefined
    3da0:	454e207c 	.inst	0x454e207c ; undefined
    3da4:	28204e4f 	stnp	w15, w19, [x18, #-256]
    3da8:	20297375 	.inst	0x20297375 ; undefined
    3dac:	7053207c 	adr	x28, aa1bb <__bss_end__+0x8a143>
    3db0:	75646565 	.inst	0x75646565 ; undefined
    3db4:	007c2070 	.inst	0x007c2070 ; undefined
    3db8:	2d2d2d7c 	stp	s28, s11, [x11, #-152]
    3dbc:	2d2d2d2d 	stp	s13, s11, [x9, #-152]
    3dc0:	2d7c2d2d 	ldp	s13, s11, [x9, #-32]
    3dc4:	2d2d2d2d 	stp	s13, s11, [x9, #-152]
    3dc8:	2d7c2d2d 	ldp	s13, s11, [x9, #-32]
    3dcc:	2d2d2d2d 	stp	s13, s11, [x9, #-152]
    3dd0:	2d2d2d2d 	stp	s13, s11, [x9, #-152]
    3dd4:	2d2d2d2d 	stp	s13, s11, [x9, #-152]
    3dd8:	2d2d2d7c 	stp	s28, s11, [x11, #-152]
    3ddc:	2d2d2d2d 	stp	s13, s11, [x9, #-152]
    3de0:	2d2d2d2d 	stp	s13, s11, [x9, #-152]
    3de4:	2d2d2d7c 	stp	s28, s11, [x11, #-152]
    3de8:	2d2d2d2d 	stp	s13, s11, [x9, #-152]
    3dec:	007c2d2d 	.inst	0x007c2d2d ; undefined
    3df0:	4556207c 	.inst	0x4556207c ; undefined
    3df4:	324c2d43 	.inst	0x324c2d43 ; undefined
    3df8:	207c2020 	.inst	0x207c2020 ; undefined
    3dfc:	20643525 	.inst	0x20643525 ; undefined
    3e00:	3125207c 	adds	w28, w3, #0x948
    3e04:	66322e31 	.inst	0x66322e31 ; undefined
    3e08:	25207c20 	.inst	0x25207c20 ; undefined
    3e0c:	66322e39 	.inst	0x66322e39 ; undefined
    3e10:	25207c20 	.inst	0x25207c20 ; undefined
    3e14:	66322e36 	.inst	0x66322e36 ; undefined
    3e18:	0a7c2078 	bic	w24, w3, w28, lsr #8
    3e1c:	00000000 	udf	#0
    3e20:	4148207c 	.inst	0x4148207c ; undefined
    3e24:	4c2d464c 	.inst	0x4c2d464c ; undefined
    3e28:	207c2032 	.inst	0x207c2032 ; undefined
    3e2c:	20643525 	.inst	0x20643525 ; undefined
    3e30:	3125207c 	adds	w28, w3, #0x948
    3e34:	66322e31 	.inst	0x66322e31 ; undefined
    3e38:	25207c20 	.inst	0x25207c20 ; undefined
    3e3c:	66322e39 	.inst	0x66322e39 ; undefined
    3e40:	25207c20 	.inst	0x25207c20 ; undefined
    3e44:	66322e36 	.inst	0x66322e36 ; undefined
    3e48:	0a7c2078 	bic	w24, w3, w28, lsr #8
    3e4c:	00000000 	udf	#0
    3e50:	4942207c 	.inst	0x4942207c ; undefined
    3e54:	41482d54 	.inst	0x41482d54 ; undefined
    3e58:	207c204d 	.inst	0x207c204d ; undefined
    3e5c:	20643525 	.inst	0x20643525 ; undefined
    3e60:	3125207c 	adds	w28, w3, #0x948
    3e64:	66322e31 	.inst	0x66322e31 ; undefined
    3e68:	25207c20 	.inst	0x25207c20 ; undefined
    3e6c:	66322e39 	.inst	0x66322e39 ; undefined
    3e70:	25207c20 	.inst	0x25207c20 ; undefined
    3e74:	66322e36 	.inst	0x66322e36 ; undefined
    3e78:	0a7c2078 	bic	w24, w3, w28, lsr #8
    3e7c:	00000000 	udf	#0
    3e80:	65766770 	fnmls	z16.h, p1/m, z27.h, z22.h
    3e84:	726f7463 	.inst	0x726f7463 ; undefined
    3e88:	4f454e20 	.inst	0x4f454e20 ; undefined
    3e8c:	704f204e 	adr	x14, a2297 <__bss_end__+0x8221f>
    3e90:	696d6974 	ldpsw	x20, x26, [x11, #-152]
    3e94:	6974617a 	ldpsw	x26, x24, [x11, #-96]
    3e98:	54206e6f 	b.nv	44c64 <__bss_end__+0x24bec>
    3e9c:	00747365 	.inst	0x00747365 ; undefined
    3ea0:	3d3d3d3d 	str	b29, [x9, #3919]
    3ea4:	3d3d3d3d 	str	b29, [x9, #3919]
    3ea8:	3d3d3d3d 	str	b29, [x9, #3919]
    3eac:	3d3d3d3d 	str	b29, [x9, #3919]
    3eb0:	3d3d3d3d 	str	b29, [x9, #3919]
    3eb4:	3d3d3d3d 	str	b29, [x9, #3919]
    3eb8:	3d3d3d3d 	str	b29, [x9, #3919]
    3ebc:	003d3d3d 	.inst	0x003d3d3d ; NYI
    3ec0:	4e4f454e 	.inst	0x4e4f454e ; undefined
    3ec4:	6e45203a 	.inst	0x6e45203a ; undefined
    3ec8:	656c6261 	fnmls	z1.h, p0/m, z19.h, z12.h
    3ecc:	00000064 	udf	#100
    3ed0:	3d3d3d0a 	str	b10, [x8, #3919]
    3ed4:	3d3d3d3d 	str	b29, [x9, #3919]
    3ed8:	3d3d3d3d 	str	b29, [x9, #3919]
    3edc:	3d3d3d3d 	str	b29, [x9, #3919]
    3ee0:	3d3d3d3d 	str	b29, [x9, #3919]
    3ee4:	3d3d3d3d 	str	b29, [x9, #3919]
    3ee8:	3d3d3d3d 	str	b29, [x9, #3919]
    3eec:	3d3d3d3d 	str	b29, [x9, #3919]
	...
    3ef8:	75736552 	.inst	0x75736552 ; undefined
    3efc:	3a73746c 	.inst	0x3a73746c ; undefined
    3f00:	20642520 	.inst	0x20642520 ; undefined
    3f04:	73736170 	.inst	0x73736170 ; undefined
    3f08:	202c6465 	.inst	0x202c6465 ; undefined
    3f0c:	66206425 	.inst	0x66206425 ; undefined
    3f10:	656c6961 	fnmls	z1.h, p2/m, z11.h, z12.h
    3f14:	00000a64 	udf	#2660
	...
    3f20:	80000000 	.inst	0x80000000 ; undefined
    3f24:	ffffffff 	.inst	0xffffffff ; undefined
    3f28:	80000000 	.inst	0x80000000 ; undefined
    3f2c:	ffffffff 	.inst	0xffffffff ; undefined
    3f30:	7fffffff 	.inst	0x7fffffff ; undefined
    3f34:	00000000 	udf	#0
    3f38:	7fffffff 	.inst	0x7fffffff ; undefined
    3f3c:	00000000 	udf	#0
    3f40:	00000001 	udf	#1
    3f44:	00000000 	udf	#0
    3f48:	00000001 	udf	#1
    3f4c:	00000000 	udf	#0
    3f50:	9908b0df 	stlur	wzr, [x6, #139]
    3f54:	00000000 	udf	#0
    3f58:	9908b0df 	stlur	wzr, [x6, #139]
    3f5c:	00000000 	udf	#0
    3f60:	a0b5ed8d 	.inst	0xa0b5ed8d ; undefined
    3f64:	3eb0c6f7 	.inst	0x3eb0c6f7 ; undefined
    3f68:	d9d7bdbb 	.inst	0xd9d7bdbb ; undefined
    3f6c:	3ddb7cdf 	ldr	q31, [x6, #28144]
    3f70:	00000080 	udf	#128
    3f74:	00000200 	udf	#512
    3f78:	00000004 	udf	#4
    3f7c:	00000010 	udf	#16
    3f80:	00000040 	udf	#64
    3f84:	00000100 	udf	#256
    3f88:	00000200 	udf	#512
    3f8c:	00000000 	udf	#0
    3f90:	00000008 	udf	#8
    3f94:	00000020 	udf	#32
    3f98:	00000080 	udf	#128
    3f9c:	00000200 	udf	#512
    3fa0:	00000400 	udf	#1024
	...

0000000000003fb0 <_ZL14popcount_table>:
    3fb0:	02010100 	.inst	0x02010100 ; undefined
    3fb4:	03020201 	.inst	0x03020201 ; undefined
    3fb8:	03020201 	.inst	0x03020201 ; undefined
    3fbc:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    3fc0:	03020201 	.inst	0x03020201 ; undefined
    3fc4:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    3fc8:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    3fcc:	05040403 	.inst	0x05040403 ; undefined
    3fd0:	03020201 	.inst	0x03020201 ; undefined
    3fd4:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    3fd8:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    3fdc:	05040403 	.inst	0x05040403 ; undefined
    3fe0:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    3fe4:	05040403 	.inst	0x05040403 ; undefined
    3fe8:	05040403 	.inst	0x05040403 ; undefined
    3fec:	06050504 	.inst	0x06050504 ; undefined
    3ff0:	03020201 	.inst	0x03020201 ; undefined
    3ff4:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    3ff8:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    3ffc:	05040403 	.inst	0x05040403 ; undefined
    4000:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    4004:	05040403 	.inst	0x05040403 ; undefined
    4008:	05040403 	.inst	0x05040403 ; undefined
    400c:	06050504 	.inst	0x06050504 ; undefined
    4010:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    4014:	05040403 	.inst	0x05040403 ; undefined
    4018:	05040403 	.inst	0x05040403 ; undefined
    401c:	06050504 	.inst	0x06050504 ; undefined
    4020:	05040403 	.inst	0x05040403 ; undefined
    4024:	06050504 	.inst	0x06050504 ; undefined
    4028:	06050504 	.inst	0x06050504 ; undefined
    402c:	07060605 	.inst	0x07060605 ; undefined
    4030:	03020201 	.inst	0x03020201 ; undefined
    4034:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    4038:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    403c:	05040403 	.inst	0x05040403 ; undefined
    4040:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    4044:	05040403 	.inst	0x05040403 ; undefined
    4048:	05040403 	.inst	0x05040403 ; undefined
    404c:	06050504 	.inst	0x06050504 ; undefined
    4050:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    4054:	05040403 	.inst	0x05040403 ; undefined
    4058:	05040403 	.inst	0x05040403 ; undefined
    405c:	06050504 	.inst	0x06050504 ; undefined
    4060:	05040403 	.inst	0x05040403 ; undefined
    4064:	06050504 	.inst	0x06050504 ; undefined
    4068:	06050504 	.inst	0x06050504 ; undefined
    406c:	07060605 	.inst	0x07060605 ; undefined
    4070:	04030302 	subr	z2.b, p0/m, z2.b, z24.b
    4074:	05040403 	.inst	0x05040403 ; undefined
    4078:	05040403 	.inst	0x05040403 ; undefined
    407c:	06050504 	.inst	0x06050504 ; undefined
    4080:	05040403 	.inst	0x05040403 ; undefined
    4084:	06050504 	.inst	0x06050504 ; undefined
    4088:	06050504 	.inst	0x06050504 ; undefined
    408c:	07060605 	.inst	0x07060605 ; undefined
    4090:	05040403 	.inst	0x05040403 ; undefined
    4094:	06050504 	.inst	0x06050504 ; undefined
    4098:	06050504 	.inst	0x06050504 ; undefined
    409c:	07060605 	.inst	0x07060605 ; undefined
    40a0:	06050504 	.inst	0x06050504 ; undefined
    40a4:	07060605 	.inst	0x07060605 ; undefined
    40a8:	07060605 	.inst	0x07060605 ; undefined
    40ac:	08070706 	stxrb	w7, w6, [x24]
    40b0:	02010100 	.inst	0x02010100 ; undefined
    40b4:	03020201 	.inst	0x03020201 ; undefined
    40b8:	03020201 	.inst	0x03020201 ; undefined
    40bc:	04030302 	subr	z2.b, p0/m, z2.b, z24.b

Disassembly of section .eh_frame_hdr:

00000000000040c0 <__GNU_EH_FRAME_HDR>:
    40c0:	3b031b01 	.inst	0x3b031b01 ; undefined
    40c4:	00000124 	udf	#292
    40c8:	00000023 	udf	#35
    40cc:	ffffc840 	.inst	0xffffc840 ; undefined
    40d0:	00000474 	udf	#1140
    40d4:	ffffc8c0 	.inst	0xffffc8c0 ; undefined
    40d8:	0000013c 	udf	#316
    40dc:	ffffc910 	.inst	0xffffc910 ; undefined
    40e0:	00000150 	udf	#336
    40e4:	ffffc940 	.inst	0xffffc940 ; undefined
    40e8:	00000164 	udf	#356
    40ec:	ffffc980 	.inst	0xffffc980 ; undefined
    40f0:	00000178 	udf	#376
    40f4:	ffffc9d0 	.inst	0xffffc9d0 ; undefined
    40f8:	0000019c 	udf	#412
    40fc:	ffffc9e0 	.inst	0xffffc9e0 ; undefined
    4100:	000001c4 	udf	#452
    4104:	ffffcb20 	.inst	0xffffcb20 ; undefined
    4108:	00000214 	udf	#532
    410c:	ffffce50 	.inst	0xffffce50 ; undefined
    4110:	0000027c 	udf	#636
    4114:	ffffd024 	.inst	0xffffd024 ; undefined
    4118:	000002f0 	udf	#752
    411c:	ffffd350 	.inst	0xffffd350 ; undefined
    4120:	00000358 	udf	#856
    4124:	ffffd4d4 	.inst	0xffffd4d4 ; undefined
    4128:	0000039c 	udf	#924
    412c:	ffffd570 	.inst	0xffffd570 ; undefined
    4130:	000003cc 	udf	#972
    4134:	ffffd784 	.inst	0xffffd784 ; undefined
    4138:	00000420 	udf	#1056
    413c:	ffffdc20 	.inst	0xffffdc20 ; undefined
    4140:	000001b0 	udf	#432
    4144:	ffffdd50 	.inst	0xffffdd50 ; undefined
    4148:	00000498 	udf	#1176
    414c:	ffffde80 	.inst	0xffffde80 ; undefined
    4150:	000004ac 	udf	#1196
    4154:	ffffdfb0 	.inst	0xffffdfb0 ; undefined
    4158:	000004c0 	udf	#1216
    415c:	ffffe124 	.inst	0xffffe124 ; undefined
    4160:	000004e0 	udf	#1248
    4164:	ffffe250 	.inst	0xffffe250 ; undefined
    4168:	000004f8 	udf	#1272
    416c:	ffffe400 	.inst	0xffffe400 ; undefined
    4170:	0000050c 	udf	#1292
    4174:	ffffe5a0 	.inst	0xffffe5a0 ; undefined
    4178:	00000520 	udf	#1312
    417c:	ffffe7c0 	.inst	0xffffe7c0 ; undefined
    4180:	00000540 	udf	#1344
    4184:	ffffe970 	.inst	0xffffe970 ; undefined
    4188:	00000558 	udf	#1368
    418c:	ffffeac0 	.inst	0xffffeac0 ; undefined
    4190:	0000056c 	udf	#1388
    4194:	ffffecb0 	.inst	0xffffecb0 ; undefined
    4198:	00000580 	udf	#1408
    419c:	ffffeef4 	.inst	0xffffeef4 ; undefined
    41a0:	00000594 	udf	#1428
    41a4:	fffff2f0 	.inst	0xfffff2f0 ; undefined
    41a8:	000005a8 	udf	#1448
    41ac:	fffff3d0 	.inst	0xfffff3d0 ; undefined
    41b0:	000005bc 	udf	#1468
    41b4:	fffff4a0 	.inst	0xfffff4a0 ; undefined
    41b8:	000005d0 	udf	#1488
    41bc:	fffff534 	.inst	0xfffff534 ; undefined
    41c0:	000005f0 	udf	#1520
    41c4:	fffff610 	.inst	0xfffff610 ; undefined
    41c8:	00000608 	udf	#1544
    41cc:	fffff760 	.inst	0xfffff760 ; undefined
    41d0:	0000061c 	udf	#1564
    41d4:	fffff890 	.inst	0xfffff890 ; undefined
    41d8:	00000630 	udf	#1584
    41dc:	fffff9b4 	.inst	0xfffff9b4 ; undefined
    41e0:	00000650 	udf	#1616

Disassembly of section .eh_frame:

00000000000041e8 <__FRAME_END__-0x53c>:
    41e8:	00000010 	udf	#16
    41ec:	00000000 	udf	#0
    41f0:	00527a01 	.inst	0x00527a01 ; undefined
    41f4:	011e7804 	.inst	0x011e7804 ; undefined
    41f8:	001f0c1b 	.inst	0x001f0c1b ; undefined
    41fc:	00000010 	udf	#16
    4200:	00000018 	udf	#24
    4204:	ffffc77c 	.inst	0xffffc77c ; undefined
    4208:	00000034 	udf	#52
    420c:	1e074100 	.inst	0x1e074100 ; undefined
    4210:	00000010 	udf	#16
    4214:	0000002c 	udf	#44
    4218:	ffffc7b8 	.inst	0xffffc7b8 ; undefined
    421c:	00000030 	udf	#48
    4220:	00000000 	udf	#0
    4224:	00000010 	udf	#16
    4228:	00000040 	udf	#64
    422c:	ffffc7d4 	.inst	0xffffc7d4 ; undefined
    4230:	0000003c 	udf	#60
    4234:	00000000 	udf	#0
    4238:	00000020 	udf	#32
    423c:	00000054 	udf	#84
    4240:	ffffc800 	.inst	0xffffc800 ; undefined
    4244:	00000048 	udf	#72
    4248:	200e4100 	.inst	0x200e4100 ; undefined
    424c:	039e049d 	.inst	0x039e049d ; undefined
    4250:	4e029342 	.inst	0x4e029342 ; undefined
    4254:	0ed3ddde 	.inst	0x0ed3ddde ; undefined
    4258:	00000000 	udf	#0
    425c:	00000010 	udf	#16
    4260:	00000078 	udf	#120
    4264:	ffffc82c 	.inst	0xffffc82c ; undefined
    4268:	00000004 	udf	#4
    426c:	00000000 	udf	#0
    4270:	00000010 	udf	#16
    4274:	0000008c 	udf	#140
    4278:	ffffda68 	.inst	0xffffda68 ; undefined
    427c:	00000128 	udf	#296
    4280:	00000000 	udf	#0
    4284:	0000004c 	udf	#76
    4288:	000000a0 	udf	#160
    428c:	ffffc814 	.inst	0xffffc814 ; undefined
    4290:	00000140 	udf	#320
    4294:	e00e4200 	ld1b	{za0h.b[w14, 0]}, p0/z, [x16, x14]
    4298:	fc9d4527 	.inst	0xfc9d4527 ; undefined
    429c:	04fb9e04 	lsl	z4.d, z16.d, #59
    42a0:	04fa9343 	asr	z3.d, z26.d, #6
    42a4:	4404f994 	.inst	0x4404f994 ; undefined
    42a8:	9604f895 	bl	fffffffff81424fc <__bss_end__+0xfffffffff8122484>
    42ac:	974d04f7 	bl	fffffffffd345688 <__bss_end__+0xfffffffffd325610>
    42b0:	054504f6 	.inst	0x054504f6 ; undefined
    42b4:	4204f54a 	.inst	0x4204f54a ; undefined
    42b8:	04f34905 	index	z5.d, #8, x19
    42bc:	04f44805 	index	z5.d, #0, x20
    42c0:	0641d766 	.inst	0x0641d766 ; undefined
    42c4:	41480649 	.inst	0x41480649 ; undefined
    42c8:	dd454a06 	.inst	0xdd454a06 ; undefined
    42cc:	d3d6d5de 	.inst	0xd3d6d5de ; undefined
    42d0:	00000ed4 	udf	#3796
    42d4:	00000064 	udf	#100
    42d8:	000000f0 	udf	#240
    42dc:	ffffc904 	.inst	0xffffc904 ; undefined
    42e0:	00000328 	udf	#808
    42e4:	b00e4100 	adrp	x0, 1c825000 <__bss_end__+0x1c804f88>
    42e8:	9e169d01 	.inst	0x9e169d01 ; undefined
    42ec:	14934515 	b	24d5740 <__bss_end__+0x24b56c8>
    42f0:	12951394 	mov	w20, #0xffff5763            	// #-43165
    42f4:	97421196 	bl	fffffffffd08894c <__bss_end__+0xfffffffffd0688d4>
    42f8:	420f9810 	.inst	0x420f9810 ; undefined
    42fc:	0d9a0e99 	st1	{v25.b}[3], [x20], x26
    4300:	0c480546 	.inst	0x0c480546 ; undefined
    4304:	050b4905 	.inst	0x050b4905 ; undefined
    4308:	4b050a4a 	sub	w10, w18, w5, lsl #2
    430c:	084c0509 	ldxrb	w9, [x8]
    4310:	05074d05 	.inst	0x05074d05 ; undefined
    4314:	4f05064e 	movi	v14.4s, #0xb2
    4318:	0a7a0205 	bic	w5, w16, w26, lsr #0
    431c:	dad9ddde 	.inst	0xdad9ddde ; undefined
    4320:	d6d5d8d7 	.inst	0xd6d5d8d7 ; undefined
    4324:	4e06d4d3 	.inst	0x4e06d4d3 ; undefined
    4328:	4c064f06 	.inst	0x4c064f06 ; undefined
    432c:	4a064d06 	eor	w6, w8, w6, lsl #19
    4330:	48064b06 	stxrh	w6, w6, [x24]
    4334:	000e4906 	.inst	0x000e4906 ; undefined
    4338:	00000b41 	udf	#2881
    433c:	00000070 	udf	#112
    4340:	00000158 	udf	#344
    4344:	ffffcbcc 	.inst	0xffffcbcc ; undefined
    4348:	000001d4 	udf	#468
    434c:	e00e4200 	ld1b	{za0h.b[w14, 0]}, p0/z, [x16, x14]
    4350:	fc9d4527 	.inst	0xfc9d4527 ; undefined
    4354:	04fb9e04 	lsl	z4.d, z16.d, #59
    4358:	04fa9343 	asr	z3.d, z26.d, #6
    435c:	4404f994 	.inst	0x4404f994 ; undefined
    4360:	9604f895 	bl	fffffffff81425b4 <__bss_end__+0xfffffffff812253c>
    4364:	974f04f7 	bl	fffffffffd3c5740 <__bss_end__+0xfffffffffd3a56c8>
    4368:	054204f6 	eor	z22.d, z22.d, #0xffffffffff
    436c:	4204f54a 	.inst	0x4204f54a ; undefined
    4370:	04f34905 	index	z5.d, #8, x19
    4374:	04f44805 	index	z5.d, #0, x20
    4378:	0641d769 	.inst	0x0641d769 ; undefined
    437c:	41480649 	.inst	0x41480649 ; undefined
    4380:	dd454a06 	.inst	0xdd454a06 ; undefined
    4384:	d3d6d5de 	.inst	0xd3d6d5de ; undefined
    4388:	41000ed4 	.inst	0x41000ed4 ; undefined
    438c:	9327e00e 	.inst	0x9327e00e ; undefined
    4390:	f99404fa 	prfm	#0x1a, [x7, #10248]
    4394:	04f89504 	lsr	z4.d, z8.d, #8
    4398:	9704f796 	bl	fffffffffc1421f0 <__bss_end__+0xfffffffffc122178>
    439c:	fc9d04f6 	.inst	0xfc9d04f6 ; undefined
    43a0:	04fb9e04 	lsl	z4.d, z16.d, #59
    43a4:	04f44805 	index	z5.d, #0, x20
    43a8:	04f34905 	index	z5.d, #8, x19
    43ac:	04f54a05 	index	z5.d, #-16, x21
    43b0:	00000064 	udf	#100
    43b4:	000001cc 	udf	#460
    43b8:	ffffcd2c 	.inst	0xffffcd2c ; undefined
    43bc:	0000032c 	udf	#812
    43c0:	b00e4100 	adrp	x0, 1c825000 <__bss_end__+0x1c804f88>
    43c4:	9e169d01 	.inst	0x9e169d01 ; undefined
    43c8:	14934515 	b	24d581c <__bss_end__+0x24b57a4>
    43cc:	12951394 	mov	w20, #0xffff5763            	// #-43165
    43d0:	97421196 	bl	fffffffffd088a28 <__bss_end__+0xfffffffffd0689b0>
    43d4:	420f9810 	.inst	0x420f9810 ; undefined
    43d8:	0d9a0e99 	st1	{v25.b}[3], [x20], x26
    43dc:	0c480546 	.inst	0x0c480546 ; undefined
    43e0:	050b4905 	.inst	0x050b4905 ; undefined
    43e4:	4b050a4a 	sub	w10, w18, w5, lsl #2
    43e8:	084c0509 	ldxrb	w9, [x8]
    43ec:	05074d05 	.inst	0x05074d05 ; undefined
    43f0:	4f05064e 	movi	v14.4s, #0xb2
    43f4:	0a7b0205 	bic	w5, w16, w27, lsr #0
    43f8:	dad9ddde 	.inst	0xdad9ddde ; undefined
    43fc:	d6d5d8d7 	.inst	0xd6d5d8d7 ; undefined
    4400:	4e06d4d3 	.inst	0x4e06d4d3 ; undefined
    4404:	4c064f06 	.inst	0x4c064f06 ; undefined
    4408:	4a064d06 	eor	w6, w8, w6, lsl #19
    440c:	48064b06 	stxrh	w6, w6, [x24]
    4410:	000e4906 	.inst	0x000e4906 ; undefined
    4414:	00000b41 	udf	#2881
    4418:	00000040 	udf	#64
    441c:	00000234 	udf	#564
    4420:	ffffcff0 	.inst	0xffffcff0 ; undefined
    4424:	00000184 	udf	#388
    4428:	400e4100 	.inst	0x400e4100 ; undefined
    442c:	079e089d 	.inst	0x079e089d ; undefined
    4430:	94069344 	bl	1a9140 <__bss_end__+0x1890c8>
    4434:	96049505 	bl	fffffffff8129848 <__bss_end__+0xfffffffff81097d0>
    4438:	02974203 	.inst	0x02974203 ; undefined
    443c:	0a620198 	bic	w24, w12, w2, lsr #0
    4440:	d8d7ddde 	prfm	#0x1e, fffffffffffb3ff8 <__bss_end__+0xfffffffffff93f80>
    4444:	d4d3d6d5 	.inst	0xd4d3d6d5 ; undefined
    4448:	0b41000e 	add	w14, w0, w1, lsr #0
    444c:	ddde0a73 	.inst	0xddde0a73 ; undefined
    4450:	d6d5d8d7 	.inst	0xd6d5d8d7 ; undefined
    4454:	000ed4d3 	.inst	0x000ed4d3 ; undefined
    4458:	00000b41 	udf	#2881
    445c:	0000002c 	udf	#44
    4460:	00000278 	udf	#632
    4464:	ffffd130 	.inst	0xffffd130 ; undefined
    4468:	00000098 	udf	#152
    446c:	c00e4200 	.inst	0xc00e4200 ; undefined
    4470:	f89d4527 	.inst	0xf89d4527 ; undefined
    4474:	04f79e04 	lsl	z4.d, z16.d, #55
    4478:	04f69343 	asr	z3.d, z26.d, #10
    447c:	4d04f594 	.inst	0x4d04f594 ; undefined
    4480:	4a04f495 	.inst	0x4a04f495 ; undefined
    4484:	dedd44d5 	.inst	0xdedd44d5 ; undefined
    4488:	000ed4d3 	.inst	0x000ed4d3 ; undefined
    448c:	00000050 	udf	#80
    4490:	000002a8 	udf	#680
    4494:	ffffd19c 	.inst	0xffffd19c ; undefined
    4498:	00000214 	udf	#532
    449c:	b00e4100 	adrp	x0, 1c825000 <__bss_end__+0x1c804f88>
    44a0:	9e169d01 	.inst	0x9e169d01 ; undefined
    44a4:	14934615 	b	24d5cf8 <__bss_end__+0x24b5c80>
    44a8:	12951394 	mov	w20, #0xffff5763            	// #-43165
    44ac:	10971196 	adr	x22, fffffffffff326dc <__bss_end__+0xfffffffffff12664>
    44b0:	99420f98 	.inst	0x99420f98 ; undefined
    44b4:	440d9a0e 	uqshlr	z14.b, p6/m, z14.b, z16.b
    44b8:	0b9c0c9b 	add	w27, w4, w28, asr #3
    44bc:	0a480544 	and	w4, w10, w8, lsr #1
    44c0:	05094905 	.inst	0x05094905 ; undefined
    44c4:	5702084a 	.inst	0x5702084a ; undefined
    44c8:	dbddde0a 	.inst	0xdbddde0a ; undefined
    44cc:	d7dad9dc 	.inst	0xd7dad9dc ; undefined
    44d0:	d3d6d5d8 	.inst	0xd3d6d5d8 ; undefined
    44d4:	064a06d4 	.inst	0x064a06d4 ; undefined
    44d8:	0e490648 	fmaxnm	v8.4h, v18.4h, v9.4h
    44dc:	000b4100 	.inst	0x000b4100 ; undefined
    44e0:	00000050 	udf	#80
    44e4:	000002fc 	udf	#764
    44e8:	ffffd35c 	.inst	0xffffd35c ; undefined
    44ec:	00000490 	udf	#1168
    44f0:	a00e4100 	.inst	0xa00e4100 ; undefined
    44f4:	9e149d01 	.inst	0x9e149d01 ; undefined
    44f8:	12934613 	mov	w19, #0xffff65cf            	// #-39473
    44fc:	10951194 	adr	x20, fffffffffff2e72c <__bss_end__+0xfffffffffff0e6b4>
    4500:	0e970f96 	.inst	0x0e970f96 ; undefined
    4504:	99430d98 	.inst	0x99430d98 ; undefined
    4508:	460b9a0c 	.inst	0x460b9a0c ; undefined
    450c:	099c0a9b 	.inst	0x099c0a9b ; undefined
    4510:	05084805 	.inst	0x05084805 ; undefined
    4514:	4a050749 	eor	w9, w26, w5, lsl #1
    4518:	01120306 	.inst	0x01120306 ; undefined
    451c:	dbddde0a 	.inst	0xdbddde0a ; undefined
    4520:	d7dad9dc 	.inst	0xd7dad9dc ; undefined
    4524:	d3d6d5d8 	.inst	0xd3d6d5d8 ; undefined
    4528:	064a06d4 	.inst	0x064a06d4 ; undefined
    452c:	0e490648 	fmaxnm	v8.4h, v18.4h, v9.4h
    4530:	000b4100 	.inst	0x000b4100 ; undefined
    4534:	00000020 	udf	#32
    4538:	00000350 	udf	#848
    453c:	ffffc3c4 	.inst	0xffffc3c4 ; undefined
    4540:	00000080 	udf	#128
    4544:	200e4100 	.inst	0x200e4100 ; undefined
    4548:	039e049d 	.inst	0x039e049d ; undefined
    454c:	5a029344 	.inst	0x5a029344 ; undefined
    4550:	0ed3ddde 	.inst	0x0ed3ddde ; undefined
    4554:	00000000 	udf	#0
    4558:	00000010 	udf	#16
    455c:	00000374 	udf	#884
    4560:	ffffd8b0 	.inst	0xffffd8b0 ; undefined
    4564:	00000130 	udf	#304
    4568:	00000000 	udf	#0
    456c:	00000010 	udf	#16
    4570:	00000388 	udf	#904
    4574:	ffffd9cc 	.inst	0xffffd9cc ; undefined
    4578:	0000012c 	udf	#300
    457c:	00000000 	udf	#0
    4580:	0000001c 	udf	#28
    4584:	0000039c 	udf	#924
    4588:	ffffdae8 	.inst	0xffffdae8 ; undefined
    458c:	00000174 	udf	#372
    4590:	200e7900 	.inst	0x200e7900 ; undefined
    4594:	039e049d 	.inst	0x039e049d ; undefined
    4598:	0eddde45 	.inst	0x0eddde45 ; undefined
    459c:	00000000 	udf	#0
    45a0:	00000014 	udf	#20
    45a4:	000003bc 	udf	#956
    45a8:	ffffdc3c 	.inst	0xffffdc3c ; undefined
    45ac:	0000012c 	udf	#300
	...
    45b8:	00000010 	udf	#16
    45bc:	000003d4 	udf	#980
    45c0:	ffffdd50 	.inst	0xffffdd50 ; undefined
    45c4:	000001ac 	udf	#428
    45c8:	00000000 	udf	#0
    45cc:	00000010 	udf	#16
    45d0:	000003e8 	udf	#1000
    45d4:	ffffdeec 	.inst	0xffffdeec ; undefined
    45d8:	000001a0 	udf	#416
    45dc:	00000000 	udf	#0
    45e0:	0000001c 	udf	#28
    45e4:	000003fc 	udf	#1020
    45e8:	ffffe078 	.inst	0xffffe078 ; undefined
    45ec:	00000218 	udf	#536
    45f0:	0e5b0200 	.inst	0x0e5b0200 ; undefined
    45f4:	9e049d20 	.inst	0x9e049d20 ; undefined
    45f8:	ddde4503 	.inst	0xddde4503 ; undefined
    45fc:	0000000e 	udf	#14
    4600:	00000014 	udf	#20
    4604:	0000041c 	udf	#1052
    4608:	ffffe278 	.inst	0xffffe278 ; undefined
    460c:	000001a4 	udf	#420
	...
    4618:	00000010 	udf	#16
    461c:	00000434 	udf	#1076
    4620:	ffffe410 	.inst	0xffffe410 ; undefined
    4624:	0000014c 	udf	#332
    4628:	00000000 	udf	#0
    462c:	00000010 	udf	#16
    4630:	00000448 	udf	#1096
    4634:	ffffe54c 	.inst	0xffffe54c ; undefined
    4638:	000001ec 	udf	#492
    463c:	00000000 	udf	#0
    4640:	00000010 	udf	#16
    4644:	0000045c 	udf	#1116
    4648:	ffffe728 	.inst	0xffffe728 ; undefined
    464c:	00000244 	udf	#580
    4650:	00000000 	udf	#0
    4654:	00000010 	udf	#16
    4658:	00000470 	udf	#1136
    465c:	ffffe958 	.inst	0xffffe958 ; undefined
    4660:	000003fc 	udf	#1020
    4664:	00000000 	udf	#0
    4668:	00000010 	udf	#16
    466c:	00000484 	udf	#1156
    4670:	ffffed40 	.inst	0xffffed40 ; undefined
    4674:	000000dc 	udf	#220
    4678:	00000000 	udf	#0
    467c:	00000010 	udf	#16
    4680:	00000498 	udf	#1176
    4684:	ffffee0c 	.inst	0xffffee0c ; undefined
    4688:	000000cc 	udf	#204
    468c:	00000000 	udf	#0
    4690:	0000001c 	udf	#28
    4694:	000004ac 	udf	#1196
    4698:	ffffeec8 	.inst	0xffffeec8 ; undefined
    469c:	00000094 	udf	#148
    46a0:	200e5700 	.inst	0x200e5700 ; undefined
    46a4:	039e049d 	.inst	0x039e049d ; undefined
    46a8:	0eddde45 	.inst	0x0eddde45 ; undefined
    46ac:	00000000 	udf	#0
    46b0:	00000014 	udf	#20
    46b4:	000004cc 	udf	#1228
    46b8:	ffffef3c 	.inst	0xffffef3c ; undefined
    46bc:	000000d4 	udf	#212
	...
    46c8:	00000010 	udf	#16
    46cc:	000004e4 	udf	#1252
    46d0:	fffff000 	.inst	0xfffff000 ; undefined
    46d4:	00000148 	udf	#328
    46d8:	00000000 	udf	#0
    46dc:	00000010 	udf	#16
    46e0:	000004f8 	udf	#1272
    46e4:	fffff13c 	.inst	0xfffff13c ; undefined
    46e8:	00000130 	udf	#304
    46ec:	00000000 	udf	#0
    46f0:	0000001c 	udf	#28
    46f4:	0000050c 	udf	#1292
    46f8:	fffff258 	.inst	0xfffff258 ; undefined
    46fc:	00000124 	udf	#292
    4700:	200e7600 	.inst	0x200e7600 ; undefined
    4704:	039e049d 	.inst	0x039e049d ; undefined
    4708:	0eddde45 	.inst	0x0eddde45 ; undefined
    470c:	00000000 	udf	#0
    4710:	00000010 	udf	#16
    4714:	0000052c 	udf	#1324
    4718:	fffff35c 	.inst	0xfffff35c ; undefined
    471c:	00000138 	udf	#312
    4720:	00000000 	udf	#0

0000000000004724 <__FRAME_END__>:
    4724:	00000000 	udf	#0

Disassembly of section .init_array:

000000000001fda8 <__frame_dummy_init_array_entry>:
   1fda8:	00000a90 	udf	#2704
   1fdac:	00000000 	udf	#0

Disassembly of section .fini_array:

000000000001fdb0 <__do_global_dtors_aux_fini_array_entry>:
   1fdb0:	00000a40 	udf	#2624
   1fdb4:	00000000 	udf	#0

Disassembly of section .dynamic:

000000000001fdb8 <.dynamic>:
   1fdb8:	00000001 	udf	#1
   1fdbc:	00000000 	udf	#0
   1fdc0:	000000d1 	udf	#209
   1fdc4:	00000000 	udf	#0
   1fdc8:	00000001 	udf	#1
   1fdcc:	00000000 	udf	#0
   1fdd0:	000000e0 	udf	#224
   1fdd4:	00000000 	udf	#0
   1fdd8:	00000001 	udf	#1
   1fddc:	00000000 	udf	#0
   1fde0:	000000ea 	udf	#234
   1fde4:	00000000 	udf	#0
   1fde8:	0000000c 	udf	#12
   1fdec:	00000000 	udf	#0
   1fdf0:	000007e8 	udf	#2024
   1fdf4:	00000000 	udf	#0
   1fdf8:	0000000d 	udf	#13
   1fdfc:	00000000 	udf	#0
   1fe00:	00003bac 	udf	#15276
   1fe04:	00000000 	udf	#0
   1fe08:	00000019 	udf	#25
   1fe0c:	00000000 	udf	#0
   1fe10:	0001fda8 	.inst	0x0001fda8 ; undefined
   1fe14:	00000000 	udf	#0
   1fe18:	0000001b 	udf	#27
   1fe1c:	00000000 	udf	#0
   1fe20:	00000008 	udf	#8
   1fe24:	00000000 	udf	#0
   1fe28:	0000001a 	udf	#26
   1fe2c:	00000000 	udf	#0
   1fe30:	0001fdb0 	.inst	0x0001fdb0 ; undefined
   1fe34:	00000000 	udf	#0
   1fe38:	0000001c 	udf	#28
   1fe3c:	00000000 	udf	#0
   1fe40:	00000008 	udf	#8
   1fe44:	00000000 	udf	#0
   1fe48:	6ffffef5 	.inst	0x6ffffef5 ; undefined
   1fe4c:	00000000 	udf	#0
   1fe50:	00000298 	udf	#664
   1fe54:	00000000 	udf	#0
   1fe58:	00000005 	udf	#5
   1fe5c:	00000000 	udf	#0
   1fe60:	00000438 	udf	#1080
   1fe64:	00000000 	udf	#0
   1fe68:	00000006 	udf	#6
   1fe6c:	00000000 	udf	#0
   1fe70:	000002b8 	udf	#696
   1fe74:	00000000 	udf	#0
   1fe78:	0000000a 	udf	#10
   1fe7c:	00000000 	udf	#0
   1fe80:	00000132 	udf	#306
   1fe84:	00000000 	udf	#0
   1fe88:	0000000b 	udf	#11
   1fe8c:	00000000 	udf	#0
   1fe90:	00000018 	udf	#24
   1fe94:	00000000 	udf	#0
   1fe98:	00000015 	udf	#21
	...
   1fea8:	00000003 	udf	#3
   1feac:	00000000 	udf	#0
   1feb0:	0001ffe8 	.inst	0x0001ffe8 ; undefined
   1feb4:	00000000 	udf	#0
   1feb8:	00000002 	udf	#2
   1febc:	00000000 	udf	#0
   1fec0:	00000108 	udf	#264
   1fec4:	00000000 	udf	#0
   1fec8:	00000014 	udf	#20
   1fecc:	00000000 	udf	#0
   1fed0:	00000007 	udf	#7
   1fed4:	00000000 	udf	#0
   1fed8:	00000017 	udf	#23
   1fedc:	00000000 	udf	#0
   1fee0:	000006e0 	udf	#1760
   1fee4:	00000000 	udf	#0
   1fee8:	00000007 	udf	#7
   1feec:	00000000 	udf	#0
   1fef0:	00000620 	udf	#1568
   1fef4:	00000000 	udf	#0
   1fef8:	00000008 	udf	#8
   1fefc:	00000000 	udf	#0
   1ff00:	000000c0 	udf	#192
   1ff04:	00000000 	udf	#0
   1ff08:	00000009 	udf	#9
   1ff0c:	00000000 	udf	#0
   1ff10:	00000018 	udf	#24
   1ff14:	00000000 	udf	#0
   1ff18:	6ffffffb 	.inst	0x6ffffffb ; undefined
   1ff1c:	00000000 	udf	#0
   1ff20:	08000000 	stxrb	w0, w0, [x0]
   1ff24:	00000000 	udf	#0
   1ff28:	6ffffffe 	.inst	0x6ffffffe ; undefined
   1ff2c:	00000000 	udf	#0
   1ff30:	00000590 	udf	#1424
   1ff34:	00000000 	udf	#0
   1ff38:	6fffffff 	.inst	0x6fffffff ; undefined
   1ff3c:	00000000 	udf	#0
   1ff40:	00000003 	udf	#3
   1ff44:	00000000 	udf	#0
   1ff48:	6ffffff0 	.inst	0x6ffffff0 ; undefined
   1ff4c:	00000000 	udf	#0
   1ff50:	0000056a 	udf	#1386
   1ff54:	00000000 	udf	#0
   1ff58:	6ffffff9 	.inst	0x6ffffff9 ; undefined
   1ff5c:	00000000 	udf	#0
   1ff60:	00000004 	udf	#4
	...

Disassembly of section .got:

000000000001ffb8 <.got>:
   1ffb8:	0001fdb8 	.inst	0x0001fdb8 ; undefined
   1ffbc:	00000000 	udf	#0
   1ffc0:	00000900 	udf	#2304
	...

Disassembly of section .got.plt:

000000000001ffe8 <.got.plt>:
	...
   20000:	00000800 	udf	#2048
   20004:	00000000 	udf	#0
   20008:	00000800 	udf	#2048
   2000c:	00000000 	udf	#0
   20010:	00000800 	udf	#2048
   20014:	00000000 	udf	#0
   20018:	00000800 	udf	#2048
   2001c:	00000000 	udf	#0
   20020:	00000800 	udf	#2048
   20024:	00000000 	udf	#0
   20028:	00000800 	udf	#2048
   2002c:	00000000 	udf	#0
   20030:	00000800 	udf	#2048
   20034:	00000000 	udf	#0
   20038:	00000800 	udf	#2048
   2003c:	00000000 	udf	#0
   20040:	00000800 	udf	#2048
   20044:	00000000 	udf	#0
   20048:	00000800 	udf	#2048
   2004c:	00000000 	udf	#0
   20050:	00000800 	udf	#2048
   20054:	00000000 	udf	#0

Disassembly of section .data:

0000000000020058 <__data_start>:
	...

0000000000020060 <__dso_handle>:
   20060:	00020060 	.inst	0x00020060 ; undefined
   20064:	00000000 	udf	#0

Disassembly of section .bss:

0000000000020068 <completed.0>:
   20068:	00000000 	udf	#0

000000000002006c <failures>:
   2006c:	00000000 	udf	#0

0000000000020070 <passes>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347 	ccmn	w26, w3, #0x7, mi	// mi = first
   4:	65442820 	fmaxnmv	h0, p2, z1.h
   8:	6e616962 	fcvtxn2	v2.4s, v11.2d
   c:	2e323120 	usubw	v0.8h, v9.8h, v18.8b
  10:	2d302e32 	stp	s18, s11, [x17, #-128]
  14:	642b3431 	.inst	0x642b3431 ; undefined
  18:	32316265 	orr	w5, w19, #0xffff80ff
  1c:	20293175 	.inst	0x20293175 ; undefined
  20:	322e3231 	orr	w17, w17, #0x7ffc0000
  24:	Address 0x24 is out of bounds.

