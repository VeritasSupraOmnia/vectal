; Include whole files as function libraries into the program file to be invoked.
; Uses {!./path/to/function_library.vl} as the syntax to include the program.
; Only one level of inclusion - no C autism here.
fproc_include: θ=cf θ+f θ=bf
; Find the end of the path definition by its ending curly brace. 
.pathload: λ≟aj* [rsi] θλ↯aa θ⋖aa θ+fa θ≟fd μι∘# .openended θ≟a# 32 ι∘# .pathload
 ζ=*# [rsi] 0
; Push all registers.
ι⫰a ι⫰b ι⫰c ι⫰d ι⫰e ι⫰f ι⫰i ι⫰j ι⫰k ι⫰l ι⫰m ι⫰n ι⫰o
; Open the file
 θ=eb θ=a# 2 θ⊽ff syscall
; Read the file
 ι⫰a θ=ea θ⊽aa θ=f# incfilebuff θ=d# bsize syscall
; Close the file
 ι⫯e ι⫰a θ≟a# 0 ι∘# .emptyfile θ=a# 3 syscall
; Set up scan of file
 ι⫯d θ=f# incfilebuff θ+df 
; Scan through the file buffer and call fproc_define when a definition is found.
.scan: λ≟ai* [rsi] θλ↯aa θ⋖aa θ+fa θ≟fd μι∘# .exitscan θ≟a# 32 ι∘# .scan
; Call the define function - might break if the 
.dodefine: θ+f ι⫱# fproc_define θ≟fd μι∘# .exitscan η∘# .scan
; Pop all registers.
.exitscan:
ι⫯o ι⫯n ι⫯m ι⫯l ι⫯k ι⫯j ι⫯i ι⫯f ι⫯e ι⫯d ι⫯c ι⫯b ι⫯a 
ret
.emptyfile:
ι⫯o ι⫯n ι⫯m ι⫯l ι⫯k ι⫯j ι⫯i ι⫯f ι⫯e ι⫯d ι⫯c ι⫯b ι⫯a 
.openended: 
.nopath: θ=fc η∘# fproc_notfound
