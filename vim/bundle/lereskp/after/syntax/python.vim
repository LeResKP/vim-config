hi py_params guifg=#EEEEEE
hi link py_symbol LineNr

syn match py_symbol /[\(\)\[\]\{\}\,\=]/
syn region py_params start=+[^ ]=[^ ]+hs=s+2 end=+[,: ]+ contains=py_symbol
