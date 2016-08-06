;//////////////////////////////////////////////////////////////////////////////;
;///   void putc(char c, int offset)                                        ///;
;//////////////////////////////////////////////////////////////////////////////;

; Label for procedure.
putc:


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
%define         .c              bp-4
%define         .offset         bp-2
 
; Allocate space for local variables on the stack.
        sub     sp,4

; Make local copies of arguments.
        mov     ax,[.arg0]               
        mov     [.c],ax
        mov     ax,[.arg1]
        mov     [.offset],ax

; Preserve register state.
        push    ds
        push    bx


;//////////////////////////////////////////////////////////////////////////////;
;///   Procedure code.                                                      ///;
;//////////////////////////////////////////////////////////////////////////////;

        mov     ax,TEXTSEG
        mov     ds,ax
        mov     al,[.c]
        mov     bx,[.offset]
        shl     bx,1
        mov     [bx],al


;//////////////////////////////////////////////////////////////////////////////;
;///   Deinitialization code.                                               ///;
;//////////////////////////////////////////////////////////////////////////////;

; Restore register state.
        pop     bx
        pop     ds

; Free local variable stack space.
        add     sp,4
  
; Release stack frame and return.
        pop     bp
        ret