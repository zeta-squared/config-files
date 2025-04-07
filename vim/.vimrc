call plug#begin('~/.vim/plugged')

"Plug 'preservim/nerdtree'
"Plug 'lervag/vimtex'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'haya14busa/incsearch.vim'
Plug 'bfrg/vim-cpp-modern'
Plug 'vim-python/python-syntax'
Plug 'othree/html5.vim'
"Plug 'vieira/vim-javascript'
"Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
"Plug 'leafgarland/typescript-vim'
"Plug 'zeta-squared/vim-ts'
Plug 'othree/yajs.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'cakebaker/scss-syntax.vim'
Plug 'elzr/vim-json'
Plug 'chr4/nginx'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'SirVer/ultisnips'
Plug 'uiiaoo/java-syntax.vim'
Plug 'vim-latex/vim-latex'
Plug 'zeta-squared/sonokai'

call plug#end()

"General Settings
syntax on
filetype plugin indent on
set breakindent autoindent linebreak shiftwidth=4 tabstop=4 textwidth=110
set viminfo='100,<2000,s2000,h
set clipboard=unnamed
set mouse=a
map j gj
map k gk
map <C-f> <Plug>IMAP_JumpForward
imap <C-f> <Plug>IMAP_JumpForward
map <C-d> <Plug>IMAP_JumpBack
imap <C-d> <Plug>IMAP_JumpBack
noremap <C-j> <C-d>
noremap <C-k> <C-u>
noremap <C-u> <C-e>
noremap <C-i> <C-y>

let g:sonokai_transparent_background=1
let g:sonokai_style='zeta-squared'
set termguicolors
colorscheme sonokai

"Python Syntax Settings
let g:python_highlight_all = 1

"Airline Settings
let g:airline_powerline_fonts=1
let g:airline_section_z = '%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_bold#/%L %{g:airline_symbols.maxlinenr}%v %#__restore__#'
let g:airline#extensions#wordcount#enabled=0
let g:airline#extensions#default#section_truncate_width = {'a': 0, 'b': 40, 'c': 60, 'x': 100, 'y': 40, 'z': 0}

"UltiSnips Settings
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<C-f>"
let g:UltiSnipsJumpBackwardTrigger="<C-d>"

"Incsearch.vim Settings
set hlsearch
let g:incsearch#auto_nohlsearch=1
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map * <Plug>(incsearch-nohl-*)
map # <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"Vim-LaTeX-Suite Settings
let g:Tex_Leader = '`'
let g:tex_no_error=1
let g:tex_flavor='latex'
let g:Tex_GotoError=0
let g:Tex_Folding=0
"let Tex_FoldedSection='part,chapter,section,subsection'
"let Tex_FoldedEnvironments='verbatim,comment,equation,gather,align,figure,table,thebibliography,keywords,abstract,example,exercise,definition,proposition.lemma,corollary,theorem,proof,remark'
let Tex_FoldedMisc=''
let g:Tex_CompileRule_pdf='pdflatex -synctex=1 -interaction=nonstopmode $*'
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_ViewRule_pdf='zathura'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_PromptedEnvironments='equation,equation*,align,align*,aligned,enumerate,itemize,figure,table,cases,pmatrix,definition,lemma,proposition,corollary,theorem,proof,exercise,example,remark'
let g:Tex_EnvEndWithCR=0
let g:Tex_LabelAfterContent=0
let g:Tex_EnvLabelprefix_equation='eqn:'
let g:Tex_EnvLabelprefix_align='eqn:'
let g:Tex_EnvLabelprefix_figure='fig:'
let g:Tex_EnvLabelprefix_table='tab:'
let g:Tex_EnvLabelprefix_definition='def:'
let g:Tex_EnvLabelprefix_lemma='lem:'
let g:Tex_EnvLabelprefix_proposition='prop:'
let g:Tex_EnvLabelprefix_corollary='cor:'
let g:Tex_EnvLabelprefix_theorem='thm:'
let g:Tex_EnvLabelprefix_remark='rem:'
let g:Tex_HotKeyMappings='align,align*'
let g:Tex_PromptedCommands='ref,cite,footnote,pagref'
let g:Tex_IgnoredWarnings=
			\"Underfull\n".
			\"Overfull\n".
			\"specifier changed to\n".
			\"You have requested\n".
			\"Missing number, treated as zero.\n".
			\"There were undefined references\n".
			\"Citation %.%# undefined\n".
			\"Package amsmath Warning\n".
			\"Package todonotes Warning\n".
			\"Package amsthm Warning"
let g:Tex_IgnoreLevel=10
let g:Tex_BIBINPUTS='/home/zeaiter/texmf/bibtex/bib/local'

"NERDTree Settings
"let NERDTreeWinSize=10
"autocmd VimEnter * NERDTree | wincmd p
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
"    \ quit | endif
