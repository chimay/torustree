" vim: set ft=vim fdm=indent iskeyword&:

" Pyramid
"
" Mixed layouts of tabs and windows

fun! torustree#pyramid#steps (level, ...)
	" Display one level in tabs and the lower level in split windows
	" level can be torus or circle
	" Use optional argument as split function for torustree#mosaic#split
	if a:0 > 0
		let fun = a:1
	else
		let fun = 'main_left'
	endif
	let one = a:level
	let two = torustree#referen#lower_level_name (a:level)
	call torustree#mosaic#tabs (one)
	let tabnum = tabpagenr('$')
	for tabind in range(tabnum - 1)
		call torustree#mosaic#split(two, fun)
		tabnext
		call torustree#projection#follow ()
	endfor
	call torustree#mosaic#split(two, fun)
	tabrewind
	call torustree#projection#follow ()
endfun
