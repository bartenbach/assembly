TITLE MacroTest
; Blake Bartenbach
; Chapter 10 - Exercise 2
; Macro Exercise - write a string in any color

INCLUDE C:\Irvine\Irvine32.inc
WaitMsg       PROTO
WriteString   PROTO
CrLf          PROTO
SetTextColor  PROTO

    mWriteString MACRO string:REQ, color
        push edx
        push eax
        mov edx, OFFSET string
        mov eax,color
        call SetTextColor
        call WriteString
        call CrLf
        pop eax
        pop edx
    ENDM

.data
    string db "Here is my string",0
    DefaultColor = lightGray + (black * 16)

.code
    main PROC
        ; Call macro with test values
        mWriteString string,white
        mWriteString string,yellow
        mWriteString string,blue
        mWriteString string,magenta

        ; Restore default color and pause
        mov eax,DefaultColor
        call SetTextColor
        call WaitMsg

        exit
    main ENDP

END main