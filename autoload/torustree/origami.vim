" vim: set ft=vim fdm=indent iskeyword&:

" Origami
"
" Folding

" ---- script constants

if exists('s:fold_markers')
	unlockvar s:fold_markers
endif
let s:fold_markers = torustree#crystal#fetch('fold/markers')
let s:fold_markers = join(s:fold_markers, ',')
lockvar s:fold_markers

" ---- helpers

fun! torustree#origami#open ()
	" Open all folds
	setlocal foldlevel=2
endfun

fun! torustree#origami#close ()
	" Close all folds
	setlocal foldlevel=0
endfun

fun! torustree#origami#view_cursor ()
	" Unfold to view cursor line
	let cursor_level = foldlevel(line('.'))
	let file_level = &l:foldlevel
	if cursor_level <= 1
		call torustree#origami#close ()
	elseif &foldopen =~ 'jump'
		normal! zv
	endif
endfun

" ---- mandalas

fun! torustree#origami#folding_options (textfun = 'folding_text')
	" Folding options for mandala buffers
	let textfun = a:textfun
	setlocal foldenable
	setlocal foldminlines=1
	setlocal foldlevel=0
	setlocal foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
	setlocal foldclose=
	setlocal foldmethod=marker
	let &l:foldmarker = s:fold_markers
	setlocal foldcolumn=2
	execute 'setlocal foldtext=torustree#origami#' .. textfun .. '()'
endfun

fun! torustree#origami#folding_text ()
	" Folding text for mandala buffers
	let numlines = v:foldend - v:foldstart
	let line = getline(v:foldstart)
	if v:foldlevel == 1
		let level = 'torus'
	elseif v:foldlevel == 2
		let level = 'circle'
	elseif v:foldlevel == 3
		let level = 'location'
	else
		let level = 'none'
	endif
	let marker = s:fold_markers[0]
	let pattern = '\m' .. marker .. '[12]'
	let repl = ':: ' .. level
	let line = substitute(line, pattern, repl, '')
	let text = line .. ' :: ' .. numlines .. ' lines ' .. v:folddashes
	return text
endfun

fun! torustree#origami#tabwin_folding_text ()
	" Folding text for mandala buffers
	let numlines = v:foldend - v:foldstart
	let line = getline(v:foldstart)
	let marker = s:fold_markers[0]
	let pattern = '\m ' .. marker .. '[12]'
	let repl = ''
	let line = substitute(line, pattern, repl, '')
	let text = line .. ' :: ' .. numlines .. ' lines ' .. v:folddashes
	return text
endfun

" ---- suspend & resume during heavy functions that does not need it

fun! torustree#origami#suspend ()
	" Suspend expr folding
	if ! exists('b:torustree')
		let b:torustree = {}
		let b:torustree.foldmethod = {}
		let b:torustree.foldmethod.locked = v:false
	endif
	if b:torustree.foldmethod.locked
		return v:false
	endif
	let b:torustree.foldmethod.value = &l:foldmethod
	let b:torustree.foldmethod.locked = v:true
	let &l:foldmethod = 'manual'
	return v:true
endfun

fun! torustree#origami#resume ()
	" Resume expr folding
	if ! exists('b:torustree')
		echomsg 'torustree origami resume : b:torustree does not exist'
		return v:false
	endif
	let &l:foldmethod = b:torustree.foldmethod.value
	let b:torustree.foldmethod.locked = v:false
	return v:true
endfun
