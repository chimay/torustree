" vim: set ft=vim fdm=indent iskeyword&:

" Attic
"
" Most recently used files

" ---- script constants

if exists('s:is_mandala_file')
	unlockvar s:is_mandala_file
endif
let s:is_mandala_file = torustree#crystal#fetch('is_mandala_file')
lockvar s:is_mandala_file

" ---- helpers

fun! torustree#attic#remove_if_present (entry)
	" Remove entry from mru if file is already there
	let entry = a:entry
	let attic = g:torustree_attic
	for elem in g:torustree_attic
		if elem.file ==# entry.file
			eval g:torustree_attic->torustree#chain#remove_element(elem)
		endif
	endfor
endfun

" ---- operations

fun! torustree#attic#record (...)
	" Add file path to most recently used file list
	" Optional argument :
	" - full path of file
	" - current file by default
	" Add new entry at the beginning of the list
	" Move existing entry at the beginning of the list
	if a:0 > 0
		let filename = a:1
	else
		let filename = expand('%:p')
	endif
	" ---- do not add empty filenames
	if empty(filename)
		return v:false
	endif
	" ---- only add non torustree files
	if torustree#referen#is_in_torustree ()
		return v:false
	endif
	" ---- do not add mandala buffer
	let bufnum = bufnr('%')
	let mandalas = g:torustree_bufring.mandalas
	if torustree#chain#is_inside(bufnum, mandalas)
		return v:false
	endif
	" ---- do not add mandala filename
	if filename =~ s:is_mandala_file
		return v:false
	endif
	" ---- do not add term buffer
	if filename =~ '^term://'
		return v:false
	endif
	" ---- record file
	let attic = g:torustree_attic
	let entry = {}
	let entry.file = filename
	let entry.timestamp = torustree#pendulum#timestamp ()
	call torustree#attic#remove_if_present (entry)
	let g:torustree_attic = insert(g:torustree_attic, entry)
	let max = g:torustree_config.maxim.mru
	let g:torustree_attic = g:torustree_attic[:max - 1]
	return v:true
endfun
