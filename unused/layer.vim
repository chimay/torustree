" vim: set ft=vim fdm=indent iskeyword&:

" Layers stack in each mandala buffer

" first implementation
"
" the stack does not contain the current mandala lines & settings

" Script constants

if ! exists('s:mandala_options')
	let s:mandala_options = torustree#crystal#fetch('mandala/options')
	lockvar s:mandala_options
endif

if ! exists('s:map_keys')
	let s:map_keys = torustree#crystal#fetch('map/keys')
	lockvar s:map_keys
endif

if ! exists('s:mandala_autocmds_group')
	let s:mandala_autocmds_group = torustree#crystal#fetch('mandala/autocmds/group')
	lockvar s:mandala_autocmds_group
endif

if ! exists('s:mandala_autocmds_events')
	let s:mandala_autocmds_events = torustree#crystal#fetch('mandala/autocmds/events')
	lockvar s:mandala_autocmds_events
endif

if ! exists('s:mandala_vars')
	let s:mandala_vars = torustree#crystal#fetch('mandala/vars')
	lockvar s:mandala_vars
endif

" Init stack

fun! torustree#layer#init ()
	" Init stack and buffer variables
	" Last inserted layer is at index 0
	call torustree#mandala#init ()
	if ! exists('b:torustree_stack')
		let b:torustree_stack = {}
		let stack = b:torustree_stack
		" index of top layer
		let stack.top = -1
		let stack.layers = []
	endif
endfun

" State

fun! torustree#layer#length ()
	" Layer stack length
	return len(b:torustree_stack.layers)
endfun

fun! torustree#layer#bottom ()
	" Return layer index to be popped or replaced in stack
	let top = b:torustree_stack.top
	let length = torustree#layer#length ()
	let bottom = torustree#gear#circular_minus (top, length)
	return bottom
endfun

fun! torustree#layer#stack (...)
	" Return stack of fieldname given by argument
	" Return layer stack if no argument is given
	" Useful for debugging
	if a:0 == 0
		return b:torustree_stack.layers
	endif
	let stack = b:torustree_stack
	let fieldname = a:1
	let field_stack = []
	for elem in stack.layers
		let shadow = deepcopy(elem[fieldname])
		call add(field_stack, shadow)
	endfor
	return field_stack
endfun

fun! torustree#layer#top_field (...)
	" Return field given by fieldname at top of stack
	" Return top of stack if no argument is given
	let stack = b:torustree_stack
	if a:0 == 0
		return stack.layers[stack.top]
	endif
	let fieldname = a:1
	return stack.layers[stack.top][fieldname]
endfun

" Clearing things

fun! torustree#layer#clear_options ()
	" Clear mandala local options
	setlocal nofoldenable
endfun

fun! torustree#layer#clear_maps ()
	" Clear mandala local maps
	call torustree#gear#unmap(s:map_keys)
endfun

fun! torustree#layer#clear_autocmds ()
	" Clear mandala local autocommands
	let group = s:mandala_autocmds_group
	let events = s:mandala_autocmds_events
	call torustree#gear#clear_autocmds (group, events)
endfun

fun! torustree#layer#clear_vars ()
	" Clear mandala local variables, except the layer stack
	call torustree#gear#unlet (s:mandala_vars)
endfun

fun! torustree#layer#fresh ()
	" Fresh empty layer : clear mandala local data
	call torustree#layer#clear_options ()
	call torustree#layer#clear_maps ()
	call torustree#layer#clear_autocmds ()
	call torustree#layer#clear_vars ()
	" delete lines -> underscore _ = no storing register
	silent! 1,$ delete _
endfun

" Saving things

fun! torustree#layer#save_options ()
	" Save options
	return torustree#gear#save_options (s:mandala_options)
endfun

fun! torustree#layer#save_maps ()
	" Save maps
	return torustree#gear#save_maps (s:map_keys)
endfun

fun! torustree#layer#save_autocmds ()
	" Save autocommands
	let group = s:mandala_autocmds_group
	let events = s:mandala_autocmds_events
	return torustree#gear#save_autocmds (group, events)
endfun

" Restoring things

fun! torustree#layer#restore_autocmds (autodict)
	" Restore autocommands
	let group = s:mandala_autocmds_group
	call torustree#gear#restore_autocmds (group, a:autodict)
endfun

" Sync & swap

fun! torustree#layer#syncdown ()
	" Sync top of the stack to mandala state : vars, options, maps
	if torustree#layer#length () == 0
		echomsg 'torustree layer sync : empty stack.'
		return v:false
	endif
	let stack = b:torustree_stack
	let top = stack.top
	let layer = stack.layers[top]
	" pseudo filename
	let pseudo_file = layer.filename
	execute 'silent file' pseudo_file
	" options
	call torustree#gear#restore_options (layer.options)
	" mappings
	let mappings = deepcopy(layer.mappings)
	call torustree#gear#restore_maps (mappings)
	" autocommands
	let autodict = copy(layer.autocmds)
	call torustree#layer#restore_autocmds (autodict)
	" lines, without filtering
	let b:torustree_lines = copy(layer.lines)
	" filtered mandala content
	" layer.filtered should contain also the original first line, so we have
	" to delete the first line added by :put in the replace routine
	call torustree#mandala#replace (layer.filtered, 'delete')
	" cursor position
	call torustree#gear#restore_cursor (layer.position)
	" address linked to cursor line & context
	let b:torustree_address = copy(layer.address)
	" selection
	let b:torustree_selected = deepcopy(layer.selected)
	" settings
	let b:torustree_settings = deepcopy(layer.settings)
	" reload
	let b:torustree_reload = layer.reload
	" Tell (neo)vim the buffer is to be considered not modified
	setlocal nomodified
