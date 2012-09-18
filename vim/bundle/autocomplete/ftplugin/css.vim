if exists("b:omni_func")
    finish
endif

function! UseOmniCompletion(textBeforeCursor)
    if a:textBeforeCursor =~ '^  '
        " We want to find a property
        if a:textBeforeCursor =~ '#[^\s]*$'
            " We want to find a color
            return 0
        endif
        return 1
    endif
    return 0
endfunction

let b:omni_func=funcref#Function('UseOmniCompletion')
