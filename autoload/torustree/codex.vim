" vim: set ft=vim fdm=indent iskeyword&:

" Codex
"
" Yank ring
"
" Takes advantage of TextYankPost event

" codex were written by copists
"
" other names ideas for this file :
"
" scroll, coil, spool
" scriptorium

" ---- script constants

if exists('s:registers_symbols')
	unlockvar s:registers_symbols
endif
let s:registers_symbols = torustree#crystal#fetch('registers-symbols')
lockvar s:registers_symbols

" ---- helpers

fun! torustree#codex#climb (content, register = 'unnamed')
	" Move content at beginning of yank ring
	let content = a:content
	let register = a:register
	let yanks = g:torustree_yank[register]
	let index = yanks->index(content)
	if index < 0
		return v:false
	endif
	eval yanks->remove(index)
	eval yanks->insert(content)
	return v:true
endfun

" ---- register

fun! torustree#codex#register (register = 'unnamed')
	" Add register to yank torustree
	let register = a:register
	" ---- ring
	let yanks = g:torustree_yank[register]
	" ---- vim symbol of register
	let symbols_dict = torustree#matrix#items2dict(s:registers_symbols)
	let symbol = symbols_dict[register]
	" ---- content
	let content = getreg(symbol, 1, v:true)
	if empty(content)
		return v:false
	endif
	if len(content) == 1 && content[0] !~ '\m\w'
		return v:false
	endif
	if len(content) > g:torustree_config.maxim.yank_lines
		return v:false
	endif
	if strchars(join(content)) > g:torustree_config.maxim.yank_size
		return v:false
	endif
	" -- treat special chars in inserted register
	eval content->map({ _, val -> split(val, "\n") })
	let content = torustree#matrix#flatten (content)
	" ---- add
	let index = yanks->index(content)
	if index >= 0
		eval yanks->remove(index)
	endif
	eval yanks->insert(content)
	" ---- truncate if too big
	if register ==# 'unnamed'
		let maxim = g:torustree_config.maxim.unnamed_yanks
	else
		let maxim = g:torustree_config.maxim.other_yanks
	endif
	" we need to use g:torustree_yank here
	" because yanks[:maxim - 1] makes a copy
	let g:torustree_yank[register] = yanks[:maxim - 1]
	return v:true
endfun

" --- add : for TextYankPost

fun! torustree#codex#add ()
	" Insert registers in yank torustree
	let register_list = torustree#matrix#items2keys(s:registers_symbols)
	for register in register_list
		call torustree#codex#register (register)
	endfor
endfun

" ---- prompt

fun! torustree#codex#switch_default_register ()
	" Switch register in yank prompting functions
	let prompt = 'Default register for torustree yank ring functions : '
	let complete = 'customlist,torustree#complete#register'
	let register = input(prompt, '', complete)
	if empty(register)
		return v:false
	endif
	let g:torustree_shelve.yank.default_register = register
	return v:true
endfun

fun! torustree#codex#yank_plain (where = 'linewise-after')
	" Paste yank from yank ring in plain mode
	let where = a:where
	let prompt = 'Yank element (' .. where .. ') : '
	let complete = 'customlist,torustree#complete#yank_plain'
	let content = input(prompt, '', complete)
	if empty(content)
		return v:false
	endif
	call torustree#codex#climb([ content ])
	let clipreg = substitute(&clipboard, 'unnamedplus', '+', '')
	let clipreg = substitute(clipreg, 'unnamed', '*', '')
	let clipboard = [ '"' ]->extend(split(clipreg, ','))
	if where ==# 'linewise-after'
		for register in clipboard
			call setreg(register, content, 'l')
		endfor
		silent put =content
	elseif where ==# 'linewise-before'
		for register in clipboard
			call setreg(register, content, 'l')
		endfor
		silent put! =content
	elseif where ==# 'charwise-after'
		for register in clipboard
			call setreg(register, content, 'c')
		endfor
		silent normal! p
	elseif where ==# 'charwise-before'
		for register in clipboard
			call setreg(register, content, 'c')
		endfor
		silent normal! P
	endif
	return v:true
endfun

