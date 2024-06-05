include inout.asm
.model small, c
.486
.stack
;Enter the string you want to reverse

.const

.data
   s1 db 13,10,"Enter the string you want to reverse: $"
   string1 db 300 dup(0)
   string2 db 300 dup(0)
   s2 db 13,10,"The reverse of the string: $"
   s3 db 13,10,"The string you entered: $"

.code

.startup
   call puts, offset s1
   call gets, offset string1
   call endl

   lea si, string1
   lea di, string2

   reverse_string:
      mov al, [si]           
      cmp al, 0               
      je end_reverse
      inc si
      call reverse_string
      dec si
      mov al, [si]
      mov [di], al
      inc di
      ret

   end_reverse:
      ;mov byte ptr [di], 0   

   call puts, offset s2
   ;lea si, string2
   ;call puts, offset string2
   call endl

   call puts, offset s3
   call puts, offset string1
   call endl

.exit
end