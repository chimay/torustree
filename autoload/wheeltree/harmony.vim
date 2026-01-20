" vim: set ft=vim fdm=indent iskeyword&:

" Harmony
"
" Writing functions for local BufWriteCmd autocommand
" in wheeltree elements dedicated buffers

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

if exists('s:fold_markers')
	unlockvar s:fold_markers
endif
let s:fold_markers = wheeltree#crystal#fetch('fold/markers')
let s:fold_markers = join(s:fold_markers, ',')
lockvar s:fold_markers

if exists('s:fold_1')
	unlockvar s:fold_1
endif
let s:fold_1 = wheeltree#crystal#fetch('fold/one')
lockvar s:fold_1

if exists('s:fold_2')
	unlockvar s:fold_2
endif
let s:fold_2 = wheeltree#crystal#fetch('fold/two')
lockvar s:fold_2

" ---- wheeltree elements

fun! wheeltree#harmony#reorder (level, ask = 'confirm')
	" Reorder elements at level, after buffer content
	let level = a:level
	" ---- confirm
	if ! wheeltree#polyphony#confirm (a:ask)
		return v:false
	endif
	silent doautocmd User WheelBeforeOrganize
	" ---- update lines in local vars from visible lines
	call wheeltree#polyphony#update_var_lines ()
	" ---- reorder
	let upper = wheeltree#referen#upper (level)
	let upper_level_name = wheeltree#referen#upper_level_name(level)
	let key = wheeltree#referen#list_key (upper_level_name)
	let old_list = deepcopy(wheeltree#referen#elements (upper))
	let old_names = deepcopy(old_list)
	let old_names = map(old_names, {_,val -> val.name})
	let current_name = old_names[upper.current]
	let new_names = wheeltree#teapot#all_lines ()
	let new_list = []
	for name in new_names
		let index = old_names->index(name)
		if index < 0
			echomsg 'wheeltree harmony reorder : ' name  'not found'
			continue
		endif
		let elem = old_list[index]
		eval new_list->add(elem)
	endfor
	if len(new_list) < len(old_list)
		echomsg 'Some elements seem to be missing : changes not written'
		return []
	elseif len(new_list) > len(old_list)
		echomsg 'Elements in excess : changes not written'
		return []
	endif
	let upper[key] = new_list
	let upper.glossary = new_names
	let upper.current = new_names->index(current_name)
	setlocal nomodified
	echomsg 'Changes written to wheeltree'
	return new_list
endfun

fun! wheeltree#harmony#rename (level, ask = 'confirm')
	" Rename elements at level, after buffer content
	let level = a:level
	" ---- confirm
	if ! wheeltree#polyphony#confirm (a:ask)
		return v:false
	endif
	silent doautocmd User WheelBeforeOrganize
	" ---- update lines in local vars from visible lines
	call wheeltree#polyphony#update_var_lines ()
	" ---- rename
	let upper = wheeltree#referen#upper (level)
	let elements = wheeltree#referen#elements (upper)
	let names = wheeltree#teapot#all_lines ()
	let len_names = len(names)
	let len_elements = len(elements)
	if len_names < len_elements
		echomsg 'Some names seem to be missing : changes not written'
		return []
	endif
	if len_names > len_elements
		echomsg 'Names in excess : changes not written'
		return []
	endif
	let upper.glossary = names
	for index in range(len_names)
		let old_name = elements[index].name
		let new_name = names[index]
		" -- nothing to do if old == new
		if old_name == new_name
			continue
		endif
		let elements[index].name = new_name
		call wheeltree#pendulum#rename(level, old_name, new_name)
	endfor
	let g:wheeltree.timestamp = wheeltree#pendulum#timestamp ()
	call wheeltree#rectangle#goto_previous ()
	call wheeltree#vortex#jump()
	call wheeltree#cylinder#recall()
	setlocal nomodified
	echomsg 'Changes written to wheeltree'
	return elements
endfun

fun! wheeltree#harmony#rename_file (ask = 'confirm')
	" Rename locations & files of current circle, after buffer content
	" ---- confirm
	if ! wheeltree#polyphony#confirm (a:ask)
		return v:false
	endif
	silent doautocmd User WheelBeforeOrganize
	" ---- update lines in local vars from visible lines
	call wheeltree#polyphony#update_var_lines ()
	" ---- init
	let circle = wheeltree#referen#circle ()
	let glossary = circle.glossary
	let locations = circle.locations
	let lines = wheeltree#teapot#all_lines ()
	let len_lines = len(lines)
	let len_locations = len(locations)
	" ---- pre-checks
	if len_lines < len_locations
		echomsg 'Some names seem to be missing : changes not written'
		return []
	endif
	if len_lines > len_locations
		echomsg 'Names in excess : changes not written'
		return []
	endif
	" ---- rename location
	for index in range(len_lines)
		let fields = split(lines[index], s:field_separ)
		let old_name = glossary[index]
		let new_name = wheeltree#tree#format_name(fields[0])
		" -- check not empty
		if empty(old_name) || empty(new_name)
			echomsg 'wheeltree harmony rename : location name cannot be empty'
			continue
		endif
		" -- nothing to do if old == new
		if old_name == new_name
			continue
		endif
		" -- search for location
		let found = glossary->index(new_name)
		if found >= 0 && found != index
			echomsg 'Location' new_name 'already present in circle'
			continue
		endif
		" -- rename location
		let glossary[index] = new_name
		let locations[index].name = new_name
		call wheeltree#pendulum#rename('location', old_name, new_name)
	endfor
	let g:wheeltree.timestamp = wheeltree#pendulum#timestamp ()
	" ---- rename file
	for index in range(len_lines)
		let fields = split(lines[index], s:field_separ)
		let old_filename = locations[index].file
		let new_filename = wheeltree#disc#format_name (fields[1])
		" -- nothing to do if old == new
		if old_filename == new_filename
			continue
		endif
		" -- rename file
		let returnstring = wheeltree#disc#rename(old_filename, new_filename)
		if returnstring != 'success'
			continue
		endif
		echomsg 'wheeltree : renaming' old_filename '->' new_filename
		let locations[index].file = new_filename
		" -- wipe old filename buffer if existent
		if bufexists(old_filename)
			execute 'bwipe!' old_filename
		endif
		" -- rename file in all involved locations of the wheeltree
		call wheeltree#tree#adapt_to_filename (old_filename, new_filename)
	endfor
	call wheeltree#rectangle#goto_previous ()
	call wheeltree#vortex#jump()
	call wheeltree#cylinder#recall()
	setlocal nomodified
	echomsg 'Changes written to wheeltree'
	return lines
endfun

fun! wheeltree#harmony#delete (level, ask = 'confirm')
	" Delete selected elements at level, after buffer content
	let level = a:level
	" ----  confirm
	if ! wheeltree#polyphony#confirm (a:ask)
		return v:false
	endif
	silent doautocmd User WheelBeforeOrganize
	" ----  update lines in local vars from visible lines
	call wheeltree#polyphony#update_var_lines ()
	" ----  delete
	let upper = wheeltree#referen#upper (level)
	let upper_level_name = wheeltree#referen#upper_level_name(level)
	let glossary = upper.glossary
	let elements = wheeltree#referen#elements (upper)
	let selection = wheeltree#pencil#selection ()
	let components = selection.components
	if empty(components)
		echomsg 'wheeltree delete : first select element(s)'
	endif
	for name in components
		let index = glossary->index(name)
		if index < 0
			echomsg upper_level_name 'does not contain' name
			continue
		endif
		" -- remove from elements list
		eval glossary->remove(index)
		eval elements->remove(index)
		if empty(elements)
			let upper.current = -1
		elseif index <= upper.current
			" if removed element index is before current one,
			" the need to decrease current
			let length = len(elements)
			let upper.current = wheeltree#taijitu#circular_minus(index, length)
		endif
	endfor
	" -- clean history
	call wheeltree#pendulum#broom ()
	" -- for index auto update at demand
	let g:wheeltree.timestamp = wheeltree#pendulum#timestamp ()
	setlocal nomodified
	echomsg 'Changes written to wheeltree'
	return elements
endfun

fun! wheeltree#harmony#copy_move (level, ask = 'confirm')
	" Copy or move selected elements at level
	let level = a:level
	" ---- confirm
	if ! wheeltree#polyphony#confirm (a:ask)
		return v:false
	endif
	silent doautocmd User WheelBeforeOrganize
	" ---- update lines in local vars from visible lines
	call wheeltree#polyphony#update_var_lines ()
	" ---- mode : copy or move
	let prompt = 'Mode ? '
	let answer = confirm(prompt, "&Copy\n&Move", 1)
	if answer == 1
		let mode = 'copy'
	elseif answer == 2
		let mode = 'move'
	endif
	" ---- prompt for destination
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
	if empty(destination)
		return v:false
	endif
	let coordin = split(destination, s:level_separ)
	" ---- pre checks
	let selection = wheeltree#pencil#selection ()
	let components = selection.components
	if empty(components)
		echomsg 'wheeltree copy / move : first select element(s)'
	endif
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
	endif
	" ---- departure
	if level ==# 'wheeltree'
		echomsg 'Cannot copy or move the wheeltree'
		return v:false
	elseif level ==# 'torus'
		for name in components
			" mode must be copy at this stage
			let index = g:wheeltree.glossary->index(name)
			let torus = deepcopy(g:wheeltree.toruses[index])
			call wheeltree#tree#insert_torus (torus)
		endfor
	else
		let upper = wheeltree#referen#upper (level)
		let glossary = upper.glossary
		let elements = wheeltree#referen#elements (upper)
		let travellers = []
		for name in components
			let index = glossary->index(name)
			let elem = deepcopy(elements[index])
			eval travellers->add(elem)
			if mode ==# 'move'
				call wheeltree#tree#remove (level, elem.name)
			endif
		endfor
	endif
	" ---- destination
	if level ==# 'circle'
		call wheeltree#vortex#voice ('torus', destination)
		for circle in travellers
			call wheeltree#tree#insert_circle (circle)
		endfor
	elseif level ==# 'location'
		call wheeltree#vortex#interval (coordin)
		for location in travellers
			call wheeltree#tree#insert_location (location)
		endfor
	endif
	let g:wheeltree.timestamp = wheeltree#pendulum#timestamp ()
	setlocal nomodified
	echomsg 'Changes written to wheeltree'
	call wheeltree#rectangle#goto_previous ()
	call wheeltree#vortex#jump ()
	call wheeltree#cylinder#recall()
	return v:true
endfun

fun! wheeltree#harmony#reorganize (ask = 'confirm')
	" Reorganize wheeltree after elements contained in buffer
	" Rebuild all from scratch
	" Follow folding tree
	" ---- confirm
	if ! wheeltree#polyphony#confirm (a:ask)
		return v:false
	endif
	silent doautocmd User WheelBeforeOrganize
	" ---- save old wheeltree before reorganizing
	let prompt = 'Write old wheeltree to file before reorganizing ?'
	let confirm = confirm(prompt, "&Yes\n&No", 1)
	if confirm == 1
		call wheeltree#disc#write_wheel ()
	endif
	" ---- update lines in local vars from visible lines
	call wheeltree#polyphony#update_var_lines ()
	" ---- start from empty wheeltree
	call wheeltree#ouroboros#unlet ('g:wheeltree')
	call wheeltree#void#wheeltree ()
	" ---- loop over buffer lines
	let linelist = wheeltree#teapot#all_lines ()
	let marker = s:fold_markers[0]
	let pat_fold_one = '\m' .. s:fold_1 .. '$'
	let pat_fold_two = '\m' .. s:fold_2 .. '$'
	let pat_dict = '\m^{.*}'
	for line in linelist
		if line =~ pat_fold_one
			" -- torus line
			let torus = split(line)[0]
			call wheeltree#tree#add_torus(torus)
		elseif line =~ pat_fold_two
			" -- circle line
			let circle = split(line)[0]
			call wheeltree#tree#add_circle(circle)
		elseif line =~ pat_dict
			" -- location line
			let location = eval(line)
			" -- no pendulum#record in tree#insert_location
			call wheeltree#tree#insert_location(location)
		endif
	endfor
	" ---- rebuild location index
	call wheeltree#helix#helix ()
	" ---- rebuild circle index
	call wheeltree#helix#grid ()
	" ---- rebuild file index
	call wheeltree#helix#files ()
	" ---- remove invalid entries from history
	call wheeltree#pendulum#broom ()
	" ---- info
	setlocal nomodified
	echomsg 'Changes written to wheeltree'
	" -- tune wheeltree coordinates to first entry in history
	call wheeltree#vortex#chord(g:wheeltree_history.line[0].coordin)
endfun
