" vim: set ft=vim fdm=indent iskeyword&:

" Curve
"
" Wheeltree action on the cursor line :
"
" - switching element
" - element in index
" - element in history
"
" called by loop#navigation

" ---- script constants

if exists('s:field_separ')
	unlockvar s:field_separ
endif
let s:field_separ = wheeltree#crystal#fetch('separator/field')
lockvar s:field_separ

if exists('s:level_separ')
	unlockvar s:level_separ
endif
let s:level_separ = wheeltree#crystal#fetch('separator/level')
lockvar s:level_separ

" -- applications

fun! wheeltree#curve#switch (settings)
	" Switch to element in wheeltree
	" settings keys :
	" - target : current, tab, horizontal_split, vertical_split
	" - level : torus, circle or location
	" - selection : selection item
	" - selection.component : place to jump to
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let level = settings.level
	let component = settings.selection.component
	" ---- jump
	call wheeltree#vortex#voice(level, component)
	call wheeltree#vortex#jump(target)
	return win_getid ()
endfun

fun! wheeltree#curve#helix (settings)
	" Go to torus > circle > location
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let component = settings.selection.component
	let coordin = split(component, s:level_separ)
	" ---- jump
	call wheeltree#vortex#chord(coordin)
	call wheeltree#vortex#jump (target)
	return win_getid ()
endfun

fun! wheeltree#curve#grid (settings)
	" Go to torus > circle
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let component = settings.selection.component
	let coordin = split(component, s:level_separ)
	" ---- jump
	call wheeltree#vortex#interval (coordin)
	call wheeltree#vortex#jump (target)
	return win_getid ()
endfun

fun! wheeltree#curve#tree (settings)
	" Go to torus, circle or location in tree view
	" Possible vallues of selection component :
	" - [torus]
	" - [torus, circle]
	" - [torus, circle, location]
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let coordin = settings.selection.component
	let length = len(coordin)
	" ---- jump
	if length == 3
		call wheeltree#vortex#chord(coordin)
	elseif length == 2
		call wheeltree#vortex#interval (coordin)
	elseif length == 1
		call wheeltree#vortex#voice('torus', coordin[0])
	else
		return v:false
	endif
	call wheeltree#vortex#jump (target)
	return win_getid ()
endfun

fun! wheeltree#curve#history (settings)
	" Go to location in history
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let component = settings.selection.component
	let fields = split(component, s:field_separ)
	let coordin = split(fields[1], s:level_separ)
	" ---- jump
	call wheeltree#vortex#chord(coordin)
	call wheeltree#vortex#jump (target)
	return win_getid ()
endfun

fun! wheeltree#curve#history_circuit (settings)
	" Go to location in history circuit
	return wheeltree#curve#history (a:settings)
endfun

fun! wheeltree#curve#frecency (settings)
	" Go to location in history
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let component = settings.selection.component
	let fields = split(component, s:field_separ)
	let coordin = split(fields[1], s:level_separ)
	" ---- jump
	call wheeltree#vortex#chord(coordin)
	call wheeltree#vortex#jump (target)
	return win_getid ()
endfun
