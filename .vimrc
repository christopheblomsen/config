set nu
set relativenumber
syntax on
set encoding=utf-8
set clipboard=unnamed


"Vim-plug installer
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"All pluggins between here and #end
call plug#begin('~/.vim/plugged')

"For vim-airline
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1

"For snippets
Plug 'SirVer/ultisnips'

"Syntaxes
Plug 'vim-syntastic/syntastic'

"Powerline
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

"Super search
Plug 'kien/ctrlp.vim'

"Git integretation
Plug 'tpope/vim-fugitive'

"File tree
Plug 'scrooloose/nerdtree'

"Python auto-complete
Plug 'Valloric/YouCompleteMe'

"For Latex
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

"PEP8
Plug 'nvie/vim-flake8'

"For indent
Plug 'vim-scripts/indentpython.vim'

"For folding
Plug 'tmhedberg/SimpylFold'

call plug#end()

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

"Folding preview
let g:SimpylFold_docstring_preview=1

"PEP8 indendt
au BufNewFile,BufRead *.py;
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css;
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2


"Bad whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


"You Complete me
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(compile(open(activate_this, "rb").read(), activate_this, 'exec'), dict(__file__=activate_this))
EOF

"Python highligh
let python_highlight_all=1
syntax on

"Hide .pyc files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
 
" Bind End to save file if modified and execute python script in a buffer.
nnoremap <silent> <End> :call SaveAndExecutePython()<CR>
vnoremap <silent> <End> :<C-u>call SaveAndExecutePython()<CR>

function! SaveAndExecutePython()
    " SOURCE [reusable window]: https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    " save and reload current file
    silent execute "update | edit"

    " get file path of current file
    let s:current_buffer_file_path = expand("%")

    let s:output_buffer_name = "Python"
    let s:output_buffer_filetype = "output"

    " reuse existing buffer window if it exists otherwise create a new one
    if !exists("s:buf_nr") || !bufexists(s:buf_nr)
        silent execute 'botright new ' . s:output_buffer_name
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        silent execute 'botright new'
        silent execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        silent execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    silent execute "setlocal filetype=" . s:output_buffer_filetype
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal winfixheight
    setlocal cursorline " make it easy to distinguish
    setlocal nonumber
    setlocal norelativenumber
    setlocal showbreak=""

    " clear the buffer
    setlocal noreadonly
    setlocal modifiable
    %delete _

    " add the console output
    silent execute ".!python " . shellescape(s:current_buffer_file_path, 1)

    " resize window to content length
    " Note: This is annoying because if you print a lot of lines then your code buffer is forced to a height of one line every time you run this function.
    "       However without this line the buffer starts off as a default size and if you resize the buffer then it keeps that custom size after repeated runs of this function.
    "       But if you close the output buffer then it returns to using the default size when its recreated
    "execute 'resize' . line('$')

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
endfunction

"Auto folding
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 

"Powerline
set rtp+=/usr/lib/python3.8/site-packages/powerline/bindings/vim

"Placeholder
inoremap <c-j> <Esc>/<++><Return>dei
