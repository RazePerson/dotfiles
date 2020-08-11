call plug#begin('~/.vim/autoload')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'jreybert/vimagit'
Plug 'LukeSmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'vifm/vifm.vim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

" Basic
	let mapleader =","
	let g:mapleader =","

	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	set tabstop=4
	set hlsearch
	set autoindent
	set autoread
	set directory^=$HOME/.vim/tmp//

" Colorscheme:
	colorscheme molokai
	hi Normal guibg=NONE ctermbg=NONE

" Clipboard:
	set clipboard=unnamedplus

" Enable autocompletion:
	set wildmode=longest,list,full

" Disable automatic commenting on newline:
	autocmd Filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin
	map <leader>f :Goyo \| set linebreak<CR>

" Spell-check ('o' for 'orthography'):
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Split open at bottom and right instead of top and left:
	set splitbelow splitright

" Reload file F5:
	nnoremap <F5> :e<CR>

" noh on double Esc:
	nnoremap <Esc><Esc> :noh<CR>

" Save on CTRL+S:
	nnoremap <C-s> :w<CR>
	inoremap <C-s> <Esc>:w<CR>

" Shortcutting for console mode:
	cnoremap <C-j> <Down>
	cnoremap <C-k> <Up>
	cnoremap <C-h> <Left>
	cnoremap <C-l> <Right>

" Shortcutting for tab navitation:
	nnoremap <C-l> :tabnext<CR>
	nnoremap <C-h> :tabprevious<CR>
	nnoremap <S-H> :tabm -1<CR>
	nnoremap <S-L> :tabm +1<CR>
	nnoremap <C-w> :q<CR>

" Shortcutting for split navigation:
"	nnoremap <C-h> <C-w>h
"	nnoremap <C-j> <C-w>j
"	nnoremap <C-k> <C-w>k
"	nnoremap <C-l> <C-w>l

" Esc in insert mode
	inoremap jj <Esc>

" Insert mode remap:
	inoremap <C-H> <Left>
	inoremap <C-J> <Down>
	inoremap <C-K> <Up>
	inoremap <C-L> <Right>

" Remap delete without cut:
	nnoremap x "_x
	nnoremap X "_X
	nnoremap d "_d
	nnoremap D "_D
	vnoremap d "_d

	if has('unnamedplus')
	  set clipboard=unnamed,unnamedplus
	  nnoremap <leader>d "+d
	  nnoremap <leader>D "+D
	  vnoremap <leader>d "+d
	else
	  set clipboard=unnamed
	  nnoremap <leader>d "*d
	  nnoremap <leader>D "*D
	  vnoremap <leader>d "*d
	endif

" Compile document (groff, LaTeX etc):
	map <leader>c :w! \| !compiler <c-r>%<CR><CR>

" Open corresponding .pdf/.html or preview:
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and vifm configs with new material:
	autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Navigating with guides
	inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	map <leader><leader> <Esc>/<++><Enter>"_c4l

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
