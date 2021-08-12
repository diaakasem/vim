"=======================================================================
" Author : Diaa Mohamed Kasem
" Date   : 24 May 2012
" VIM Configuration File
"=======================================================================

" change the leader to be a comma vs slash
let mapleader=","

" Enable man pages
runtime ftplugin/man.vim

" =============================================================================
" Refactor a variable name in python
" =============================================================================
function! Refactor()
  call inputsave()
  let @z=input("What do you want to rename '" . @z . "' to? ")
  call inputrestore()
endfunction

" =============================================================================
" Making command R that opens a new window with the output of the following command
" =============================================================================
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | silent r !<args>

" ============================
" Set ft based on extensions
" ============================
" Sets extensions for files with goto file to help with js imports
augroup suffixes
  autocmd!
  let associations = [
        \["javascript", ".js,.javascript,.es,.esx,.json"],
        \["css", ".css,.less,.scss"],
        \["html", ".htm,.html,.xhtml,.tmpl"],
        \["ts", ".typescript"],
        \["arduino", ".ino"],
        \["yaml", ".yml,.yaml"],
        \["yaml", ".yml,.yaml"],
        \["shell", ".csh,.sh,.bash"],
        \["vimrc", ".vimrc,vimrc"],
        \["python", ".py,.pyw"]
        \]
  for ft in associations
    execute "au! BufNewFile,BufRead,BufEnter *" . ft[1] . " setlocal filetype=" . ft[0]
    execute "au FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
  endfor
augroup END

" ===============
" Basic Settings
" ===============
" syntax highlighing
syntax on
syntax enable
filetype plugin on
" enable loading indent file for filetype
filetype plugin indent on
" always set autoindenting on
set autoindent
" We are using dark background in vim
set background=dark
" Allow backspacing over autoindent, EOL, and BOL
set backspace=2
" Change backupdir ,/var/tmp,/tmp
set backupdir=~/.vim/tmp,~/.tmp,~/tmp
" Make command line two lines high
set ch=1
set cindent
" Add the unnamed register to the clipboard
set clipboard+=unnamedplus
" set clipboard+=unnamed
set colorcolumn=80
set completeopt=menuone,longest


" Y-N-C prompt if closing with unsaved changes.
set confirm
" have a line indicate the cursor location
set cursorline
" Add ignorance of whitespace to diff
set diffopt+=iwhite
" ,/var/tmp,/tmp
set directory=~/.vim/tmp,~/.tmp,~/tmp
" Use spaces, not tabs, for autoindent/tab key.
set expandtab
" Try recognizing dos, unix, and mac line endings.
set ffs=unix,dos,mac
set fillchars +=stl:\ ,stlnc:\
" get rid of the silly characters in separators
set fillchars=""
" this is just what i use
set foldlevel=1
" fold based on syntax ( indent, syntax, manual )
set foldmethod=indent
" deepest fold is 10 levels
set foldnestmax=99
set guioptions+=a
" Better handling for the buffers
set hidden
" Set the commands history to 1000
set history=1000
" Highlight searches by default.
set hlsearch
" Default to using case insensitive searches,
set ignorecase
" Incrementally search while typing a /regex
set incsearch
" Set the filename:linenumber delimiter to be colon
set isfname-=:
" Always show statusline, even if only 1 window.
set laststatus=2
" Allow vim options to be embedded in files
set modeline
" they must be within the first or last 5 lines.
set modelines=3
" Enable mouse interactions
set mouse=a
" Don't automatically re-read changed files. ( use <leader>re to reload )
set noautoread
" Never write a file unless I request it.
set noautowrite
" NEVER.
set noautowriteall
" vim>vi
set nocompatible
set noerrorbells visualbell t_vb=
" dont fold by default
set nofoldenable
" Avoid moving cursor to BOL when jumping around
set nostartofline
" don't wrap text
set nowrap
" Set number formats to only decimal
set nrformats=
" Display line numbers
set number
" using only 1 column (and 1 space) while possible
set numberwidth=1
set ofu=syntaxcomplete#Complete
" Printing options
set printoptions=header:0,duplex:long,paper:letter
" Keep a small completion window
set pumheight=10
" : commands always print changed line count.
set report=0
" Keep 8 context lines above and below the cursor
set scrolloff=8
" rounds indent to a multiple of shiftwidth
set shiftround
" but an indent level is 4 spaces wide.
set shiftwidth=4
" Use [+]/[RO]/[w] for modified/readonly/written.
set shortmess+=a
" Show incomplete normal mode commands as I type.
set showcmd
" When completing by tag, show the whole tag, not just the function name
set showfulltag
" Briefly jump to a paren once it's balanced
set showmatch
" Show the current mode
set showmode
" unless uppercase letters are used in the regex.
set smartcase
" use smart indent if there is no indent file
set smartindent
" Handle tabs more intelligently
set smarttab
" <BS> over an autoindent deletes both spaces.
set softtabstop=4
" <tab> inserts 4 spaces
set tabstop=4
" show title in console title bar
set title
" Disable all bells.  I hate ringing/flashing.
set vb t_vb=
" Let cursor move past the last char in <C-v> mode
set virtualedit=block
" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc,eggs/**,*.egg-info/**
" set the search scan to wrap lines
set wrapscan
set pastetoggle=<F8>
au FileType javascript setl foldmethod=syntax nofoldenable
" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_exec_path = system('which editorconfig')
set runtimepath+=~/.vim/plugged
set runtimepath+=~/.vim/personal
" =============================================================================
" Encoding UTF-8
" =============================================================================
set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8
set fileencodings=utf-8,latin1

