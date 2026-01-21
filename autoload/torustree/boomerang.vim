" vim: set ft=vim fdm=indent iskeyword&:

" Boomerang
"
" Context menu
" Act back on parent, previous leaf of mandala

" Script constants

if exists('s:field_separ')
	unlockvar s:field_separ
endif
let s:field_separ = torustree#crystal#fetch('separator/field')
lockvar s:field_separ

if exists('s:mandala_targets')
	unlockvar s:mandala_targets
endif
let s:mandala_targets = torustree#crystal#fetch('mandala/targets')
lockvar s:mandala_targets

" ---- helpers

fun! torustree#boomerang#is_context_menu ()
	" Whether mandala leaf is a context menu
	if ! torustree#cylinder#is_mandala ()
		return v:false
	endif
	return b:torustree_nature.class ==# 'menu/context'
endfun

fun! torustree#boomerang#hidden_buffers (action)
	" Execute action on hidden buffers
	let action = a:action
	let lines = torustree#book#previous ('lines')
	let filter = torustree#book#previous ('filter')
	" ---- hidden buffers
	if action ==# 'delete_hidden' || action ==# 'wipe_hidden'
		let hidden = torustree#rectangle#hidden_buffers ()[0]
	elseif action ==# 'wipe_all_hidden'
		let hidden = torustree#rectangle#hidden_buffers ('all')[0]
	else
		throw 'torustree boomerang buffer : bad action format'
	endif
	if empty(hidden)
		echomsg 'no hidden buffer'
		return v:false
	endif
	let hidden = reverse(hidden)
	let rangelines = reverse(range(len(lines)))
	" ---- remove lines
	for index in rangelines
		let record = lines[index]
		let fields = split(record, s:field_separ)
		let bufnum = str2nr(fields[0])
		if bufnum->torustree#chain#is_inside(hidden)
			eval lines->remove(index)
			if ! empty(filter.indexes)
				let where = filter.indexes->index(index)
				eval filter.indexes->remove(where)
				eval filter.lines->remove(where)
			endif
		endif
	endfor
	" ---- remove buffers
	if action ==# 'delete_hidden'
		for bufnum in hidden
			execute 'silent bdelete!' bufnum
		endfor
		echomsg 'hidden buffers deleted'
	elseif  action =~ 'wipe.*hidden'
		for bufnum in hidden
			execute 'silent bwipe!' bufnum
		endfor
		echomsg 'hidden buffers wiped'
	endif
endfun

" ---- mandalas

fun! torustree#boomerang#launch_map (type)
	" Define map to launch context menu
	" -- navigation by default
	let type = a:type
	execute 'nnoremap <buffer> <tab> <cmd>call torustree#boomerang#menu(' .. string(type) .. ')<cr>'
endfun

fun! torustree#boomerang#menu (dictname)
	" Build context menu
	let dictname = 'context/' .. a:dictname
	let settings = deepcopy(b:torustree_settings)
	" close is false for space & tab
	" within tower#staircase -> tower#mappings
	let menuset = #{
				\ class : 'menu/context',
				\ linefun : dictname,
				\ close : v:true,
				\ }
	call torustree#tower#staircase (menuset, settings)
	" ---- properties ; must come after tower#staircase
	" -- let loop#menu handle open / close, tell loop#navigation to forget it
	let settings.close = v:false
	" -- reload function
	call torustree#mandala#set_reload('torustree#boomerang#menu', a:dictname)
endfun

" ---- applications

fun! torustree#boomerang#navigation (target)
	" Navigation actions
	let target = a:target
	let settings = b:torustree_settings
	let settings.menu.action = 'navigation'
	if ! target->torustree#chain#is_inside(s:mandala_targets)
		return v:false
	endif
	let settings.target = target
	call torustree#loop#navigation (settings)
	return v:true
endfun

fun! torustree#boomerang#buffer (action)
	" Buffers actions
	" Only called for non navigation actions
	let action = a:action
	let settings = b:torustree_settings
	let settings.menu.action = action
	if action ==# 'delete'
		call torustree#loop#buffer_delete ()
	elseif action ==# 'unload'
		call torustree#loop#buffer_unload ()
	elseif action ==# 'wipe'
		call torustree#loop#buffer_wipe ()
	elseif action =~ 'delete.*hidden' || action =~ 'wipe.*hidden'
		call torustree#boomerang#hidden_buffers (action)
	endif
	return v:true
endfun

fun! torustree#boomerang#tabwin (action)
	" Buffers visible in tabs & wins
	let action = a:action
	let settings = b:torustree_settings
	let settings.menu.action = action
	if action ==# 'open'
		" tell loop#navigation to not care about opening a new
		" target tab or window
		let settings.target = 'here'
		return torustree#loop#navigation (settings)
	elseif action ==# 'tabnew'
		tabnew
		return v:true
	elseif action ==# 'tabclose'
		call torustree#loop#tabclose ()
		return v:true
	endif
	return v:false
endfun

fun! torustree#boomerang#tabwin_tree (action)
	" Buffers visible in tree of tabs & wins
	return torustree#boomerang#tabwin (a:action)
endfun

fun! torustree#boomerang#grep (action)
	" Grep actions
	let action = a:action
	let settings = b:torustree_settings
	let settings.menu.action = action
	if action ==# 'quickfix'
		call torustree#cylinder#close ()
		call torustree#vector#copen ()
	endif
endfun

fun! torustree#boomerang#yank (action)
	" Yank actions
	" action = before / after
	let action = a:action
	let settings = b:torustree_settings
	let settings.menu.action = action
	let mode = b:torustree_settings.mode
	call torustree#line#paste_{mode} (action, 'open')
endfun
