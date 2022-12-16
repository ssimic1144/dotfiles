"vim-plug installation required (https://github.com/junegunn/vim-plug)
call plug#begin('~/.vim/plugged')
"Place plugins here
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
call plug#end()

syntax on

"Required for iceberg theme
set background=dark
"Editor theme (download required : https://github.com/cocopon/iceberg.vim)
colorscheme iceberg
"Vim airline theme (download required : https://github.com/cocopon/iceberg.vim)
let g:airline_theme='iceberg' 
"Transparent vim
hi Normal ctermbg=NONE

set noerrorbells
"Tabs setup 
set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set smartindent
"Puts line where cursor is
"set cursorline
"For searching paterns
set incsearch
"Line numbers + relative numbers from cursor
set nu relativenumber 
"Set line number to white color -> easier to notice them with this theme
if (&background == "dark")
    highlight LineNr ctermfg=white
else
    highlight LineNr ctermfg=black
endif
"Don't wrap text
set nowrap
"Gets rid of lag when exiting modes and entering other
set timeout timeoutlen=1000 ttimeoutlen=100
"Number of line to keep above and below cursor
set scrolloff=10

"Put vertical line on column 80
set colorcolumn=80

"Set LEADER to ","
"let mapleader="," 
"REMAPS
nnoremap ; :NERDTreeFocus<CR>
nnoremap <C-f> /
nnoremap gb gT
vnoremap yy "+y
nnoremap <C-S-e> :tabe

"TREE-PLUGIN
"Hide brackets - Git
let g:NERDTreeGitStatusConcealBrackets = 1
"Show ignored status - Git
let g:NERDTreeGitStatusShowIgnored = 1
"Custom indicators - Git
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'♻',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'🟉',
                \ 'Renamed'   :'⥱',
                \ 'Unmerged'  :'≆',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'⁈',
                \ 'Ignored'   :'#',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

"Colors - Git
function! SetStatusColorsNERDTree()
    hi NERDTreeGitStatusIgnored ctermfg=darkcyan
    hi NERDTreeGitStatusUntracked ctermfg=yellow
    hi NERDTreeGitStatusDirty ctermfg=darkred
    hi NERDTreeGitStatusModified ctermfg=green
    hi NERDTreeGitStatusDeleted ctermfg=red
    hi NERDTreeGitStatusUnknown ctermfg=grey
    hi NERDTreeGitStatusClean ctermfg=green
    hi NERDTreeGitStatusRenamed ctermfg=darkmagenta
    hi NERDTreeGitStatusStaged ctermfg=green
    hi NERDTreeGitStatusUnmerged ctermfg=darkmagenta
endfunction

"Set git status colors on tree
autocmd FileType nerdtree call SetStatusColorsNERDTree()

"GitGutter
"Remove GitGutter default mappings
let g:gitgutter_map_keys = 0

"Markdown to PDF -> (requires -> pandoc, texlive-latex-extra)
"To presentation
function! Md2Presentation()
    "%:p:r -> removes file extension
    silent! execute "! pandoc % -t beamer -o %:p:r.pdf"
    "Preview
    silent! execute "!evince %:p:r.pdf &"
    execute "redraw!"
endfunction

"To regular PDF
function! Md2Pdf()
    silent! execute "!pandoc % -o %:p:r.pdf"
    "Preview
    silent! execute "!evince %:p:r.pdf &"
    "Get rid of Press Enter to Continue
    execute "redraw!"
endfunction

"Make presentation from markdown
autocmd FileType markdown nnoremap <F6> :call Md2Presentation()<CR>
"Make regular pdf from markdown
autocmd FileType markdown nnoremap <F5> :call Md2Pdf()<CR>


