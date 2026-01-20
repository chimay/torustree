" vim: set ft=vim fdm=indent iskeyword&:

" Status
"
" Echo status info

" ---- script constants

if exists('s:field_separ')
	unlockvar s:field_separ
endif
let s:field_separ = torustree#crystal#fetch('separator/field')
lockvar s:field_separ

if exists('s:level_separ')
	unlockvar s:level_separ
endif
let s:level_separ = torustree#crystal#fetch('separator/level')
lockvar s:level_separ

" ---- clear cmd line

fun! torustree#status#clear ()
	" Clear command line space
	" Does not clear the vim messages
	" credit :
	" https://neovim.discourse.group/t/how-to-clear-the-echo-message-in-the-command-line/268/2
	call feedkeys(':','nx')
endfun

fun! torustree#status#clear_messages ()
	" Clear vim messages
	messages clear
	echo 'messages cleared'
endfun

" ---- echo

fun! torustree#status#echo (...)
	" Echo message
	if a:0 == 0
		let message = ''
	endif
	if a:0 > 1
		let message = join(a:000)
		return call('torustree#status#echo', [ message ])
	endif
	let message = a:1
	if type(message) == v:t_list
		let message = join(message)
	endif
	call torustree#status#clear ()
	echo message
	return v:true
endfun

fun! torustree#status#message (...)
	" Echomsg message
	if a:0 == 0
		let message = ''
	endif
	if a:0 > 1
		let message = join(a:000)
		return call('torustree#status#message', [ message ])
	endif
	let message = a:1
	if type(message) == v:t_list
		let message = join(message)
	endif
	" does not clear messages, only echo area
	call torustree#status#clear ()
	echomsg message
	return v:true
endfun

" ---- torustree

fun! torustree#status#dashboard_text ()
	" Return dashboard text
	if torustree#referen#is_empty('torustree')
		return 'empty torustree'
	endif
	let [torus, circle, location] = torustree#referen#location('all')
	let dashboard = 'torustree: '
	let dashboard ..= torus.name .. s:level_separ
	if torustree#referen#is_empty('torus')
		let dashboard ..= '[empty torus]'
		return dashboard
	endif
	let dashboard ..= circle.name .. s:level_separ
	if torustree#referen#is_empty('circle')
		let dashboard ..= '[empty circle]'
		return dashboard
	endif
	let dashboard ..= location.name .. ' : '
	let file = torustree#disc#relative_path(location.file)
	let dashboard ..= file .. ':' .. location.line .. ':' .. location.col
	return dashboard
endfun

fun! torustree#status#dashboard ()
	" Display dashboard, summary of current torustree status
	let dashboard = torustree#status#dashboard_text ()
	call torustree#status#echo (dashboard)
endfun

" ---- mandala & leaf

fun! torustree#status#mandalas ()
	" Return bufring status
	let bufring = g:torustree_bufring
	let names = copy(bufring.names)
	let current = bufring.current
	let names[current] = '[' .. names[current] .. ']'
	return names
endfun

fun! torustree#status#leaves ()
	" Return leaves status
	if ! torustree#cylinder#is_mandala ()
		return []
	endif
	let nature = torustree#book#ring ('nature')
	let types = nature->map({ _, val -> val.type })
	let current = b:wheel_ring.current
	let types[current] =  '[' .. types[current] .. ']'
	return types
endfun

fun! torustree#status#statusline ()
	" Statusline for mandala
	if ! torustree#cylinder#is_mandala ()
		echomsg 'torustree statusline : should not be called outside of mandala'
		return &g:statusline
	endif
	let mandalas = torustree#status#mandalas ()
	let mandalas = join(mandalas)
	let leaves = torustree#status#leaves ()
	let leaves = join(leaves)
	let statusline = '%#WheelStatusLine# '
	let statusline ..= 'mandalas: '
	let statusline ..= mandalas
	let statusline ..= s:field_separ
	let statusline ..= 'leaves: '
	let statusline ..= leaves
	let statusline ..=' %='
	let statusline ..= '%F'
	let statusline ..= s:field_separ
	let statusline ..= '%L lines %y%r%m'
	let statusline ..= s:field_separ
	let statusline ..= 'buf %n'
	let statusline ..= s:field_separ
	let statusline ..=' win %{winnr()}/%{win_getid()}'
	let statusline ..= '   %<'
	return statusline
endfun

fun! torustree#status#mandala_leaf ()
	" Mandala & leaf dashboard
	let in_status = g:torustree_config.display.statusline
	if in_status > 0 && torustree#cylinder#is_mandala ()
		call torustree#status#clear ()
		setlocal statusline=%!torustree#status#statusline()
		return v:true
	endif
	let mandalas = torustree#status#mandalas()
	let leaves = torustree#status#leaves()
	call torustree#status#clear ()
	if empty(leaves)
		echo 'torustree buffers: ' join(mandalas) "\n"
		return v:true
	endif
	let oneline = g:torustree_config.display.dedibuf ==# 'one-line'
	if oneline
		echo 'torustree buf:' join(mandalas) '/ lay:' join(leaves)
	else
		echo 'torustree buffers : ' join(mandalas) "\n"
		echo '      layers  : ' join(leaves)
	endif
	return v:true
endfun

" ---- tab line

fun! torustree#status#tablabel (tabnum)
	" Label of a tab
	let tabnum = a:tabnum
	let buflist = tabpagebuflist(tabnum)
	let win_num = len(buflist)
	let winnr = tabpagewinnr(tabnum)
	let bufnr = buflist[winnr - 1]
	let filename = bufname(bufnr)
	let filename = fnamemodify(filename, ':t')[0:14]
	let modified = ''
	for bufnum in buflist
		if getbufvar(bufnum, '&modified')
			let modified = '[+]'
			break
		endif
	endfor
	if empty(filename)
		let filename = '[no-name]'
	endif
	let label = tabnum .. ':' .. filename .. modified
	if win_num > 1
		let label ..= '(' .. win_num .. ')'
	endif
	if ! has_key(g:torustree_shelve.layout, 'tabnames')
		return label
	endif
	let tabnames = g:torustree_shelve.layout.tabnames
	if empty(tabnames)
		return label
	endif
	let label = tabnames[tabnum - 1] .. ' ' .. modified
	return label
endfun

fun! torustree#status#tabline ()
	" Tab line
	let text = ''
	for tabnum in range(1, tabpagenr('$'))
		" Highlighting
		if tabnum == tabpagenr()
			let text ..= '%#TabLineSel#'
		else
			let text ..= '%#TabLine#'
		endif
		" Tab page number (for mouse clicks)
		let text ..= '%' .. tabnum .. 'T'
		" Label of a tab
		let text ..= ' %{torustree#status#tablabel(' .. tabnum .. ')} '
	endfor
	" After the last tab fill with TabLineFill and reset tab page nr
	let text ..= '%#TabLineFill#%T'
	" Right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let text ..= '%=%#TabLine#%999X[X]'
	endif
	return text
endfun

fun! torustree#status#guitablabel ()
	" Gui label of a tab
	if has('nvim')
		" find a doc of nvim-qt for how to do it
	else
		return torustree#status#tablabel (v:lnum)
	endif
endfun
