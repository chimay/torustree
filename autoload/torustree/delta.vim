" vim: set ft=vim fdm=indent iskeyword&:

" Delta
"
" Undo list & diff

" ---- undo state

fun! torustree#delta#undo_iden (...)
	" Return undo iden at current or given line
	if a:0 > 0
		let linum = a:1
	else
		let linum = '.'
	endif
	if linum ==# '.'
		call torustree#teapot#filter_to_default_line ()
	elseif linum == 1
		let linum = torustree#teapot#first_data_line ()
	endif
	let line = getline(linum)
	let fields = split(line)
	let iden = str2nr(fields[0])
	return iden
endfun

fun! torustree#delta#earlier (bufnum)
	" Go to earlier state
	call torustree#rectangle#find_or_load (a:bufnum)
	earlier
	call torustree#cylinder#recall ()
endfun

fun! torustree#delta#later (bufnum)
	" Go to later state
	call torustree#rectangle#find_or_load (a:bufnum)
	later
	call torustree#cylinder#recall ()
endfun

fun! torustree#delta#last (bufnum)
	" Set buffer to last undo state
	if has_key(b:wheel_settings, 'undo_iden')
		let iden = b:wheel_settings.undo_iden
	else
		let iden = torustree#delta#undo_iden (1)
	endif
	call torustree#rectangle#find_or_load (a:bufnum)
	execute 'undo' iden
	call torustree#cylinder#recall ()
endfun

" ---- diff windows

fun! torustree#delta#close_diff (bufnum)
	" Wipe copy or original buffer
	let diff_buf = b:wheel_settings.diff_buf
	execute 'silent bwipe!' diff_buf
	call torustree#rectangle#find_or_load (a:bufnum)
	diffoff
	call torustree#cylinder#recall ()
endfun

" ---- maps

fun! torustree#delta#mappings ()
	" Maps for undo list mandala
	let bufnum = b:wheel_related.bufnum
	let map = 'nnoremap <buffer>'
	let coda = ')<cr>'
	" earlier or later
	let earlier = '<cmd>call torustree#delta#earlier('
	execute map '-' earlier .. bufnum .. coda
	execute map '<kminus>' earlier .. bufnum .. coda
	let later = '<cmd>call torustree#delta#later('
	execute map '+' later .. bufnum .. coda
	execute map '<kplus>' later .. bufnum .. coda
	" go to undo given by line
	let undolist = '<cmd>call torustree#line#undolist('
	execute map '<cr>' undolist .. bufnum .. coda
	" view diff between undo state and last one
	let undodiff = '<cmd>call torustree#line#undo_diff('
	" d does not work for it puts vim in operator pending mode
	execute map 'D' undodiff .. bufnum .. coda
	" close diff
	let closediff = '<cmd>call torustree#delta#close_diff('
	execute map 'x' closediff .. bufnum .. coda
	" undo, go to last state
	let last = '<cmd>call torustree#delta#last('
	execute map 'u' last .. bufnum .. coda
endfun
