;//////////////////////////////////////////////////////////////////////////////;
;///   void drawPixel(int x, int y, int color)                              ///;
;//////////////////////////////////////////////////////////////////////////////;

; Label for procedure.
drawPixel:


;//////////////////////////////////////////////////////////////////////////////;
;///   Initialization code.                                                 ///;
;//////////////////////////////////////////////////////////////////////////////;

; Create stack frame.
        push    bp
        mov     bp,sp

; Define aliases for arguments.
%define         .arg0           bp+4
%define         .arg1           bp+6
%define         .arg2           bp+8

; Define aliases for local variables.
%define         .x              bp-6
%define         .y              bp-4
%define         .color          bp-2

; Allocate space for local variables on the stack.
        sub     sp,6

; Make local copies of arguments.
        mov     ax,[.arg0]               
        mov     [.x],ax
        mov     ax,[.arg1]
        mov     [.y],ax
        mov     ax,[.arg2]
        mov     [.color],ax  

; Preserve register state.
        push    dx
        push    di
        push    ds


;//////////////////////////////////////////////////////////////////////////////;
;///   Procedure code.                                                      ///;
;//////////////////////////////////////////////////////////////////////////////;

        mov     ax,GFXSEG
        mov     ds,ax
        mov     ax,[.y]
        mov     di,320
        mul     di
        add     ax,[.x]
        mov     di,ax
        mov     dl,[.color]
        mov     byte [di],dl


;//////////////////////////////////////////////////////////////////////////////;
;///   Deinitialization code.                                               ///;
;//////////////////////////////////////////////////////////////////////////////;

; Restore register state.
        pop     ds
        pop     di
        pop     dx

; Free local variable stack space.
        add     sp,6
  
; Release stack frame and return.
        pop     bp
        ret