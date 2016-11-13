TITLE StringConcat
; Blake Bartenbach
; Chapter 9 - Exercise 2
; String concatenation program

INCLUDE C:\Irvine\Irvine32.inc
WaitMsg       PROTO
WriteString   PROTO
CrLf          PROTO
Str_concat    PROTO source:ptr byte, target:ptr byte

.data
    target byte "This is ",10 DUP(0)
    source byte "a test",0

.code
    main PROC
        ; concatenate source to target
        invoke str_concat, addr target, addr source

        ; output to console
        mov edx,offset target
        call WriteString
        call CrLf

        ; pause
        call WaitMsg
        exit
    main ENDP

    Str_concat PROC uses edx, string1:ptr byte, string2:ptr byte
        mov edi,string1
        mov al,0
        repne scasb
        dec edi
        mov esi,string2
        concat:
            mov al,[esi]
            mov [edi],al
            inc esi
            inc edi
            test al,al
            jnz concat ; if not zero continue loop
        ret
    Str_concat ENDP

END main