call plug#begin()
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'BenBergman/vsearch.vim'
Plug '~/.vim/bundle/lereskp'
Plug '~/.vim/bundle/gymglish'
call plug#end()

set backspace=indent,eol,start

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline#extensions#tagbar#flags = 'f'

" fzf
""" let $FZF_DEFAULT_COMMAND = 'ag -a -l -g ""'
let $FZF_DEFAULT_COMMAND = 'ag -f -U -l -g ""'
let $FZF_DEFAULT_OPTS = '--no-mouse'
if executable('fzf')
  nnoremap <silent> qp :FZF -m<cr>
  nnoremap <silent> qb :Buffers<cr>
  nnoremap <silent> qh :History<cr>
  nnoremap <silent> qt :Tags<cr>

  " Use fuzzy completion relative filepaths across directory
  imap <expr> <c-x><c-f> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

  " Better command history with q:
  command! CmdHist call fzf#vim#command_history({'right': '40'})
  nnoremap q: :CmdHist<CR>

  " Better search history with a/
  command! QHist call fzf#vim#search_history({'right': '40'})
  nnoremap q/ :QHist<CR>

  " command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'down': '40%', 'options': --no-color'})
end


""" " call pathogen#infect()
""" set t_Co=256
""" " let g:syntastic_enable_signs = 0
""" " let g:syntastic_enable_balloons = 0
""" " let g:syntastic_enable_highlighting = 0
""" 
if &term =~ '^screen'
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
""" 
""" 
""" cnoreabbrev Ack Ack!
""" nnoremap <Leader>a :Ack!<Space>
""" let g:ack_default_options = " -H --nopager --nocolor --nogroup --column"
""" " If defined it breaks the shortcut mapping
""" " https://github.com/mileszs/ack.vim/issues/197
""" let g:ack_qhandler = "botright vertical copen 80"
""" let g:ack_apply_qmappings = 1
""" 
""" nnoremap qk :Ack! <C-R>=expand("<cword>") <CR><CR>
""" 
""" map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
""" map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
""" map ,s :split <C-R>=expand("%:p:h") . "/" <CR>
""" 
""" 
""" 
""" cnoremap w!! w !sudo tee > /dev/null %
""" 
""" set cpt=.,w,b,u,t,i,k/home/aurelien/a9engine/expert/A9/*.py
""" 
""" 
""" let $FZF_DEFAULT_COMMAND = 'ag -f -U -l -g ""'
""" let $FZF_DEFAULT_OPTS = '--no-mouse'
""" 
""" 
""" " let g:ale_fixers = {}
""" " let g:ale_fixers.python = ['autopep8', 'trim_whitespace']
""" "
""" " let g:ale_linters = {}
""" " let g:ale_linters.python = ['flake8', 'mypy', 'pylint', 'pycodestyle', 'pyflakes']
""" "
""" let g:ale_python_pylint_options = '--disable C0111'
""" " let g:ale_python_pylint_options = '--py3k'
