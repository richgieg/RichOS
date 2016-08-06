[bits 32]
[cpu 386]

;//////////////////////////////////////////////////////////////////////////////;
;///   void _memcpy_asm(int *destination, const int *source, size_t num)    ///;
;//////////////////////////////////////////////////////////////////////////////;

; Label for procedure.
global _memcpy_asm
_memcpy_asm:


;//////////////////////////////////////////////////////////////////////////////;
;///   Initialization code.                                                 ///;
;//////////////////////////////////////////////////////////////////////////////;

; Create stack frame.
        push    ebp
        mov     ebp,esp

; Define aliases for arguments.
%define         .arg0           ebp+8
%define         .arg1           ebp+12
%define         .arg2           ebp+16

; Define aliases for local variables.
%define         .destination    ebp-12
%define         .source         ebp-8
%define         .num            ebp-4
 
; Allocate space for local variables on the stack.
        sub     esp,12

; Make local copies of arguments.
        mov     eax,[.arg0]               
        mov     [.destination],eax
        mov     eax,[.arg1]
        mov     [.source],eax
        mov     eax,[.arg2]
        mov     [.num],eax

; Preserve register state.
        pushad
  
  
;//////////////////////////////////////////////////////////////////////////////;
;///   Procedure code.                                                      ///;
;//////////////////////////////////////////////////////////////////////////////;

        mov     ecx,[.num]
        mov     edi,[.destination]
        mov     esi,[.source]
        rep movsd


;//////////////////////////////////////////////////////////////////////////////;
;///   Deinitialization code.                                               ///;
;//////////////////////////////////////////////////////////////////////////////;

; Restore register state.
        popad

; Free local variable stack space.
        add     esp,12

; Release stack frame and return.
        pop     ebp
        ret