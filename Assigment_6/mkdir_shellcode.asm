/*
 Filename  : mkdir_shellcode.asm
 Author    : M.Acosta snow <amcx62[_at_]gmail[_dot_]com>
 Date      : 2013 August
 Location  : Lima(Peru)
 Desc	     : mkdir & exit shellcode 
 Tested on : Linux/x86 (Ubuntu SMP 3.2.0-49-generic-pae)
*/
global _start			

section .text
_start:

;mkdir()
xor eax,eax
push eax
push 0x65616c73 ;hackslae
push 0x6b636168
xor ebx,ebx
mov ebx,esp
add al,0x27
add cx,0x1ed
int 0x80

;Exit()
mov al,0x1
xor ebx,ebx
int 0x80
