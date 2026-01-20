" vim: set ft=vim fdm=indent iskeyword&:

" Yggdrasil
"
" Organize the wheeltree, dedicated buffers

" ---- reorder

fun! wheeltree#yggdrasil#reorder (level)
	" Reorder level elements
	let level = a:level
	let lines = wheeltree#flower#element (level)
	" -- pre-checks
	if empty(lines)
		echomsg 'wheeltree shape reorder : empty or incomplete' level
		return v:false
	endif
	" -- mandala
	call wheeltree#mandala#blank ('reorder/' .. level)
	call wheeltree#mandala#common_maps ()
	call wheeltree#polyphony#temple ()
	call wheeltree#polyphony#score ('reorder', level)
	call wheeltree#mandala#fill(lines)
	" -- reload
	call wheeltree#mandala#set_reload('wheeltree#yggdrasil#reorder', level)
	" -- additional maps
	" sort
	nnoremap <buffer> <m-s> <cmd>2,$sort<cr>
	" reverse sort
	nnoremap <buffer> <m-r> <cmd>2,$sort!<cr>
endfun

" ---- rename

fun! wheeltree#yggdrasil#rename (level)
	" Rename level elements
	let level = a:level
	let lines = wheeltree#flower#element (level)
	" -- pre-checks
	if empty(lines)
		echomsg 'wheeltree shape rename : empty or incomplete' level
		return v:false
	endif
	" -- mandala
	call wheeltree#mandala#blank ('rename/' .. level)
	call wheeltree#mandala#common_maps ()
	call wheeltree#polyphony#temple ()
	call wheeltree#polyphony#score ('rename', level)
	call wheeltree#mandala#fill(lines)
	setlocal nomodified
	" reload
	call wheeltree#mandala#set_reload('wheeltree#yggdrasil#rename', level)
endfun

fun! wheeltree#yggdrasil#rename_file ()
	" Rename locations & files of current circle
	" -- lines
	let lines = wheeltree#flower#rename_file ()
	" -- pre-checks
	if empty(lines)
		echomsg 'wheeltree shape rename_file : empty or incomplete circle'
		return v:false
	endif
	" -- mandala
	call wheeltree#mandala#blank ('rename/loc_files')
	call wheeltree#mandala#common_maps ()
	call wheeltree#polyphony#temple ()
	call wheeltree#polyphony#score ('rename_file')
	call wheeltree#mandala#fill(lines)
	setlocal nomodified
	" reload
	call wheeltree#mandala#set_reload('wheeltree#yggdrasil#rename_file')
	return v:true
endfun

" ---- delete

fun! wheeltree#yggdrasil#delete (level)
	" Delete elements at level
	let level = a:level
	let lines = wheeltree#flower#element (level)
	" -- pre-checks
	if empty(lines)
		echomsg 'wheeltree shape copy / move : empty or incomplete' level
		return v:false
	endif
	" -- mandala
	call wheeltree#mandala#blank ('delete/' .. level)
	call wheeltree#mandala#common_maps ()
	call wheeltree#polyphony#temple ()
	call wheeltree#pencil#mappings ()
	call wheeltree#polyphony#score ('delete', level)
	call wheeltree#mandala#fill(lines)
	setlocal nomodified
	" reload
	call wheeltree#mandala#set_reload('wheeltree#yggdrasil#delete', level)
endfun

" ---- copy / move

fun! wheeltree#yggdrasil#copy_move (level)
	" Copy or move elements at level
	let level = a:level
	let lines = wheeltree#flower#element (level)
	" -- pre-checks
	if empty(lines)
		echomsg 'wheeltree shape copy / move : empty or incomplete' level
		return v:false
	endif
	" -- mandala
	call wheeltree#mandala#blank ('copy_move/' .. level)
	call wheeltree#mandala#common_maps ()
	call wheeltree#polyphony#temple ()
	call wheeltree#pencil#mappings ()
	call wheeltree#polyphony#score ('copy_move', level)
	call wheeltree#mandala#fill(lines)
	setlocal nomodified
	" reload
	call wheeltree#mandala#set_reload('wheeltree#yggdrasil#copy_move', level)
endfun

" ---- reorganize

fun! wheeltree#yggdrasil#reorganize ()
	" Reorganize the wheeltree tree
	let lines = wheeltree#flower#reorganize ()
	" -- pre-checks
	if empty(lines)
		echomsg 'wheeltree shape reorganize : empty wheeltree'
		return v:false
	endif
	" -- mandala
	call wheeltree#mandala#blank ('reorganize')
	call wheeltree#mandala#common_maps ()
	call wheeltree#polyphony#temple ()
	call wheeltree#origami#folding_options ()
	call wheeltree#polyphony#score ('reorganize')
	call wheeltree#mandala#fill(lines)
	setlocal nomodified
	setlocal nocursorline
	" reload
	call wheeltree#mandala#set_reload('wheeltree#yggdrasil#reorganize')
endfun
