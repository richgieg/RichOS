[bits 16]
[cpu 386]

;//////////////////////////////////////////////////////////////////////////////;
;///   Segment pointer definitions.                                         ///;
;//////////////////////////////////////////////////////////////////////////////;

TEXTSEG         equ     0xb800  ; Text mode video segment.


;//////////////////////////////////////////////////////////////////////////////;
;///   Procedure inclusions.                                                ///;
;//////////////////////////////////////////////////////////////////////////////;

%include "text/putc.asm"
%include "text/puts.asm"
%include "text/textMode.asm"