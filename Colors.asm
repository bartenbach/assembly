; Chapter 5, Assignment 8
; Blake Bartenbach
; Prints all 256 color combinations
include C:\Irvine\Irvine32.inc

.data
    count dword 256
    DefaultColor = lightGray + (black * 16)
    string BYTE "COLOR ",0
    var dword 0Fh;
    counter dword 1;

.code
    main PROC
        call Clrscr
        mov ecx,count
        mov edx,OFFSET string

        ColorLoop:
            mov eax,var
            call SetTextColor
            call WriteString
            mov eax,counter
            call WriteInt
            inc counter
            inc var
        Loop ColorLoop

        mov eax,DefaultColor
        call SetTextColor
        call WaitMsg 
        call Clrscr
        exit
    main ENDP
END main