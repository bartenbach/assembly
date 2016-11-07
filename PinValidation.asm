; Chapter 6 Exercise 9
; Blake Bartenbach
; Pin number validation program
include C:\Irvine\Irvine32.inc
WriteString PROTO
CrLf        PROTO
WaitMsg     PROTO
WriteInt    PROTO

byteP typedef ptr byte

.data
    pin1 byte 1,2,3,4,5  ; first digit too small
    pin2 byte 6,3,5,2,4  ; fine
    pin3 byte 5,4,5,2,2  ; last digit too small
    pin4 byte 8,3,6,4,9  ; last digit too large
    pinMin byte 5,2,4,1,3
    pinMax byte 9,5,8,4,6

    validMsg byte "Pin is Valid",0
    invalidSmallMsg byte "Pin is invalid - Digit too small",0
    invalidLargeMsg byte "Pin is invalid - Digit too large",0
    problemDigitMsg byte "Problem digit was #",0
    nextPinMsg byte "Next pin...",0
    doneMsg byte "Done!",0
    iteration byte "iteration",0

.code
    main PROC
        ; setup pin value pointers
        mov ebp,OFFSET pinMin
        mov edi,OFFSET pinMax

        ; test first pin
        mov esi,OFFSET pin1
        mov ecx,LENGTHOF pin1
        mov ebx,TYPE pin1
        call Validate_PIN

        mov ebp,OFFSET pinMin
        mov edi,OFFSET pinMax
        call WriteNextPinMessage

        ; test second pin
        mov esi,OFFSET pin2
        mov ecx,LENGTHOF pin2
        mov ebx,TYPE pin2
        call Validate_PIN
                
        mov ebp,OFFSET pinMin
        mov edi,OFFSET pinMax
        call WriteNextPinMessage

        ; test third pin
        mov esi,OFFSET pin3
        mov ecx,LENGTHOF pin3
        mov ebx,TYPE pin3
        call Validate_PIN

        mov ebp,OFFSET pinMin
        mov edi,OFFSET pinMax
        call WriteNextPinMessage

        ; test fourth pin
        mov esi,OFFSET pin4
        mov ecx,LENGTHOF pin4
        mov ebx,TYPE pin4
        call Validate_PIN
   
        call Done

        exit
    main ENDP


    ; Validates PIN
    ; Recieves: 
    ;           ESI - array offset
    ;           ECX - number of elements in the array
    ;
    ; Returns:  EAX - Invalid digit position or zero
    Validate_PIN PROC USES esi ecx
        mov  eax,0

        mov bh,1 ; counter to identify the problem digit

        ; ecx holds length of array
        Iterate:
            ; setup registers
            mov bl, byte ptr [esi]
            mov dl, [ebp] ; TODO these aren't incrementing
            mov dh, [edi]

            .IF bl < dl
                movzx eax,bh
                mov edx,OFFSET invalidSmallMsg
                call WriteMessage
                call WriteProblemDigit
                ret
            .ENDIF

            ; test max digit
            .IF bl > dh
                movzx eax,bh
                mov edx,OFFSET invalidLargeMsg
                call WriteMessage
                call WriteProblemDigit
                ret
            .ENDIF

            ; increment byte arrays
            inc esi
            inc edi
            inc ebp
            add bh,1  ; counter

            ; debug
            ; mov edx,OFFSET iteration
            ; call WriteMessage
        LOOP Iterate
        
        ; test validity of pin
        .IF eax == 0
            mov eax,0
            mov edx,OFFSET validMsg
            call WriteMessage
            ret
        .ENDIF
        ret
    Validate_PIN ENDP

    WriteMessage PROC
        call WriteString
        CALL CrLf
        ret
    WriteMessage ENDP

    WriteMessageWait PROC
        call WriteString
        call CrLf
        call WaitMsg
        call CrLf
        ret
    WriteMessageWait ENDP

    WriteNextPinMessage PROC
        MOV edx,OFFSET nextPinMsg
        call WriteMessageWait
        ret
    WriteNextPinMessage ENDP

    WriteProblemDigit PROC
        mov edx,OFFSET problemDigitMsg
        call WriteString
        call WriteInt
        call CrLf
        ret
    WriteProblemDigit ENDP

    Done PROC
        mov edx,OFFSET doneMsg
        call WriteMessageWait
    Done ENDP
END main