" vim: set ft=vim fdm=indent iskeyword&:

" Yggdrasil
"
" Organize the torustree, dedicated buffers

" ---- reorder

fun! torustree#yggdrasil#reorder (level)
	" Reorder level elements
	let level = a:level
	let lines = torustree#flower#element (level)
	" -- pre-checks
	if empty(lines)
		echomsg 'torustree shape reorder : empty or incomplete' level
		return v:false
	endif
	" -- mandala
	call torustree#mandala#blank ('reorder/' .. level)
	call torustree#mandala#common_maps ()
	call torustree#polyphony#temple ()
	call torustree#polyphony#score ('reorder', level)
	call torustree#mandala#fill(lines)
	" -- reload
	call torustree#mandala#set_reload('torustree#yggdrasil#reorder', level)
	" -- additional maps
	" sort
	nnoremap <buffer> <m-s> <cmd>2,$sort<cr>
	" reverse sort
	nnoremap <buffer> <m-r> <cmd>2,$sort!<cr>
endfun

" ---- rename

fun! torustree#yggdrasil#rename (level)
	" Rename level elements
	let level = a:level
	let lines = torustree#flower#element (level)
	" -- pre-checks
	if empty(lines)
		echomsg 'torustree shape rename : empty or incomplete' level
		return v:false
	endif
	" -- mandala
	call torustree#mandala#blank ('rename/' .. level)
	call torustree#mandala#common_maps ()
	call torustree#polyphony#temple ()
	call torustree#polyphony#score ('rename', level)
	call torustree#mandala#fill(lines)
	setlocal nomodified
	" reload
	call torustree#mandala#set_reload('torustree#yggdrasil#rename', level)
endfun

fun! torustree#yggdrasil#rename_file ()
	" Rename locations & files of current circle
	" -- lines
	let lines = torustree#flower#rename_file ()
	" -- pre-checks
	if empty(lines)
		echomsg 'torustree shape rename_file : empty or incomplete circle'
		return v:false
	endif
	" -- mandala
	call torustree#mandala#blank ('rename/loc_files')
	call torustree#mandala#common_maps ()
	call torustree#polyphony#temple ()
	call torustree#polyphony#score ('rename_file')
	call torustree#mandala#fill(lines)
	setlocal nomodified
	" reload
	call torustree#mandala#set_reload('torustree#yggdrasil#rename_file')
	return v:true
endfun

" ---- delete

fun! torustree#yggdrasil#delete (level)
	" Delete elements at level
	let level = a:level
	let lines = torustree#flower#element (level)
	" -- pre-checks
	if empty(lines)
		echomsg 'torustree shape copy / move : empty or incomplete' level
		return v:false
	endif
	" -- mandala
	call torustree#mandala#blank ('delete/' .. level)
	call torustree#mandala#common_maps ()
	call torustree#polyphony#temple ()
	call torustree#pencil#mappings ()
	call torustree#polyphony#score ('delete', level)
	call torustree#mandala#fill(lines)
	setlocal nomodified
	" reload
	call torustree#mandala#set_reload('torustree#yggdrasil#delete', level)
endfun

" ---- copy / move

fun! torustree#yggdrasil#copy_move (level)
	" Copy or move elements at level
	let level = a:level
	let lines = torustree#flower#element (level)
	" -- pre-checks
	if empty(lines)
		echomsg 'torustree shape copy / move : empty or incomplete' level
		return v:false
	endif
	" -- mandala
	call torustree#mandala#blank ('copy_move/' .. level)
	call torustree#mandala#common_maps ()
	call torustree#polyphony#temple ()
	call torustree#pencil#mappings ()
	call torustree#polyphony#score ('copy_move', level)
	call torustree#mandala#fill(lines)
	setlocal nomodified
	" reload
	call torustree#mandala#set_reload('torustree#yggdrasil#copy_move', level)
endfun

" ---- reorganize

fun! torustree#yggdrasil#reorganize ()
	" Reorganize the torustree tree
	let lines = torustree#flower#reorganize ()
	" -- pre-checks
	if empty(lines)
		echomsg 'torustree shape reorganize : empty torustree'
		return v:false
	endif
	" -- mandala
	call torustree#mandala#blank ('reorganize')
	call torustree#mandala#common_maps ()
	call torustree#polyphony#temple ()
	call torustree#origami#folding_options ()
	call torustree#polyphony#score ('reorganize')
	call torustree#mandala#fill(lines)
	setlocal nomodified
	setlocal nocursorline
	" reload
	call torustree#mandala#set_reload('torustree#yggdrasil#reorganize')
endfun
