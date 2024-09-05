assume cs:code, ds:data, ss:stk 

stk segment stack
        dw 16 dup (?)
stk ends

data segment
    ARR  dw ?,0,0,1,100 dup (?)    ; 数组首位存放元素个数
data ends

code segment
    start:mov ax, data
          mov ds, ax

          lea si, ARR+4*2             ; 下个元素的地址
          mov cx, 3                   ; 初始话元素个数
    cont: cmp word ptr [si-2], 200    ; 比较尾部元素和 200
          ja  exit                    ; 超过则结束
    ; 累加前三个元素
          mov ax, [si-6]
          add ax, [si-4]
          add ax, [si-2]
          mov [si], ax                ; 追加至数组
          inc cx                      ; 更新元素数量
          add si, 2
          jmp short cont              ; 循环
          
    exit: mov arr, cx
          mov ah, 4ch
          int 21h
code ends
end start
