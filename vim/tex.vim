"Function Shortcuts
call IMAP(g:Tex_Leader.'1', '\mathds{1}_{<++>}<++>', 'tex')

"Environment Shortcuts
call IMAP('FTX', "\\text{<++>}<++>", 'tex')
call IMAP('EDF', "\\begin{definition}\<CR>\\label{def:<+label+>}\<CR><+content+>\<CR>\\end{definition}<++>", 'tex')
call IMAP('ETH', "\\begin{theorem}\<CR>\\label{thm:<+label+>}\<CR><+content+>\<CR>\\end{theorem}<++>", 'tex')
call IMAP('ECO', "\\begin{corollary}\<CR>\\label{cor:<+label+>}\<CR><+content+>\<CR>\\end{corollary}<++>", 'tex')
call IMAP('ELM', "\\begin{lemma}\<CR>\\label{lem:<+label+>}\<CR><+content+>\<CR>\\end{lemma}<++>", 'tex')
call IMAP('EPR', "\\begin{proposition}\<CR>\\label{prop:<+label+>}\<CR><+content+>\<CR>\\end{proposition}<++>", 'tex')
call IMAP('ERM', "\\begin{remark}\<CR>\\label{rem:<+label+>}\<CR><+content+>\<CR>\\end{remark}<++>", 'tex')
call IMAP('EPF', "\\begin{proof}\<CR><+content+>\<CR>\\end{proof}<++>", 'tex')
call IMAP('EEX', "\\begin{exercise}\<CR>\\label{ex:<+label+>}\<CR><+content+>\<CR>\\end{exercise}<++>", 'tex')
call IMAP('EEG', "\\begin{example}\<CR>\\label{eg:<+label+>}\<CR><+content+>\<CR>\\end{example}<++>", 'tex')
call IMAP('ECA', "\\bcain{cases}\<CR><+content+>\<CR>\\end{cases}<++>", 'tex')

"Function Space Shortcuts
call IMAP('\LL', 'L^{<++>}(<++>)<++>', 'tex')
call IMAP('\H', 'H^{<++>}(<++>)<++>', 'tex')
call IMAP('\OH', 'H^{<++>}_{<++>}(<++>)<++>', 'tex')
call IMAP('\W', 'W^{<++>}(<++>)<++>', 'tex')
call IMAP('\OW', 'W^{<++>}_{<++>}(<++>)<++>', 'tex')
call IMAP('\CC', 'C_{c}^{<++>}(<++>)<++>', 'tex')
call IMAP('\CF', 'C^{<++>}(<++>)<++>', 'tex')

"Common Sets/Set Notation Shotcuts
call IMAP(g:Tex_Leader.'5', '\emptyset', 'tex')
call IMAP('\bb', '\mathbb{<++>', 'tex')
call IMAP('\cal', '\mathcal{<++>', 'tex')
call IMAP('\scr', '\mathscr{<++>', 'tex')
call IMAP('\frak', '\mathfrak{<++>', 'tex')

"Domain Shortcuts
call IMAP('\cyl', '(0,T)\times\Omega', 'tex')
call IMAP('\icyl', '(0,\infty)\times\Omega', 'tex')

"Command Shortcuts
call IMAP('\ol', '\overline{<++>}<++>', 'tex')
call IMAP('\ul', '\underline{<++>}<++>', 'tex')
call IMAP('\weakto', '\rightharpoonup', 'tex')
call IMAP('\weakstarto', '\overset{*}{\rightharpoonup}', 'tex')
call IMAP('\|\|', '\left\| <++> \right\|<++>', 'tex')
call IMAP('||', '\left| <++> \right|<++>', 'tex')
call IMAP('<>', '\left\langle <++> \right\rangle<++>', 'tex')
call IMAP('\wt', '\widetilde{<++>}<++>', 'tex')
call IMAP('\wh', '\widehat{<++>}<++>', 'tex')
call IMAP('\into', '\hookrightarrow', 'tex')
call IMAP('\dinto', '\underset{\text{d}}{\hookrightarrow}', 'tex')
call IMAP('\cinto', '\underset{\text{c}}{\hookrightarrow}', 'tex')
call IMAP('\imp', '\implies', 'tex')
call IMAP(g:Tex_Leader.'.', '\cdot', 'tex')
call IMAP(g:Tex_Leader.'?', '\dfrac{<++>}{<++>}<++>', 'tex')
call IMAP(g:Tex_Leader.'[', '\nabla', 'tex')

"Vim-LaTeX-Suite Macros
map <C-e> <f5>
imap <C-e> <f5>
imap <C-l> <Plug>Tex_LeftRight
imap <C-i> <Plug>Tex_InsertItemOnThisLine
map <leader>k :w<CR><bar><leader>ll<leader>ls
