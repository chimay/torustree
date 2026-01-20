" vim: set ft=vim fdm=indent iskeyword&:

" Tree
"
" Organize wheeltree elements, prompt functions
"
" Tree = toruses / circles / locations
"
" Adding
" Renaming
" Removing

" Notes
"
" To insert a non-breaking space : C-v x a 0

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

" ---- helpers

fun! wheeltree#tree#is_in_circle (location, circle)
	" Whether file & cursor position is in circle
	let local = a:location
	let present = 0
	for elem in a:circle.locations
		if elem.file ==# local.file && elem.line == local.line
			let present = 1
		endif
	endfor
	return present
endfun

fun! wheeltree#tree#format_name (name)
	" Format element name to avoid annoying characters
	let name = a:name
	if name ==# '%'
		let name = getreg('%')
	endif
	if name ==# '#'
		let name = getreg('#')
	endif
	let name = trim(name, ' ')
	let name = substitute(name, ' ', '_', 'g')
	return name
endfun

fun! wheeltree#tree#name ()
	" Prompt for a location name and return it
	let prompt = 'Location name ? '
	let complete = 'customlist,wheeltree#complete#current_file'
	let name = input(prompt, '', complete)
	let name = wheeltree#tree#format_name (name)
	return name
endfun

fun! wheeltree#tree#add_name (location)
	" Fill the name key of location and return it
	let location = a:location
	if ! has_key(location, 'name') || empty(location.name)
		let location.name = wheeltree#tree#name ()
	endif
	return location.name
endfun

" ---- insert existent element

fun! wheeltree#tree#insert_torus (torus)
	" Insert torus into wheeltree
	" No confirm prompt, no jump : internal use only
	let torus = a:torus
	let wheeltree = g:wheeltree
	let index = wheeltree.current
	let glossary = wheeltree.glossary
	let name = torus.name
	if wheeltree#chain#is_inside(name, glossary)
		let complete = 'customlist,wheeltree#complete#torus'
		let name = input('Clone torus with name ? ', '', complete)
		let name = wheeltree#tree#format_name (name)
	endif
	if empty(name)
		call wheeltree#status#message('Torus name cannot be empty')
		return v:false
	endif
	if wheeltree#chain#is_inside(name, glossary)
		echomsg 'Torus named' name 'already exists in wheeltree'
		return v:false
	endif
	let torus.name = name
	eval wheeltree.toruses->wheeltree#chain#insert_next(index, torus)
	let wheeltree.current += 1
	eval glossary->wheeltree#chain#insert_next(index, name)
	let wheeltree.timestamp = wheeltree#pendulum#timestamp ()
	return v:true
endfun

fun! wheeltree#tree#insert_circle (circle)
	" Insert circle into current torus
	" No confirm prompt, no jump : internal use only
	let circle = a:circle
	let torus = g:wheeltree.toruses[g:wheeltree.current]
	let index = torus.current
	let glossary = torus.glossary
	let name = circle.name
	if wheeltree#chain#is_inside(name, glossary)
		let complete = 'customlist,wheeltree#complete#circle'
		let name = input('Insert circle with name ? ', '', complete)
		let name = wheeltree#tree#format_name (name)
	endif
	if empty(name)
		call wheeltree#status#message('Circle name cannot be empty')
		return v:false
	endif
	if wheeltree#chain#is_inside(name, glossary)
		echomsg 'Circle named' name 'already exists in torus' torus.name
		return v:false
	endif
	let circle.name = name
	eval torus.circles->wheeltree#chain#insert_next(index, circle)
	let torus.current += 1
	eval glossary->wheeltree#chain#insert_next(index, name)
	let g:wheeltree.timestamp = wheeltree#pendulum#timestamp ()
	return v:true
endfun

