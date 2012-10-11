let g:snips_trigger_key='<c-space>' " Disable <Tab> in snipMate
inoremap <Tab> <C-R>=IntelligentTab()<CR>
map  <Tab> I<tab>
imap <expr><CR> pumvisible() ? "\<C-y>" : "\<CR>"


function! IsSnippet()
	let word = matchstr(getline('.'), '\S\+\%'.col('.').'c')
	let lis = snipMate#GetSnippetsForWordBelowCursor(word, '',  1)
    if len(lis)
        return 1
    endif
    return 0
endfunction

function! IntelligentTab()
    " Get the text before the cursor
    let l:textBeforeCursor = strpart(getline('.'), 0, col('.')-1)

    if pumvisible()
        " The popup menu is open
	    return "\<C-N>"
    endif

    if IsSnippet()
        return snipMate#TriggerSnippet()
    endif

    if (exists('b:omni_func'))
        if funcref#Call(b:omni_func, [l:textBeforeCursor])
            return "\<C-x>\<C-o>"
        endif
    endif

    if l:textBeforeCursor =~ '^\s*$'
	    return "\<Tab>"
    else
	"use know-word completion
	    return "\<C-N>"
    endif
endfunction

au BufAdd,BufEnter * :runtime! config/default.vim <CR>
" Load special config file for css files
au BufAdd,BufEnter *.\(css\|scss\) :runtime! config/css.vim <CR>

