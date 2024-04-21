# 0 "head.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4



















# 45 "/usr/include/stdc-predef.h" 3 4

# 55 "/usr/include/stdc-predef.h" 3 4









# 0 "<command-line>" 2
# 1 "head.S"













.text


# 1 "defs.h" 1
 





















# 17 "head.S" 2

# 1 "config.h" 1

# 13 "config.h"





















 





 












# 18 "head.S" 2

# 1 "test.h" 1






# 16 "test.h"

# 19 "head.S" 2

	.code32
	.globl startup_32
startup_32:
	cld
	cli

	
	testl	%esp, %esp
	jnz 0f
	movl	$(0x00010000 + _GLOBAL_OFFSET_TABLE_), %esp
	leal	boot_stack_top@GOTOFF(%esp), %esp
0:

	
	call	0f
0:	popl	%ebx
	addl	$_GLOBAL_OFFSET_TABLE_+[.-0b], %ebx

	
	leal	boot_stack_top@GOTOFF(%ebx), %esp

	
	leal	gdt@GOTOFF(%ebx), %eax
	movl	%eax, 2 + gdt_descr@GOTOFF(%ebx)
	lgdt	gdt_descr@GOTOFF(%ebx)
	leal	flush@GOTOFF(%ebx), %eax
	pushl	$0x10
	pushl	%eax
	lret
flush:	movl	$0x18, %eax
	movw	%ax, %ds
	movw	%ax, %es
	movw	%ax, %fs
	movw	%ax, %gs
	movw	%ax, %ss




	cmpl	$1, zerobss@GOTOFF(%ebx)
	jnz	zerobss_done
	xorl	%eax, %eax
	leal	_bss@GOTOFF(%ebx), %edi
	leal	_end@GOTOFF(%ebx), %ecx
	subl	%edi, %ecx
1:	movl	%eax, (%edi)
	addl	$4, %edi
	subl	$4, %ecx
	jnz	1b
	movl	$0, zerobss@GOTOFF(%ebx)
zerobss_done:




	leal	idt@GOTOFF(%ebx), %edi

	leal	vec0@GOTOFF(%ebx), %edx
	movl	$(0x10 << 16),%eax
	movw	%dx, %ax	
	movw	$0x8E00, %dx	
	movl	%eax, (%edi)
	movl	%edx, 4(%edi)
	addl	$8, %edi

	leal	vec1@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec2@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec3@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec4@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec5@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec6@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec7@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec8@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec9@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec10@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec11@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec12@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec13@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec14@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec15@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec16@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec17@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec18@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	leal	vec19@GOTOFF(%ebx),%edx
	movl	$(0x10 << 16),%eax
	movw	%dx,%ax		   
	movw	$0x8E00,%dx	   
	movl	%eax,(%edi)
	movl	%edx,4(%edi)
	addl	$8,%edi

	
	leal	idt@GOTOFF(%ebx), %eax
	movl	%eax, 2 + idt_descr@GOTOFF(%ebx)
	lidt	idt_descr@GOTOFF(%ebx)

	leal	_dl_start@GOTOFF(%ebx), %eax
	call	*%eax

	 
	finit

	call	test_start

	
	pushfl
	pushl	%cs
	call	0f
0:	pushl	$0 
	pushl	$257 
	jmp	int_hand

vec0:
	pushl	$0 
	pushl	$0 
	jmp int_hand
vec1:
	pushl	$0 
	pushl	$1 
	jmp int_hand

vec2:
	pushl	$0 
	pushl	$2 
	jmp int_hand

vec3:
	pushl	$0 
	pushl	$3 
	jmp	int_hand

vec4:
	pushl	$0 
	pushl	$4 
	jmp	int_hand

vec5:
	pushl	$0 
	pushl	$5 
	jmp	int_hand

vec6:
	pushl	$0 
	pushl	$6 
	jmp	int_hand

vec7:
	pushl	$0 
	pushl	$7 
	jmp	int_hand

vec8:
	
	pushl	$8 
	jmp	int_hand

vec9:
	pushl	$0 
	pushl	$9 
	jmp int_hand

vec10:
	
	pushl	$10 
	jmp	int_hand

vec11:
	
	pushl	$11 
	jmp	int_hand

vec12:
	
	pushl	$12 
	jmp	int_hand