fun! wheeltree#tree#insert_location (location)
	" Insert location into current circle
	" No confirm prompt, no jump : internal use only
	let location = a:location
	let torus = g:wheeltree.toruses[g:wheeltree.current]
	let circle = torus.circles[torus.current]
	let index = circle.current
	let glossary = circle.glossary
	let name = location.name
	if wheeltree#chain#is_inside(name, glossary)
		let complete = 'customlist,wheeltree#complete#location'
		let name = input('Insert location with name ? ', '', complete)
		let name = wheeltree#tree#format_name (name)
	endif
	if empty(name)
		call wheeltree#status#message('Location name cannot be empty')
		return v:false
	endif
	if wheeltree#chain#is_inside(name, glossary)
		echomsg 'Location named' name 'already exists in circle' circle.name
		return v:false
	endif
	let location.name = name
	eval circle.locations->wheeltree#chain#insert_next(index, location)
	let circle.current += 1
	eval glossary->wheeltree#chain#insert_next(index, name)
	let g:wheeltree.timestamp = wheeltree#pendulum#timestamp ()
	return v:true
endfun

" ---- add new element

fun! wheeltree#tree#add_tree (...)
	" Add folder tree
	if a:0 > 0
		let tree_name = a:1
	else
		let tree_name = input('New tree name ? ')
	endif
	" ---- tree name
	let tree_name = wheeltree#tree#format_name (tree_name)
	if empty(tree_name)
		call wheeltree#status#message('Tree name cannot be empty')
		return v:false
	endif
	" ---- check name is not already present
	if wheeltree#chain#is_inside(tree_name, g:wheeltree.glossary)
		call wheeltree#status#message('Tree', tree_name, 'already exists in wheeltree')
		return v:false
	endif
	" ---- add tree
	call wheeltree#status#message('Adding tree', tree_name)
	let index = g:wheeltree.current
	let trees = g:wheeltree.trees
	let glossary = g:wheeltree.glossary
	let template = wheeltree#void#template ({'name': tree_name, 'circles': []})
	eval trees->wheeltree#chain#insert_next(index, template)
	eval glossary->wheeltree#chain#insert_next(index, tree_name)
	let g:wheeltree.current += 1
	let g:wheeltree.timestamp = wheeltree#pendulum#timestamp ()
	return v:true
endfun

fun! wheeltree#tree#add_location (location, optional = 'default')
	" Add location
	let location = a:location
	let optional = a:optional
	" ---- location name
	let name = wheeltree#tree#add_name (location)
	if empty(name)
		call wheeltree#status#message('Location name cannot be empty')
		return v:false
	endif
	" ---- check name is not already present
	if wheeltree#chain#is_inside(name, circle.glossary)
		let infolist = ['Location named', name, 'already exists in circle']
		call wheeltree#status#message(infolist)
		return v:false
	endif
	" ---- add the location to the circle
	let infolist = [ 'Adding location', location.name, ':', location.file ]
	let infolist += [ ':', location.line, ':', location.col ]
	let infolist += [ 'in torus', torus.name, 'circle', circle.name ]
	call wheeltree#status#message(infolist)
	let index = circle.current
	let locationlist = circle.locations
	let glossary = circle.glossary
	eval locationlist->wheeltree#chain#insert_next(index, location)
	eval glossary->wheeltree#chain#insert_next(index, name)
	let circle.current += 1
	let g:wheeltree.timestamp = wheeltree#pendulum#timestamp ()
	if optional !=# 'dont-record'
		call wheeltree#pendulum#record ()
	endif
	return v:true
endfun

fun! wheeltree#tree#add_here ()
	" Add here to circle
	silent doautocmd User WheelBeforeOrganize
	let here = wheeltree#vortex#here()
	call wheeltree#tree#add_location(here)
endfun

fun! wheeltree#tree#add_file (...)
	" Add file to circle
	if a:0 > 0
		let file = a:1
	else
		let prompt = 'File to add ? '
		let complete = 'customlist,wheeltree#complete#file'
		let file = input(prompt, '', complete)
	endif
	if empty(file)
		return v:false
	endif
	silent doautocmd User WheelBeforeOrganize
	execute 'hide edit' file
	call wheeltree#tree#add_here()
	return v:true
