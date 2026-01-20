" vim: set ft=vim fdm=indent iskeyword&:

" Referen
"
" Reference to objects in wheeltree

" Script constants

if exists('s:levels')
	unlockvar s:levels
endif
let s:levels = wheeltree#crystal#fetch('referen/levels')
lockvar s:levels

if exists('s:coordinates_levels')
	unlockvar s:coordinates_levels
endif
let s:coordinates_levels = wheeltree#crystal#fetch('referen/coordinates/levels')
lockvar s:coordinates_levels

if exists('s:list_keys')
	unlockvar s:list_keys
endif
let s:list_keys = wheeltree#crystal#fetch('referen/list_keys')
lockvar s:list_keys

" ---- current elements

fun! wheeltree#referen#wheeltree ()
	" Wheeltree
	return g:wheeltree
endfun

fun! wheeltree#referen#torus ()
	" Current torus
	let cur_torus = {}
	if ! empty(g:wheeltree.toruses)
		let cur_torus = g:wheeltree.toruses[g:wheeltree.current]
	endif
	return cur_torus
endfun

fun! wheeltree#referen#circle (...)
	" Current circle
	let all = 0
	if a:0 > 0
		if a:1 ==# 'all' || a:1 ==# 'a' || a:1 == 1
			let all = 1
		endif
	endif
	let cur_torus = {}
	let cur_circle = {}
	if ! empty(g:wheeltree.toruses)
		let cur_torus = g:wheeltree.toruses[g:wheeltree.current]
		if ! empty(cur_torus.circles)
			let cur_circle = cur_torus.circles[cur_torus.current]
		endif
	endif
	if all == 1
		return [cur_torus, cur_circle]
	else
		return cur_circle
	endif
endfun

fun! wheeltree#referen#location (...)
	" Current location
	let all = 0
	if a:0 > 0
		if a:1 ==# 'all' || a:1 ==# 'a' || a:1 == 1
			let all = 1
		endif
	endif
	let cur_torus = {}
	let cur_circle = {}
	let cur_location = {}
	if ! empty(g:wheeltree.toruses)
		let cur_torus = g:wheeltree.toruses[g:wheeltree.current]
		if ! empty(cur_torus.circles)
			let cur_circle = cur_torus.circles[cur_torus.current]
			if ! empty(cur_circle.locations)
				let cur_location = cur_circle.locations[cur_circle.current]
			endif
		endif
	endif
	if all == 1
		return [cur_torus, cur_circle, cur_location]
	else
		return cur_location
	endif
endfun

fun! wheeltree#referen#current (level)
	" Current level = wheeltree, torus, circle, location
	return wheeltree#referen#{a:level} ()
endfun

" ---- coordinates

fun! wheeltree#referen#level_index_in_coordin (level)
	" Return index of level in coordinates
	" wheeltree -> -1
	" torus -> 0
	" circle -> 1
	" location -> 2
	return s:coordinates_levels->index(a:level)
endfun

fun! wheeltree#referen#coordinates ()
	" Wheeltree coordinates : names of current torus, circle and location
	let [torus, circle, location] = wheeltree#referen#location('all')
	let names = []
	if has_key(torus, 'name')
		eval names->add(torus.name)
		if has_key(circle, 'name')
			eval names->add(circle.name)
			if has_key(location, 'name')
				eval names->add(location.name)
			endif
		endif
	endif
	return names
endfun

" ---- hierarchy

fun! wheeltree#referen#upper (level)
	" Current upper element in hierarchy
	let index = s:levels->index(a:level)
	if index < 1 || index > 3
		echomsg 'wheeltree referen upper : level must be torus, circle or location'
		return
	endif
	let index -= 1
	return wheeltree#referen#{s:levels[index]} ()
endfun

fun! wheeltree#referen#lower (level)
	" Current lower element in hierarchy
	let index = s:levels->index(a:level)
	if index > 2 || index < 0
		echomsg 'wheeltree referen lower : level index must be wheeltree, torus or circle'
		return
	endif
	let index += 1
	return wheeltree#referen#{s:levels[index]} ()
endfun

fun! wheeltree#referen#upper_level_name (level)
	" Level name of upper element in hierarchy
	let index = s:levels->index(a:level)
	if index < 1 || index > 3
		echomsg 'wheeltree referen upper level name : level must be torus, circle or location'
		return
	endif
	let index -= 1
	return s:levels[index]
endfun

fun! wheeltree#referen#lower_level_name (level)
	" Level name of lower element in hierarchy
	let index = s:levels->index(a:level)
	if index > 2 || index < 0
		echomsg 'wheeltree referen lower level name : level index must be wheeltree, torus or circle'
		return
	endif
	let index += 1
	return s:levels[index]
endfun

" ---- emptiness

fun! wheeltree#referen#is_empty (level)
	" Whether current level element is empty
	" Level can be wheeltree, torus, circle or location
	let level = a:level
	let elem = wheeltree#referen#current (level)
	if level ==# 'location'
		if empty(elem)
			return v:true
		else
			return v:false
		endif
	endif
	if empty(elem) || empty(elem.glossary)
		return v:true
	else
		return v:false
	endif
endfun

fun! wheeltree#referen#is_upper_empty (level)
	" Whether upper level element is empty
	" Level can be torus, circle or location
	let level = a:level
	let elem = wheeltree#referen#upper (level)
	if empty(elem) || empty(elem.glossary)
		return v:true
	else
		return v:false
	endif
endfun

" ---- current file in wheeltree ?

fun! wheeltree#referen#is_in_wheel (...)
	" Whether filename argument is in wheeltree
	" Default optional argument : current filename
	if a:0 > 0
		let filename = a:1
	else
		let filename = expand('%:p')
	endif
	let wheel_files = wheeltree#helix#files ()
	let is_in_wheel = wheeltree#chain#is_inside(filename, wheel_files)
	return is_in_wheel
endfun

" ---- element lists

fun! wheeltree#referen#list_key (level)
	" Name of key containing list of elements
	return s:list_keys[a:level]
endfun

fun! wheeltree#referen#elements (dict)
	" Elements list of dict :
	" - toruses if dict is the wheeltree
	" - circles if dict is a torus
	" - locations if dict is a circle
	let dict = a:dict
	if has_key(dict, 'toruses')
		return dict.toruses
	elseif has_key(dict, 'circles')
		return dict.circles
	elseif has_key(dict, 'locations')
		return dict.locations
	else
		echomsg 'wheeltree referen elements : arg should be the wheeltree, a torus or a circle'
		return []
	endif
endfun

" ---- match current buffer

fun! wheeltree#referen#location_matches_file ()
	" Whether current location matches current file
	let cur_file = expand('%:p')
	let cur_location = wheeltree#referen#location()
	if empty(cur_location)
		return v:false
	endif
	return cur_file ==# cur_location.file
endfun

fun! wheeltree#referen#location_matches_file_line_col ()
	" Whether current location matches current file & cursor  position
	let cur_location = wheeltree#referen#location()
	let match = wheeltree#referen#location_matches_file ()
	let match = match && line('.') ==# cur_location.line
	let match = match && col('.') ==# cur_location.col
	return match
endfun