vec13:
	
	pushl	$13 
	jmp	int_hand

vec14:
	
	pushl	$14 
	jmp	int_hand

vec15:
	pushl	$0 
	pushl	$15 
	jmp	int_hand

vec16:
	pushl	$0 
	pushl	$16 
	jmp	int_hand

vec17:
	
	pushl	$17 
	jmp	int_hand

vec18:
	pushl	$0 
	pushl	$18 
	jmp	int_hand

vec19:
	pushl	$0 
	pushl	$19 
	jmp	int_hand

int_hand:
	pushl	%eax
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%edi
	pushl	%esi
	pushl	%ebp

	
	leal	48(%esp), %eax
	pushl	%eax
	pushl	%ds  
	pushl	%ss 
	pushl	%esp 
	call	inter
	addl	$8, %esp

	popl	%ebp
	popl	%esi
	popl	%edi
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%eax
	iret




.align 4
.word 0
idt_descr:
	.word 20*8-1	       # idt contains 32 entries
	.long 0

idt:
	.fill 20,8,0	       # idt is uninitialized

gdt_descr:
	.word gdt_end - gdt - 1
	.long 0

.align 4
.globl gdt, gdt_end
gdt:
	.quad 0x0000000000000000	
	.quad 0x0000000000000000	
	.quad 0x00cf9b000000ffff	
	.quad 0x00cf93000000ffff	

	.word	0xFFFF				# 16bit 64KB - (0x10000*1 = 64KB)
	.word	0				# base address = (0x9000+0x20)
	.byte	0x00, 0x9b			# code read/exec/accessed
	.byte	0x00, 0x00			# granularity = bytes


	.word	0xFFFF				# 16bit 64KB - (0x10000*1 = 64KB)
	.word	0				# base address = (0x9000+0x20)
	.byte	0x00, 0x93			# data read/write/accessed
	.byte	0x00, 0x00			# granularity = bytes

gdt_end:

.data

.macro ptes64 start, count=64
.quad \start + 0x0000000 + 0xE3
.quad \start + 0x0200000 + 0xE3
.quad \start + 0x0400000 + 0xE3
.quad \start + 0x0600000 + 0xE3
.quad \start + 0x0800000 + 0xE3
.quad \start + 0x0A00000 + 0xE3
.quad \start + 0x0C00000 + 0xE3
.quad \start + 0x0E00000 + 0xE3
.if \count-1
ptes64 "(\start+0x01000000)",\count-1
.endif
.endm

.macro maxdepth depth=1
.if \depth-1
maxdepth \depth-1
.endif
.endm

maxdepth

# Page Directory Tables:
# There are 4 tables, the first two map the first 2 GB of memory. The last two are used with # PAE to map
# the rest of memory in 2 GB segments. The last two tables are changed in vmem.c to map each segment.
# We use 2 MB pages so only the Page Directory Table is used (no page tables). 
.balign 4096
.globl pd0
pd0:
	ptes64 0x0000000000000000

.balign 4096
.globl pd1
pd1:
	ptes64 0x0000000040000000

.balign 4096
.globl pd2
pd2:
	ptes64 0x0000000080000000

.balign 4096
.globl pd3
pd3:
	ptes64 0x00000000C0000000

# Legacy Mode Page Directory Pointer Table:
# 4 Entries, pointing to the Page Directory Tables
.balign 4096
.globl pdp
pdp:
	.long pd0 + 1
	.long 0
	.long pd1 + 1
	.long 0
	.long pd2 + 1
	.long 0
	.long pd3 + 1
	.long 0

# Long Mode Page Directory Pointer Table:
# 4 Entries, pointing to the Page Directory Tables
.balign 4096
lpdp:
	.long pd0 + 3
	.long 0
	.long pd1 + 3
	.long 0
	.long pd2 + 3
	.long 0
	.long pd3 + 3
	.long 0


# The long mode level 4 page map table
.balign 4096
.globl pml4
pml4:
	.long lpdp + 3
	.long 0
.previous



	.globl query_pcbios
query_pcbios:
	
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	pushl	%ebp
	call	1f
