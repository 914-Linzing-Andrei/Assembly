global reverse

segment data use32 class = data

segment code use32 class = code
    reverse:
        mov ecx, 4
        add edi, 7
        mov esi, edi
        sub edi, 7
        xor eax,eax
        repeta:
            mov al,[esi]
            mov ah,[edi]
            xchg al,ah
            mov [esi],al
            mov [edi],ah
            inc edi
            dec esi
        loop repeta
        ret
