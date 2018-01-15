call pathogen#infect()
set t_Co=256
" let g:syntastic_enable_signs = 0
" let g:syntastic_enable_balloons = 0
" let g:syntastic_enable_highlighting = 0

if &term =~ '^screen'
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline#extensions#tagbar#flags = 'f'

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
" If defined it breaks the shortcut mapping
" https://github.com/mileszs/ack.vim/issues/197
" let g:ack_qhandler = "botright vertical copen 80"

nnoremap qk :Ack! <C-R>=expand("<cword>") <CR><CR>

map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>
