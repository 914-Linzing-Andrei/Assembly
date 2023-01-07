global reverse

segment data use32 class = data
    numar dw 2

segment code use32 class = code
    reverse:
        xor eax,eax
        xor ebx,ebx
        mov edi,esi
        sub edi,1
        sub esi,edx
        mov eax, edx
        xor edx,edx
        div word [numar]
        mov ecx, eax
        cmp ecx,0
        je afara
        repeta:
            mov bl,[esi]
            mov bh,[edi]
            xchg bl,bh
            mov [esi],bl
            mov [edi],bh
            inc esi
            dec edi
        loop repeta
        afara:
        ret
