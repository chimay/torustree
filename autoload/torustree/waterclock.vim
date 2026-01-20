" vim: set ft=vim fdm=indent iskeyword&:

" Waterclock
"
" Travel in the stream of history
"
" Same as vortex, but for history & frecency

" other names ideas for this file :
"   - water glass, clepsydra
"   - sundial
"   - hourglass, sandglass

" ---- script constants

if exists('s:level_separ')
	unlockvar s:level_separ
endif
let s:level_separ = torustree#crystal#fetch('separator/level')
lockvar s:level_separ

if exists('s:field_separ')
	unlockvar s:field_separ
endif
let s:field_separ = torustree#crystal#fetch('separator/field')
lockvar s:field_separ

" ---- newer & older

fun! torustree#waterclock#newer_anywhere ()
	" Go to newer entry in g:wheeltree_history.circuit
	let timeloop = g:wheeltree_history.circuit
	let timeloop = torustree#taijitu#rotate_right (timeloop)
	let coordin = timeloop[0].coordin
	" rotate makes deepcopy
	let g:wheeltree_history.circuit = timeloop
	call torustree#vortex#chord(coordin)
	return torustree#vortex#jump ()
endfun

fun! torustree#waterclock#older_anywhere ()
	" Go to older entry in g:wheeltree_history.circuit
	let timeloop = g:wheeltree_history.circuit
	let timeloop = torustree#taijitu#rotate_left (timeloop)
	let coordin = timeloop[0].coordin
	" rotate makes deepcopy
	let g:wheeltree_history.circuit = timeloop
	call torustree#vortex#chord(coordin)
	return torustree#vortex#jump ()
endfun

fun! torustree#waterclock#newer (level = 'torustree')
	" Go to newer entry in g:wheeltree_history.circuit, same level
	let level = a:level
	if torustree#referen#is_empty(level)
		echomsg 'torustree newer :' level 'is empty'
		return v:false
	endif
	if level ==# 'torustree'
		return torustree#waterclock#newer_anywhere ()
	endif
	" ---- current coordin
	let present_coordin = torustree#referen#coordinates ()
	" ---- index for range in coordin
	let level_index = torustree#referen#level_index_in_coordin (level)
	" ---- back to the future
	let timeloop = g:wheeltree_history.circuit
	let range = torustree#chain#rangelen(timeloop)
	let range = reverse(range)
	for index in range[:-2]
		let coordin = timeloop[index].coordin
		if present_coordin[:level_index] == coordin[:level_index]
			let timeloop = timeloop->torustree#taijitu#roll_right(index)
			break
		endif
	endfor
	" ---- newer found in same torus or circle ?
	if present_coordin[:level_index] != coordin[:level_index]
		echomsg 'torustree newer : no location found in same' level
		return v:false
	endif
	" ---- update timeloop : rotate return a deepcopy
	let g:wheeltree_history.circuit = timeloop
	" ---- jump
	call torustree#vortex#chord(coordin)
	return torustree#vortex#jump ()
endfun

fun! torustree#waterclock#older (level = 'torustree')
	" Go to older entry in g:wheeltree_history.circuit, same level
	let level = a:level
	if torustree#referen#is_empty(level)
		echomsg 'torustree older :' level 'is empty'
		return v:false
	endif
	if level ==# 'torustree'
		return torustree#waterclock#older_anywhere ()
	endif
	" ---- current coordin
	let present_coordin = torustree#referen#coordinates ()
	" ---- index for range in coordin
	let level_index = torustree#referen#level_index_in_coordin (level)
	" ---- back in history
	let timeloop = g:wheeltree_history.circuit
	let range = torustree#chain#rangelen(timeloop)
	for index in range[1:]
		let coordin = timeloop[index].coordin
		if present_coordin[:level_index] == coordin[:level_index]
			let timeloop = timeloop->torustree#taijitu#roll_left(index)
			break
		endif
	endfor
	" ---- older found in same torus or circle ?
	if present_coordin[:level_index] != coordin[:level_index]
		echomsg 'torustree older : no location found in same' level
		return v:false
	endif
	" ---- update timeloop : rotate return a deepcopy
	let g:wheeltree_history.circuit = timeloop
	" ---- jump
	call torustree#vortex#chord(coordin)
	return torustree#vortex#jump ()
endfun

" ---- prompt

fun! torustree#waterclock#history (where = 'search-window')
	" Switch to coordinates in history
	" Optional argument : see vortex#jump optional argument
	let where = a:where
	let prompt = 'Switch to history element : '
	let complete = 'customlist,torustree#complete#history'
	let record = input(prompt, '', complete)
	if empty(record)
		return v:false
	endif
	let fields = split(record, s:field_separ)
	let entry = fields[1]
	let coordin = split(entry, s:level_separ)
	call torustree#vortex#chord(coordin)
	call torustree#vortex#jump (where)
	return v:true
endfun

fun! torustree#waterclock#history_circuit (where = 'search-window')
	" Switch to coordinates in history
	" Optional argument : see vortex#jump optional argument
	let where = a:where
	let prompt = 'Switch to history circuit element : '
	let complete = 'customlist,torustree#complete#history_circuit'
	let record = input(prompt, '', complete)
	if empty(record)
		return v:false
	endif
	let fields = split(record, s:field_separ)
	let entry = fields[1]
	let coordin = split(entry, s:level_separ)
	call torustree#vortex#chord(coordin)
	call torustree#vortex#jump (where)
	return v:true
endfun

fun! torustree#waterclock#frecency (where = 'search-window')
	" Switch to coordinates in frecency
	" Optional argument : see vortex#jump optional argument
	let where = a:where
	let prompt = 'Switch to frecency element : '
	let complete = 'customlist,torustree#complete#frecency'
	let record = input(prompt, '', complete)
	if empty(record)
		return v:false
	endif
	let fields = split(record, s:field_separ)
	let entry = fields[1]
	let coordin = split(entry, s:level_separ)
	call torustree#vortex#chord(coordin)
	call torustree#vortex#jump (where)
	return v:true
endfun
