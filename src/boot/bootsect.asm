[bits 16]
[cpu 386]

;//////////////////////////////////////////////////////////////////////////////;
;///   Segment pointer definitions.                                         ///;
;//////////////////////////////////////////////////////////////////////////////;

BOOTSEG         equ     0x07c0  ; Boot image segment.
INITSEG         equ     0x9000  ; Segment for copied boot image.
SETUPSEG        equ     0x9020  ; Setup image segment.
SYSSEG          equ     0x1000  ; Kernel segment.


;//////////////////////////////////////////////////////////////////////////////;
;///   Constant definitions.                                                ///;
;//////////////////////////////////////////////////////////////////////////////;

SETUPLEN        equ     4       ; Length of setup image, in sectors.
SYSLEN          equ     32      ; Length of kernel image, in sectors.


;//////////////////////////////////////////////////////////////////////////////;
;///   Code.                                                                ///;
;//////////////////////////////////////////////////////////////////////////////;

; Copy boot image to INITSEG.
        mov     ax,BOOTSEG
        mov     ds,ax
        mov     ax,INITSEG
        mov     es,ax
        mov     cx,256
        sub     si,si
        sub     di,di
        rep movsw

; Switch to INITSEG and continue executing.
        jmp     INITSEG:go
go:     mov     ax,cs

; Set DS/ES to the current code segment (INITSEG).
        mov     ds,ax
        mov     es,ax

; Set stack segment to 0x9000 and stack pointer to 0.
; The first push will end up at address 0x9fffe.
        mov     ss,ax
        mov     sp,0

; Read setup image from disk. Halt CPU upon failure.
        push    0
        push    loadMsg1
        call    puts
        add     sp,4
        mov     dx,0
        mov     cx,2
        mov     bx,0x200
        mov     ax,0x200+SETUPLEN
        int     0x13
        jc      halt

; Read kernel image from disk. Halt CPU upon failure.
        push    80
        push    loadMsg2
        call    puts
        add     sp,4
        mov     ax,SYSSEG
        mov     es,ax
        mov     dx,0
        mov     cx,6
        mov     bx,0
        mov     ax,0x200+SYSLEN
        int     0x13
        jc      halt
        
; Jump to first instruction of setup segment.
        jmp     SETUPSEG:0

; Subroutine that halts the CPU upon disk read failure.
halt:   cli
        push    240
        push    errorMsg
        call    puts
        add     sp,4
        hlt


;//////////////////////////////////////////////////////////////////////////////;
;///   Library inclusions.                                                  ///;
;//////////////////////////////////////////////////////////////////////////////;

%include "text/text.asm"
%include "libc/stdlib.asm"


;//////////////////////////////////////////////////////////////////////////////;
;///   Data definitions.                                                    ///;
;//////////////////////////////////////////////////////////////////////////////;

loadMsg1        db      "Loading SETUP image...", 0
loadMsg2        db      "Loading KERNEL image...", 0
errorMsg        db      "Error reading disk! CPU halted!", 0


;//////////////////////////////////////////////////////////////////////////////;
;///   Image padding to 510 bytes (1 word short of a sector).               ///;
;//////////////////////////////////////////////////////////////////////////////;

times 510-($-$$) db 0


;//////////////////////////////////////////////////////////////////////////////;
;///   Boot signature magic word.                                           ///;
;//////////////////////////////////////////////////////////////////////////////;

dw 0xAA55