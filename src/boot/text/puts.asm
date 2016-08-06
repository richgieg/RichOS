;//////////////////////////////////////////////////////////////////////////////;
;///   void puts(const char * s, int offset)                                ///;
;//////////////////////////////////////////////////////////////////////////////;

; Label for procedure.
puts:


;//////////////////////////////////////////////////////////////////////////////;
;///   Initialization code.                                                 ///;
;//////////////////////////////////////////////////////////////////////////////;

; Create stack frame.
        push    bp
        mov     bp,sp

; Define aliases for arguments.
%define         .arg0           bp+4
%define         .arg1           bp+6

; Define aliases for local variables.
%define         .s              bp-4
%define         .offset         bp-2

; Allocate space for local variables on the stack.
        sub     sp,4

; Make local copies of arguments.
        mov     ax,[.arg0]               
        mov     [.c],ax
        mov     ax,[.arg1]
        mov     [.offset],ax

; Preserve register state.
        push    bx
        push    dx


;//////////////////////////////////////////////////////////////////////////////;
;///   Procedure code.                                                      ///;
;//////////////////////////////////////////////////////////////////////////////;

        mov     bx,[.s]
        mov     dx,[.offset]
.loop:  mov     al,[bx]
        test    al,al
        jz      .exit
        push    dx
        push    ax
        call    putc
        add     sp,4
        inc     bx
        inc     dx
        jmp     .loop
.exit:


;//////////////////////////////////////////////////////////////////////////////;
;///   Deinitialization code.                                               ///;
;//////////////////////////////////////////////////////////////////////////////;

; Restore register state.
        pop     dx
        pop     bx

; Free local variable stack space.
        add     sp,4
  
; Release stack frame and return.
        pop     bp
        ret