endfun

fun! torustree#layer#swap ()
	" Swap mandala state and top of stack
	call torustree#layer#init ()
	let stack = b:torustree_stack
	" -- Mandala state -> swap space
	let swap = {}
	" pseudo filename
	let swap.filename = expand('%')
	" options
	let swap.options = torustree#layer#save_options ()
	" mappings
	let swap.mappings = torustree#layer#save_maps ()
	" autocommands
	let swap.autocmds = torustree#layer#save_autocmds ()
	" lines, without filtering
	if empty(b:torustree_lines)
		let begin = torustree#mandala#first_data_line ()
		let swap.lines = getline(begin, '$')
	else
		let swap.lines = copy(b:torustree_lines)
	endif
	" filtered content
	let swap.filtered = getline(1, '$')
	" cursor position
	let swap.position = getcurpos()
	" address of cursor line
	" useful for boomerang = context menus
	let swap.address = torustree#line#address()
	" selected lines
	let swap.selected = deepcopy(b:torustree_selected)
	" settings
	if exists('b:torustree_settings')
		let swap.settings = b:torustree_settings
	else
		let swap.settings = {}
	endif
	" reload
	if exists('b:torustree_reload')
		let swap.reload = b:torustree_reload
	else
		let swap.reload = ''
	endif
	" -- Stack top -> mandala state
	call torustree#layer#syncdown ()
	" -- Swap space -> top of stack
	let stack.layers[stack.top] = swap
endfun

" Push & pop

fun! torustree#layer#push ()
	" Push buffer content to the stack
	" save modified local maps
	call torustree#layer#init ()
	let stack = b:torustree_stack
	let length = torustree#layer#length ()
	let maxim = g:torustree_config.maxim.layers
	if length == 0
		let stack.top = 0
	endif
	if length < maxim
		" insert new layer before top
		" the top index will reflect the new element,
		" no need to update it
		call insert(stack.layers, {}, stack.top)
	else
		" new layer will replace the bottom
		let stack.top = torustree#layer#bottom ()
	endif
	" layer to fill / update
	let layer = stack.layers[stack.top]
	" pseudo filename
	let layer.filename = expand('%')
	" options
	let layer.options = torustree#layer#save_options ()
	" mappings
	let layer.mappings = torustree#layer#save_maps ()
	" autocommands
	let layer.autocmds = torustree#layer#save_autocmds ()
	" lines, without filtering
	if empty(b:torustree_lines)
		let begin = torustree#mandala#first_data_line ()
		let layer.lines = getline(begin, '$')
	else
		let layer.lines = copy(b:torustree_lines)
	endif
	" filtered content
	let layer.filtered = getline(1, '$')
	" cursor position
	let layer.position = getcurpos()
	" address of cursor line
	" useful for boomerang = context menus
	let layer.address = torustree#line#address()
	" selected lines
	if exists('b:torustree_selected')
		let layer.selected = deepcopy(b:torustree_selected)
	else
		let layer.selected = []
	endif
	" settings
	if exists('b:torustree_settings')
		let layer.settings = deepcopy(b:torustree_settings)
	else
		let layer.settings = {}
	endif
	" reload
	if exists('b:torustree_reload')
		let layer.reload = b:torustree_reload
	else
		let layer.reload = ''
	endif
endfun

fun! torustree#layer#pop ()
	" Pop top of stack to the mandala state
	let length = torustree#layer#length ()
	if length == 0
		echomsg 'torustree layer pop : empty stack.'
		return v:false
	endif
	" pop
	call torustree#layer#syncdown ()
	let stack = b:torustree_stack
	call remove(stack.layers, stack.top)
	" update length
	let length = torustree#layer#length ()
	" update top index
	if stack.top >= length
		let stack.top = length - 1
	endif
	call torustree#status#layer ()
endfun

" Forward & backward

fun! torustree#layer#forward ()
	" Go forward in layer stack
	let length = torustree#layer#length ()
	if length == 0
		echomsg 'torustree layer forward : empty stack.'
		return v:false
	endif
	let stack = b:torustree_stack
	let top = stack.top
	let length = torustree#layer#length ()
	let stack.top = torustree#gear#circular_minus (top, length)
	call torustree#layer#swap ()
	call torustree#status#layer ()
endfun

fun! torustree#layer#backward ()
	" Go backward in layer stack
	let length = torustree#layer#length ()
	if length == 0
		echomsg 'torustree layer backward : empty stack.'
		return v:false
	endif
	call torustree#layer#swap ()
	let top = b:torustree_stack.top
	let length = torustree#layer#length ()
	let b:torustree_stack.top = torustree#gear#circular_plus (top, length)
	call torustree#status#layer ()
endfun

" Switch

fun! torustree#layer#switch (...)
	" Switch to layer with completion
	if torustree#layer#length () == 0
		echomsg 'torustree layer switch : empty layer stack.'
		return v:false
	endif
	let prompt = 'Switch to layer : '
	let complete = 'customlist,torustree#complete#layer'
	if a:0 > 0
		let name = a:1
	else
		let name = input(prompt, '', complete)
	endif
	let name = torustree#mandala#pseudo (name)
	let filenames = torustree#layer#stack ('filename')
	let stack = b:torustree_stack
	let top = index(filenames, name)
	if top < 0
		return v:false
	endif
	let stack.top = top
	call torustree#layer#swap ()
	call torustree#status#layer ()
endfun