let g:miniBufExplForceSyntaxEnable = 1
" Same as default except that I remove the 'u' option
" set complete=.,w,b,t
" Set text width to 120 chars
" set textwidth=80
" Menu completion in command mode on <Tab>
" set wildmenu
" <Tab> cycles between all matching choices.
" set wildmode=full
" Set the status line
" set stl=%{fugitive#statusline()}\ Buf:#%n\ [%b][0x%B]
" set statusline^=%{fnamemodify(expand('%'),':.')}
" set stl+=%{expand('%:~:.')}
" au FileType html setl foldmethod=indent nofoldenable
" au FileType css setl foldmethod=indent nofoldenable
" =============================================================================
" Auto change directory to where the opened file is opened
" =============================================================================
" set autochdir
" Better than autochdir
au BufEnter * silent! lcd %:p:h

" ====================================================
" Commands
" ====================================================
" Sample command W - save as root
" command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
" command! W w !sudo tee % > /dev/null
" command! W :execute 'w !sudo tee % > /dev/null' | :edit!
"
" For when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

" ====================================================
" Global Key Mappings / Assignments 
" ====================================================
" change the behavior of the <Enter> key when the popup menu is visible.
" to select the highlighted menu item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :'<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" open omni completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') . '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
" open user completion menu closing previous if open and opening new menu without changing the text
inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') . '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'

" Make jj in insert mode to go to ESC
inoremap jj <esc>
" Have Enter to go to command line ( do not put that comment in the same line )
" I actually found that I use ; alot 
" nnoremap ; :
nnoremap <C-n> ;
" Increase window left
noremap <C-h> <C-W><
" Increase window right
noremap <C-l> <C-W>>
" Move window up
noremap <C-k> <C-W>-
" Move window down
noremap <C-j> <C-W>+
" Bubble single & multiple lines
noremap <S-Up> ddkP
noremap <S-Down> ddp
vnoremap <S-Up> xkP`[V`]
vnoremap <S-Down> xp`[V`]
" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv
" Scroll faster Down
noremap <C-e> 4<C-e>
" Scroll faster Up
noremap <C-y> 4<C-y>

" ====================================================
" Global Leader Mapping / Assignments 
" Window global Leader Mappings
" ====================================================
" Save window on <leader>w
noremap <silent> <leader>w :w<CR>
noremap <silent> <leader>W :w!<CR>
" Quit window on <leader>q
noremap <silent> <leader>q :q<CR>
noremap <silent> <leader>Q :q<CR>

