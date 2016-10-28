; Fibonacci sequence
; Blake Bartenbach

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
current dword 0
previous dword 0
sum dword 0

; variable sum will contain the fibonnaci sequence each loop iteration
.code
main PROC
    ; clear registers
    mov eax,0
    mov ebx,0
    mov ecx,0

    ; start the first number
    add eax,1

    ; loop counter
    mov ecx,7

    CALC:

        add sum,eax ; Add both previous numbers to the sum
        add sum,ebx ;
        
        mov current,eax   ; Move eax into the current number
        mov previous,ebx  ; Move ebx into the previous number

        mov ebx,current ; old current digit is new previous number
        mov eax,sum     ; new current digit was the previous sum

        mov sum,0 ; reset the sum

        loop CALC

	invoke ExitProcess,0
main endp
end main