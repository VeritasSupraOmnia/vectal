; Read function definitions for assembly functions with remappable regs.
fproc_define:
; Copy the function metadata even though the function might be invalid. 
 θ+f θ=b* [nfuncs] θζ=a* [rsi] ζ=*a [funcnamechars+rbx]  θ=*p [funcpointers+(rbx*4)]
 λλ=a* [rsi] θ≪b# 5 λλ=*a [funcnames+rbx] λ≰hoa 
 θλ↯jh θ⋖jj θ=kb 
 θ=cf

.findendloop: λλ=a* [rsi] λ≟aaj θλ↯aa θ⋖aa θ+fa 
 θ≟fd ΓΓ∘# .handleopenended θ≟a# 32 ι∘# .findendloop

 θ⇋cf θ=bc θ=ap θ+fj ζ=*# [funcnames+r10+r9] 3  ζ=*# [rbx] 0 θ=ib θ+b θ-if θ-ij

.copyloop: λλ=a* [rsi] λλ=*a [rax] θ+a# 32 θ+f# 32 θ≟fb βι∘# .copyloop

; Update pointer registernfuncs count and return.
 θ=fb θ+* [nfuncs] θ=a* [nfuncs] θ-bc θ+pi ret ;η∘# mainloop

.handleopenended: θ=fc η∘# fproc_notfound
