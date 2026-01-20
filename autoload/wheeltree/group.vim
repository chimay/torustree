" vim: set ft=vim fdm=indent iskeyword&:

" Group
"
" Auto grouping

fun! wheeltree#group#extension(location)
	" Filename extension
	return fnamemodify(a:location.file, ':e')
endfun

fun! wheeltree#group#directory(location)
	" Depth levels of directory
	let dir = fnamemodify(a:location.file, ':p:h')
	let dir = dir[1:]
	let dirname = substitute(dir, '/', '-', 'g')
	return dirname
endfun

fun! wheeltree#group#dispatch(dispatcher)
	" Auto grouping
	let Dispatcher = a:dispatcher
	if type(Dispatcher) == v:t_func
		let Fun = Dispatcher
	elseif type(Dispatcher) == v:t_string
		let Fun = function(Dispatcher)
	else
		echoerr 'wheeltree#group#auto : bad argument format'
	endif
	let groups = {}
	let torus = wheeltree#referen#current('torus')
	for circle in torus.circles
		for location in deepcopy(circle.locations)
			let extension = Fun(location)
			if ! has_key(groups, extension)
				let groups[extension] = [location]
			else
				eval groups[extension]->add(location)
			endif
		endfor
	endfor
	return groups
endfun

fun! wheeltree#group#torus(method)
	" New torus with autogrouped locations
	let prompt = 'Write old wheeltree to file before autogrouping ?'
	let confirm = confirm(prompt, "&Yes\n&No", 1)
	if confirm == 1
		call wheeltree#disc#write_wheel ()
	endif
	let method = a:method
	let name = wheeltree#referen#current('torus').name
	let name ..= '-by-' .. method
	let fun = 'wheeltree#group#' .. method
	let groups = wheeltree#group#dispatch(fun)
	if wheeltree#tree#add_torus (name)
		for [key, localist] in items(groups)
			call wheeltree#tree#add_circle (key)
			for location in localist
				call wheeltree#tree#add_location (location, 'dont-record')
			endfor
		endfor
	endif
endfun

fun! wheeltree#group#menu()
	" Autogroup menu
	let prompt = 'Autogroup method ?'
	let method = confirm(prompt, "&Extension\n&Directory", 1)
	if method == 1
		call wheeltree#group#torus('extension')
	elseif method == 2
		call wheeltree#group#torus('directory')
	endif
endfun
