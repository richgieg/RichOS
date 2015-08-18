[bits 16]
[cpu 386]

;//////////////////////////////////////////////////////////////////////////////;
;///   Segment pointer definitions (for real mode).                         ///;
;//////////////////////////////////////////////////////////////////////////////;

INITSEG         equ     0x9000  ; Initialization data segment.


;//////////////////////////////////////////////////////////////////////////////;
;///   Segment selector definitions (for protected mode).                   ///;
;//////////////////////////////////////////////////////////////////////////////;

CODESEG         equ     8       ; Code segment selector.
DATASEG         equ     0x10    ; Data segment selector.


;//////////////////////////////////////////////////////////////////////////////;
;///   Global variable pointer definitions (offsets in INITSEG).            ///;
;//////////////////////////////////////////////////////////////////////////////;

CURSOR_POS      equ     0x0000  ; Cursor row (high byte) and col (low byte).
EXTENDED_MEM    equ     0x0002  ; Contiguous KB above 1M.


;//////////////////////////////////////////////////////////////////////////////;
;///   Misc constant definitions.                                           ///;
;//////////////////////////////////////////////////////////////////////////////;

THIS_IMAGE      equ     0x90200 ; 32-bit pointer to this image.


;//////////////////////////////////////////////////////////////////////////////;
;///   Code.                                                                ///;
;//////////////////////////////////////////////////////////////////////////////;

; Set DS to the current code segment (SETUPSEG).
        mov     ax,cs
        mov     ds,ax

; Set ES to point to INITSEG, where we will store system initialization data.
        mov     ax,INITSEG
        mov     es,ax

; Retrieve cursor row and column.
get_cursor:
        mov     ah,3
        xor     bh,bh
        int     0x10
        mov     [es:CURSOR_POS],dx
        
; Retrieve extended memory info.
get_mem:
        mov     ah,0x88
        int     0x15                    ; This BIOS function may limit itself
        mov     [es:EXTENDED_MEM],ax    ; to reporting 15 MB for legacy reasons.
        jc      .error                  ; If carry flag is set, then error.
        test    ax,ax                   ; If returned value is 0, then error.
        jz      .error
        jmp     .success
.error: mov     ax,msgErr_get_mem
        jmp     halt
.success:
        
; Move system image to address 0.
        cli
        xor     ax,ax
do_move:
        mov     es,ax
        add     ax,0x1000
        cmp     ax,INITSEG
        jz      end_move
        mov     ds,ax
        sub     si,si
        sub     di,di
        mov     cx,0x8000
        rep movsw
        jmp     do_move
end_move:

; Load GDT and IDT.
        mov     ax,cs
        mov     ds,ax
        lgdt    [gdt_48]
        lidt    [idt_48]
        
; Enable A20 line using "fast A20 gate."
        in      al,0x92
        or      al,2
        out     0x92,al
        
; Set PE (protection enable) bit in CR0 (control register 0).
        mov     eax,cr0
        or      al,1
        mov     cr0,eax

; Enter protected mode and continue executing.
        jmp     dword CODESEG:THIS_IMAGE+go
[bits 32]
go:     mov     ax,0x10

; Set DS/ES to the data segment (0x10).
        mov     ds,ax
        mov     es,ax
        
; Put stack at 0x200000 (2nd megabyte boundary).
        mov     ss,ax
        mov     esp,0x200000
        
; Transfer control to the kernel image.
        jmp     CODESEG:0

; Subroutine that displays a message and halts the CPU upon setup failure.
[bits 16]
halt:   cli
        push    240
        push    ax
        call    puts
        add     sp,4
        push    320
        push    haltMsg
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

msgErr_get_mem  db      "Error detecting memory!", 0
haltMsg         db      "Setup failure! CPU halted!", 0
gdt             dw      0, 0, 0, 0
                dw      0x07ff
                dw      0x0000
                dw      0x9a00
                dw      0x00c0
                dw      0x07ff
                dw      0x0000
                dw      0x9200
                dw      0x00c0
idt_48          dw      0, 0, 0
gdt_48          dw      0x800, 512+gdt, 9


;//////////////////////////////////////////////////////////////////////////////;
;///   Image padding to 2048 bytes (4 sectors).                             ///;
;//////////////////////////////////////////////////////////////////////////////;

times 2048-($-$$) db 0