" vim: set ft=vim fdm=indent iskeyword&:

" Pyramid
"
" Mixed layouts of tabs and windows

fun! wheeltree#pyramid#steps (level, ...)
	" Display one level in tabs and the lower level in split windows
	" level can be torus or circle
	" Use optional argument as split function for wheeltree#mosaic#split
	if a:0 > 0
		let fun = a:1
	else
		let fun = 'main_left'
	endif
	let one = a:level
	let two = wheeltree#referen#lower_level_name (a:level)
	call wheeltree#mosaic#tabs (one)
	let tabnum = tabpagenr('$')
	for tabind in range(tabnum - 1)
		call wheeltree#mosaic#split(two, fun)
		tabnext
		call wheeltree#projection#follow ()
	endfor
	call wheeltree#mosaic#split(two, fun)
	tabrewind
	call wheeltree#projection#follow ()
endfun
