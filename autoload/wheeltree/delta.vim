" vim: set ft=vim fdm=indent iskeyword&:

" Delta
"
" Undo list & diff

" ---- undo state

fun! wheeltree#delta#undo_iden (...)
	" Return undo iden at current or given line
	if a:0 > 0
		let linum = a:1
	else
		let linum = '.'
	endif
	if linum ==# '.'
		call wheeltree#teapot#filter_to_default_line ()
	elseif linum == 1
		let linum = wheeltree#teapot#first_data_line ()
	endif
	let line = getline(linum)
	let fields = split(line)
	let iden = str2nr(fields[0])
	return iden
endfun

fun! wheeltree#delta#earlier (bufnum)
	" Go to earlier state
	call wheeltree#rectangle#find_or_load (a:bufnum)
	earlier
	call wheeltree#cylinder#recall ()
endfun

fun! wheeltree#delta#later (bufnum)
	" Go to later state
	call wheeltree#rectangle#find_or_load (a:bufnum)
	later
	call wheeltree#cylinder#recall ()
endfun

fun! wheeltree#delta#last (bufnum)
	" Set buffer to last undo state
	if has_key(b:wheel_settings, 'undo_iden')
		let iden = b:wheel_settings.undo_iden
	else
		let iden = wheeltree#delta#undo_iden (1)
	endif
	call wheeltree#rectangle#find_or_load (a:bufnum)
	execute 'undo' iden
	call wheeltree#cylinder#recall ()
endfun

" ---- diff windows

fun! wheeltree#delta#close_diff (bufnum)
	" Wipe copy or original buffer
	let diff_buf = b:wheel_settings.diff_buf
	execute 'silent bwipe!' diff_buf
	call wheeltree#rectangle#find_or_load (a:bufnum)
	diffoff
	call wheeltree#cylinder#recall ()
endfun

" ---- maps

fun! wheeltree#delta#mappings ()
	" Maps for undo list mandala
	let bufnum = b:wheel_related.bufnum
	let map = 'nnoremap <buffer>'
	let coda = ')<cr>'
	" earlier or later
	let earlier = '<cmd>call wheeltree#delta#earlier('
	execute map '-' earlier .. bufnum .. coda
	execute map '<kminus>' earlier .. bufnum .. coda
	let later = '<cmd>call wheeltree#delta#later('
	execute map '+' later .. bufnum .. coda
	execute map '<kplus>' later .. bufnum .. coda
	" go to undo given by line
	let undolist = '<cmd>call wheeltree#line#undolist('
	execute map '<cr>' undolist .. bufnum .. coda
	" view diff between undo state and last one
	let undodiff = '<cmd>call wheeltree#line#undo_diff('
	" d does not work for it puts vim in operator pending mode
	execute map 'D' undodiff .. bufnum .. coda
	" close diff
	let closediff = '<cmd>call wheeltree#delta#close_diff('
	execute map 'x' closediff .. bufnum .. coda
	" undo, go to last state
	let last = '<cmd>call wheeltree#delta#last('
	execute map 'u' last .. bufnum .. coda
endfun
