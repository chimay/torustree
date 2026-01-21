" vim: set ft=vim fdm=indent iskeyword&:

" Triangle
"
" Undo list dedicated buffer

fun! torustree#triangle#undolist ()
	" Undo list mandala
	call torustree#mandala#goto_related ()
	let bufname = bufname('%')
	let filename = fnamemodify(bufname, ':t')
	let lines = torustree#perspective#undolist ()
	call torustree#mandala#blank('undo/' .. filename)
	call torustree#mandala#template ()
	call torustree#delta#mappings ()
	call torustree#mandala#fill (lines)
	let b:torustree_settings.undo_iden = torustree#delta#undo_iden(1)
	" reload
	call torustree#mandala#set_reload('torustree#triangle#undolist')
endfun
