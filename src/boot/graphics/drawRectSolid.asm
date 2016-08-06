;//////////////////////////////////////////////////////////////////////////////;
;///   void drawRectSolid(int x, int y, int width, int height, int color)   ///;
;//////////////////////////////////////////////////////////////////////////////;

; Label for procedure.
drawRectSolid:


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
%define         .arg3           bp+10
%define         .arg4           bp+12

; Define aliases for local variables.
%define         .x              bp-10
%define         .y              bp-8
%define         .width          bp-6
%define         .height         bp-4
%define         .color          bp-2

; Allocate space for local variables on the stack.
        sub     sp,10

; Make local copies of arguments.
        mov     ax,[.arg0]               
        mov     [.x],ax
        mov     ax,[.arg1]
        mov     [.y],ax
        mov     ax,[.arg2]
        mov     [.width],ax  
        mov     ax,[.arg3]
        mov     [.height],ax  
        mov     ax,[.arg4]
        mov     [.color],ax  

; Preserve register state.
        push    bx
        push    cx
        push    dx
        push    di
        push    es


;//////////////////////////////////////////////////////////////////////////////;
;///   Procedure code.                                                      ///;
;//////////////////////////////////////////////////////////////////////////////;

        mov     ax,GFXSEG
        mov     es,ax
        mov     ax,[.y]
        mov     di,320
        mul     di
        add     ax,[.x]
        mov     dx,ax
        mov     bx,[.height]
        test    bx,bx
        jz      .exit
.loop:  mov     di,dx
        mov     al,[.color]
        mov     cx,[.width]
        rep stosb
        add     dx,320
        dec     bx
        jnz     .loop
.exit:


;//////////////////////////////////////////////////////////////////////////////;
;///   Deinitialization code.                                               ///;
;//////////////////////////////////////////////////////////////////////////////;

; Restore register state.
        pop     es
        pop     di
        pop     dx
        pop     cx
        pop     bx

; Free local variable stack space.
        add     sp,10
  
; Release stack frame and return.
        pop     bp
        ret