endfun

fun! wheeltree#tree#add_buffer (...)
	" Add buffer to circle
	if a:0 > 0
		let buffer = a:1
	else
		let prompt = 'Buffer to add ? '
		let complete = 'customlist,wheeltree#complete#buffer'
		let choice = input(prompt, '', complete)
		if empty(choice)
			return v:false
		endif
		let fields = split(choice, s:field_separ)
		let buffer = fields[3]
	endif
	if empty(buffer)
		return v:false
	endif
	silent doautocmd User WheelBeforeOrganize
	execute 'hide buffer' buffer
	call wheeltree#tree#add_here()
	return v:true
endfun

fun! wheeltree#tree#add_glob (...)
	" Add all files matching a glob pattern
	if a:0 > 0
		let glob = a:1
	else
		let prompt = 'Add files matching glob : '
		let complete = 'customlist,wheeltree#complete#file'
		let glob = input(prompt, '', complete)
	endif
	if empty(glob)
		return []
	endif
	silent doautocmd User WheelBeforeOrganize
	" add first torus if needed
	if empty(g:wheeltree.toruses)
		call wheeltree#tree#add_torus()
	endif
	" add files to a new circle ?
	let answer = confirm('Create new circle ?', "&Yes\n&No", 2)
	if answer == 1
		call wheeltree#tree#add_circle()
	endif
	" add first circle if needed
	let torus = g:wheeltree.toruses[g:wheeltree.current]
	if empty(torus.circles)
		call wheeltree#tree#add_circle()
	endif
	" add files
	let filelist = glob(glob, v:false, v:true)
	for filename in filelist
		let location = {}
		let location.name = filename
		let location.file = fnamemodify(filename, ':p')
		let location.line = 1
		let location.col = 1
		call wheeltree#tree#insert_location(location)
	endfor
	" jump to first location of circle, if not empty
	let circle = wheeltree#referen#current('circle')
	if ! empty(circle.locations)
		let circle.current = 0
		call wheeltree#vortex#jump ()
	endif
	return filelist
endfun

" ---- rename

fun! wheeltree#tree#rename (level, ...)
	" Rename current element at level -> new
	let level = a:level
	if wheeltree#referen#is_empty (level)
		echomsg 'wheeltree rename :' level 'is empty'
		return v:false
	endif
	if a:0 > 0
		let new = a:1
	else
		let prompt = 'Rename ' .. level .. ' as ? '
		if level ==# 'torus'
			let complete = 'customlist,wheeltree#complete#empty'
		elseif level ==# 'circle'
			let complete = 'customlist,wheeltree#complete#current_directory'
		elseif level ==# 'location'
			let complete = 'customlist,wheeltree#complete#current_file'
		else
			echomsg 'wheeltree rename : bad level name'
			return v:false
		endif
		let new = input(prompt, '', complete)
	endif
	if empty(new)
		return v:false
	endif
	let upper = wheeltree#referen#upper (level)
	let current = wheeltree#referen#current (level)
	" ---- name
	let new = wheeltree#tree#format_name (new)
	if empty(new)
		call wheeltree#status#message(level, 'name cannot be empty')
		return v:false
	endif
	" ---- check new is not present in upper list
	if wheeltree#chain#is_inside(new, upper.glossary)
		let upper_level_name = wheeltree#referen#upper_level_name(a:level)
		let infolist = [level, new, 'already exists in', upper_level_name]
		call wheeltree#status#message(infolist)
		return v:false
	endif
	" ---- user update autocmd
	silent doautocmd User WheelBeforeOrganize
	" ---- rename
	let old = current.name
	let current.name = new
	call wheeltree#status#message('Renaming', level, old, '->', new)
	let glossary = upper.glossary
	let upper.glossary = glossary->wheeltree#chain#replace(old, new)
	let g:wheeltree.timestamp = wheeltree#pendulum#timestamp ()
	call wheeltree#pendulum#rename(level, old, new)
	return v:true
