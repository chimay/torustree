" vim: set ft=vim fdm=indent iskeyword&:

" Whirl
"
" Wheeltree navigation, dedicated buffers

fun! wheeltree#whirl#switch (level)
	" Choose an element of level to switch to
	let level = a:level
	if wheeltree#referen#is_upper_empty (level)
		let upper_name = wheeltree#referen#upper_level_name (level)
		echomsg 'wheeltree whirl switch : empty' upper_name
		return v:false
	endif
	let lines = wheeltree#flower#element (level)
	call wheeltree#mandala#blank ('switch/' .. level)
	let settings = { 'level' : level }
	call wheeltree#river#template (settings)
	if ! empty(lines)
		call wheeltree#mandala#fill(lines)
	else
		echomsg 'wheeltree whirl switch : empty or incomplete' level
	endif
	" reload
	call wheeltree#mandala#set_reload('wheeltree#whirl#switch', level)
endfun

fun! wheeltree#whirl#helix ()
	" Choose a location coordinate
	" Each coordinate = [torus, circle, location]
	let lines = wheeltree#flower#helix ()
	if empty(lines)
		echomsg 'wheeltree whirl helix : empty wheeltree'
		return v:false
	endif
	call wheeltree#mandala#blank ('index/location')
	let settings = #{ function : 'wheeltree#curve#helix' }
	call wheeltree#river#template (settings)
	call wheeltree#mandala#fill(lines)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#whirl#helix')
endfun

fun! wheeltree#whirl#grid ()
	" Choose a circle coordinate
	" Each coordinate = [torus, circle]
	let lines = wheeltree#flower#grid ()
	if empty(lines)
		echomsg 'wheeltree whirl grid : empty wheeltree'
		return v:false
	endif
	call wheeltree#mandala#blank ('index/circle')
	let settings = #{ function : 'wheeltree#curve#grid' }
	call wheeltree#river#template (settings)
	call wheeltree#mandala#fill (lines)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#whirl#grid')
endfun

fun! wheeltree#whirl#tree ()
	" Choose an element in the wheeltree index tree
	let lines = wheeltree#flower#tree ()
	if empty(lines)
		echomsg 'wheeltree whirl tree : empty wheeltree'
		return v:false
	endif
	call wheeltree#mandala#blank ('index/tree')
	let settings = #{ function : 'wheeltree#curve#tree' }
	call wheeltree#river#template (settings)
	call wheeltree#origami#folding_options ()
	call wheeltree#mandala#fill(lines)
	" properties
	let b:wheel_nature.is_treeish = v:true
	" full information
	let b:wheel_full = wheeltree#cuboctahedron#tree ()
	" reload
	call wheeltree#mandala#set_reload('wheeltree#whirl#tree')
endfun

fun! wheeltree#whirl#history ()
	" Choose a location coordinate in history
	" Each coordinate = [torus, circle, location]
	call wheeltree#river#generic('history')
endfun

fun! wheeltree#whirl#history_circuit ()
	" Choose a location coordinate in history
	" Each coordinate = [torus, circle, location]
	call wheeltree#river#generic('history_circuit')
endfun

fun! wheeltree#whirl#frecency ()
	" Choose a location coordinate in frecency
	" Each coordinate = [torus, circle, location]
	call wheeltree#river#generic('frecency')
endfun
