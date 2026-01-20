" vim: set ft=vim fdm=indent iskeyword&:

" Loop
"
" Loops on mandala selections

" ---- script constants

if exists('s:field_separ')
	unlockvar s:field_separ
endif
let s:field_separ = torustree#crystal#fetch('separator/field')
lockvar s:field_separ

" ---- navigation

fun! torustree#loop#navigation (settings)
	" Call navigation function
	" settings keys :
	"   - function : navigation function name or funcref
	"   - target : current window, tab, horizontal or vertical split,
	"              even or with golden ratio
	"   - related buffer of current mandala
	"   - close : whether to close mandala
	let settings = deepcopy(a:settings)
	call torustree#river#default (settings)
	let Fun = settings.function
	let target = settings.target
	let close = settings.close
	" ---- selection
	let selection = torustree#pencil#selection ()
	let indexes = selection.indexes
	let components = selection.components
	if empty(indexes)
		return v:false
	endif
	" ---- switch off preview
	call torustree#orbiter#switch_off ()
	" ---- go to previous window before processing
	call torustree#rectangle#goto_previous ()
	" ---- target : current window or not ?
	if target ==# 'here'
		let settings.selection.index = selection.indexes[0]
		let settings.selection.component = selection.components[0]
		let winiden = Fun->torustree#metafun#call(settings)
		call torustree#spiral#cursor ()
	else
		let length = len(indexes)
		for ind in range(length)
			let settings.selection.index = selection.indexes[ind]
			let settings.selection.component = selection.components[ind]
			let winiden = Fun->torustree#metafun#call(settings)
			call torustree#spiral#cursor ()
		endfor
	endif
	" ---- coda
	if close
		call torustree#cylinder#close ()
		" go to last destination
		call win_gotoid (winiden)
	else
		" no need to trigger WheelBeforeJump : the operation is already done
		" vortex#update overrides native navigation signs
		" by location signs on some files
		call torustree#cylinder#recall ('dont-trigger')
	endif
	return winiden
endfun

" ---- context menus

fun! torustree#loop#buffer_delete ()
	" Delete buffers
	let selection = torustree#upstream#selection ()
	let components = selection.components
	for elem in components
		let fields = split(elem, s:field_separ)
		let bufnum = str2nr(fields[0])
		execute 'silent bdelete!' bufnum
		echomsg 'buffer' bufnum 'deleted'
	endfor
	" dont remove parent selection on buffer/all
	if torustree#mandala#type () ==# 'buffer'
		call torustree#upstream#remove_selection ()
	endif
endfun

fun! torustree#loop#buffer_unload ()
	" Unload buffers
	let selection = torustree#upstream#selection ()
	let components = selection.components
	for elem in components
		let fields = split(elem, s:field_separ)
		let bufnum = str2nr(fields[0])
		execute 'silent bunload' bufnum
		echomsg 'buffer' bufnum 'unloaded'
	endfor
endfun

fun! torustree#loop#buffer_wipe ()
	" Wipe buffers
	let selection = torustree#upstream#selection ()
	let components = selection.components
	for elem in components
		let fields = split(elem, s:field_separ)
		let bufnum = str2nr(fields[0])
		execute 'silent bwipe!' bufnum
		echomsg 'buffer' bufnum 'wiped'
	endfor
	call torustree#upstream#remove_selection ()
endfun

fun! torustree#loop#tabclose ()
	" Close tabs
	let selection = torustree#upstream#selection()
	let indexes = selection.indexes
	let components = selection.components
	let [shuffled, indexes] = torustree#chain#sort(indexes)
	call reverse(indexes)
	call reverse(shuffled)
	let selection.indexes = indexes
	let selection.components = components->torustree#chain#sublist(shuffled)
	let components = selection.components
	let cur_tab = tabpagenr()
	for elem in components
		if type(elem) == v:t_string
			" plain, unfolded, tabs & wins
			let fields = split(elem, s:field_separ)
			let tabnum = str2nr(fields[0])
		else
			" tree, folded tabs & wins
			let tabnum = elem[0]
		endif
		if tabnum == cur_tab
			echomsg 'torustree line tabwin : will not close current tab page'
			continue
		endif
		echomsg 'noautocmd tabclose' tabnum
		execute 'noautocmd tabclose' tabnum
	endfor
	call torustree#upstream#remove_selection ()
endfun
