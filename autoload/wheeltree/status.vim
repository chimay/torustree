" vim: set ft=vim fdm=indent iskeyword&:

" Status
"
" Echo status info

" ---- script constants

if exists('s:field_separ')
	unlockvar s:field_separ
endif
let s:field_separ = wheeltree#crystal#fetch('separator/field')
lockvar s:field_separ

if exists('s:level_separ')
	unlockvar s:level_separ
endif
let s:level_separ = wheeltree#crystal#fetch('separator/level')
lockvar s:level_separ

" ---- clear cmd line

fun! wheeltree#status#clear ()
	" Clear command line space
	" Does not clear the vim messages
	" credit :
	" https://neovim.discourse.group/t/how-to-clear-the-echo-message-in-the-command-line/268/2
	call feedkeys(':','nx')
endfun

fun! wheeltree#status#clear_messages ()
	" Clear vim messages
	messages clear
	echo 'messages cleared'
endfun

" ---- echo

fun! wheeltree#status#echo (...)
	" Echo message
	if a:0 == 0
		let message = ''
	endif
	if a:0 > 1
		let message = join(a:000)
		return call('wheeltree#status#echo', [ message ])
	endif
	let message = a:1
	if type(message) == v:t_list
		let message = join(message)
	endif
	call wheeltree#status#clear ()
	echo message
	return v:true
endfun

fun! wheeltree#status#message (...)
	" Echomsg message
	if a:0 == 0
		let message = ''
	endif
	if a:0 > 1
		let message = join(a:000)
		return call('wheeltree#status#message', [ message ])
	endif
	let message = a:1
	if type(message) == v:t_list
		let message = join(message)
	endif
	" does not clear messages, only echo area
	call wheeltree#status#clear ()
	echomsg message
	return v:true
endfun

" ---- wheeltree

fun! wheeltree#status#dashboard_text ()
	" Return dashboard text
	if wheeltree#referen#is_empty('wheeltree')
		return 'empty wheeltree'
	endif
	let [torus, circle, location] = wheeltree#referen#location('all')
	let dashboard = 'wheeltree: '
	let dashboard ..= torus.name .. s:level_separ
	if wheeltree#referen#is_empty('torus')
		let dashboard ..= '[empty torus]'
		return dashboard
	endif
	let dashboard ..= circle.name .. s:level_separ
	if wheeltree#referen#is_empty('circle')
		let dashboard ..= '[empty circle]'
		return dashboard
	endif
	let dashboard ..= location.name .. ' : '
	let file = wheeltree#disc#relative_path(location.file)
	let dashboard ..= file .. ':' .. location.line .. ':' .. location.col
	return dashboard
endfun

fun! wheeltree#status#dashboard ()
	" Display dashboard, summary of current wheeltree status
	let dashboard = wheeltree#status#dashboard_text ()
	call wheeltree#status#echo (dashboard)
endfun

" ---- mandala & leaf

fun! wheeltree#status#mandalas ()
	" Return bufring status
	let bufring = g:wheeltree_bufring
	let names = copy(bufring.names)
	let current = bufring.current
	let names[current] = '[' .. names[current] .. ']'
	return names
endfun

fun! wheeltree#status#leaves ()
	" Return leaves status
	if ! wheeltree#cylinder#is_mandala ()
		return []
	endif
	let nature = wheeltree#book#ring ('nature')
	let types = nature->map({ _, val -> val.type })
	let current = b:wheel_ring.current
	let types[current] =  '[' .. types[current] .. ']'
	return types
endfun

fun! wheeltree#status#statusline ()
	" Statusline for mandala
	if ! wheeltree#cylinder#is_mandala ()
		echomsg 'wheeltree statusline : should not be called outside of mandala'
		return &g:statusline
	endif
	let mandalas = wheeltree#status#mandalas ()
	let mandalas = join(mandalas)
	let leaves = wheeltree#status#leaves ()
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

fun! wheeltree#status#mandala_leaf ()
	" Mandala & leaf dashboard
	let in_status = g:wheeltree_config.display.statusline
	if in_status > 0 && wheeltree#cylinder#is_mandala ()
		call wheeltree#status#clear ()
		setlocal statusline=%!wheeltree#status#statusline()
		return v:true
	endif
	let mandalas = wheeltree#status#mandalas()
	let leaves = wheeltree#status#leaves()
	call wheeltree#status#clear ()
	if empty(leaves)
		echo 'wheeltree buffers: ' join(mandalas) "\n"
		return v:true
	endif
	let oneline = g:wheeltree_config.display.dedibuf ==# 'one-line'
	if oneline
		echo 'wheeltree buf:' join(mandalas) '/ lay:' join(leaves)
	else
		echo 'wheeltree buffers : ' join(mandalas) "\n"
		echo '      layers  : ' join(leaves)
	endif
	return v:true
endfun

" ---- tab line

fun! wheeltree#status#tablabel (tabnum)
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
	if ! has_key(g:wheeltree_shelve.layout, 'tabnames')
		return label
	endif
	let tabnames = g:wheeltree_shelve.layout.tabnames
	if empty(tabnames)
		return label
	endif
	let label = tabnames[tabnum - 1] .. ' ' .. modified
	return label
endfun

fun! wheeltree#status#tabline ()
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
		let text ..= ' %{wheeltree#status#tablabel(' .. tabnum .. ')} '
	endfor
	" After the last tab fill with TabLineFill and reset tab page nr
	let text ..= '%#TabLineFill#%T'
	" Right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let text ..= '%=%#TabLine#%999X[X]'
	endif
	return text
endfun

fun! wheeltree#status#guitablabel ()
	" Gui label of a tab
	if has('nvim')
		" find a doc of nvim-qt for how to do it
	else
		return wheeltree#status#tablabel (v:lnum)
	endif
endfun
