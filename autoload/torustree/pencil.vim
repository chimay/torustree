" vim: set ft=vim fdm=indent iskeyword&:

" Pencil
"
" Selection in mandalas

" ---- booleans

fun! torustree#pencil#has_selection ()
	" Whether mandala has selection
	return b:wheel_nature.has_selection
endfun

fun! torustree#pencil#is_selection_empty ()
	" Whether selection is empty
	if torustree#boomerang#is_context_menu ()
		return v:false
	endif
	return empty(b:wheel_selection.indexes)
endfun

fun! torustree#pencil#is_selected (...)
	" Whether line is selected
	" Optional argument : line number
	" Default : current line number
	if a:0 > 0
		let linum = a:1
	else
		let linum = line('.')
	endif
	let index = torustree#teapot#line_index (linum)
	let reference = b:wheel_selection.indexes
	return index->torustree#chain#is_inside(reference)
endfun

fun! torustree#pencil#has_select_mark (line)
	" Whether line has selection mark
	let selection_mark = g:torustree_config.display.selection
	let selection_pattern = '\m^' .. selection_mark
	return a:line =~ selection_pattern
endfun

" ---- marked / unmarked version

fun! torustree#pencil#marked (line)
	" Return marked line
	let line = a:line
	if torustree#pencil#has_select_mark (line)
		return line
	endif
	let selection_mark = g:torustree_config.display.selection
	return substitute(line, '\m^', selection_mark, '')
endfun

fun! torustree#pencil#unmarked (line)
	" Return unmarked line
	let line = a:line
	if ! torustree#pencil#has_select_mark (line)
		return line
	endif
	let selection_mark = g:torustree_config.display.selection
	let selection_pattern = '\m^' .. selection_mark
	return substitute(line, selection_pattern, '', '')
endfun

" ---- virtual selection at current line

fun! torustree#pencil#cursor (...)
	" Return dict containing index & component at cursor line
	" Optional argument :
	"   - line number
	"   - default : current line number
	" Mandala can be :
	"   - plain : in ordinary mandala buffer
	"   - treeish : in folded mandala buffer
	" ---- default line if needed
	" ---- must come before : line('.')
	if ! torustree#teapot#filter_to_default_line ()
		return {}
	endif
	" ---- arguments
	if a:0 > 0
		let linum = a:1
	else
		let linum = line('.')
	endif
	" ---- line index
	let index = torustree#teapot#line_index (linum)
	" ---- component
	if torustree#cuboctahedron#is_treeish ()
		let component = copy(b:wheel_full[index])
	else
		let cursor_line = getline(linum)
		let component = torustree#pencil#unmarked (cursor_line)
	endif
	" ---- coda
	let info = {}
	let info.index = index
	let info.component = component
	return info
endfun

fun! torustree#pencil#virtual (...)
	" Return selection as if cursor line was selected
	" Optional argument :
	"   - line number
	"   - default : current line number
	let info = torustree#pencil#cursor ()
	if empty(info)
		return #{ indexes : [], components : []}
	endif
	let cursor_selection = {}
	let cursor_selection.indexes = [ info.index ]
	let cursor_selection.components = [ info.component ]
	return cursor_selection
endfun

" ---- one line

fun! torustree#pencil#select (...)
	" Select line
	" Optional argument : line number
	" Default : current line number
	if ! torustree#pencil#has_selection ()
		return v:false
	endif
	if a:0 > 0
		let linum = a:1
	else
		let linum = line('.')
	endif
	if torustree#teapot#has_filter () && linum == 1
		return v:false
	endif
	let line = getline(linum)
	if empty(line)
		return v:false
	endif
	if torustree#pencil#is_selected (linum)
		return v:false
	endif
	" ---- update b:wheel_selection
	let selection = b:wheel_selection
	let cursor_info = torustree#pencil#cursor (linum)
	let index = cursor_info.index
	let component = cursor_info.component
	eval selection.indexes->add(index)
	eval selection.components->add(component)
	" ---- update buffer line
	let marked_line = torustree#pencil#marked (line)
	call torustree#mandala#unlock ()
	call setline(linum, marked_line)
	call torustree#mandala#post_edit ()
	" ---- coda
	setlocal nomodified
	return v:true
endfun

fun! torustree#pencil#clear (...)
	" Deselect line
	" Optional argument : line number
	" Default : current line number
	if ! torustree#pencil#has_selection ()
		return v:false
	endif
	if a:0 > 0
		let linum = a:1
	else
		let linum = line('.')
	endif
	let line = getline(linum)
	if empty(line)
		return v:false
	endif
	if ! torustree#pencil#is_selected (linum)
		return v:false
	endif
	" ---- update b:wheel_selection
	let selection = b:wheel_selection
	let cursor_info = torustree#pencil#cursor (linum)
	" -- indexes
	let index = cursor_info.index
	let found = selection.indexes->index(index)
	eval selection.indexes->remove(found)
	eval selection.components->remove(found)
	" ---- update buffer line
	let unmarked_line = torustree#pencil#unmarked (line)
	call torustree#mandala#unlock ()
	call setline(linum, unmarked_line)
	call torustree#mandala#post_edit ()
	" ---- coda
	setlocal nomodified
	return v:true
