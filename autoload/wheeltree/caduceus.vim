" vim: set ft=vim fdm=indent iskeyword&:

" Caduceus
"
" Alternate locations :
"
"   - anywhere
"   - in same circle
"   - in same torus
"   - in another circle
"   - in another torus
"   - in same torus but another circle
"
" Caduceus can be interpreted as a symbol of a polarized vortex

fun! wheeltree#caduceus#update ()
	" Update g:wheeltree_history.alternate
	let timeline = g:wheeltree_history.line
	let alternate = g:wheeltree_history.alternate
	let length = len(timeline)
	if length < 2
		return v:false
	endif
	" ---- anywhere
	let current = timeline[0].coordin
	for ind in range(1, length - 1)
		let coordin = timeline[ind].coordin
		if coordin != current
			let alternate.anywhere = coordin
			break
		endif
	endfor
	" ---- same torus
	for ind in range(1, length - 1)
		let coordin = timeline[ind].coordin
		if coordin[0] ==# current[0]
			let alternate.same_torus = coordin
			break
		endif
	endfor
	" ---- same circle
	for ind in range(1, length - 1)
		let coordin = timeline[ind].coordin
		if coordin[0] ==# current[0] && coordin[1] ==# current[1]
			let alternate.same_circle = coordin
			break
		endif
	endfor
	" ---- other torus
	for ind in range(1, length - 1)
		let coordin = timeline[ind].coordin
		if coordin[0] !=# current[0]
			let alternate.other_torus = coordin
			break
		endif
	endfor
	" ---- other circle
	for ind in range(1, length - 1)
		let coordin = timeline[ind].coordin
		if coordin[0] !=# current[0] || coordin[1] !=# current[1]
			let alternate.other_circle = coordin
			break
		endif
	endfor
	" ---- same torus, other circle
	for ind in range(1, length - 1)
		let coordin = timeline[ind].coordin
		if coordin[0] ==# current[0] && coordin[1] !=# current[1]
			let alternate.same_torus_other_circle = coordin
			break
		endif
	endfor
	" ---- coda
	return v:true
endfun

fun! wheeltree#caduceus#update_window ()
	" Update g:wheeltree_history.alternate.window
	" to be called by wheeltree#vortex#jump ()
	let g:wheeltree_history.alternate.window = win_getid ()
	return v:true
endfun

fun! wheeltree#caduceus#alternate (mode)
	" Alternate entries in history
	" mode argument can be :
	" - anywhere : alternate with previous entry anywhere in the wheeltree
	" - same_torus : previous entry in same torus
	" - other_torus : previous entry in another torus
	" - same_circle : previous entry in same circle
	" - other_circle : previous entry in another circle
	" - same_torus_other_circle : previous entry in same torus, but another circle
	" If not in current location file, just jump to it
	if wheeltree#referen#is_empty ('wheeltree')
		buffer #
		return 'wheeltree empty : just alternate buffer'
	endif
	if ! wheeltree#referen#location_matches_file ()
		return wheeltree#vortex#jump ()
	endif
	if has_key(g:wheeltree_history.alternate, a:mode)
		let coordin = g:wheeltree_history.alternate[a:mode]
		call wheeltree#vortex#chord(coordin)
	endif
	return wheeltree#vortex#jump ()
endfun

fun! wheeltree#caduceus#alternate_window ()
	" Alternate with previous window in any tab,
	" i.e. previous visible buffer
	" Generalization of native vim : C-w p
	if ! has_key(g:wheeltree_history.alternate, 'window')
		return v:false
	endif
	let window = g:wheeltree_history.alternate.window
	call win_gotoid(window)
	return v:true
endfun

fun! wheeltree#caduceus#alternate_menu ()
	" Alternate prompt menu
	let prompt = 'Alternate mode ? '
	let mode = confirm(prompt, "&1 Anywhere\n&2 Same torus\n&3 Same circle\n&4 Other torus\n&5 Other circle\n&6 Same torus, other circle\n&7 Window", 1)
	if mode == 1
		call wheeltree#caduceus#alternate ('anywhere')
	elseif mode == 2
		call wheeltree#caduceus#alternate ('same_torus')
	elseif mode == 3
		call wheeltree#caduceus#alternate ('same_circle')
	elseif mode == 4
		call wheeltree#caduceus#alternate ('other_torus')
	elseif mode == 5
		call wheeltree#caduceus#alternate ('other_circle')
	elseif mode == 6
		call wheeltree#caduceus#alternate ('same_torus_other_circle')
	elseif mode == 7
		call wheeltree#caduceus#alternate_window ()
	endif
endfun
