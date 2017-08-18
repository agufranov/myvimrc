set hidden
call plug#begin('~/.vim/plugged')

" Defaults
Plug 'tpope/vim-sensible'

" Colorschemes
Plug 'crusoexia/vim-monokai'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'

" Search
Plug 'ctrlpvim/ctrlp.vim'

" Tree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ryanoasis/vim-devicons'

" Dev tools
Plug 'vim-airline/vim-airline'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdcommenter'

" Tags
Plug 'majutsushi/tagbar'
Plug 'bitterjug/vim-tagbar-ctags-elm'

" Complete
Plug 'Shougo/neocomplete.vim'

" Lint
Plug 'w0rp/ale'

" Langs
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'elmcast/elm-vim'

call plug#end()

colorscheme monokai
if has("osx")
	set guifont=InconsolataGo\ Nerd\ Font:h18
else
	set guifont=Inconsolata\ 16
endif

set guioptions-=m
set guioptions-=T

set encoding=utf-8

inoremap <Tab> <Right><Esc>
nnoremap <C-n> :NERDTreeTabsToggle<cr>

" Window navigation
" TODO Think about mappings (Alt-N doesn't work in MacVim gui)
if has("osx") && has("gui")
	nnoremap <silent> ˙ :wincmd h<cr>
	nnoremap <silent> ∆ :wincmd j<cr>
	nnoremap <silent> ˚ :wincmd k<cr>
	nnoremap <silent> ¬ :wincmd l<cr>
	noremap ˜ :NERDTreeFocusToggle<cr>
	nnoremap  :NERDTreeTabsFind<cr>
elseif has("osx") && !has("gui")
	nnoremap <silent> h :wincmd h<cr>
	nnoremap <silent> j :wincmd j<cr>
	nnoremap <silent> k :wincmd k<cr>
	nnoremap <silent> l :wincmd l<cr>
	noremap n :NERDTreeFocusToggle<cr>
	nnoremap N :NERDTreeTabsFind<cr>
else
	nnoremap <silent> <A-h> :wincmd h<cr>
	nnoremap <silent> <A-j> :wincmd j<cr>
	nnoremap <silent> <A-k> :wincmd k<cr>
	nnoremap <silent> <A-l> :wincmd l<cr>
	nnoremap <A-n> :NERDTreeFocusToggle<cr>
	nnoremap <C-A-n> :NERDTreeTabsFind<cr>
endif

filetype plugin on

syntax on

set noswapfile
set nobackup

" $MYVIMRC helpers
nnoremap <Leader>ee :e $MYVIMRC<cr>
nnoremap <Leader>et :tabnew $MYVIMRC<cr>
nnoremap <Leader>es :w<bar>so $MYVIMRC<cr>
nnoremap <Leader>ei :w<bar>so $MYVIMRC<bar>PlugInstall<cr>

let g:NERDTreeChDirMode=2

cd ~/src

let g:airline_powerline_fonts = 1

let g:tagbar_type_typescript = {
  \ 'ctagsbin' : 'source',
  \ 'ctagsargs' : '~/.nvm/nvm.sh && tstags -f-',
  \ 'kinds': [
    \ 'e:enums:0:1',
    \ 'f:function:0:1',
    \ 't:typealias:0:1',
    \ 'M:Module:0:1',
    \ 'I:import:0:1',
    \ 'i:interface:0:1',
    \ 'C:class:0:1',
    \ 'm:method:0:1',
    \ 'p:property:0:1',
    \ 'v:variable:0:1',
    \ 'c:const:0:1',
  \ ],
  \ 'sort' : 0
\ }
let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
let g:ctrlp_use_caching = 0

" Elm
call neocomplete#util#set_default_dictionary(
  \ 'g:neocomplete#sources#omni#input_patterns',
  \ 'elm',
  \ '\.')


""" ALE
let g:ale_linters = {
	\'typescript': ['tsserver', 'tslint']
\}


""" NEOCOMPLETE
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" Don't select the first match automatically.
let g:neocomplete#enable_auto_select = 0
set completeopt+=longest
" Define keyword.
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns['default'] = '\h\w*'
if !(has("osx") && has("gui")) " Omnicomplete hangs in OS X gvim for Typescript
	let g:neocomplete#force_omni_input_patterns['typescript'] = '[^. *\t]\.\w*\|\h\w*::'
endif

let g:tsuquyomi_completion_detail = 1
let g:elm_detailed_complete = 1
