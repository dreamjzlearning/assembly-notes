ASSUME CS:CSEG, DS:DSEG, SS:SSEG

SSEG SEGMENT STACK        ; 定义堆栈段, STACK 为组合类型(本程序似乎用不上...)
         DW 16 DUP(?)    ; 分配内存, 16 个字(32 字节)
SSEG ENDS

DSEG SEGMENT        ; 定义数据段
    ; 变量设置
    A    DB 56
    B    DB -20
    Z    DB 106     ; 此处不能使用 C 作为变量名
    D    DB 80
    E    DB -112
    F    DB 15
    X    DW ?       ; 为 X 分配一个字的空间
DSEG ENDS

CSEG SEGMENT               ; 代码段
    START:MOV  AX, DSEG    ; 程序入口, 将数据段 DSEG 地址给 AX
          MOV  DS, AX      ; 将 DSEG 存如 DS
          
    ; 计算 AxB 并将结果存在 BX 中
          MOV  AL, A
          IMUL B           ; A, B为有符号数
          MOV  BX, AX

    ; 计算 AxB+C-D, 将结果存在 BX 中
          MOV  AL, Z
          CBW              ; 扩展 C, 避免溢出
          ADD  BX, AX      ; AxB+C
          MOV  AL, D
          CBW
          SUB  BX, AX      ; AxB+C-D

    ; 计算 E+F, 结果存在 CX 中
          MOV  AL, E
          CBW
          MOV  CX, AX
          MOV  AL, F
          CBW
          ADD  CX, AX

    ; 计算最终结果
          MOV  AX, BX
          CWD              ; 扩展 AX 防止溢出
          IDIV CX
          MOV  X, AX       ; 将结果存至 X 中
          
    ; 结束程序
          MOV  AH, 4CH
          INT  21H
CSEG ENDS
END START