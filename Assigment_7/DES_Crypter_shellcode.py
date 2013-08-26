#!/usr/bin/python
# Filename : DES_Crypter_shellcode.py
# Author : M.Acosta <amcx62[_at_]gmail[_dot_]com>
# Date : 2013 August
# Location : Lima(Peru)
# Desc : Python Custom Crypter DES Cipher feedback (CFB) 
# Tested on : Linux/x86 (Kali Linux SMP 3.7-trunk-686-pae #1 SMP Debian 3.7.2-0+kali8 i686)
from Crypto.Cipher import DES
import os
import sys
	
BLOCK_SIZE = 8
Padding = '{'
password =""

shellcode='\x31\xc0\xb0\x04\x31\xdb\xb3\x01\x31\xd2\x52\x68\x72\x6c\x64\x0a\x68\x6f\x20\x57\x6f\x68\x48\x65\x6c\x6c\x89\xe1\xb2\x0c\xcd\x80\x31\xc0\xb0\x01\x31\xdb\xcd\x80'

#Lambda function for Padding Encrypted Text to Fit the Block
pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * Padding

def to_hex(shellcode):
	shellhex=""
	for x in bytearray(shellcode) :
		shellhex += '\\x'
		shellhex += '%02x' % (x & 0xff)
	return shellhex


if __name__ == "__main__":

	print " [*] DES CRYPTER SHELLCODE"
	print " [*] ---------------------"
	print " "
	print " [*] Shellcode Length : %d " % len(bytearray(shellcode))
	print " [*] Shellcode : %s" % to_hex(shellcode)
	print "" 

	#Create a secret key
	password=sys.argv[1]
	print " [*] Secret key : %s" % password

	#Create a IV
	iv = os.urandom(BLOCK_SIZE)
	hexiv = to_hex(iv)
	print " [*] Random IV : %s" % hexiv
	print ""

	# Create a cipher object DES MODE CFB
	cipher = DES.new(password, DES.MODE_CFB, iv)
	
	# Encrypted Shellcode
	encrypted_shellcode = cipher.encrypt(pad(shellcode))
	hexencrypted_shellcode = to_hex(encrypted_shellcode)

	print " [*] Encrypted shellcode Length: %d" % len(hexencrypted_shellcode)
	print " [*] Encrypted Shellcode : %s" % hexencrypted_shellcode
