assume cs:code, ds:data, ss:stk 

stk segment stack
        dw 16 dup (?)
stk ends

data segment
    x    dw 23
    oe   db ?
data ends

code segment
    start: mov  ax, data
           mov  ds, ax

           test x, 1        ; 计算 x&1
           jz   isEven      ; 判断 ZF=0? (结果是否为 0)
           mov  oe, 1
           jmp  ok

    isEven:mov  oe, 0

    ok:    mov  ah, 4ch
           int  21h
code ends
end start 