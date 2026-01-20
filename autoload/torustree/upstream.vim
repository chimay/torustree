" vim: set ft=vim fdm=indent iskeyword&:

" Upstream
"
" Parent leaf properties for context menus
"
" See also boomerang

" ---- booleans

fun! torustree#upstream#has_filter ()
	" Whether parent leaf has filter
	let nature = torustree#book#previous('nature')
	return nature.has_filter
endfun

fun! torustree#upstream#is_filtered ()
	" Whether parent leaf is filtered
	let filter = torustree#book#previous('filter')
	return ! empty(filter.words)
endfun

" ---- main

fun! torustree#upstream#first_data_line ()
	" First data line of parent leaf
	" Return 1 if parent leaf has no filter, 2 otherwise
	if torustree#upstream#has_filter ()
		return 2
	else
		return 1
	endif
endfun

fun! torustree#upstream#is_selection_empty ()
	" Whether parent leaf has empty selection
	let selection = torustree#book#previous('selection')
	return empty(selection.indexes)
endfun

fun! torustree#upstream#line_index (line)
	" Return index of parent line number in parent b:wheel_lines
	let line = a:line
	let shift = torustree#upstream#first_data_line ()
	let index = line - shift
	if torustree#upstream#is_filtered ()
		let filter = torustree#book#previous('filter')
		let indexlist = filter.indexes
		return indexlist[index]
	else
		return index
	endif
endfun

fun! torustree#upstream#selection ()
	" Return selection of parent leaf or parent index & component if empty
	if torustree#upstream#is_selection_empty ()
		let cursor = torustree#book#previous('cursor')
		return cursor.selection
	endif
	return torustree#book#previous('selection')
endfun

" ---- remove selection & related lines

fun! torustree#upstream#remove_selection ()
	" Parent leaf : remove selection & related lines
	" removed = selection lines or cursor component
	" e.g. : deleted buffers, closed tabs
	let lines = torustree#book#previous ('lines')
	let full = torustree#book#previous ('full')
	let not_empty_full = ! empty(full)
	let filter = torustree#book#previous ('filter')
	let filt_indexes = filter.indexes
	let filt_lines = filter.lines
	let filtered = ! empty(filt_indexes)
	" -- remove selection in lines & filter
	let selection_or_cursor = torustree#upstream#selection ()
	let indexlist = copy(selection_or_cursor.indexes)
	let indexlist = sort(indexlist, 'n')
	" last index first, to not confuse lines indexes
	let indexlist = reverse(indexlist)
	for index in indexlist
		eval lines->remove(index)
		if not_empty_full
			eval full->remove(index)
		endif
		if filtered
			let where = filt_indexes->index(index)
			eval filt_indexes->remove(where)
			eval filt_lines->remove(where)
		endif
	endfor
	" -- clear selection
	let selection = torustree#book#previous ('selection')
	let selection.indexes = []
	let selection.components = []
endfun
