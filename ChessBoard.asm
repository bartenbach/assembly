TITLE ChessBoard
; Blake Bartenbach
; Chapter 8 - Exercise 3
; Chess board that loops through colors

INCLUDE C:\Irvine\Irvine32.inc
WaitMsg       PROTO
WriteChar     PROTO
SetTextColor  PROTO
CrLf          PROTO
Delay         PROTO
Clrscr        PROTO
WriteEvenRow  PROTO times:byte, color:dword
WriteOddRow   PROTO times:byte, color:dword
WriteSquare   PROTO color:dword
WriteBoard    PROTO color:dword
UpdateColor   PROTO

.data
    whiteSquare  = 15 + (15 * 16)
    default      = white + (black * 16)
    BOARDROWS    = 8
    BOARDCOLUMNS = 8
    LOOPS        = 16
    count byte 0 ; if this isn't global the program breaks for some reason

.code
    main PROC
        mov ecx,loops
        mov edx,0 ; first board color

        WriteBoards:
            invoke WriteBoard, edx
            inc count
            call UpdateColor

            mov eax,500 ; milliseconds to delay
            call Delay
            call Clrscr
        LOOP WriteBoards
        call RestoreDefaultColor
        call WaitMsg
        exit
    main ENDP

    ; receives: count - counter variable
    ; returns: color in edx
    UpdateColor PROC
        mov edx,0
        movzx edx,count
        imul edx,16
        ret
    UpdateColor ENDP

    WriteBoard PROC uses ecx, color:dword
            mov ecx,BOARDCOLUMNS / 2 ; times to write even and odd rows
        Output:
            invoke WriteEvenRow, BOARDROWS / 2, color
            invoke WriteOddRow,  BOARDROWS / 2, color
        LOOP Output
        call RestoreDefaultColor
        ret
    WriteBoard ENDP

    WriteEvenRow PROC uses ecx, times:byte, color:dword
        movzx ecx,times
        OutputEven:
            invoke WriteSquare, whiteSquare
            invoke WriteSquare, color
        LOOP OutputEven
        call RestoreDefaultColor
        call CrLf
        ret
    WriteEvenRow ENDP

    WriteOddRow PROC uses ecx, times:byte, color:dword
        movzx ecx,times
        OutputOdd:
            invoke WriteSquare, color
            invoke WriteSquare, whiteSquare
        LOOP OutputOdd
        call CrLf
        ret
    WriteOddRow ENDP

    WriteSquare PROC uses eax, color:dword
        mov eax,color
        call SetTextColor
        mov al,' '
        call WriteChar
        call WriteChar
        ret
    WriteSquare ENDP

    RestoreDefaultColor PROC uses eax
       mov eax,default
       call SetTextColor
       ret
    RestoreDefaultColor ENDP

END main