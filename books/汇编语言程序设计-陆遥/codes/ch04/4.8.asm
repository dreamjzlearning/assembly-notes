    assume cs:code, ds:data, ss:stk 

stk segment stack
        dw 16 dup (?)
stk ends

data segment
    ARR   db 1,2,3,4,5,6    ;...
    N     =  5
    N1    =  8
    TOTAL dw 5 dup (?)
data ends

code segment
    start:mov  ax, data
          mov  ds, ax
          lea  si, ARR
          lea  di, TOTAL
          mov  cx, N
        
    glop: xor  ax, ax
          push cx           ; 暂存外循环计数器
          mov  cx, N1       ; 开始内循环
        
    slop: add  al, [si]
          adc  ah, 0
          inc  si
          loop slop
          mov  [di], ax
          add  di, 2
          pop  cx
          loop glop
          mov  ah, 4ch
          int  21h
code ends
    end start
