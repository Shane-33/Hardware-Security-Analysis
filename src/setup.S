# 0 "setup.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4



















# 45 "/usr/include/stdc-predef.h" 3 4

# 55 "/usr/include/stdc-predef.h" 3 4









# 0 "<command-line>" 2
# 1 "setup.S"










# 1 "defs.h" 1
 





















# 11 "setup.S" 2

.code16
.section ".setup", "ax", @progbits
.globl start
start:
# ok, the read went well 
# now we want to move to protected mode ...


	cli			# no interrupts allowed #
	movb	$0x80, %al	# disable NMI for the bootup sequence
	outb	%al, $0x70

# The system will move itself to its rightful place.
# reload the segment registers and the stack since the 
# APs also execute this code
#ljmp	$0x9000, $(reload - start + 0x200)
reload:
	movw	$0x9000, %ax
	movw	%ax, %ds
	movw	%ax, %es
	movw	%ax, %fs
	movw	%ax, %ss	# reset the stack to 0x9000:0x4000-12.
	movw	%dx, %sp
	push	%cs
	pop	%ds
	lidt	idt_48 - start	# load idt with 0,0
	lgdt	gdt_48 - start	# load gdt with whatever appropriate

# that was painless, now we enable A20
# start from grub-a20.patch
     	



     	mov	$0x92, %dx
     	inb	%dx, %al
     	
     	cmpb	$0xff, %al
     	jz	alt_a20_done
     	
     	
     	movb	4(%esp), %ah
     	testb	%ah, %ah
     	jz	alt_a20_cont1
     	orb	$2, %al
     	jmp	alt_a20_cont2
alt_a20_cont1:
	and	$0xfd, %al

	
alt_a20_cont2:
	and	$0xfe, %al
	outb	%al, %dx

alt_a20_done:
# end from grub-a20.patch

	call    empty_8042
	
	movb	$0xD1, %al	# command write
	outb	%al, $0x64
	call    empty_8042	

	movb	$0xDF, %al	# A20 on
	outb	%al, $0x60
	call	empty_8042





	movw	$0x0001, %ax	# protected mode (PE) bit
	lmsw	%ax		# This is it#
	jmp	flush_instr
flush_instr:
	movw	$0x18, %ax
	movw	%ax, %ds
	movw	%ax, %es
	movw	%ax, %ss
	movw	%ax, %fs
	movw	%ax, %gs

data32	ljmp	$0x10, $(0x1000 <<4)	# jmp offset 2000 of segment 0x10 (cs)








empty_8042:
	call	delay
	inb	$0x64, %al	# 8042 status port
	cmpb	$0xff, %al	# from grub-a20-patch, skip if not impl
	jz	empty_8042_ret
	testb	$1, %al		# output buffer?
	jz	no_output
	call	delay
	inb	$0x60, %al	# read it
	jmp	empty_8042
	
no_output:
	testb	$2, %al		# is input buffer full?
	jnz	empty_8042	# yes - loop
empty_8042_ret:
	ret

# Delay is needed after doing i/o

delay:
	.word	0x00eb			# jmp $+2
	ret

gdt:
	.word	0,0,0,0		# dummy

	.word	0,0,0,0		# unused

	.word	0x7FFF		# limit 128mb
	.word	0x0000		# base address=0
	.word	0x9A00		# code read/exec
	.word	0x00C0		# granularity=4096, 386

	.word	0x7FFF		# limit 128mb
	.word	0x0000		# base address=0
	.word	0x9200		# data read/write
	.word	0x00C0		# granularity=4096, 386

idt_48:
	.word	0			# idt limit=0
	.long	0			# idt base=0L

gdt_48:
	.word	0x800		# gdt limit=2048, 256 GDT entries
	.word	512+gdt - start,0x9	# gdt base = 0X9xxxx

msg1:
	.asciz "Setup.S\r\n"

	
	.org	(4*512)