" Open NerdTree
nnoremap <leader>n :NERDTreeFind<CR>
" Turning off highlighing
nnoremap <leader>b :silent :nohlsearch<CR>
nnoremap <leader>f :CtrlPMixed<CR>
" Split the same window
nnoremap <leader>h :sp<CR>
" Opem Most Recently Used :MRU  - Dont add comments afterwards
nnoremap <leader>m :CtrlPMRU<CR>
" Toggle NerdTree
nnoremap <leader>N :NERDTreeToggle<CR>
" Toggle the BufExplorer
nnoremap <leader>o :CtrlPBuffer<CR>
" Paste from clipboard
nnoremap <leader>p <C-R><C-P>.
" Reload buffer
nnoremap <leader>re :e <CR>
nnoremap <leader>s :vsp<CR>
nnoremap <leader>sb :window set scrollbind! <CR>
" Opens a new empty tab
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>x <c-w>

" ================
" Numbers config
" ================
noremap <F6> :NumbersToggle<CR>
noremap <F7> :NumbersOnOff<CR>
" Toggle paste 
noremap <F8> :set invpaste paste?<CR>
" imap <F8> <C-O>:set invpaste paste?<CR>
" nmap <leader>G :bprev<CR>
" nmap <leader>g :bnext<CR>

" ====================
" Git Commands
" ====================
nnoremap <leader>gL :Git log<CR>
nnoremap <leader>ga :!git add %<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>ge :Git edit<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gg :Git grep<CR>
nnoremap <leader>gl :Git log --follow %<CR>
nnoremap <leader>gP :Git pull<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gs :Git status<CR>
" Dangerous
" nnoremap <leader>gA :!git add . --all<CR>

" ====================
" Compiling commands
" ====================
" Beautify for css or scss
au FileType css nnoremap <buffer> <leader>; :call CSSBeautify()<cr>
au FileType css vnoremap <buffer> <leader>; :call RangeCSSBeautify()<cr>

" ==================
" Javascript leader mappings
" ==================
" ALEFix  use ALE Fixers
au FileType javascript nnoremap <buffer> <leader>l :ALEFix<CR> :w<CR>
" Execute eslint on the current js file
au FileType javascript nnoremap <buffer> <leader>L :w<CR> :R eslint --fix <C-R>%<CR>
" Add debugger; keyword
au FileType javascript nnoremap <buffer> <leader>d Odebugger; <ESC> :w <CR>
" Execute node on the current line
au FileType javascript nnoremap <buffer> <leader>e :.!node <CR>
au FileType javascript nnoremap <buffer> <leader>= :w<CR>:!fixjsstyle %<CR>
" Beautify
au FileType javascript nnoremap <buffer> <leader>; :call JsBeautify()<cr>
au FileType javascript vnoremap <buffer> <leader>; :call RangeJsBeautify()<cr>
" TODO: Check why this does not work.. it should use `ga` to search and find definition
au FileType javascript nnoremap <buffer> <leader>g :ALEGoToDefinition<CR>
" au FileType javascript nmap <buffer> <F8>T :TagbarToggle<CR>

" ==================
" JSON leader mappings
" ==================
" Formats a .json file
au FileType json nmap <leader>F :% !cat % \| jq '.'<CR>

" ==================
" Python leader mappings
" ==================
" Add the python line for debugging
au FileType python nmap <leader>d Oimport rpdb2; rpdb2.start_embedded_debugger('diaa'); <ESC> :w <CR>
" Run nosetest over the current file
au FileType python nmap <leader>c setlocal buftype=py<CR> :w<CR> :R py.test -s <C-R>% --reuse-db<CR> 10<C-W>-
" Rename all occurences after defintion
au FileType python nmap <Leader>r zyiw:call Refactor()<cr>mx:silent! norm gd<cr>[%v]%:s/<C-R>//<c-r>z/g<cr>`x
" Rename in block
au FileType python nmap <Leader>rb zyiw:call Refactor()<cr>mx:silent! norm <cr>[%V]%:s/<C-R>//<c-r>z/g<cr>`x
" Execute python on the current line
au FileType python nmap <leader>e :.!python <CR>

