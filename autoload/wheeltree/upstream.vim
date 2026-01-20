" vim: set ft=vim fdm=indent iskeyword&:

" Upstream
"
" Parent leaf properties for context menus
"
" See also boomerang

" ---- booleans

fun! wheeltree#upstream#has_filter ()
	" Whether parent leaf has filter
	let nature = wheeltree#book#previous('nature')
	return nature.has_filter
endfun

fun! wheeltree#upstream#is_filtered ()
	" Whether parent leaf is filtered
	let filter = wheeltree#book#previous('filter')
	return ! empty(filter.words)
endfun

" ---- main

fun! wheeltree#upstream#first_data_line ()
	" First data line of parent leaf
	" Return 1 if parent leaf has no filter, 2 otherwise
	if wheeltree#upstream#has_filter ()
		return 2
	else
		return 1
	endif
endfun

fun! wheeltree#upstream#is_selection_empty ()
	" Whether parent leaf has empty selection
	let selection = wheeltree#book#previous('selection')
	return empty(selection.indexes)
endfun

fun! wheeltree#upstream#line_index (line)
	" Return index of parent line number in parent b:wheel_lines
	let line = a:line
	let shift = wheeltree#upstream#first_data_line ()
	let index = line - shift
	if wheeltree#upstream#is_filtered ()
		let filter = wheeltree#book#previous('filter')
		let indexlist = filter.indexes
		return indexlist[index]
	else
		return index
	endif
endfun

fun! wheeltree#upstream#selection ()
	" Return selection of parent leaf or parent index & component if empty
	if wheeltree#upstream#is_selection_empty ()
		let cursor = wheeltree#book#previous('cursor')
		return cursor.selection
	endif
	return wheeltree#book#previous('selection')
endfun

" ---- remove selection & related lines

fun! wheeltree#upstream#remove_selection ()
	" Parent leaf : remove selection & related lines
	" removed = selection lines or cursor component
	" e.g. : deleted buffers, closed tabs
	let lines = wheeltree#book#previous ('lines')
	let full = wheeltree#book#previous ('full')
	let not_empty_full = ! empty(full)
	let filter = wheeltree#book#previous ('filter')
	let filt_indexes = filter.indexes
	let filt_lines = filter.lines
	let filtered = ! empty(filt_indexes)
	" -- remove selection in lines & filter
	let selection_or_cursor = wheeltree#upstream#selection ()
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
	let selection = wheeltree#book#previous ('selection')
	let selection.indexes = []
	let selection.components = []
endfun
