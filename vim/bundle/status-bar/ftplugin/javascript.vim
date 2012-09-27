if exists("b:status_bar_func")
  finish
endif


function! GetFunctionName(line)

  let v = substitute(a:line, '.*function *\([^ (]*\).*', '\1', '')
  let v = substitute(v, ' ', '', 'g')
  if v != ''
    return v
  endif

  let v = substitute(a:line, '[^ ]* *\([^ ]*\) *= *function.*', '\1', '')
  let v = substitute(v, ' ', '', 'g')
  if v != ''
    return v
  endif

  return 'Function name not found'

endfunction

function! GetCurrentJavascriptStringForStatusBar()
  let clnum = getpos('.')[1]
  let lnum = clnum
  let lis = []
  let plint = -1

  while lnum > 0
    let line = getline(lnum)

    if stridx(line, '}') != -1 && lnum != clnum
      let plint = indent(lnum)
    endif

    while indent(lnum) >= plint
      if plint == -1
        break
      else
        let lnum = prevnonblank(lnum-1)
      endif
    endwhile

    let line = getline(lnum)
    let m = matchstr(line, 'return')
    if m != ''
      break
    endif
    let m = matchstr(line, 'function.*(')
    if m != ""
      let name = GetFunctionName(line)
      let plint = indent(lnum)
      call insert(lis, name)
    endif
    if indent(lnum) == 0 && clnum != lnum
      break
    endif

    let lnum = prevnonblank(lnum-1)
  endwhile

  return join(lis)

endfunction

let b:status_bar_func=funcref#Function('GetCurrentJavascriptStringForStatusBar')
