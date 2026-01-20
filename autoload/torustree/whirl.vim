" vim: set ft=vim fdm=indent iskeyword&:

" Whirl
"
" Torustree navigation, dedicated buffers

fun! torustree#whirl#switch (level)
	" Choose an element of level to switch to
	let level = a:level
	if torustree#referen#is_upper_empty (level)
		let upper_name = torustree#referen#upper_level_name (level)
		echomsg 'torustree whirl switch : empty' upper_name
		return v:false
	endif
	let lines = torustree#flower#element (level)
	call torustree#mandala#blank ('switch/' .. level)
	let settings = { 'level' : level }
	call torustree#river#template (settings)
	if ! empty(lines)
		call torustree#mandala#fill(lines)
	else
		echomsg 'torustree whirl switch : empty or incomplete' level
	endif
	" reload
	call torustree#mandala#set_reload('torustree#whirl#switch', level)
endfun

fun! torustree#whirl#helix ()
	" Choose a location coordinate
	" Each coordinate = [torus, circle, location]
	let lines = torustree#flower#helix ()
	if empty(lines)
		echomsg 'torustree whirl helix : empty torustree'
		return v:false
	endif
	call torustree#mandala#blank ('index/location')
	let settings = #{ function : 'torustree#curve#helix' }
	call torustree#river#template (settings)
	call torustree#mandala#fill(lines)
	" reload
	call torustree#mandala#set_reload('torustree#whirl#helix')
endfun

fun! torustree#whirl#grid ()
	" Choose a circle coordinate
	" Each coordinate = [torus, circle]
	let lines = torustree#flower#grid ()
	if empty(lines)
		echomsg 'torustree whirl grid : empty torustree'
		return v:false
	endif
	call torustree#mandala#blank ('index/circle')
	let settings = #{ function : 'torustree#curve#grid' }
	call torustree#river#template (settings)
	call torustree#mandala#fill (lines)
	" reload
	call torustree#mandala#set_reload('torustree#whirl#grid')
endfun

fun! torustree#whirl#tree ()
	" Choose an element in the torustree index tree
	let lines = torustree#flower#tree ()
	if empty(lines)
		echomsg 'torustree whirl tree : empty torustree'
		return v:false
	endif
	call torustree#mandala#blank ('index/tree')
	let settings = #{ function : 'torustree#curve#tree' }
	call torustree#river#template (settings)
	call torustree#origami#folding_options ()
	call torustree#mandala#fill(lines)
	" properties
	let b:wheel_nature.is_treeish = v:true
	" full information
	let b:wheel_full = torustree#cuboctahedron#tree ()
	" reload
	call torustree#mandala#set_reload('torustree#whirl#tree')
endfun

fun! torustree#whirl#history ()
	" Choose a location coordinate in history
	" Each coordinate = [torus, circle, location]
	call torustree#river#generic('history')
endfun

fun! torustree#whirl#history_circuit ()
	" Choose a location coordinate in history
	" Each coordinate = [torus, circle, location]
	call torustree#river#generic('history_circuit')
endfun

fun! torustree#whirl#frecency ()
	" Choose a location coordinate in frecency
	" Each coordinate = [torus, circle, location]
	call torustree#river#generic('frecency')
endfun
