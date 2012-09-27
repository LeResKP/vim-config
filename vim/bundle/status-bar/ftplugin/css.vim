if exists("b:status_bar_func")
  finish
endif

function! GetCurrentCssStringForStatusBar()
  let clnum = getpos('.')[1]
  let lnum=clnum
  let lis = []
  while 0 < lnum
    let line = getline(lnum)
    if stridx(line, '}') != -1 &&  lnum != clnum
      let lin = indent(lnum)
      if lin == 0
        break
      endif

      while lin <= indent(lnum) && lnum > 0
        let lnum = prevnonblank(lnum-1)
      endwhile
    endif
    let line = getline(lnum)
    if match(line, '[;}] *$') == -1
      let v = substitute(line, '^[ ]*\([^\{]*\).*', '\1', '')
      call insert(lis, v)
    endif
    let lnum = prevnonblank(lnum-1)
  endwhile
  return join(lis)
endfunction

let b:status_bar_func=funcref#Function('GetCurrentCssStringForStatusBar')
