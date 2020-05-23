"=======================================================================
" Author : Diaa Mohamed Kasem
" Date   : 24 May 2012
" VIM Configuration File
"=======================================================================

let mapleader=","             " change the leader to be a comma vs slash
let NERDTreeShowBookmarks=1   " By default show bookmarks
let g:acp_enableAtStartup = 0 
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1 
let g:jsx_ext_required = 0
let g:jsx_pragma_required = 0

" Enable man pages
runtime ftplugin/man.vim

let g:NERDTreeIndicatorMapCustom = {
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

" 
" Airline configurations
" 
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='molokai'
" Airline performance
let g:airline_highlighting_cache = 1
let g:airline_extensions = []

" let NERDTreeChDirMode=2
" " Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/vim/NERDTreeBookmarks")

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
" Macros
"
"  press combination CtrlV followed by Enter. This will insert Enter code represented by ^M sign
" ==========================
" Fixes HTML attributes format
let @f='ggO// @flowxx'
let @d=':JsDoc'
let @i='0ceimport/=cf(from /)x0j'
let @w='2f"a'
let @g='*ggnf''lgfggn<CR>'
" convert - muso import {... }  from models; to import DB from models;
let @m='gg/models''0f{ca{modelsG?import oconst pa = models;0'
let @l='gg}}}?importoimport log from ''../../../decorators/log'';0'

" py3file /Users/dino/vim/diaa-python/html-indent-tag-attrs.py
" function! IndentHTMLTagAttrs()
  " call inputsave()
  " py3 IndentHTMLTagAttrs()
  " call inputrestore()
" endfunction
" au BufNewFile,BufRead,BufEnter *.html nmap <Leader>ff :call IndentHTMLTagAttrs()<cr>

" Sets extensions for files with goto file to help with js imports
augroup suffixes
    autocmd!

    let associations = [
                \["javascript", ".js,.javascript,.es,.esx,.json"],
                \["python", ".py,.pyw"]
                \]

    for ft in associations
        execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
    endfor
augroup END


" ==========================
" Refactor a variable name
" ==========================
function! Refactor()
    call inputsave()
    let @z=input("What do you want to rename '" . @z . "' to? ")
    call inputrestore()
endfunction


" Making command R that opens a new window with the output of the following command
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | silent r !<args> 
inoremap jj <esc>                      " Make jj in insert mode to go to ESC
"
" Sample command W - save as root
" 
" command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
" command! W w !sudo tee % > /dev/null
" command! W :execute 'w !sudo tee % > /dev/null' | :edit!

" ====================================================
" Leader Assignments
" ====================================================
" For when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

nmap <leader>i :IndentGuidesEnable<CR>  " Toggle Indent guides on
nmap <leader>I :IndentGuidesDisable<CR> " Toggle Indent guides off
nmap <leader>n :NERDTreeToggle<CR>      " Toggle NerdTree
nmap <leader>N :NERDTreeFind<CR>        " Open NerdTree

" Opem Most Recently Used :MRU  - Dont add comments afterwards
nmap <leader>m :CtrlPMRU<CR>
" nmap <leader>m :MRU<CR>
nmap <leader>p <C-R><C-P>.           " Paste from clipboard
nmap <leader>t :tabnew<CR>           " Opens a new empty tab

" Toggle the BufExplorer
nmap <leader>o :CtrlPBuffer<CR>
au BufNewFile,BufRead,BufEnter *.json nmap <leader>F :% !cat % \| json<CR> " Formats a .json file

" Align with a letter 
nmap <leader>a :Align 

" ALEFix  use ALE Fixers
noremap <leader>l :ALEFix<CR> :w<CR>

"nmap <leader>f :CtrlP<CR>
nmap <leader>f :CtrlPMixed<CR>
"nnoremap <leader>. :CtrlPTag<cr>

" nmap <leader>G :bprev<CR>
" nmap <leader>g :bnext<CR>

" nmap <leader>g :ALEGoToDefinition<CR>


" ====================
" Git Commands
" ====================

nmap <leader>gL :Glog<CR>
nmap <leader>gA :!git add . --all<CR>
nmap <leader>ga :!git add %<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>ge :Gedit<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gg :Ggrep<CR>
nmap <leader>gl :Glog --follow %<CR>
nmap <leader>gP :Gpull<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gs :Gstatus<CR>

" ====================
" Compiling commands
" ====================

au BufNewFile,BufRead,BufEnter *.less,*.LESS     nmap <leader>c :w<CR> :silent !lessc % %:r.css <CR>                                  " Execute lessc on the current file
au BufNewFile,BufRead,BufEnter *.css,*.CSS       nmap <leader>c :w<CR> :silent !node ~/zshconfigs/scripts/css2less.js % %:r.less <CR>                                  " Execute lessc on the current file
"au BufNewFile,BufRead,BufEnter *.jade,*.JADE     nmap <leader>c :w<CR> :silent !jade -P % > %:r.html <CR>                                  " Execute jade on the current file
"au BufNewFile,BufRead,BufEnter *.html,*.HTML     nmap <leader>c :w<CR> :silent !html2jade % > %:r.jade <CR>                             " Convert the html to jade
"au BufNewFile,BufRead,BufEnter *.js,*.JS         nmap <leader>c :w<CR> :silent !js2coffee % > %:r.coffee <CR>                           " converts js to coffeescript
"au BufNewFile,BufRead,BufEnter *.coffee,*.COFFEE nmap <leader>C :w<CR> :silent !coffee -b -cm % & <CR>                                  " Execute coffe on the current file
"au BufNewFile,BufRead,BufEnter *.coffee,*.COFFEE nmap <leader>c :w<CR> :silent !coffee -cm % & <CR>                                     " Execute coffe on the current file

" ==================
" linting commands
" ==================

"au BufNewFile,BufRead,BufEnter *.js,*.JS          nmap <leader>l :w<CR> :JSHint<CR>                                                               " Execute jshint on the current js file
"au BufNewFile,BufRead,BufEnter *.js,*.JS          nmap <leader>l :w<CR> :R npm run lint <C-R>%<CR>                                                               " Execute jshint on the current js file
" au BufNewFile,BufRead,BufEnter *.js,*.JS          nmap <leader>l :w<CR> :SyntasticReset<CR> :SyntasticCheck<CR>                                    " Execute Syntastic check for pytho on the current bash file
" au BufNewFile,BufRead,BufEnter *.js,*.JS          nmap <leader>L :w<CR> :R eslint --fix <C-R>%<CR>                                                               " Execute jshint on the current js file
" au BufNewFile,BufRead,BufEnter *.ts,*.TS,*.Ts     nmap <leader>l :w<CR> :R tslint <C-R>%<CR>                                                      " Execute jshint on the current js file
" au BufNewFile,BufRead,BufEnter *.coffee,*.COFFEE  nmap <leader>l :w<CR> :R coffeelint -f ~/zshconfigs/coffeelint_config.json --nocolor <C-R>%<CR> " Execute coffelint on the current coffe file
" au BufNewFile,BufRead,BufEnter *.json,*.JSON      nmap <leader>l :w<CR> :R jsonlint <C-R>%<CR>                                                    " Execute jsonlint on the current json file
" au BufNewFile,BufRead,BufEnter *.less,*.LESS      nmap <leader>l :w<CR> :R lesslint <C-R>%<CR>                                                    " Execute lesslint on the current lesscss file
" au BufNewFile,BufRead,BufEnter *.py,*.PY          nmap <leader>l :w<CR> :SyntasticReset<CR> :SyntasticCheck<CR>                                    " Execute Syntastic check for pytho on the current python file
" au BufNewFile,BufRead,BufEnter *.sh,*.SH          nmap <leader>l :w<CR> :SyntasticReset<CR> :SyntasticCheck<CR>                                    " Execute Syntastic check for pytho on the current bash file
" au BufNewFile,BufRead,BufEnter *.yml,*.YML        nmap <leader>l :w<CR> :R yaml-lint <C-R>%<CR>                                                   " Execute Yaml lint check for yaml on the current file

au BufNewFile,BufRead,BufEnter *.js nmap <leader>= :w<CR>:!fixjsstyle %<CR>

" ====================
" Debuggers commands
" ====================

au BufNewFile,BufRead,BufEnter *.js,*.coffee nmap <leader>d Odebugger; <ESC> :w <CR>                                            " Add debugger; keyword
au BufNewFile,BufRead,BufEnter *.py          nmap <leader>d Oimport rpdb2; rpdb2.start_embedded_debugger('diaa'); <ESC> :w <CR> " Add the python line for debugging
au BufNewFile,BufRead,BufEnter *.py          nmap <leader>c setlocal buftype=py<CR> :w<CR> :R py.test -s <C-R>% --reuse-db<CR> 10<C-W>-                            " Run nosetest over the current file
" Rename all occurences after defintion
au BufNewFile,BufRead,BufEnter *.py nmap <Leader>r zyiw:call Refactor()<cr>mx:silent! norm gd<cr>[%v]%:s/<C-R>//<c-r>z/g<cr>`x
" Rename in block
au BufNewFile,BufRead,BufEnter *.py nmap <Leader>rb zyiw:call Refactor()<cr>mx:silent! norm <cr>[%V]%:s/<C-R>//<c-r>z/g<cr>`x

" ====================
" Execution commands
" ====================
                                                                     
au BufNewFile,BufRead,BufEnter *.coffee nmap <leader>e :.!coffee <CR> " Execute coffee on the current line
au BufNewFile,BufRead,BufEnter *.py     nmap <leader>e :.!python <CR> " Execute python on the current line
au BufNewFile,BufRead,BufEnter *.js     nmap <leader>e :.!node <CR>   " Execute node on the current line
au BufNewFile,BufRead,BufEnter *.sh     nmap <leader>e :.!bash <CR>   " Execute bash on the current line
au BufNewFile,BufRead,BufEnter *.pl     nmap <leader>e :call setline('.', system('docker run --rm -v ' . expand('%:p:h') .':/src -w /src swipl swipl -q -s ' . expand('%:t') . ' -t ''' . getline('.') . '''')) <CR><CR>    " Execute bash on the current line 

" set rtp+=<your_path_here>/typescript-tools.vim/

" ==============
" Beautify
" ==============
autocmd FileType javascript noremap <buffer>  <leader>; :call JsBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <leader>; :call RangeJsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <leader>; :call HtmlBeautify()<cr>
autocmd FileType html vnoremap <buffer> <leader>; :call RangeHtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <leader>; :call CSSBeautify()<cr>
autocmd FileType css vnoremap <buffer> <leader>; :call RangeCSSBeautify()<cr>


noremap <leader>= :Autoformat<CR>

" ==============
" Reload Vimrc
" ==============

au BufNewFile,BufRead,BufEnter vimrc map <silent> <leader>v :w! <CR>:source ~/.vimrc<CR>:filetype detect<CR> :!cd ~/vim/ && git commit -am 'Update Vim' & <CR> :exe ":echo 'vimrc reloaded'"<CR>
au BufNewFile,BufRead,BufEnter .vimrc map <silent> <leader>v :w! <CR>:source ~/.vimrc<CR>:filetype detect<CR> :!cd ~/vim/ && git commit -am 'Update Vim' & <CR> :exe ":echo 'vimrc reloaded'"<CR>

" ==============
" Reload buffer
" ==============

nmap <leader>re :e <CR>

" ==============
" Window shortcut
" ==============

map <silent> <leader>x <C-W>
"map <silent> <leader>X <C-W>

" ==================================
" Have Enter to go to command line
" ==================================
" Affects all plugins 
"noremap <CR> :

" ================
" Scroll faster 
" ================

nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>

" ================
" numbers config
" ================
nnoremap <silent> <F3> :NumbersToggle<CR>
nnoremap <silent> <F4> :NumbersOnOff<CR>
nnoremap <silent> <F7> :w<CR>:silent !cd ..; ino clean; ino build; ino upload; cd -<CR>
au! BufRead,BufEnter *.py nmap <F8> :TagbarToggle<CR>
au! BufRead,BufEnter *.js nmap <leader>T :TagbarToggle<CR>

nnoremap <F6> :set invpaste paste?<CR>
imap <F6> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F6>


" ======================================
" Make shift-insert work like in Xterm
" ======================================
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" =========================
" Turning off highlighing
" =========================
nmap <silent> <leader>b :silent :nohlsearch<CR>
" nnoremap ' `
" nnoremap ` '

" ==========================
" Quit window on <leader>q
" ==========================

nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>Q :q<CR>

" ==========================
" Save window on <leader>w
" ==========================

nnoremap <leader>w :w<CR>
nnoremap <leader>W :w<CR>

" =======================
" Split the same window
" =======================

nmap <silent> <leader>H :sp<CR>
nmap <silent> <leader>s :vsp<CR>
nmap <silent> <leader>sb :windo set scrollbind! <CR>

" ============================================
" Maps to make handling windows a bit easier
" ============================================

noremap <silent> <C-h> <C-W><
noremap <silent> <C-k> <C-W>-
noremap <silent> <C-j> <C-W>+
noremap <silent> <C-l> <C-W>>

" ==============================
" Bubble single&multiple lines
" ==============================

nmap <S-Down> ddp
vmap <S-Up> xkP`[V`]
vmap <S-Down> xp`[V`]
nmap <S-Up> ddkP

" ============================================
" Read visual block
" ============================================
vmap <leader>S :AsyncRun say --voice ava --rate=220<CR>

" ============================================
" Reselect visual block after indent/outdent
" ============================================

vnoremap < <gv
vnoremap > >gv

" ============================================
" Underline the current line with '=' or '-'
" ============================================

au BufRead,BufEnter vimrc nmap <silent> <leader>u= :t.\|s/./=/g\|:nohls<cr>gcc
au BufRead,BufEnter vimrc nmap <silent> <leader>u- :t.\|s/./-/g\|:nohls<cr>gcc

" ==========================================================
" Pathogen - Allows us to organize our vim plugins
" Load pathogen with docs for all plugins
" ==========================================================

" filetype off
" call pathogen#infect()
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()

" ===============
" Basic Settings
" ===============

syntax on                 " syntax highlighing
filetype plugin indent on " enable loading indent file for filetype
set nocp                  " For Align plugin
set number                " Display line numbers
set nrformats=            " Set number formats to only decimal
set numberwidth=1         " using only 1 column (and 1 space) while possible
set background=dark       " We are using dark background in vim
set title                 " show title in console title bar
"set wildmenu              " Menu completion in command mode on <Tab>
"set wildmode=full         " <Tab> cycles between all matching choices.
set history=1000          " Set the commands history to 1000
set hidden                " Better handling for the buffers
set mouse=a               " Enable mouse interactions
"set clipboard+=unnamed    " Add the unnamed register to the clipboard
set nocompatible          " vim>vi
set isfname-=:            " Set the filename:linenumber delimiter to be colon
set noerrorbells visualbell t_vb=
set ofu=syntaxcomplete#Complete
set cindent

" ==================
" Printing options
" ==================
set printoptions=header:0,duplex:long,paper:letter

" ==================
" Change backupdir
" ==================
set backupdir=~/.vim/tmp,~/.tmp,~/tmp " ,/var/tmp,/tmp
set directory=~/.vim/tmp,~/.tmp,~/tmp " ,/var/tmp,/tmp


" ======================
" Set the status line 
" ======================
" set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]
set showmode                           " Show the current mode

" =================
" Folding settings
" =================
"set nofoldenable      " dont fold by default
"set foldmethod=indent " fold based on indent

set showfulltag       " When completing by tag, show the whole tag, not just the function name
set foldmethod=manual " fold based on indent
set foldnestmax=99    " deepest fold is 10 levels
set foldlevel=1       " this is just what i use
" set textwidth=80      " Set text width to 120 chars
" set colorcolumn=80
set textwidth=80      " Set text width to 120 chars
set colorcolumn=80

" get rid of the silly characters in separators
set fillchars = ""
set fillchars +=stl:\ ,stlnc:\
set diffopt+=iwhite                    " Add ignorance of whitespace to diff

" au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.html setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.less setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.scss setl foldmethod=indent nofoldenable

" ====================================
" Ignore these files when completing
" ====================================
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

set completeopt=menuone,longest

" set complete=.,w,b,t                   " Same as default except that I remove the 'u' option
set pumheight=10                       " Keep a small completion window

" =======================
" Moving Around/Editing
" =======================
set cursorline                         " have a line indicate the cursor location
set nostartofline                      " Avoid moving cursor to BOL when jumping around
set virtualedit=block                  " Let cursor move past the last char in <C-v> mode
set scrolloff=8                        " Keep 8 context lines above and below the cursor
set backspace=2                        " Allow backspacing over autoindent, EOL, and BOL
set showmatch                          " Briefly jump to a paren once it's balanced
set wrapscan                           " set the search scan to wrap lines
set ch=2                               " Make command line two lines high
set nowrap                             " don't wrap text
set autoindent                         " always set autoindenting on
set smartindent                        " use smart indent if there is no indent file
set tabstop=2                          " <tab> inserts 4 spaces 
set shiftwidth=2                       " but an indent level is 4 spaces wide.
set softtabstop=2                      " <BS> over an autoindent deletes both spaces.
set expandtab                          " Use spaces, not tabs, for autoindent/tab key.
set shiftround                         " rounds indent to a multiple of shiftwidth
set grepprg=ack

" ====================
" Reading/Writing
" ====================
set noautowrite                        " Never write a file unless I request it.
set noautowriteall                     " NEVER.
" set auto                           " Set auto read file changes
" set noautoread                         " Don't automatically re-read changed files.
set modeline                           " Allow vim options to be embedded in files;
set modelines=3                        " they must be within the first or last 5 lines.
set ffs=unix,dos,mac                   " Try recognizing dos, unix, and mac line endings.

" ===========================
" Messages, Info, Status
" ===========================
set vb t_vb=                           " Disable all bells.  I hate ringing/flashing.
set confirm                            " Y-N-C prompt if closing with unsaved changes.
set showcmd                            " Show incomplete normal mode commands as I type.
set report=0                           " : commands always print changed line count.
set shortmess+=a                       " Use [+]/[RO]/[w] for modified/readonly/written.
set laststatus=2                       " Always show statusline, even if only 1 window.

" ========================
" Searching and Patterns
" ========================
set ignorecase                         " Default to using case insensitive searches,
set smartcase                          " unless uppercase letters are used in the regex.
set smarttab                           " Handle tabs more intelligently 
set hlsearch                           " Highlight searches by default.
set incsearch                          " Incrementally search while typing a /regex

" ============================
" Set ft based on extensions
" ============================

au! BufNewFile,BufRead,BufEnter *.js      setlocal filetype=javascript  shiftwidth=4 tabstop=4 softtabstop=4
au! BufNewFile,BufRead,BufEnter *.ts      setlocal filetype=typescript
au! BufNewFile,BufRead,BufEnter *.yml     setlocal filetype=yaml
au! BufNewFile,BufRead,BufEnter *.coffee setlocal ft=coffee
au! BufNewFile,BufRead,BufEnter *.ino    setlocal ft=arduino
au! BufNewFile,BufRead,BufEnter *.jade   setlocal ft=jade
au! BufNewFile,BufRead,BufEnter *.less   setlocal ft=css shiftwidth=2 tabstop=2 softtabstop=2
au! BufNewFile,BufRead,BufEnter *.sass   setlocal ft=sass
au! BufNewFile,BufRead,BufEnter *.tmpl   setlocal ft=html

au! FileType arduino setlocal shiftwidth=2 tabstop=2 softtabstop=2
au! FileType css,javascript,js setlocal shiftwidth=2 tabstop=2 softtabstop=2
au! FileType yml,yaml,htm,html,xhtml,xml,coffee,jade,sass setlocal shiftwidth=2 tabstop=2 softtabstop=2

" ============================================================
" Auto change directory to where the opened file is opened
" ============================================================
"au! BufNewFile,BufRead,BufEnter * silent! lcd %:p:h
"set autochdir
" Better than autochdir
autocmd BufEnter * silent! lcd %:p:h
"au! GUIEnter * set visualbell t_vb=

" ================================================
" Use tab to scroll through autocomplete menus
" ================================================
" au VimEnter * imap <expr> <Tab> pumvisible() ? "<C-N>" : "<Tab>"
" au VimEnter * imap <expr> <S-Tab> pumvisible() ? "<C-P>" : "<S-Tab>"



" ==========================
" Python Related Actions
" ==========================
au! BufNewFile,BufRead,BufEnter *.py set smartindent cinwords=ifelifelseforwhilewithtryexceptfinallydefclass
" au! FileType python set omnifunc=pythoncomplete#Complete
au! FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au! BufRead,BufEnter *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

"let &cpo = s:save_cpo
"unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:


" ================================================
" Add xptemplate global personal directory value
" ================================================
" if has("unix")
set runtimepath+=~/.vim/plugged
" 	set runtimepath+=~/.vim/bundle
set runtimepath+=~/.vim/personal
" endif

"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

" ================================================
" Remove pyc files from NERDTree View
" ================================================
let NERDTreeIgnore = ['\.pyc$']

" =============
" Nerdtree
" =============
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" ==============
" Editor config
" ==============
" let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'
" ====================================
" Yank into the system's clipboard
" ====================================
set guioptions+=a

" ==========
" UTF 8 
" ==========
set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8
set fileencodings=utf-8,latin1

" Allow vim transparency
"hi Normal ctermfg=252 ctermbg=none

let g:main_font = "Monofur\\ for\\ Powerline:h13"
let g:small_font = "Monofur\\ for\\ Powerline:h13"

" Enable 256 Colors in terminals
"set t_Co=256
"set term=xterm-256color
"set term=screen-256color
" set runtimepath%=~/.vim/bundle/ctrlp.vim

filetype off                   " required!

autocmd! BufWritePost ~/.vimrc nested :source ~/.vimrc
let g:miniBufExplForceSyntaxEnable = 1

"set guifont=Inconsolata\ for\ Powerline:h15
"let g:Powerline_symbols = 'fancy'
set fillchars+=stl:\ ,stlnc:\

set clipboard=unnamed


hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_auto_colors = 0
"let g:indent_guides_color_change_percent = 10
"let g:indent_guides_guide_size = 1

" 'c' - the directory of the current file.
" 'r' - the nearest ancestor that contains one of these directories or files:
"       .git .hg .svn .bzr _darcs
" 'a' - like c, but only if the current working directory outside of CtrlP is not
"       a direct ancestor of the directory of the current file.
"  0 or '' (empty string) - disable this feature.
let g:ctrlp_working_path_mode = 'ra'
" Instead of using fuzzy search
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux


" My Bundles here:
"
" original repos on github

call plug#begin('~/.vim/plugged')
" Plug 'Arduino-syntax-file'
" Plug 'DirDiff'
" Plug 'L9'
" Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'Quramy/tsuquyomi'
" Plug 'Quramy/tsuquyomi'
" Plug 'Raimondi/delimitMate'
" Plug 'SQLUtilities'
" Plug 'SirVer/ultisnips'
" Plug 'Valloric/YouCompleteMe'
" Plug 'Vim-R-plugin'
" Plug 'ZoomWin'
" Plug 'amiel/vim-tmux-navigator'
" Plug 'chemzqm/vim-jsx-improve'
" Plug 'davidhalter/jedi-vim'
" Plug 'davidoc/taskpaper.vim'
" Plug 'edkolev/tmuxline.vim'
" Plug 'einars/js-beautify'
" Plug 'ervandew/supertab'
" Plug 'fatih/vim-go'
" Plug 'fatih/vim-go'
" Plug 'godlygeek/tabular'
" Plug 'honza/vim-snippets'
" Plug 'imkmf/ctrlp-branches'
" Plug 'jade.vim'
" Plug 'jshint.vim'
" Plug 'jtratner/vim-flavored-markdown'
" Plug 'kchmck/vim-coffee-script'
" Plug 'leafgarland/typescript-vim'
" Plug 'majutsushi/tagbar'
" Plug 'maksimr/vim-jsbeautify'
" Plug 'mattn/emmet-vim'
" Plug 'mxw/vim-jsx'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'nsf/gocode', {'rtp': 'vim/'}
" Plug 'othree/es.next.syntax.vim'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'pangloss/vim-javascript'
" Plug 'pathogen.vim'
Plug 'rking/ag.vim'
" Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
" Plug 'rust-lang/rust.vim'
" Plug 'sgur/ctrlp-extensions.vim'
" Plug 'sheerun/vim-polyglot'
" Plug 'tacahiroy/ctrlp-funky'
" Plug 'tomlion/vim-solidity'
" Plug 'tpope/vim-abolish'
" Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-eunuch'
" Plug 'vim-flake8'
" Plug 'vim-multiple-cursors'
" Plug 'vim-scripts/Align'
" Plug 'vim-syntastic/syntastic'
" Plug 'virtualenv.vim'
" Plug 'wakatime/vim-wakatime'
" Plug 'maralla/completor.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'EasyMotion'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'bash-support.vim'
Plug 'dense-analysis/ale'
Plug 'docunext/closetag.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'filetype.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'isRuslan/vim-es6'
Plug 'jisaacks/GitGutter'
Plug 'kien/ctrlp.vim'
Plug 'git@github.com:ajh17/VimCompletesMe.git'
Plug 'git@github.com:Valloric/YouCompletesMe.git'
Plug 'mhinz/vim-signify'
Plug 'mru'
Plug 'myusuf3/numbers.vim'
Plug 'posva/vim-vue'
Plug 'rstacruz/vim-xtract'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'jacoborus/tender.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/vim-preview'
Plug 'surround.vim'
Plug 'tpope/vim-repeat'
Plug 'unimpaired.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimagit'
Plug 'yaml.vim'
Plug 'fugitive.vim'
Plug 'tomlion/vim-solidity'
Plug 'arzg/vim-colors-xcode'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'tomasr/molokai'
Plug 'jceb/vim-orgmode'

call plug#end()


" ============
" Display
" ============
colorscheme Molokai
" colorscheme xcodedarkhc
" colorscheme gruvbox
" colorscheme one
"
" ====================
" highlight the 80th column
" ====================
hi ColorColumn ctermbg=8
" ====================
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsSnippetsDir = '~/UltiSnips'
" let g:UltiSnipsListSnippets = '<leader>whatever'
" let g:UltiSnipsExpandTrigger = '<c-l>'
" let g:UltiSnipsJumpForwardTrigger = '<c-j>'
" let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" Ale syntax checking
" let b:ale_linters = ['cargo']
" let b:ale_linters = {'javascript': ['tslint'], 'typescript': ['tslint']}
" let g:ale_fixers = {'javascript': ['tslint'], 'typescript': ['tslint']}
" let b:ale_linters = ['eslint', 'flow']
" let b:ale_linters = ['eslint', 'flow-language-server']
" let g:ale_fixers = ['eslint', 'flow-language-server']

let b:ale_linters = ['eslint']
let g:ale_fixers = ['eslint']
let g:ale_echo_msg_format = '%linter% says %s'

let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_rust_cargo_use_check = 0
" let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_delay = 2000
let g:ale_lint_on_text_changed = 0
" use Ctrl-k and Ctrl-j to jump up and down between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" RUST
"
let g:rust_clip_command = 'pbcopy'
let g:rustfmt_autosave = 1

filetype plugin indent on " enable loading indent file for filetype
filetype plugin on

" ======================================== 
" Previewing file in nerd tree
" ======================================== 
if exists("g:loaded_nerdree_live_preview_mapping")
  finish
endif
let g:loaded_nerdree_live_preview_mapping = 1

function! NERDTreeLivePreview()
  " Get the path of the item under the cursor if possible:
  let current_file = g:NERDTreeFileNode.GetSelected()

  if current_file == {}
    return
  else
    "  Nice pop up , but not useful here
    " set previewpopup=height:10,width:60
    exe 'botright vertical pedit '.current_file.path.str()
  endif
endfunction

" ======================================== 
" Remapping for Colemak
" ======================================== 

" This remaps the movemet keys j and k (In Colemak, J (= Qwerty Y) is placed 
" above K (= Qwerty N), which I find confusing in Vim since j moves down and k 
" up. I think the remappings below result in a more logical and easier to 
" reach layout, keeping in mind that space and backspace (= Qwerty Caps-Lock) 
" can be used instead of Colemak J (= Qwerty Y). I use the join-lines command 
" much more than the help command, and have therefore swapped J and K since I 
" find Colemak K (Qwerty N) much easier to reach than Colemak J (Qwerty Y).

" The first five mappings are basically all one needs to remember.
"getCollaboratorBySongId set langmap=fpgjluyrstdneikFPGJLUYRSTDNEIKoO;ertyuiosdfgjklnERTYUIOSDFGJKLNpP
"
" autocmd FileType nerdtree nnoremap <buffer> j :call NERDTreeLivePreview()<cr><down>
" autocmd FileType nerdtree nnoremap <buffer> k :call NERDTreeLivePreview()<cr><up>
