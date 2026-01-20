" vim: set ft=vim fdm=indent iskeyword&:

" Triangle
"
" Undo list dedicated buffer

fun! wheeltree#triangle#undolist ()
	" Undo list mandala
	call wheeltree#mandala#goto_related ()
	let bufname = bufname('%')
	let filename = fnamemodify(bufname, ':t')
	let lines = wheeltree#perspective#undolist ()
	call wheeltree#mandala#blank('undo/' .. filename)
	call wheeltree#mandala#template ()
	call wheeltree#delta#mappings ()
	call wheeltree#mandala#fill (lines)
	let b:wheel_settings.undo_iden = wheeltree#delta#undo_iden(1)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#triangle#undolist')
endfun
