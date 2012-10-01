function! GetMainStatusBar()
  let extra = ''
  if exists("b:status_bar_func")
    let extra = funcref#Call(b:status_bar_func)
  endif
  return '%#statusbar#%F   '.extra.' %#statusbar#%=buffer %0n  %4l/%-4L %3p%% %3c'
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
