" vim: set ft=vim fdm=indent iskeyword&:

" Mirror
"
" Organize native elements, dedicated buffers

fun! torustree#mirror#reorg_tabwin ()
	" Reorganize tabs & windows
	let lines = torustree#perspective#tabwin_tree ()
	" ---- pre-checks
	if empty(lines)
		echomsg 'torustree shape reorganize tabs & windows : empty lines'
		return v:false
	endif
	" ---- mandala
	call torustree#mandala#blank ('reorg/tabwin')
	call torustree#mandala#common_maps ()
	call torustree#polyphony#temple ()
	call torustree#origami#folding_options ('tabwin_folding_text')
	call torustree#polyphony#score ('reorg_tabwin')
	call torustree#mandala#fill(lines)
	" ---- reload
	call torustree#mandala#set_reload('torustree#mirror#reorg_tabwin')
endfun
