" Tab mapping
inoremap <Tab> <C-R>=IntelligentTab()<CR>
map  <Tab> I<tab>


" We need to update ~/.vim/bundle/snipMate/plugin/snipMate.vim to make
" GetSnippet callable. Add the following lines
" fun! GetSnippet(word, scope)
" 	return s:GetSnippet(a:word, a:scope)
" endf
"
function! IsSnippet()
	let word = matchstr(getline('.'), '\S\+\%'.col('.').'c')
	for scope in [bufnr('%')] + split(&ft, '\.') + ['_']
		let [trigger, snippet] = GetSnippet(word, scope)
		" If word is a trigger for a snippet, delete the trigger & expand
		" the snippet.
		if snippet != ''
            return 1
		endif
	endfor
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
        return TriggerSnippet()
    endif

    if UseOmniCompletion(l:textBeforeCursor)
        return "\<C-x>\<C-o>"
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
