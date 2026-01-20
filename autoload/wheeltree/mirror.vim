" vim: set ft=vim fdm=indent iskeyword&:

" Mirror
"
" Organize native elements, dedicated buffers

fun! wheeltree#mirror#reorg_tabwin ()
	" Reorganize tabs & windows
	let lines = wheeltree#perspective#tabwin_tree ()
	" ---- pre-checks
	if empty(lines)
		echomsg 'wheeltree shape reorganize tabs & windows : empty lines'
		return v:false
	endif
	" ---- mandala
	call wheeltree#mandala#blank ('reorg/tabwin')
	call wheeltree#mandala#common_maps ()
	call wheeltree#polyphony#temple ()
	call wheeltree#origami#folding_options ('tabwin_folding_text')
	call wheeltree#polyphony#score ('reorg_tabwin')
	call wheeltree#mandala#fill(lines)
	" ---- reload
	call wheeltree#mandala#set_reload('wheeltree#mirror#reorg_tabwin')
endfun
