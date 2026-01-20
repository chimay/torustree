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
let s:level_separ = wheeltree#crystal#fetch('separator/level')
lockvar s:level_separ

if exists('s:field_separ')
	unlockvar s:field_separ
endif
let s:field_separ = wheeltree#crystal#fetch('separator/field')
lockvar s:field_separ

" ---- newer & older

fun! wheeltree#waterclock#newer_anywhere ()
	" Go to newer entry in g:wheeltree_history.circuit
	let timeloop = g:wheeltree_history.circuit
	let timeloop = wheeltree#taijitu#rotate_right (timeloop)
	let coordin = timeloop[0].coordin
	" rotate makes deepcopy
	let g:wheeltree_history.circuit = timeloop
	call wheeltree#vortex#chord(coordin)
	return wheeltree#vortex#jump ()
endfun

fun! wheeltree#waterclock#older_anywhere ()
	" Go to older entry in g:wheeltree_history.circuit
	let timeloop = g:wheeltree_history.circuit
	let timeloop = wheeltree#taijitu#rotate_left (timeloop)
	let coordin = timeloop[0].coordin
	" rotate makes deepcopy
	let g:wheeltree_history.circuit = timeloop
	call wheeltree#vortex#chord(coordin)
	return wheeltree#vortex#jump ()
endfun

fun! wheeltree#waterclock#newer (level = 'wheeltree')
	" Go to newer entry in g:wheeltree_history.circuit, same level
	let level = a:level
	if wheeltree#referen#is_empty(level)
		echomsg 'wheeltree newer :' level 'is empty'
		return v:false
	endif
	if level ==# 'wheeltree'
		return wheeltree#waterclock#newer_anywhere ()
	endif
	" ---- current coordin
	let present_coordin = wheeltree#referen#coordinates ()
	" ---- index for range in coordin
	let level_index = wheeltree#referen#level_index_in_coordin (level)
	" ---- back to the future
	let timeloop = g:wheeltree_history.circuit
	let range = wheeltree#chain#rangelen(timeloop)
	let range = reverse(range)
	for index in range[:-2]
		let coordin = timeloop[index].coordin
		if present_coordin[:level_index] == coordin[:level_index]
			let timeloop = timeloop->wheeltree#taijitu#roll_right(index)
			break
		endif
	endfor
	" ---- newer found in same torus or circle ?
	if present_coordin[:level_index] != coordin[:level_index]
		echomsg 'wheeltree newer : no location found in same' level
		return v:false
	endif
	" ---- update timeloop : rotate return a deepcopy
	let g:wheeltree_history.circuit = timeloop
	" ---- jump
	call wheeltree#vortex#chord(coordin)
	return wheeltree#vortex#jump ()
endfun

fun! wheeltree#waterclock#older (level = 'wheeltree')
	" Go to older entry in g:wheeltree_history.circuit, same level
	let level = a:level
	if wheeltree#referen#is_empty(level)
		echomsg 'wheeltree older :' level 'is empty'
		return v:false
	endif
	if level ==# 'wheeltree'
		return wheeltree#waterclock#older_anywhere ()
	endif
	" ---- current coordin
	let present_coordin = wheeltree#referen#coordinates ()
	" ---- index for range in coordin
	let level_index = wheeltree#referen#level_index_in_coordin (level)
	" ---- back in history
	let timeloop = g:wheeltree_history.circuit
	let range = wheeltree#chain#rangelen(timeloop)
	for index in range[1:]
		let coordin = timeloop[index].coordin
		if present_coordin[:level_index] == coordin[:level_index]
			let timeloop = timeloop->wheeltree#taijitu#roll_left(index)
			break
		endif
	endfor
	" ---- older found in same torus or circle ?
	if present_coordin[:level_index] != coordin[:level_index]
		echomsg 'wheeltree older : no location found in same' level
		return v:false
	endif
	" ---- update timeloop : rotate return a deepcopy
	let g:wheeltree_history.circuit = timeloop
	" ---- jump
	call wheeltree#vortex#chord(coordin)
	return wheeltree#vortex#jump ()
endfun

" ---- prompt

fun! wheeltree#waterclock#history (where = 'search-window')
	" Switch to coordinates in history
	" Optional argument : see vortex#jump optional argument
	let where = a:where
	let prompt = 'Switch to history element : '
	let complete = 'customlist,wheeltree#complete#history'
	let record = input(prompt, '', complete)
	if empty(record)
		return v:false
	endif
	let fields = split(record, s:field_separ)
	let entry = fields[1]
	let coordin = split(entry, s:level_separ)
	call wheeltree#vortex#chord(coordin)
	call wheeltree#vortex#jump (where)
	return v:true
endfun

fun! wheeltree#waterclock#history_circuit (where = 'search-window')
	" Switch to coordinates in history
	" Optional argument : see vortex#jump optional argument
	let where = a:where
	let prompt = 'Switch to history circuit element : '
	let complete = 'customlist,wheeltree#complete#history_circuit'
	let record = input(prompt, '', complete)
	if empty(record)
		return v:false
	endif
	let fields = split(record, s:field_separ)
	let entry = fields[1]
	let coordin = split(entry, s:level_separ)
	call wheeltree#vortex#chord(coordin)
	call wheeltree#vortex#jump (where)
	return v:true
endfun

fun! wheeltree#waterclock#frecency (where = 'search-window')
	" Switch to coordinates in frecency
	" Optional argument : see vortex#jump optional argument
	let where = a:where
	let prompt = 'Switch to frecency element : '
	let complete = 'customlist,wheeltree#complete#frecency'
	let record = input(prompt, '', complete)
	if empty(record)
		return v:false
	endif
	let fields = split(record, s:field_separ)
	let entry = fields[1]
	let coordin = split(entry, s:level_separ)
	call wheeltree#vortex#chord(coordin)
	call wheeltree#vortex#jump (where)
	return v:true
endfun
