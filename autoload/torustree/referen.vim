" vim: set ft=vim fdm=indent iskeyword&:

" Referen
"
" Reference to objects in torustree

" Script constants

if exists('s:levels')
	unlockvar s:levels
endif
let s:levels = torustree#crystal#fetch('referen/levels')
lockvar s:levels

if exists('s:coordinates_levels')
	unlockvar s:coordinates_levels
endif
let s:coordinates_levels = torustree#crystal#fetch('referen/coordinates/levels')
lockvar s:coordinates_levels

if exists('s:list_keys')
	unlockvar s:list_keys
endif
let s:list_keys = torustree#crystal#fetch('referen/list_keys')
lockvar s:list_keys

" ---- current elements

fun! torustree#referen#torustree ()
	" Torustree
	return g:torustree
endfun

fun! torustree#referen#torus ()
	" Current torus
	let cur_torus = {}
	if ! empty(g:torustree.toruses)
		let cur_torus = g:torustree.toruses[g:torustree.current]
	endif
	return cur_torus
endfun

fun! torustree#referen#circle (...)
	" Current circle
	let all = 0
	if a:0 > 0
		if a:1 ==# 'all' || a:1 ==# 'a' || a:1 == 1
			let all = 1
		endif
	endif
	let cur_torus = {}
	let cur_circle = {}
	if ! empty(g:torustree.toruses)
		let cur_torus = g:torustree.toruses[g:torustree.current]
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

fun! torustree#referen#location (...)
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
	if ! empty(g:torustree.toruses)
		let cur_torus = g:torustree.toruses[g:torustree.current]
		if ! empty(cur_torus.circles)
			let cur_circle = cur_torus.circles[cur_torus.current]
			if ! empty(cur_circle.stones)
				let cur_location = cur_circle.stones[cur_circle.current]
			endif
		endif
	endif
	if all == 1
		return [cur_torus, cur_circle, cur_location]
	else
		return cur_location
	endif
endfun

fun! torustree#referen#current (level)
	" Current level = torustree, torus, circle, location
	return torustree#referen#{a:level} ()
endfun

" ---- coordinates

fun! torustree#referen#level_index_in_coordin (level)
	" Return index of level in coordinates
	" torustree -> -1
	" torus -> 0
	" circle -> 1
	" location -> 2
	return s:coordinates_levels->index(a:level)
endfun

fun! torustree#referen#coordinates ()
	" Torustree coordinates : names of current torus, circle and location
	let [torus, circle, location] = torustree#referen#location('all')
	let names = []
	if torus->has_key('name')
		eval names->add(torus.name)
		if circle->has_key('name')
			eval names->add(circle.name)
			if location->has_key('name')
				eval names->add(location.name)
			endif
		endif
	endif
	return names
endfun

" ---- hierarchy

fun! torustree#referen#upper (level)
	" Current upper element in hierarchy
	let index = s:levels->index(a:level)
	if index < 1 || index > 3
		echomsg 'torustree referen upper : level must be torus, circle or location'
		return
	endif
	let index -= 1
	return torustree#referen#{s:levels[index]} ()
endfun

fun! torustree#referen#lower (level)
	" Current lower element in hierarchy
	let index = s:levels->index(a:level)
	if index > 2 || index < 0
		echomsg 'torustree referen lower : level index must be torustree, torus or circle'
		return
	endif
	let index += 1
	return torustree#referen#{s:levels[index]} ()
endfun

fun! torustree#referen#upper_level_name (level)
	" Level name of upper element in hierarchy
	let index = s:levels->index(a:level)
	if index < 1 || index > 3
		echomsg 'torustree referen upper level name : level must be torus, circle or location'
		return
	endif
	let index -= 1
	return s:levels[index]
endfun

fun! torustree#referen#lower_level_name (level)
	" Level name of lower element in hierarchy
	let index = s:levels->index(a:level)
	if index > 2 || index < 0
		echomsg 'torustree referen lower level name : level index must be torustree, torus or circle'
		return
	endif
	let index += 1
	return s:levels[index]
endfun

" ---- emptiness

fun! torustree#referen#is_empty (level)
	" Whether current level element is empty
	" Level can be torustree, torus, circle or location
	let level = a:level
	let elem = torustree#referen#current (level)
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

fun! torustree#referen#is_upper_empty (level)
	" Whether upper level element is empty
	" Level can be torus, circle or location
	let level = a:level
	let elem = torustree#referen#upper (level)
	if empty(elem) || empty(elem.glossary)
		return v:true
	else
		return v:false
	endif
endfun

" ---- current file in torustree ?

fun! torustree#referen#is_in_torustree (...)
	" Whether filename argument is in torustree
	" Default optional argument : current filename
	if a:0 > 0
		let filename = a:1
	else
		let filename = expand('%:p')
	endif
	let torustree_files = torustree#helix#files ()
	let is_in_torustree = torustree#chain#is_inside(filename, torustree_files)
	return is_in_torustree
endfun

" ---- element lists

fun! torustree#referen#list_key (level)
	" Name of key containing list of elements
	return s:list_keys[a:level]
endfun

fun! torustree#referen#elements (dict)
	" Elements list of dict :
	" - toruses if dict is the torustree
	" - circles if dict is a torus
	" - locations if dict is a circle
	let dict = a:dict
	if dict->has_key('toruses')
		return dict.toruses
	elseif dict->has_key('circles')
		return dict.circles
	elseif dict->has_key('locations')
		return dict.stones
	else
		echomsg 'torustree referen elements : arg should be the torustree, a torus or a circle'
		return []
	endif
endfun

" ---- match current buffer

fun! torustree#referen#location_matches_file ()
	" Whether current location matches current file
	let cur_file = expand('%:p')
	let cur_location = torustree#referen#location()
	if empty(cur_location)
		return v:false
	endif
	return cur_file ==# cur_location.file
endfun

fun! torustree#referen#location_matches_file_line_col ()
	" Whether current location matches current file & cursor  position
	let cur_location = torustree#referen#location()
	let match = torustree#referen#location_matches_file ()
	let match = match && line('.') ==# cur_location.line
	let match = match && col('.') ==# cur_location.col
	return match
endfun
