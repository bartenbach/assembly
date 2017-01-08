TITLE FPComp
; Blake Bartenbach
; Chapter 12 - Exercise 1
; Floating Point Comparison

INCLUDE C:\Irvine\Irvine32.inc
INCLUDE C:\Irvine\macros.inc
WaitMsg       PROTO
WriteString   PROTO
CrLf          PROTO

.data
    ; VALUES
    val1    REAL8 5.1
    val2    REAL8 5.12

    ; Variables
    N       dword 0
    largerMsg byte  "First value is larger",0,0
    lessMsg   byte  "Second value is larger",0,0

.code
    main PROC
        ; compare values
        fld val2
        fld val1
        fcomi ST(0),ST(1)

        jnb L1
        mov N,1
        L1:

        .if N == 1
          mov edx,OFFSET lessMsg
        .else
          mov edx,OFFSET largerMsg
        .endif
        call WriteString
        call CrLf
        call WaitMsg
          
        exit
    main ENDP

END main