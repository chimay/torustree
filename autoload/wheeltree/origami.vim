" vim: set ft=vim fdm=indent iskeyword&:

" Origami
"
" Folding

" ---- script constants

if exists('s:fold_markers')
	unlockvar s:fold_markers
endif
let s:fold_markers = wheeltree#crystal#fetch('fold/markers')
let s:fold_markers = join(s:fold_markers, ',')
lockvar s:fold_markers

" ---- helpers

fun! wheeltree#origami#open ()
	" Open all folds
	setlocal foldlevel=2
endfun

fun! wheeltree#origami#close ()
	" Close all folds
	setlocal foldlevel=0
endfun

fun! wheeltree#origami#view_cursor ()
	" Unfold to view cursor line
	let cursor_level = foldlevel(line('.'))
	let file_level = &l:foldlevel
	if cursor_level <= 1
		call wheeltree#origami#close ()
	elseif &foldopen =~ 'jump'
		normal! zv
	endif
endfun

" ---- mandalas

fun! wheeltree#origami#folding_options (textfun = 'folding_text')
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
	execute 'setlocal foldtext=wheeltree#origami#' .. textfun .. '()'
endfun

fun! wheeltree#origami#folding_text ()
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

fun! wheeltree#origami#tabwin_folding_text ()
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

fun! wheeltree#origami#suspend ()
	" Suspend expr folding
	if ! exists('b:wheeltree')
		let b:wheeltree = {}
		let b:wheeltree.foldmethod = {}
		let b:wheeltree.foldmethod.locked = v:false
	endif
	if b:wheeltree.foldmethod.locked
		return v:false
	endif
	let b:wheeltree.foldmethod.value = &l:foldmethod
	let b:wheeltree.foldmethod.locked = v:true
	let &l:foldmethod = 'manual'
	return v:true
endfun

fun! wheeltree#origami#resume ()
	" Resume expr folding
	if ! exists('b:wheeltree')
		echomsg 'wheeltree origami resume : b:wheeltree does not exist'
		return v:false
	endif
	let &l:foldmethod = b:wheeltree.foldmethod.value
	let b:wheeltree.foldmethod.locked = v:false
	return v:true
endfun