endfun

" -- rename file

fun! wheeltree#tree#adapt_to_filename (old_filename, new_filename)
	" Adapt wheeltree variables to new_filename
	let old_filename = a:old_filename
	let new_filename = a:new_filename
	" ---- rename file in all involved locations of the wheeltree
	for torus in g:wheeltree.toruses
		for circle in torus.circles
			for location in circle.locations
				if location.file ==# old_filename
					let location.file = new_filename
				endif
			endfor
		endfor
	endfor
	" ---- rename file in wheeltree index
	let g:wheeltree.timestamp = wheeltree#pendulum#timestamp()
	call wheeltree#helix#rename_file(old_filename, new_filename)
endfun

fun! wheeltree#tree#rename_file (...)
	" Rename current file in filesystem & in the wheeltree
	if wheeltree#referen#is_empty ('location')
		echomsg 'wheeltree rename file : location is empty'
		return v:false
	endif
	if a:0 > 0
		let new_filename = a:1
	else
		let dir = expand('%:h')
		let dir = wheeltree#disc#relative_path (dir)
		let prompt = 'Rename file as ? '
		let complete = 'customlist,wheeltree#complete#file'
		let new_filename = input(prompt, dir, complete)
	endif
	if empty(new_filename)
		return v:false
	endif
	" ---- old name
	let location = wheeltree#referen#location ()
	let old_filename = location.file
	" ---- new name
	let new_filename = wheeltree#disc#format_name (new_filename)
	" ---- rename file
	let returnstring = wheeltree#disc#rename (old_filename, new_filename)
	if returnstring != 'success'
		return v:false
	endif
	" ---- link buffer to new file name
	execute 'silent file' new_filename
	silent write!
	" ---- user update autocmd
	silent doautocmd User WheelBeforeOrganize
	" ---- adapt wheeltree variables to new_filename
	call wheeltree#tree#adapt_to_filename (old_filename, new_filename)
	" ---- rename location
	call wheeltree#tree#rename('location')
	return v:true
endfun

" ---- remove

fun! wheeltree#tree#remove (level, name)
	" Remove element given by name at level
	" No confirm prompt, no jump : internal use only
	let level = a:level
	let name = a:name
	let coordin = wheeltree#referen#coordinates ()
	let upper = wheeltree#referen#upper (level)
	let elements = wheeltree#referen#elements (upper)
	let glossary = upper.glossary
	" ---- find element index
	let index = glossary->index(name)
	if index < 0
		echomsg upper_name 'does not contain' name
		return v:false
	endif
	" ---- user update autocmd
	silent doautocmd User WheelBeforeOrganize
	" ---- remove from elements list
	eval elements->remove(index)
	" ---- adjust current index if necessary
	if empty(elements)
		let upper.current = -1
	elseif index <= upper.current
		" if removed element index is before current one,
		" the need to decrease current
		let length = len(elements)
		let upper.current = wheeltree#taijitu#circular_minus(index, length)
	endif
	" ---- remove from glossary
	eval glossary->wheeltree#chain#remove_element(name)
	" ---- for index auto update at demand
	let g:wheeltree.timestamp = wheeltree#pendulum#timestamp ()
	" ---- adjust history
	call wheeltree#pendulum#delete (level, coordin)
	return v:true
endfun

" -- delete

