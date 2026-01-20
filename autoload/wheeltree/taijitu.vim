" vim: set ft=vim fdm=indent iskeyword&:

" Ring helpers
" Circular functions
"
" Taijitu is the rotating yin-yang symbol

" ---- index rotation

fun! wheeltree#taijitu#circular_plus (index, length)
	" Rotate/increase index with modulo
	return (a:index + 1) % a:length
endfun

fun! wheeltree#taijitu#circular_minus (index, length)
	" Rotate/decrease index with modulo
	let index = (a:index - 1) % a:length
	if index < 0
		let index += a:length
	endif
	return index
endfun

" ---- list rotation

fun! wheeltree#taijitu#rotate_left (list)
	" Rotate list to the left
	let list = a:list
	if len(list) > 1
		let rotated = deepcopy(list[1:]) + deepcopy([list[0]])
	else
		let rotated = deepcopy(list)
	endif
	return rotated
endfun

fun! wheeltree#taijitu#rotate_right (list)
	" Rotate list to the right
	let list = a:list
	if len(list) > 1
		let rotated = deepcopy([list[-1]]) + deepcopy(list[:-2])
	else
		let rotated = deepcopy(list)
	endif
	return rotated
endfun

fun! wheeltree#taijitu#roll_left (list, index)
	" Roll index in list until left = beginning
	let index = a:index
	let list = a:list
	if index > 0 && index < len(list)
		return deepcopy(list[index:]) + deepcopy(list[0:index - 1])
	else
		return deepcopy(list)
	endif
endfun

fun! wheeltree#taijitu#roll_right (list, index)
	" Roll index of list until right = end
	let index = a:index
	let list = a:list
	if index >= 0 && index < len(list) - 1
		return deepcopy(list[index + 1:-1]) + deepcopy(list[0:index])
	else
		return deepcopy(list)
	endif
endfun
