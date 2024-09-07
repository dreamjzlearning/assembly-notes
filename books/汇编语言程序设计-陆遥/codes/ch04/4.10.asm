assume cs:code, ds:data, ss:stk 

stk segment stack
        dw 32 dup (?)
stk ends

data segment
    Score db  80,50,60,70,90
    Num   equ $-Score
    Rate  db  7 dup (0)
data ends

code segment
    start:     mov  ax, data
               mov  ds, ax

               lea  di, Score
               mov  cx, Num
               call sort

               push di
               push cx
               lea  di, Rate
               push di
               call calculate
                
               mov  ah, 4ch
               int  21h
        
sort proc
               push cx
               push di
        
               dec  cx
    outer_loop:push cx
               mov  si, di

    inner_loop:mov  al, [si]
               cmp  al, [si+1]
               jae  next
               xchg al, [si+1]
               mov  [si], al

    next:      inc  si
               loop inner_loop
               pop  cx
               loop outer_loop
               
               pop  di
               pop  cx
               ret

sort endp

calculate proc
               mov  bp, sp
               mov  di, [bp+2]
               mov  cx, [bp+4]
               mov  si, [bp+6]
               xor  ax, ax
    stat:      cmp  byte ptr [si], 60
               jb   next1
               inc  ax
    next1:     inc  si
               loop stat

               mov  bx, 100
               mul  bx
               mov  cx, [bp+4]
               div  cx

               mov  cl, 10
               div  cl
               add  ah, 30h
               mov  [di+2], ah
               xor  ah, ah
               div  cl
               add  ah, 30h
               mov  [di+1], ah
               cmp  al, 0
               je   dot
               add  al, 30h
               mov  [di], al

    dot:       mov  byte ptr [di+3], '.'
               mov  ax, dx
               mul  bl
               mov  cx, [bp+4]
               div  cx
               mov  cl, 10
               div  cl
               add  ah, 30h
               mov  [di+5], ah
               add  al, 30h
               mov  [di+4], al
               mov  byte ptr [di+6], '%'
               ret  6
calculate endp
code ends
end start