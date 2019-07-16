if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='lereskp'

" https://jonasjacek.github.io/colors/

hi Normal	ctermfg=249 ctermbg=235
" TODO find why italic isn't working
hi Comment gui=italic ctermfg=242
" Preproc
hi Include ctermfg=74
hi Constant ctermfg=217
hi Constant ctermfg=150
hi Special ctermfg=203
hi Function ctermfg=142
" def / return
hi Statement ctermfg=167
hi Error ctermfg=1 ctermbg=NONE
hi ALEWarningSign ctermfg=11 ctermbg=NONE term=NONE
hi SpellBad ctermfg=1 ctermbg=NONE cterm=underline

hi ALEInfo ctermfg=1 ctermbg=NONE cterm=underline
hi ALEWarning ctermfg=NONE ctermbg=NONE cterm=NONE

hi Type ctermfg=149

" TODO alias to Function
hi htmlTagName ctermfg=142
hi htmlEndTag ctermfg=142

hi djangoTagBlock ctermfg=74
hi htmlH1 ctermfg=249


hi Identifier ctermfg=142 cterm=NONE
" ctermfg=148