" =============================================================================
" Python Related Actions
" =============================================================================
let g:python3_host_prog=$HOME.'/.pyenv/versions/3.9.2/bin/python3'
au! FileType python set smartindent cinwords=ifelifelseforwhilewithtryexceptfinallydefclass
au! FileType python setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au! FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" au! FileType python nmap <F8> :TagbarToggle<CR>
" au! FileType python set omnifunc=pythoncomplete#Complete
" au! FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
" au! BufRead,BufEnter *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" ====================
" Shell Leader Mappings
" ====================
" Execute bash on the current line
au FileType shell nmap <leader>e :.!bash <CR>  
" Execute bash on the current line
" au BufNewFile,BufRead,BufEnter *.pl nmap <leader>e :call setline('.', system('docker run --rm -v ' . expand('%:p:h') .':/src -w /src swipl swipl -q -s ' . expand('%:t') . ' -t ''' . getline('.') . '''')) <CR><CR>

" ==============
" HTML Leader Mappings
" ==============
" for html
au FileType html nmap <buffer> <leader>; :call HtmlBeautify()<cr>
au FileType html vmap <buffer> <leader>; :call RangeHtmlBeautify()<cr>
" au FileType html nmap <buffer> <leader>= :Autoformat<CR>

" ==============
" VIMRC Leader mappings
" ==============
au FileType vimrc nmap <buffer> <silent> <leader>v :w! <CR>:source $MYVIMRC<CR>:filetype detect<CR>:PlugInstall<CR> :!cd ~/vim/ && git pull && git commit -am 'Update Vim' && git push & <CR> :exe ":echo 'vimrc reloaded'"<CR>

" Build arduino code
" noremap <silent> <F8> :w<CR>:silent !cd ..; ino clean; ino build; ino upload; cd -<CR>
" =============================================================================
" My Bundles here: using vim-plug
" =============================================================================
call plug#begin('~/.vim/plugged')


Plug 'Chiel92/vim-autoformat'
Plug 'SirVer/ultisnips'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-rooter'
Plug 'ajh17/VimCompletesMe'
Plug 'arzg/vim-colors-xcode'
Plug 'dense-analysis/ale'
Plug 'docunext/closetag.vim'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'frazrepo/vim-rainbow'
Plug 'hashivim/vim-terraform'
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'javascript.jsx','typescript'],  'do': 'make install' }
Plug 'honza/vim-snippets'
Plug 'jacoborus/tender.vim'
Plug 'jisaacks/GitGutter'
Plug 'junegunn/vim-easy-align'
Plug 'kien/ctrlp.vim'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'myusuf3/numbers.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'othree/yajs.vim'
Plug 'posva/vim-vue'
Plug 'rakr/vim-one'
Plug 'rking/ag.vim'
Plug 'rstacruz/vim-xtract'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vifm/vifm.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/bash-support.vim'
Plug 'vim-scripts/filetype.vim'
Plug 'vim-scripts/mru'
Plug 'vim-scripts/vimagit'
Plug 'vim-scripts/yaml.vim'
Plug 'vimwiki/vimwiki'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()

"Plug 'isRuslan/vim-es6'
" Plug 'tomlion/vim-solidity'
" Plug 'jceb/vim-orgmode'
" Plug 'dbakker/vim-projectroot'

" =============================================================================
" Easy align configs
" =============================================================================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" =============================================================================
" IndentGuides Configurations 
" =============================================================================
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_auto_colors = 0

" =============================================================================
" Ultisnips configurations
" =============================================================================
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit           = "vertical"
let g:rainbow_active               = 1
let g:deoplete#enable_at_startup   = 1

" =============================================================================
" Theme
" =============================================================================
colorscheme tender
let g:main_font = "Monofur\\ for\\ Powerline:h13"
let g:small_font = "Monofur\\ for\\ Powerline:h13"
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
  set termguicolors
endif

