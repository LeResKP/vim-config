function! GetCurrentPythonStringForStatusBar()
    " TODO: support: if __name__ == '__main__':

    " Define the style to display the class name and function name
    let classHi = '%#statusbar_class#'
    let functionHi = '%#statusbar_function#'
    let punctuationHi = '%#perso1#'

    " Search the first class method definition before the current position
    let classFunctionLineNumber = search('^    def', 'bncW')

    " Search the first function definition before the current position
    let simpleFunctionLineNumber = search('^def', 'bncW')

    " Search the first class definition before the current position
    let classLineNumber = search('^class', 'bncW')


    let className = classHi.substitute(getline(classLineNumber), '^class \([^(: ]*\).*', '\1', '')

    if classFunctionLineNumber < classLineNumber && simpleFunctionLineNumber < classLineNumber
        " We have found in first a class definition so we only return it
        return className
    endif

    if classFunctionLineNumber < simpleFunctionLineNumber
        " the function definition is found before the a method so we only return the function name
        return functionHi.substitute(getline(simpleFunctionLineNumber), '^[ ]*def \([^( ]*\).*', '\1', '')
    endif
        
    " return the class and the function name
    return className.punctuationHi.'.'.functionHi.substitute(getline(classFunctionLineNumber), '^[ ]*def \([^( ]*\).*', '\1', '')

endfunction


function! GetMainStatusBar()
    return '%#perso1#%F   '.GetCurrentPythonStringForStatusBar().' %#perso1#%=buffer %0n  %4l/%-4L %3p%% %3c'
endfunction


function! GetSecondaryStatusBar()
    return '%#SpecialKey#%{getcwd()}      %F'
endfunction


let s:statusline={0: '%!GetMainStatusBar()', 1:'%!GetSecondaryStatusBar()' }
let s:currentStatusLine = 1

function! ToggleStatusLine()
    let s:currentStatusLine = s:currentStatusLine + 1
    if (s:currentStatusLine > 1)
        let s:currentStatusLine=0
    endif
    let &statusline=s:statusline[s:currentStatusLine]
endfunction

call ToggleStatusLine() "Init
map <silent><C-space> :call ToggleStatusLine()<CR>
