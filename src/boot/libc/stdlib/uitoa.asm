;//////////////////////////////////////////////////////////////////////////////;
;///   char * uitoa(int value, char * str)                                   ///;
;//////////////////////////////////////////////////////////////////////////////;

; Label for procedure.
uitoa:


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
%define         .value          bp-4
%define         .str            bp-2
 
; Allocate space for local variables on the stack.
        sub     sp,4

; Make local copies of arguments.
        mov     ax,[.arg0]               
        mov     [.value],ax
        mov     ax,[.arg1]
        mov     [.str],ax

; Preserve register state.
        push    bx
        push    cx
        push    dx
  
  
;//////////////////////////////////////////////////////////////////////////////;
;///   Procedure code.                                                      ///;
;//////////////////////////////////////////////////////////////////////////////;

        mov     bx,[.str]
        mov     cx,10000
.loop:  mov     ax,[.value]
        sub     dx,dx
        div     cx
        test    al,al      
        jnz     .concat
        cmp     bx,[.str]
        jz      .skip_concat
.concat:        
        add     al,'0'
        mov     [bx],al
        inc     bx
.skip_concat:
        mov     [.value],dx
        mov     ax,cx
        mov     cx,10
        sub     dx,dx
        div     cx
        test    al,al
        jz      .exit_loop
        mov     cx,ax
        jmp     .loop
.exit_loop:
        cmp     bx,[.str]
        jnz     .terminate_string
        mov     byte [bx],'0'
        inc     bx
.terminate_string:
        mov     byte [bx], 0


;//////////////////////////////////////////////////////////////////////////////;
;///   Deinitialization code.                                               ///;
;//////////////////////////////////////////////////////////////////////////////;

; Restore register state.
        pop     dx
        pop     cx
        pop     bx

; Free local variable stack space.
        add     sp,4

; Return value.
        mov     ax,[.str]

; Release stack frame and return.
        pop     bp
        ret