" vim: set ft=vim fdm=indent iskeyword&:

" Lagrange
"
" Extrema helpers
"
" Joseph-Louis Lagrange is a mathematician, pioneer in :
"   - extrema of a function with constraints
"   - functionals
"   - variation calculus

fun! wheeltree#lagrange#argmin (list)
	" Returns indexes where list[index] = min(list)
	let list = a:list
	let minimum = min(list)
	let indexes = []
	for ind in wheeltree#chain#rangelen(list)
		if list[ind] == minimum
			eval indexes->add(ind)
		endif
	endfor
	return indexes
endfun

fun! wheeltree#lagrange#argmax (list)
	" Returns indexes where list[index] = max(list)
	let list = a:list
	let maximum = max(list)
	let indexes = []
	for ind in wheeltree#chain#rangelen(list)
		if list[ind] == maximum
			eval indexes->add(ind)
		endif
	endfor
	return indexes
endfun
