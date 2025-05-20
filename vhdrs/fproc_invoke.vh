; Invoke a function you have already defined. Search for it, convert registers to
;  their requirements and copy to the site of the invokation. Only converts the
;  registers you tell it to, so if registers don't need to be saved from scratching,
;  you don't need to specifically reassign them. 
; Offers two methods to reassign registers: explicitly mapping, where two registers
;  are given as replacement then target, and implicit mapping, where only the
;  replacement is given and the target is assumed to be the next register in the
;  alphabetical sequence. This implicit conversion can, hovever, be skipped at start.
; Max 32 remaps at once (high number because of future immediate and  memory remaps).
fproc_invoke:
; Scan for and verify the end exists just like in fproc_define.
 θ=cf θ=m# 32
.endscan: 
 λλ=a* [rsi] λ≟aaj θλ↯aa θ⋖aa θ+fa θ≟fd ΓΓ∘# .openended θ≟a# 32 ι∘# .endscan
; Search for function name among the function names.
; Do a rough search first by starting letter then verify with simd check.
 θ=fc θ+f λ⊱h* [rsi] λλ=b* [rsi] λ≰cob θλ↯ac θ⋖ia θ+fi θ⊽jj θ=l* [nfuncs]
.fnamefind:
 θ≟jl μι∘# .notfound λ≟ah* [r9+funcnamechars] θλ↯aa θ⋖aa θ+ja θ≟a# 32 ι∘# .fnamefind
 θ=kj θ≪k# 5 λ≟ab* [r10+funcnames] θλ↯aa θ~a θ⋖aa 
 θ≟ai ι∘# .fnamefound θ+j η∘# .fnamefind
; Now copy whole function text while changing register names to their required names.
.fnamefound:
 θ=oa θ=a* [funcpointers+(r9*4)] ; First grab the pointer to index's function text.
 θ=ne θ⊽cc ; Copy the function text to the output buffer and save the output location.
.fcopy: λλ=a* [rax] λλ=*a [rdi] λ≟bal θλ↯bb θ⋖bb θ+ab θ+eb θ+cb θ≟bm ι∘# .fcopy
; Search through invokation text and build a r2r map to check regs against.
θ=en θ⊽bb θ⊽jj λλ=*l [funcinvokeargs] λλ=*l [funcinvokeargs+32] 
; Skip whitespace to next token.
.bldr2rmap: λλ=a* [rsi] λ≰aam θλ↯aa θ⋖aa θ+fa ζ≟*# [rsi] '}' ι∘# .buildcomplete  
; Copy remapping to arg list.
 η=a* [rsi] ζ=*a [r9+funcinvokeargs] θ≫a# 8 ζ=*a [r9+funcinvokeargs+32] θ+j θ+f# 2
 η∘# .bldr2rmap ; Keep searching each token until all of them are used in the map.
.buildcomplete: 
; Finish the build by adding the '*' and '#' arguments to the map as identity maps.
θ+f  η=*# [r9+funcinvokeargs] "*#" η=*# [r9+funcinvokeargs+32] "*#" θ+j# 2
; Now remap every argument in the function text. 
; Skip whitespace to next token.
.nextinstruction:
 λλ=a* [rdi] λ≟bal λ≰aam λλ⋁aab θλ↯aa θ⋖aa θ+ea 
; If the token starts with 0x0 then remap is complete elsh go to end of the token.
 θζ=b* [rdi] ζ≟b# 0 ι∘# .remapcomplete  λλ=a* [rdi] λ≰aoa θλ↯aa θ⋖aa θ+ea θ=ne
; Check if it's an instruction otherwise no need to remap args so skip to next token.
 ζ≟b# 0x80 μι∘# .nextinstruction θ=ie λλ=c* [funcinvokeargs]
; Systematically check each argument backwards and remap them if in list.
.argremaploop:
 θ-i λ⊱b* [r8] λ≟abc θλ↯aa θ⋖aa ; Find the corresponding argument.
 θ≟ni μι∘# .nextinstruction ; If whole instruction is changed.
 θζ=a* [rax+funcinvokeargs+32] ζ=*a [r8] η∘# .argremaploop
.remapcomplete: ret ;η∘# mainloop
.notfound:
.openended: θ=fc η∘# fproc_notfound