endfun

fun! torustree#pencil#toggle (...)
	" Toggle selection of line
	" Optional argument : line number
	" Default : current line number
	if ! torustree#pencil#has_selection ()
		return v:false
	endif
	if a:0 > 0
		let linum = a:1
	else
		let linum = line('.')
	endif
	if torustree#pencil#is_selected (linum)
		call torustree#pencil#clear (linum)
	else
		call torustree#pencil#select (linum)
	endif
	setlocal nomodified
	return v:true
endfun

" ---- all visible lines in the mandala
" ---- they may be filtered or not

fun! torustree#pencil#select_visible ()
	" Select all visible, filtered lines
	let start = torustree#teapot#first_data_line ()
	let lastline = line('$')
	for linum in range(start, lastline)
		call torustree#pencil#select (linum)
	endfor
	setlocal nomodified
	return v:true
endfun

fun! torustree#pencil#clear_visible ()
	" Deselect all visible, filtered lines
	let start = torustree#teapot#first_data_line ()
	let lastline = line('$')
	for linum in range(start, lastline)
		call torustree#pencil#clear (linum)
	endfor
	setlocal nomodified
	return v:true
endfun

fun! torustree#pencil#toggle_visible ()
	" Toggle all visible, filtered lines
	let start = torustree#teapot#first_data_line ()
	let lastline = line('$')
	for linum in range(start, lastline)
		call torustree#pencil#toggle (linum)
	endfor
	setlocal nomodified
	return v:true
endfun

" ---- hide & show

fun! torustree#pencil#hide (lock = 'lock')
	" Remove selection mark from all visible lines
	" This does not clear the selection
	"   - lock :
	"     + lock : relock if not writable
	"     + dont-lock : don't lock
	let lock = a:lock
	let start = torustree#teapot#first_data_line ()
	let lastline = line('$')
	let linelist = getline(start, '$')
	call torustree#mandala#unlock ()
	for linum in range(start, lastline)
		let line = getline(linum)
		let unmarked = torustree#pencil#unmarked (line)
		call setline(linum, unmarked)
	endfor
	setlocal nomodified
	call torustree#mandala#post_edit (lock)
	return v:true
endfun

fun! torustree#pencil#show (lock = 'lock')
	" Add selection mark to all selected lines
	" This does not alter the selection
	"   - lock :
	"     + lock : relock if not writable
	"     + dont-lock : don't lock
	if ! torustree#pencil#has_selection ()
		" avoid useless computing
		return v:false
	endif
	let lock = a:lock
	let start = torustree#teapot#first_data_line ()
	let lastline = line('$')
	let linelist = getline(start, '$')
	let reference = b:wheel_selection.indexes
	call torustree#mandala#unlock ()
	for linum in range(start, lastline)
		let index = torustree#teapot#line_index (linum)
		let inside = index->torustree#chain#is_inside(reference)
		if inside
			let line = getline(linum)
			let marked = torustree#pencil#marked (line)
			call setline(linum, marked)
		endif
	endfor
	setlocal nomodified
	call torustree#mandala#post_edit (lock)
	return v:true
endfun

fun! torustree#pencil#syncdown ()
	" Sync selection variable -> visible lines
	if ! torustree#pencil#has_selection ()
		" avoid useless computing
		return v:false
	endif
	let start = torustree#teapot#first_data_line ()
	let lastline = line('$')
	let linelist = getline(start, '$')
	let reference = b:wheel_selection.indexes
	call torustree#mandala#unlock ()
	for linum in range(start, lastline)
		let index = torustree#teapot#line_index (linum)
		let inside = index->torustree#chain#is_inside(reference)
		if inside
			let line = getline(linum)
			let marked = torustree#pencil#marked (line)
			call setline(linum, marked)
		else
			let line = getline(linum)
			let unmarked = torustree#pencil#unmarked (line)
			call setline(linum, unmarked)
		endif
	endfor
	setlocal nomodified
	call torustree#mandala#post_edit ()
	return v:true
endfun

" ---- selection

fun! torustree#pencil#selection ()
	" Return selection or, if empty, virtual selection at cursor line
	" If context menu, look in previous leaf
	if torustree#boomerang#is_context_menu ()
		return torustree#upstream#selection ()
	endif
	if torustree#pencil#is_selection_empty ()
		return torustree#pencil#virtual ()
	endif
	return b:wheel_selection
endfun

" ---- mappings

fun! torustree#pencil#mappings ()
	" Define selection maps & set property
	" -- selection property
	let b:wheel_nature.has_selection = v:true
	" -- normal mode
	nnoremap <buffer> <space> <cmd>call torustree#pencil#toggle()<cr>
	nnoremap <buffer> =       <cmd>call torustree#pencil#toggle()<cr>
	nnoremap <buffer> #       <cmd>call torustree#pencil#toggle_visible()<cr>
	nnoremap <buffer> *       <cmd>call torustree#pencil#select_visible()<cr>
	nnoremap <buffer> <bar>   <cmd>call torustree#pencil#clear_visible()<cr>
endfun