" =============================================================================
" highlight the 80th column
" =============================================================================
hi ColorColumn ctermbg=8

" =============================================================================
" ALE Configurations
" =============================================================================
let g:ale_linters = {
      \ 'javascript': ['eslint']
      \ }
let g:ale_fixers = {
      \ 'javascript': ['eslint']
      \ }
let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
" let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_delay = 2000
let g:ale_lint_on_text_changed = 0
" use Ctrl-k and Ctrl-j to jump up and down between errors
" FIXME conflict with window resize
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

" TODO try making this dynamic
" use npm bin to get the path
let g:jsdoc_lehre_path = '$NVM_BIN/lehre'

"
" =============================================================================
" CtrlP Configurations - Using The Silver Searcher `ag` instead of grep or ack
" =============================================================================
" sudo apt install silversearcher-ag
" brew install the_silver_searcher
if executable('ag')
  " Use ag over grep or ack
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP does't need to cache
  let g:ctrl_user_caching = 0
endif
let g:ctrlp_working_path_mode = 'ra'

" =============================================================================
" NerdTree configurations
" =============================================================================
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" By default show bookmarks
let NERDTreeShowBookmarks = 1
" Store the bookmarks file
let NERDTreeBookmarksFile = expand("$HOME/vim/NERDTreeBookmarks")
let NERDTreeIgnore = ['\.pyc$']" Remove pyc files from NERDTree View
let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ "Unknown"   : "?"
      \ }
" let NERDTreeChDirMode=2

"=============================================================================
" Airline configurations
"=============================================================================
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='molokai'
" Airline performance
let g:airline_highlighting_cache = 1
let g:airline_extensions = []

" ==========================
" Nerd Commenter
" ==========================
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 0

" ==========================
" VIFM
" ==========================
map <leader>vv :Vifm<CR>
map <leader>V :VsplitVifm<CR>
map <leader>H :SplitVifm<CR>

" ==========================
" Vimwiki
" ==========================
map <leader>ww :VimwikiIndex<CR>

" ==========================
" Codi
" ==========================
function! s:pp_js(line)
" Strip escape codes
return substitute(a:line, "\<esc>".'\[\d\(\a\|\dm\)', '', 'g')
endfunction
highlight CodiVirtualText guifg=#716876
let g:codi#virtual_text_prefix = "❯ "
let g:codi#aliases = {
    \ 'javascript.jsx': 'javascript',
    \ }
" \ 'rephrase': function('s:rp_js'),
let g:codi#interpreters = {
    \ 'javascript': {
        \ 'bin': 'node',
        \ 'prompt': '^\(>\|\.\.\.\+\) ',
        \ 'preprocess': function('s:pp_js'),
        \ },
    \ }

"=============================================================================
" Macros
"=============================================================================
"
" Tip: press combination CtrlV followed by key ex.Enter. in insert mode.
" This will insert Enter code represented by ^M sign
"=============================================================================
" Line of equals
let @-='O=x77p'
" JS add // @flow at the start of js file
let @f='ggO// @flowxx'
" JS oadd js function documentation template
let @d=':JsDoc'
" JS convert require to import
let @i='0ceimport/=cf(from /)x0j'
" indent HTML attributes
let @w='2f"a'
let @g='*ggnf''lgfggn<CR>'
let @c='iconsole.log('
let @s='iJSON.stringify('
" convert - muso import {... }  from models; to import DB from models;
let @m='gg/models''0f{ca{modelsG?import oconst pa = models;0'
let @l='gg}}}?importoimport log from ''../../../decorators/log'';0'


" ============================================
" Read visual block
" ============================================
" vmap <leader>S :AsyncRun say --voice ava --rate=220<CR>

" py3file /Users/dino/vim/diaa-python/html-indent-tag-attrs.py
" function! IndentHTMLTagAttrs()
" call inputsave()
" py3 IndentHTMLTagAttrs()
" call inputrestore()
" endfunction
" au BufNewFile,BufRead,BufEnter *.html nmap <Leader>ff :call IndentHTMLTagAttrs()<cr>
