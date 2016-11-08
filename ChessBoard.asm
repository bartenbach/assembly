TITLE ChessBoard
; Blake Bartenbach
; Chapter 8 - Exercise 2
;  
INCLUDE C:\Irvine\Irvine32.inc
WaitMsg       PROTO
WriteChar     PROTO
SetTextColor  PROTO
CrLf          PROTO
WriteEvenRow  PROTO times:byte
WriteOddRow   PROTO times:byte
WriteSquare   PROTO color:byte

.data
    whiteSquare = white + (white * 16)
    graySquare  = gray  + (gray  * 16)
    default     = white + (black * 16)
    BOARDSIZE   = 4

.code
    main PROC
        mov al,' '  ; our chess board character
        mov ecx,BOARDSIZE ; times to write even and odd rows
        WriteBoard:
            invoke WriteEvenRow, 4
            invoke WriteOddRow,  4
        LOOP WriteBoard
        call RestoreDefaultColor
        call WaitMsg
        exit
    main ENDP

    WriteEvenRow PROC uses ecx, times:byte
        movzx ecx,times
        OutputEven:
            invoke WriteSquare, whiteSquare
            invoke WriteSquare, graySquare
        LOOP OutputEven
        call CrLf
        ret
    WriteEvenRow ENDP

    WriteOddRow PROC uses ecx, times:byte
        movzx ecx,times
        OutputOdd:
            invoke WriteSquare, graySquare
            invoke WriteSquare, whiteSquare
        LOOP OutputOdd
        call CrLf
        ret
    WriteOddRow ENDP

    WriteSquare PROC color:byte
        movzx eax,color
        call SetTextColor
        call WriteChar
        call WriteChar
        ret
    WriteSquare ENDP

    RestoreDefaultColor PROC
       mov eax,default
       call SetTextColor
       ret
    RestoreDefaultColor ENDP

END main