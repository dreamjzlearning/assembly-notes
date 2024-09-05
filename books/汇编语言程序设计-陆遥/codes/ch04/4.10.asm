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
        
sort proc
               push cx
               push di
        
               dec  cx
    outer_loop:push cx
               lea  si, di

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

code ends
end start