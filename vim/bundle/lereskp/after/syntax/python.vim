hi py_params guifg=#EEEEEE
hi link py_symbol LineNr

syn match py_symbol /[\(\)\[\]\{\}\,\=]/
syn region py_params start=+[^ ]=[^ ]+hs=s+2 end=+[\n,: ]+ contains=py_symbol,pythonString,py_params
