assume cs:code, ds:data, ss:stk 

stk segment stack
        dw 16 dup (?)
stk ends

data segment
    Arr  db  17,22,9,80,37
    N    equ $-Arr
data ends

code segment
    start:mov  ax, data
          mov  ds, ax

          mov  cx, N-1
    rond: push cx
          lea  si, Arr
            
    ; 内层循环, 交换升序元素
    cont: mov  al, [si]
          cmp  al, [si+1]    ; 比较 a[i], a[i+1]
          jae  next
    ; 交换 a[i], a[i+1]
          xchg al, [si+1]
          mov  [si], al

    next: inc  si
          loop cont
          pop  cx
          loop rond
            
          mov  ah, 4ch
          int  21h
code ends
end start