1:	popl	%ebx
	addl	$_GLOBAL_OFFSET_TABLE_+[.-1b], %ebx

	
	leal	startup_32@GOTOFF(%ebx), %esi

	
	movl	%esi, %eax
	shrl	$4, %eax
	movw	%ax, 2 + realptr@GOTOFF(%ebx)

	
	leal	prot@GOTOFF(%ebx), %eax
	movl	%eax, protptr@GOTOFF(%ebx)

	
	movl	%esi, %eax
	shll	$16, %eax	# Base low

	movl	%esi, %ecx
	shrl	$16, %ecx
	andl	$0xff, %ecx

	movl	%esi, %edx
	andl	$0xff000000, %edx
	orl	%edx, %ecx

	
	andl	$0x0000ffff, 0x20 + 0 + gdt@GOTOFF(%ebx)
	orl	%eax,        0x20 + 0 + gdt@GOTOFF(%ebx)
	andl	$0x00ffff00, 0x20 + 4 + gdt@GOTOFF(%ebx)
	orl	%ecx,        0x20 + 4 + gdt@GOTOFF(%ebx)
	andl	$0x0000ffff, 0x28 + 0 + gdt@GOTOFF(%ebx)
	orl	%eax,        0x28 + 0 + gdt@GOTOFF(%ebx)
	andl	$0x00ffff00, 0x28 + 4 + gdt@GOTOFF(%ebx)
	orl	%ecx,        0x28 + 4 + gdt@GOTOFF(%ebx)

	
	leal	gdt@GOTOFF(%ebx), %eax
	movl	%eax, 2 + gdt_descr@GOTOFF(%ebx)

	lidt	idt_real@GOTOFF(%ebx)

	

	
	movl	$0x28, %eax
	movl	%eax, %ds
	movl	%eax, %es
	movl	%eax, %ss
	movl	%eax, %fs
	movl	%eax, %gs

	
	leal	boot_stack@GOTOFF(%ebx), %ecx
	
	leal	mem_info@GOTOFF(%ebx), %edi

	
	ljmp	$0x20, $1f - startup_32
1:
	.code16
	
	
	movl	%cr0,%eax
	andl	$~((1 << 31)|(1<<0)),%eax
	movl	%eax,%cr0

	


	ljmp	*(realptr - startup_32)
real:
	


	movw	%cs, %ax
	movw	%ax, %ds
	movw	%ax, %es
	movw	%ax, %fs
	movw	%ax, %gs
	movw	%ax, %ss

	
	movl	%ecx, %eax
	shrl	$4, %eax
	movw	%ax, %ss
	subl	%ecx, %esp

	
	pushl	%ebx

	
	shrl	$4, %edi
	movl	%edi, %ds

	
	sti

# Get memory size (extended mem, kB)



	xorl	%eax, %eax
	movl	%eax, (0x00)
	movl	%eax, (0x04)
	movl	%eax, (0x08)

# Try three different memory detection schemes.  First, try
# e820h, which lets us assemble a memory map, then try e801h,
# which returns a 32-bit memory size, and finally 88h, which
# returns 0-64m

# method E820H:
# the memory map from hell.  e820h returns memory classified into
# a whole bunch of different types, and allows memory holes and
# everything.  We scan through this memory map and build a list
# of the first 32 memory areas, which we return at [0x0c].
# This is documented at http://www.teleport.com/~acpi/acpihtml/topic245.htm

meme820:
	xorl	%ebx, %ebx			# continuation counter
	movw	$0x0c, %di			# point into the whitelist
						# so we can have the bios
						# directly write into it.

jmpe820:
	movl	$0x0000e820, %eax		# e820, upper word zeroed
	movl	$0x534d4150, %edx			# ascii 'SMAP'
	movl	$20, %ecx			# size of the e820rec
	pushw	%ds				# data record.
	popw	%es
	int	$0x15				# make the call
	jc	bail820				# fall to e801 if it fails

	cmpl	$0x534d4150, %eax			# check the return is `0x534d4150'
	jne	bail820				# fall to e801 if it fails

#	cmpl	$1, 16(%di)			# is this usable memory?
#	jne	again820

	# If this is usable memory, we save it by simply advancing %di by
	# sizeof(e820rec).
	#
good820:
	movb	(0x08), %al			# up to 32 entries
	cmpb	$127, %al
	jnl	bail820

	incb	(0x08)
	movw	%di, %ax
	addw	$20, %ax
	movw	%ax, %di
again820:
	cmpl	$0, %ebx			# check to see if
	jne	jmpe820				# %ebx is set to EOF
bail820:


