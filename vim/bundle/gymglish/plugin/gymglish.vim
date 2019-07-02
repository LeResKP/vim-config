set tags=~/tags-a9engine.tags

nmap ,n :call OpenTabTag()<CR>
nmap ,b :call OpenTag()<CR>

function! OpenTabTag()
    " Execute tag jump open file if one open tag, otherwise display all possibilities
    exe ":tabe | tj ".expand("<cword>")
    if expand('%') == ''
        " If we cancel or don't find tag we close the empty opened tag
        exe ":tabc"
    endif
endfunction


function! OpenTag()
    " Execute tag jump open file if one open tag, otherwise display all possibilities
    exe ":e | tj ".expand("<cword>")
    " if expand('%') == ''
    "     " If we cancel or don't find tag we close the empty opened tag
    "     exe ":q"
    " endif
endfunction


function! OpenSplitTag()
    " Execute tag jump open file if one open tag, otherwise display all possibilities
    
    exe ":sp | tj ".expand("<cword>")
    if expand('%') == ''
        " If we cancel or don't find tag we close the empty opened tag
        exe ":q"
    endif
endfunction


function! OpenTestTag()
    " Open test file and go to the test function if we find it.
    " Execute tag jump open file if one open tag, otherwise display all possibilities
    exe ":tabe | tj /test_\\?".expand("<cword>")
    if expand('%') == ''
        " If we cancel or don't find tag we close the empty opened tag
        exe ":tabc"
    endif
endfunction



nmap ;c :call RunTest()<CR>
nmap ;t :call RunTests()<CR>
" nmap ;g :call PyGrep()<CR>
nmap ;g :call GrepExt()<CR>

" TODO: we should check /tmp/vim exists
function! RunTests()
    " exe ":silent !echo python ".expand("%")." --my > /tmp/vim"
    " exe ":exe \"silent !python ".expand("%")." --my > /tmp/vim 2>&1 &\" | redraw! "
    exe ":TmuxShell python ".expand("%")." --my"
endfunction

function! RunTest()
    " exe ":silent !echo python ".expand("%")." --my ".GetCurrentPythonString()."> /tmp/vim"
    " exe ":exe \"silent !python ".expand("%")." --my ".GetCurrentPythonString()."> /tmp/vim 2>&1 &\" | redraw! "

    exe ":TmuxShell python ".expand("%")." --my ".GetCurrentPythonString()
endfunction

function! PyGrep()
    " exe ":silent !echo pygrep ".expand("<cword>")."> /tmp/vim"
    " exe ":exe \"silent !pygrep.sh ".expand("<cword>")."> /tmp/vim 2>&1 &\" | redraw! "
    exe ":TmuxShell ack --py ".expand("<cword>")
endfunction

function! GrepExt()
    call inputsave()
    let name = input('ack type (py): ')
    call inputrestore()
    if name == ''
        let name = 'py'
    endif
    if name != '*'
        let name = '--'.name
    else
        let name = ''
    endif
    exe ":TmuxShell ack ".name." ".expand("<cword>")
endfunction
