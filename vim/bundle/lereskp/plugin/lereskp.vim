syntax on
filetype plugin indent on

set nocompatible
set bs=eol,indent,start
set directory=~/.vim/bundle/lereskp/backup_files/ " put swap file in this directory
set bdir=~/.vim/bundle/lereskp/backup_files/
set bk "make a backup of the file !!!
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set bg=dark

set laststatus=2
set hls
set incsearch
set sm            "affiche parenthese ouvrante quand ecrit parenthese fermante

set ignorecase    "Ignore la casse lors des recherches
set smartcase     "Ignore la casse lors des recherches sauf si une majuscule est utilisée
set autoindent    "Active indentation automatique
set smartindent   "Indentation automatique intelligente
set cindent
set smarttab

" Try this if cindent doesn't work as smartindent
" set smartindent
" inoremap # X^H#
" set autoindent

set fileformats=unix,dos,mac

" Command autocomplete
set wildmode=list:longest  " When more than one match, list all matches and
			               " complete till longest common string
" Insertion autocomplete
" set completeopt=menu,longest
set completeopt=menuone,longest,preview

" Include just word in current and opened tabs for completion
set cpt=.,w,b

" We need this because of smartcase. When we make a search with '*' or '#' we
" want to active case sensitive.
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

colorscheme desertTerm
if has("gui_running")
    colorscheme desert
endif

" Custom syntax
runtime! syntax/syntax.vim
au BufEnter,BufCreate,BufRead,WinEnter * call matchadd('TrailingWhitespace', '\s\+$', -1)

" When editing a file, always jump to the last known cursor position.
" Don't do it in commit log or when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
function! PositionCursorFromViminfo()
  if !(bufname("%") =~ '\(COMMIT_EDITMSG\)') && line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g`\""
  endif
endfunction
au BufReadPost * call PositionCursorFromViminfo()

"
" Personnal mapping
"
map  <S-Left> <Esc>gT
imap <S-Left> <Esc>gT
map  <S-Right> <Esc>gt
imap <S-Right> <Esc>gt
" Set same mapping as 'Konsole' to move Tab
map <silent><C-S-Right> <Esc>:call MoveTab(1)<CR>
map <silent><C-S-Left>  <Esc>:call MoveTab(-1)<CR>

map  <C-s> :w<Return>
imap <C-s> <Esc>:w<Return>

map <F4> :call Gitdiff()<CR>

nmap ,t :call GetLineToRunTest()<CR>



"
" Shortcuts
"

" Prepare to open file in same directory of the current one
nmap ,c :tabe <C-R>=expand('%:h').'/'<CR><C-d>
nmap ,v :tabe <C-d>
" Mapping pour désactiver le surlignage des résultats d'une recherche
nnoremap <silent> <C-N> :noh<CR>

"
"tab is 2 spaces in html pages
au BufEnter *.\(html\|pt\|zpt\|cpt\|mako\|css\|tmpl\|scss\) setl softtabstop=2 shiftwidth=2


function! MoveTab(val)
  " Move current Tab
  " If val = 1  : move after next tab
  " If val = -1 : move before previous tab

  " Warning: with tabpagenr the first tab page has number 1.
  let currentTab = tabpagenr() + a:val - 1
  
  if currentTab < 0
      let currentTag = tabpagenr('$') "Last tab
  endif

  if currentTab == tabpagenr('$')
    let currentTab = 0
  endif

  " Set focus on tab pos
  " Note: 0 is the first
  exe ':tabm ' . currentTab
endfunction


function! Gitdiff()
    let diffFileName = expand('%')
    tabe 
    exec ".!git di " . diffFileName
    set ft=diff 
endfunction

function! GetCurrentPythonString()
    " Same as GetCurrentPythonStringForStatusBar without color
    " TODO: support: if __name__ == '__main__':

    let classHi = '%#statusbar_class#'
    let functionHi = '%#statusbar_function#'
    let punctuationHi = '%#perso1#'

    " Search the first class method definition before the current position
    let classFunctionLineNumber = search('^    def', 'bncW')

    " Search the first function definition before the current position
    let simpleFunctionLineNumber = search('^def', 'bncW')

    " Search the first class definition before the current position
    let classLineNumber = search('^class', 'bncW')


    let className = substitute(getline(classLineNumber), '^class \([^(: ]*\).*', '\1', '')

    if classFunctionLineNumber < classLineNumber && simpleFunctionLineNumber < classLineNumber
        " We have found in first a class definition so we only return it
        return className
    endif

    if classFunctionLineNumber < simpleFunctionLineNumber
        " the function definition is found before the a method so we only return the function name
        return substitute(getline(simpleFunctionLineNumber), '^[ ]*def \([^( ]*\).*', '\1', '')
    endif
        
    " return the class and the function name
    return className.'.'.substitute(getline(classFunctionLineNumber), '^[ ]*def \([^( ]*\).*', '\1', '')

endfunction


function! GetLineToRunTest()
    echo 'pyssh '.expand('%:p').' --my '. ' '.GetCurrentPythonString()
endfunction
