" vim: set ft=vim fdm=indent iskeyword&:

" Group
"
" Auto grouping

fun! torustree#group#extension(location)
	" Filename extension
	return fnamemodify(a:location.file, ':e')
endfun

fun! torustree#group#directory(location)
	" Depth levels of directory
	let dir = fnamemodify(a:location.file, ':p:h')
	let dir = dir[1:]
	let dirname = substitute(dir, '/', '-', 'g')
	return dirname
endfun

fun! torustree#group#dispatch(dispatcher)
	" Auto grouping
	let Dispatcher = a:dispatcher
	if type(Dispatcher) == v:t_func
		let Fun = Dispatcher
	elseif type(Dispatcher) == v:t_string
		let Fun = function(Dispatcher)
	else
		echoerr 'torustree#group#auto : bad argument format'
	endif
	let groups = {}
	let torus = torustree#referen#current('torus')
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

fun! torustree#group#torus(method)
	" New torus with autogrouped locations
	let prompt = 'Write old torustree to file before autogrouping ?'
	let confirm = confirm(prompt, "&Yes\n&No", 1)
	if confirm == 1
		call torustree#disc#write_wheel ()
	endif
	let method = a:method
	let name = torustree#referen#current('torus').name
	let name ..= '-by-' .. method
	let fun = 'torustree#group#' .. method
	let groups = torustree#group#dispatch(fun)
	if torustree#tree#add_torus (name)
		for [key, localist] in items(groups)
			call torustree#tree#add_circle (key)
			for location in localist
				call torustree#tree#add_location (location, 'dont-record')
			endfor
		endfor
	endif
endfun

fun! torustree#group#menu()
	" Autogroup menu
	let prompt = 'Autogroup method ?'
	let method = confirm(prompt, "&Extension\n&Directory", 1)
	if method == 1
		call torustree#group#torus('extension')
	elseif method == 2
		call torustree#group#torus('directory')
	endif
endfun