fun! wheeltree#tree#delete (level, ask = 'confirm')
	" Delete current element at level
	" Optional argument :
	"   - confirm : ask confirmation
	"   - force : don't ask confirmation
	let level = a:level
	let ask = a:ask
	let current = wheeltree#referen#current (level)
	let name = current.name
	if ask != 'force'
		let prompt = 'Delete current ' .. level .. ' ' .. name .. ' ?'
		let confirm = confirm(prompt, "&Yes\n&No", 2)
		if confirm != 1
			return v:false
		endif
	endif
	" ---- for history
	let coordin = wheeltree#referen#coordinates ()
	" ---- check
	let upper = wheeltree#referen#upper (level)
	let elements = wheeltree#referen#elements (upper)
	if empty(elements)
		let upper_name = wheeltree#referen#upper_level_name (level)
		echomsg upper_name 'is already empty'
		return v:false
	endif
	" ---- user update autocmd
	silent doautocmd User WheelBeforeOrganize
	" ---- remove
	let length = len(elements)
	let upper_level_name = wheeltree#referen#upper_level_name (level)
	let key = wheeltree#referen#list_key (upper_level_name)
	let index = upper.current
	eval elements->remove(index)
	let length -= 1
	if empty(elements)
		let upper.current = -1
	else
		let upper.current = wheeltree#taijitu#circular_minus(index, length)
	endif
	eval upper.glossary->wheeltree#chain#remove_element(name)
	let g:wheeltree.timestamp = wheeltree#pendulum#timestamp ()
	call wheeltree#vortex#jump ()
	" ---- adjust history
	call wheeltree#pendulum#delete (level, coordin)
	return v:true
endfun

" ---- copy / move

fun! wheeltree#tree#copy_move (level, mode, ...)
	" Copy or move element of level
	" level can be :
	"   - circle : move circle to another torus
	"   - location : move location to another circle
	let level = a:level
	let mode = a:mode
	if wheeltree#referen#is_empty (level)
		echomsg 'wheeltree copy/move :' level 'is empty'
		return v:false
	endif
	if a:0 > 0
		let destination = a:1
	else
		let upper_name = wheeltree#referen#upper_level_name (level)
		let prompt = mode .. ' ' .. level .. ' to ' .. upper_name .. ' ? '
		if level ==# 'torus'
			let destination = 'wheeltree'
		elseif level ==# 'circle'
			let complete = 'customlist,wheeltree#complete#torus'
			let destination = input(prompt, '', complete)
		elseif level ==# 'location'
			let complete = 'customlist,wheeltree#complete#grid'
			let destination = input(prompt, '', complete)
		else
			echomsg 'wheeltree' mode ': bad level name'
			return v:false
		endif
	endif
	if empty(destination)
		return v:false
	endif
	let element = deepcopy(wheeltree#referen#{level}())
	let coordin = split(destination, s:level_separ)
	" ---- pre checks
	if mode ==# 'move'
		if level ==# 'torus'
			echomsg 'wheeltree : move torus in wheeltree = noop'
			return v:false
		elseif level ==# 'circle' && destination ==# wheeltree#referen#torus().name
			echomsg 'wheeltree : move circle to current torus = noop'
			return v:false
		elseif level ==# 'location' && coordin ==# wheeltree#referen#coordinates()[:1]
			echomsg 'wheeltree : move location to current circle = noop'
			return v:false
		endif
		call wheeltree#tree#remove (level, element.name)
	elseif mode !=# 'copy'
		echomsg 'wheeltree copy/move : mode must be copy or move'
	endif
	" ---- user update autocmd
	silent doautocmd User WheelBeforeOrganize
	" ---- copy / move
	if level ==# 'torus'
		" mode must be copy at this stage
		call wheeltree#tree#insert_torus (element)
	elseif level ==# 'circle'
		call wheeltree#vortex#voice ('torus', destination)
		call wheeltree#tree#insert_circle (element)
	elseif level ==# 'location'
		call wheeltree#vortex#interval (coordin)
		call wheeltree#tree#insert_location (element)
	endif
	call wheeltree#vortex#jump ()
	return v:true
endfun

fun! wheeltree#tree#copy (level)
	" Copy element of level
	call wheeltree#tree#copy_move(a:level, 'copy')
endfun

fun! wheeltree#tree#move (level)
	" Move element of level
	call wheeltree#tree#copy_move(a:level, 'move')
endfun
