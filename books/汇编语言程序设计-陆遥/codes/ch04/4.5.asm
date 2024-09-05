assume cs:code, ds:data, ss:stk 

stk segment stack
        dw 16 dup (?)
stk ends

data segment
    SCORES db  76,82,65,95,24,50,82,92
    N      EQU $-SCORES                   ; N 为 数据元素个数
    AVG    DB  ?
    BEST   DB  ?
data ends

code segment
    start:mov  ax, data
          mov  ds, ax
    
          lea  si, SCORES    ; 获取数组首地址
          xor  ax, ax        ; AX 清零
          mov  bl, [si]      ; bl 存储最高分, 初始为 SCORES[0]
          mov  cx, N         ; 循环计数
          
    cont: add  al, [si]      ; 累加分数
          adc  ah, 0
          cmp  bl, [si]
          jae  next          ; 更新最高分
          mov  bl, [si]

    next: inc  si
          loop cont
          mov  cl, N
          div  cl
          mov  AVG, al
          mov  BEST, bl
          
          mov  ah, 4ch
          int  21h
code ends
end start
