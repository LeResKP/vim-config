call plug#begin()
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --js-completer --ts-completer'}
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" tagbar is needed for airline to display current class and function
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'BenBergman/vsearch.vim'
Plug 'tpope/vim-commentary'

Plug '~/.vim/bundle/lereskp'
Plug '~/.vim/bundle/gymglish'

Plug 'tweekmonster/django-plus.vim'
Plug 'raimondi/delimitmate'

" Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'



Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
" Plug 'garbas/vim-snipmate'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Themes
" color too yellow
Plug 'morhetz/gruvbox'
Plug 'rhysd/wallaby.vim'
" bg too light
Plug 'jnurmine/Zenburn'
Plug 'HenryNewcomer/vim-theme-papaya'
Plug 'vim-scripts/xoria256.vim'

Plug 'Yggdroot/indentLine'

" Plug 'zxqfl/tabnine-vim'

" Plug 'chriskempson/base16-vim'
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'tomasr/molokai'
" Plug 'sonph/onehalf'
" Plug 'ciaranm/inkpot'
" Plug 'joshdick/onedark.vim'
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
" By default it opens like a popup centered but sometimes the layout didn't
" refreshed properly and also ctrl+w isn't working inside
let g:fzf_layout = { 'down': '~40%' }
if executable('fzf')
  nnoremap <silent> qp :FZF -m<cr>
  nnoremap <silent> qb :Buffers<cr>
  nnoremap <silent> qh :History<cr>
  nnoremap <silent> qt :Tags<cr>
  nnoremap <silent> qs :Ag <C-R>=expand('<cword>')<CR><CR>

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

let g:ack_default_options = " -H --nopager --nocolor --nogroup --column"
" let g:ack_qhandler = "botright vertical copen 80"

""" " If defined it breaks the shortcut mapping
""" " https://github.com/mileszs/ack.vim/issues/197
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
""" "
""" " let g:ale_python_pylint_options = '--py3k'
" let g:ale_set_highlights=0
"
"
" let g:ale_linters = {}
" let g:ale_linters.python = ['flake8', 'mypy', 'pylint', 'pycodestyle', 'pyflakes']
let g:ale_sign_warning = '>>'
let g:ale_python_pylint_options = '--disable C0111'
let g:ale_xml_xmllint_options = '-valid'

nmap <C-S-I> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_semantic_triggers = {'python': ['re!from\s+\S+\s+import\s']}
let g:ycm_global_ycm_extra_conf = '~/dev/github/dotfiles/dotycm_extra_conf.py'



" imap <expr> <C-J> pumvisible() ? '<esc><Plug>snipMateNextOrTrigger' : '<Plug>snipMateNextOrTrigger'

autocmd BufWritePost * GitGutter
" let g:ycm_collect_identifiers_from_tags_files = 1
"
"
" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'




" " make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'

" " better key bindings for UltiSnipsExpandTrigger
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
