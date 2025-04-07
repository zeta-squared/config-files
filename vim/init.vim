call plug#begin()

" Functionality
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'vim-latex/vim-latex'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'haya14busa/is.vim'
Plug 'SirVer/ultisnips'
Plug 'ibhagwan/fzf-lua', { 'branch': 'main' }

" Colours
Plug 'zeta-squared/sonokai'

call plug#end()

" General
syntax enable
filetype plugin indent on
set breakindent autoindent linebreak shiftwidth=4 tabstop=4 textwidth=110
set viminfo='100,<2000,s2000,h
set clipboard=unnamed
set mouse=a
set timeoutlen=500
set splitright splitbelow
map j gj
map k gk
map <C-f> <Plug>IMAP_JumpForward
imap <C-f> <Plug>IMAP_JumpForward
map <C-d> <Plug>IMAP_JumpBack
imap <C-d> <Plug>IMAP_JumpBack
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
nnoremap <C-u> <C-e>
nnoremap <C-i> <C-y>
nnoremap <A-h> :wincmd h<CR>
nnoremap <A-l> :wincmd l<CR>
nnoremap <A-j> :wincmd j<CR>
nnoremap <A-k> :wincmd k<CR>
nmap <C-o> o<Esc>
nmap <A-o> O<Esc>
set guicursor=n-v-c-i:block
tnoremap <C-[> <C-\><C-n>
nnoremap <C-q> <C-^>

" Switching Tabs
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" Python Virtual Env
let g:python3_host_prog='/home/zeaiter/.local/share/nvim/nvim_venv/bin/python'

" fzf Settings 
nnoremap <leader>f :FzfLua files<CR>
nnoremap <leader>b :FzfLua buffers<CR>
nnoremap <leader>t :FzfLua tabs<CR>
nnoremap <leader>r :FzfLua grep_visual<CR>
nnoremap <leader>q :FzfLua lines<CR>
nnoremap <leader>l :FzfLua blines<CR>
nnoremap <leader>c :FzfLua git_commits<CR>
nnoremap <leader>g :FzfLua git_status<CR>

" Color scheme
if (has("termguicolors"))
	set termguicolors
endif
let g:sonokai_style='zeta-squared'
let g:sonokai_transparent_background=1
colorscheme sonokai

"Airline Settings
let g:airline_powerline_fonts=1
let g:airline_section_z = '%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_bold#/%L %{g:airline_symbols.maxlinenr}%v %#__restore__#'
let g:airline#extensions#wordcount#enabled=0
let g:airline#extensions#default#section_truncate_width = {'a': 0, 'b': 40, 'c': 60, 'x': 100, 'y': 40, 'z': 0}

"UltiSnips Settings
let g:UltiSnipsSnippetDirectories=["/home/zeaiter/.local/share/nvim/UltiSnips"]
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<C-f>"
let g:UltiSnipsJumpBackwardTrigger="<C-d>"

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


" Lua
lua << EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"c", "java", "javascript", "typescript", "tsx", "vim",
		"python", "lua", "html", "json", "latex", "prisma"},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
		disable = {"python"},
	},
}

require('fzf-lua').setup({
	fzf_opts = {
		['--layout'] = 'default',
	},
	keymap = {
		builtin = {
			true,
			["<C-k>"] = "preview-page-up",
			["<C-j>"] = "preview-page-down",
			["<C-i>"] = "preview-up",
			["<C-u>"] = "preview-down",
		},
		fzf = {
			true,
			["ctrl-k"] = "preview-page-up",
			["ctrl-j"] = "preview-page-down",
			["ctrl-i"] = "preview-up",
			["ctrl-u"] = "preview-down",
		},
	},
	files = {
		true,
		rg_opts = [[--color=never --files --hidden --follow -g "!.git" -g "!node_modules" -g "!venv" -g "!__pycache__"]],
	},
	grep = {
		true,
		rg_opts = [[-g "!.git" -g "!node_modules" -g "!venv" -g "!__pycache__" --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e]],
	},
})
