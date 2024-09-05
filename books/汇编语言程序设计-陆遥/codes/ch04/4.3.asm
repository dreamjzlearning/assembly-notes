assume cs:code, ds:data, ss:stk  

stk segment stack
        dw 16 dup (?)
stk ends

data segment
    A    db 56
    B    db 24
    X    db 35
data ends

code segment
    start:mov  ax, data
          mov  ds, ax
          
          mov  al, A
          cmp  al, B       ; 比较 A, B
          jbe  A_X         ; A <= B 则比较 A,X
          xchg al, B
          mov  A, al
    
    A_X:  cmp  al, X
          jbe  B_X
          xchg al, X
          mov  A, al

    B_X:  mov  al, B
          cmp  al, X
          jbe  ok          ; B <= X 排序完成
          xchg al, X
          mov  B, al
          
    ok:   mov  ah, 4ch
          int  21h
         
code ends
end start