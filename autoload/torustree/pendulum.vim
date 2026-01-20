" vim: set ft=vim fdm=indent iskeyword&:

" Pendulum
"
" History

" g:wheeltree_history keys :
"
" - line : naturally sorted list of timestamps & torustree coordinates
"		   each coordinate appear at most once
"		   used :
"				- in history dedicated buffer
"				- to build & update g:wheeltree_history.alternate
"
" - circuit : unsorted list of timestamps & travelled torustree coordinates
"			  used in newer & older functions
"			  rotated by newer & older
"
" - alternate : coordinates of alternates locations
"
" - frecency : coordinates & scores of locations

" other names ideas for this file :
"   - longcase clock
"   - chime

" ---- timestamps

fun! torustree#pendulum#timestamp ()
	" Timestamp in seconds since epoch
	 return str2nr(strftime('%s'))
endfun

fun! torustree#pendulum#date_hour (timestamp)
	" Timestamp in date & hour format
	return strftime('%Y %B %d %A %H:%M', a:timestamp)
endfun

fun! torustree#pendulum#compare (one, two)
	" Comparison of history entries : used to sort index
	return a:two.timestamp - a:one.timestamp
endfun

" ---- filters

fun! torustree#pendulum#distinct_coordin (index, one, unused, two)
	" Return true if coordin[0:index] of one & two are distinct
	" unused argument is for compatibility with filter()
	let one = a:one
	let two = a:two
	let index = a:index
	let type_one = type(one)
	let type_two = type(two)
	if type_one == v:t_list && type_two == v:t_list
		return one[:index] != two[:index]
	elseif type_one == v:t_dict && type_two == v:t_dict
		return one.coordin[:index] != two.coordin[:index]
	elseif type_one == v:t_list && type_two == v:t_dict
		return one[:index] != two.coordin[:index]
	elseif type_one == v:t_dict && type_two == v:t_list
		return one.coordin[:index] != two[:index]
	endif
endfun

fun! torustree#pendulum#coordin_inside_wheel (unused, entry)
	" Return true if coordin of entry belongs to the torustree
	" unused argument is for compatibility with filter()
	let entry = a:entry
	let coordin = entry.coordin
	let helix = torustree#helix#helix()
	return coordin->torustree#chain#is_inside(helix)
endfun

" ---- helpers

fun! torustree#pendulum#remove_if_present (entry)
	" Remove entry from history if coordinates are already there
	let entry = a:entry
	let Filter = function('torustree#pendulum#distinct_coordin', [2, entry])
	" history line
	let timeline = g:wheeltree_history.line
	eval timeline->filter(Filter)
	" history circuit
	let timeloop = g:wheeltree_history.circuit
	eval timeloop->filter(Filter)
endfun

" ---- operations

fun! torustree#pendulum#record ()
	" Add current torus, circle, location to history
	" Add new entry at the beginning of the list
	" Move existing entry at the beginning of the list
	" Update alternate & frecency coordinates
	" -- new entry
	let coordin = torustree#referen#coordinates()
	let maxim = g:wheeltree_config.maxim.history
	let entry = {}
	let entry.coordin = coordin
	let entry.timestamp = torustree#pendulum#timestamp ()
	call torustree#pendulum#remove_if_present (entry)
	" -- new entry in history line
	let timeline = g:wheeltree_history.line
	eval timeline->torustree#chain#push_max(entry, maxim)
	" -- new entry in history circuit
	let timeloop = g:wheeltree_history.circuit
	eval timeloop->torustree#chain#push_max(entry, maxim)
	" -- alternate history
	call torustree#caduceus#update ()
	" -- frecency
	call torustree#cuckoo#record ()
endfun

fun! torustree#pendulum#rename (level, old, new)
	" Rename all occurences old -> new in history
	" level = 0 or torus    : rename torus
	" level = 1 or circle   : rename circle
	" level = 2 or location : rename location
	let level = a:level
	let old = a:old
	let new = a:new
	let level_index = torustree#referen#level_index_in_coordin (level)
	let new_names = torustree#referen#coordinates ()
	let old_names = copy(new_names)
	let old_names[level_index] = old
	" -- history line
	for elem in g:wheeltree_history.line
		let coordin = elem.coordin
		if coordin[:level_index] == old_names[:level_index]
			let elem.coordin[level_index] = new
		endif
	endfor
	" -- history circuit
	for elem in g:wheeltree_history.circuit
		let coordin = elem.coordin
		if coordin[:level_index] == old_names[:level_index]
			let elem.coordin[level_index] = new
		endif
	endfor
	" -- frecency
	for elem in g:wheeltree_history.frecency
		let coordin = elem.coordin
		if coordin[:level_index] == old_names[:level_index]
			let elem.coordin[level_index] = new
		endif
	endfor
	" -- alternate
	call torustree#caduceus#update ()
endfun

fun! torustree#pendulum#delete (level, coordin)
	" Delete all occurences of coordin coordin in history
	" level = 0 or torus    : delete torus
	" level = 1 or circle   : delete circle
	" level = 2 or location : delete location
	let level = a:level
	let coordin = a:coordin
	let level_index = torustree#referen#level_index_in_coordin (level)
	let coordin = coordin
	let Filter = function('torustree#pendulum#distinct_coordin', [level_index, coordin])
	" -- history line
	let timeline = g:wheeltree_history.line
	eval timeline->filter(Filter)
	" -- history circuit
	let timeloop = g:wheeltree_history.circuit
	eval timeloop->filter(Filter)
	" -- frecency
	let frecency = g:wheeltree_history.frecency
	eval frecency->filter(Filter)
	" -- alternate
	call torustree#caduceus#update ()
endfun

fun! torustree#pendulum#broom ()
	" Remove history entries that do not belong to the torustree anymore
	let Filter = function('torustree#pendulum#coordin_inside_wheel')
	" -- history line
	let timeline = g:wheeltree_history.line
	eval timeline->filter(Filter)
	" -- history circuit
	let timeloop = g:wheeltree_history.circuit
	eval timeloop->filter(Filter)
	" -- frecency
	let frecency = g:wheeltree_history.frecency
	eval frecency->filter(Filter)
	" -- alternate
	call torustree#caduceus#update ()
endfun
