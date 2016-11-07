TITLE ChessBoard
; Blake Bartenbach
; Chapter 8 - Exercise 2
;  
INCLUDE C:\Irvine\Irvine32.inc
WaitMsg       PROTO
WriteChar     PROTO
SetTextColor  PROTO
CrLf          PROTO

.data
    whiteSquare = white + (white * 16)
    graySquare  = gray  + (gray  * 16)
    default     = white + (black * 16)

.code
    main PROC
        mov al,' '  ; our chess board character
        call WriteEvenRow
        call CrLf
        call WriteOddRow
        call CrLf
        call WriteEvenRow
        call CrLf
        call WriteOddRow
        call CrLf
        call WriteEvenRow
        call CrLf
        call WriteOddRow
        call CrLf
        call WriteEvenRow
        call CrLf
        call WriteOddRow
        call CrLf
        call RestoreDefaultColor
        call WaitMsg

        exit
    main ENDP

    WriteEvenRow PROC
        call WriteWhiteSquare
        call WriteGraySquare
        call WriteWhiteSquare
        call WriteGraySquare
        call WriteWhiteSquare
        call WriteGraySquare
        call WriteWhiteSquare
        call WriteGraySquare
        ret
    WriteEvenRow ENDP

    WriteOddRow PROC
        call WriteGraySquare
        call WriteWhiteSquare
        call WriteGraySquare
        call WriteWhiteSquare
        call WriteGraySquare
        call WriteWhiteSquare
        call WriteGraySquare
        call WriteWhiteSquare
        ret
    WriteOddRow ENDP

    WriteWhiteSquare PROC
        mov eax,whiteSquare
        call SetTextColor
        call WriteChar
        call WriteChar
        ret
    WriteWhiteSquare ENDP

    WriteGraySquare PROC
        mov eax,graySquare
        call SetTextColor
        call WriteChar
        call WriteChar
        ret
    WriteGraySquare ENDP

    RestoreDefaultColor PROC
       mov eax,default
       call SetTextColor
       ret
    RestoreDefaultColor ENDP

END main