fun! torustree#codex#yank_list (where = 'linewise-after')
	" Paste yank from yank ring in list mode
	let where = a:where
	let prompt = 'Yank list element (' .. where .. ') : '
	let complete = 'customlist,torustree#complete#yank_list'
	let line = input(prompt, '', complete)
	if empty(line)
		return v:false
	endif
	let content = eval(line)
	call torustree#codex#climb(content)
	let clipreg = substitute(&clipboard, 'unnamedplus', '+', '')
	let clipreg = substitute(clipreg, 'unnamed', '*', '')
	let clipboard = [ '"' ]->extend(split(clipreg, ','))
	if where ==# 'linewise-after'
		for register in clipboard
			call setreg(register, content, 'l')
		endfor
		silent put =content
	elseif where ==# 'linewise-before'
		for register in clipboard
			call setreg(register, content, 'l')
		endfor
		silent put! =content
	elseif where ==# 'charwise-after'
		for register in clipboard
			call setreg(register, content, 'c')
		endfor
		silent normal! p
	elseif where ==# 'charwise-before'
		for register in clipboard
			call setreg(register, content, 'c')
		endfor
		silent normal! P
	endif
	return v:true
endfun

" ---- mandala

fun! torustree#codex#mandala_switch (mode)
	" Switch register in yank mandala
	let mode = a:mode
	let prompt = 'Switch to register : '
	let complete = 'customlist,torustree#complete#register'
	let register = input(prompt, '', complete)
	if empty(register)
		return v:false
	endif
	" ---- type
	if mode ==# 'plain'
		let type = 'yank/'
	elseif mode ==# 'list'
		let type = 'yank/list/'
	endif
	if register ==# 'overview'
		let type ..= 'overview'
	elseif register ==# 'file'
		let type ..= '%%'
	else
		let symbols_dict = torustree#matrix#items2dict(s:registers_symbols)
		let type ..= symbols_dict[register]
	endif
	" ---- properties
	let b:torustree_nature.type = type
	let b:torustree_settings.yank.register = register
	" ---- lines
	let lines = torustree#perspective#yank_mandala(mode, register)
	call torustree#teapot#reset ()
	call torustree#mandala#fill(lines)
	" ---- status
	call torustree#cylinder#update_type ()
	call torustree#status#mandala_leaf ()
	return v:true
endfun

fun! torustree#codex#undo ()
	" Undo action in previous window
	call torustree#rectangle#goto_previous ()
	undo
	call torustree#cylinder#recall ()
endfun

fun! torustree#codex#redo ()
	" Redo action in previous window
	call torustree#rectangle#goto_previous ()
	redo
	call torustree#cylinder#recall ()
endfun

fun! torustree#codex#options (mode)
	" Set local yank options
	setlocal nowrap
	if a:mode ==# 'plain'
		setlocal nocursorline
	endif
endfun

fun! torustree#codex#mappings (mode)
	" Define local yank maps
	let nmap = 'nnoremap <buffer>'
	let mode = a:mode
	if mode ==# 'list'
		let paste = 'torustree#line#paste_list'
	elseif mode ==# 'plain'
		let paste = 'torustree#line#paste_plain'
	endif
	" ---- normal mode
	let nmap = 'nnoremap <buffer>'
	execute nmap '<cr>  <cmd>call' paste "('linewise-after', 'close')<cr>"
	execute nmap 'g<cr> <cmd>call' paste "('linewise-after', 'open')<cr>"
	execute nmap 'p     <cmd>call' paste "('linewise-after', 'open')<cr>"
	execute nmap 'P     <cmd>call' paste "('linewise-before', 'open')<cr>"
	execute nmap 'gp    <cmd>call' paste "('charwise-after', 'open')<cr>"
	execute nmap 'gP    <cmd>call' paste "('charwise-before', 'open')<cr>"
	" -- switch register
	execute nmap 's     <cmd>call torustree#codex#mandala_switch(' .. string(mode) .. ')<cr>'
	" ---- visual mode
	if mode ==# 'plain'
		let paste_visual = 'torustree#line#paste_visual'
		let vmap = 'vnoremap <silent> <buffer>'
		execute vmap '<cr>  :<c-u>call' paste_visual "('after', 'close')<cr>"
		execute vmap 'g<cr> :<c-u>call' paste_visual "('after', 'open')<cr>"
		execute vmap 'p     :<c-u>call' paste_visual "('after', 'open')<cr>"
		execute vmap 'P     :<c-u>call' paste_visual "('before', 'open')<cr>"
	endif
	" ---- undo, redo
	nnoremap <buffer> u <cmd>call torustree#codex#undo()<cr>
	nnoremap <buffer> <c-r> <cmd>call torustree#codex#redo()<cr>
	" ---- context menu
	let menu = 'yank/' .. mode
	call torustree#boomerang#launch_map (menu)
endfun

fun! torustree#codex#template (settings)
	" Template
	let settings = a:settings
	let mode = settings.mode
	call torustree#mandala#template (settings)
	call torustree#codex#options (mode)
	call torustree#codex#mappings (mode)
	" selection
	call torustree#pencil#mappings ()
endfun