# method E801H:
# memory size is in 1k chunksizes, to avoid confusing loadlin.
# we store the 0xe801 memory size in a completely different place,
# because it will most likely be longer than 16 bits.

meme801:
	stc					# fix to work around buggy
	xorw	%cx,%cx				# BIOSes which dont clear/set
	xorw	%dx,%dx				# carry on pass/error of
						# e801h memory size call
						# or merely pass cx,dx though
						# without changing them.
	movw	$0xe801, %ax
	int	$0x15
	jc	mem88

	cmpw	$0x0, %cx			# Kludge to handle BIOSes
	jne	e801usecxdx			# which report their extended
	cmpw	$0x0, %dx			# memory in AX/BX rather than
	jne	e801usecxdx			# CX/DX.  The spec I have read
	movw	%ax, %cx			# seems to indicate AX/BX
	movw	%bx, %dx			# are more reasonable anyway...

e801usecxdx:
	andl	$0xffff, %edx			# clear sign extend
	shll	$6, %edx			# and go from 64k to 1k chunks
	movl	%edx, (0x04)			# store extended memory size
	andl	$0xffff, %ecx			# clear sign extend
 	addl	%ecx, (0x04)			# and add lower memory into
						# total size.

# Ye Olde Traditional Methode.  Returns the memory size (up to 16mb or
# 64mb, depending on the bios) in ax.
mem88:

	movb	$0x88, %ah
	int	$0x15
	movw	%ax, (0x00)


# check for APM BIOS
	movw	$0x5300, %ax    # APM BIOS installation check
	xorw	%bx, %bx
	int	$0x15
	jc	done_apm_bios   # error -> no APM BIOS

	cmpw	$0x504d, %bx    # check for "PM" signature
	jne	done_apm_bios   # no signature -> no APM BIOS

	movw	$0x5304, %ax    # Disconnect first just in case
	xorw	%bx, %bx
	int	$0x15           # ignore return code

	movw	$0x5301, %ax    # Real Mode connect
	xorw	%bx, %bx
	int	$0x15
	jc	done_apm_bios   # error

	movw	$0x5308, %ax    # Disable APM
	mov	$0xffff, %bx
	xorw	%cx, %cx
	int	$0x15

done_apm_bios:


	
	cli

	
	popl	%ebx

	
	movw	%cs, %ax
	movw	%ax, %ds

	
	addr32 lgdt	gdt_descr - startup_32

	
	
	movl	%cr0,%eax
	orl	$(1<<0),%eax
	movl	%eax,%cr0

	
	data32 ljmp	*(protptr - startup_32)
prot:
	.code32
	
	movl	$0x18, %eax
	movl	%eax, %ds
	movl	%eax, %es
	movl	%eax, %fs
	movl	%eax, %gs
	movl	%eax, %ss

	
	leal	boot_stack@GOTOFF(%ebx), %eax
	addl	%eax, %esp

	
	popl	%ebp
	popl	%edi
	popl	%esi
	popl	%ebx
	movl	$1, %eax
	ret

realptr:
	.word	real - startup_32
	.word	0x0000
protptr:
	.long	0
	.long	0x10

idt_real:
	.word	0x400 - 1			# idt limit ( 256 entries)
	.word	0, 0				# idt base = 0L


# 805 "head.S"
	.globl _ap_trampoline_start
	.globl _ap_trampoline_protmode
	.code16
_ap_trampoline_start:
	lgdt    0x0 
	movl	%cr0, %eax
	orl	$1, %eax
	movl	%eax, %cr0
	data32 ljmp    $0x10, $_ap_trampoline_protmode
_ap_trampoline_protmode:
	.code32
	movw	$0x18, %ax
	movw	%ax, %ds
	movw	%ax, %es
	movw	%ax, %fs
	movw	%ax, %gs
	movw	%ax, %ss
	movl	$(0x00010000 + _GLOBAL_OFFSET_TABLE_), %esp
	leal	boot_stack_top@GOTOFF(%esp), %esp
	pushl   $0
	popf
	call    startup_32
	
	cli
2:	hlt
	jmp 2b	
.data
zerobss:	.long	1
.previous
.data
.balign 16
	.globl mem_info
mem_info:
	. = . + (0x0c + 127 * 20)
.previous
.bss
.balign 16
boot_stack:
	.globl boot_stack
	. = . + 4096
boot_stack_top:
	.globl boot_stack_top
.previous
