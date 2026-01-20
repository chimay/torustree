" vim: set ft=vim fdm=indent iskeyword&:

" Vector
"
" Batch
" Grep
" Quickfix

" ---- script constants

if exists('s:field_separ')
	unlockvar s:field_separ
endif
let s:field_separ = wheeltree#crystal#fetch('separator/field')
lockvar s:field_separ

" ---- helpers

fun! wheeltree#vector#files (sieve)
	" Current circle files
	" Filter files with sieve
	let sieve = a:sieve
	if sieve !~ '^\\m'
		let sieve = '\m' .. sieve
	endif
	if wheeltree#referen#is_empty ('circle')
		return []
	endif
	" Locations files
	let locations = deepcopy(wheeltree#referen#circle().locations)
	let files = locations->map({ _, val -> fnameescape(val.file) })
	let directory = '\m^' .. getcwd() .. '/'
	eval files->map({ _, path -> substitute(path, directory, '', '') })
	" Filter with sieve
	eval files->filter({ _, val -> val =~ sieve })
	" Done
	return files
endfun

" ---- arg list

fun! wheeltree#vector#reset ()
	" Reset argument list
	if argc() == 0
		return v:true
	endif
	let confirm = confirm('Overwrite old argument list ?', "&Yes\n&No", 2)
	if confirm != 1
		return v:false
	endif
	% argdelete
	return v:true
endfun

fun! wheeltree#vector#argadd (sieve)
	" Add files of current circle to arguments
	" Filter files with sieve
	let yield = wheeltree#vector#reset ()
	if yield
		let files = wheeltree#vector#files (a:sieve)
		execute 'argadd' join(files)
	endif
	return yield
endfun

fun! wheeltree#vector#argdo (command, ...)
	" Execute command on each location of the circle
	" Filter files with optional argument
	if a:0 > 0
		let sieve = a:1
	else
		let sieve = '\m.'
	endif
	let command = a:command
	let yield = wheeltree#vector#argadd (sieve)
	if yield
		let runme = 'silent! argdo ' .. command
		let output = execute(runme)
		let output = split(output, '\n')
		let type = 'batch/' .. split(command)[0]
		call wheeltree#mandala#blank(type)
		call wheeltree#mandala#common_maps ()
		call wheeltree#mandala#fill (output)
		setlocal nofoldenable
	endif
endfun

fun! wheeltree#vector#batch (...)
	" Interactive wrapper for wheeltree#vector#argdo
	if a:0 > 0
		let command = a:1
	else
		let command = input('Batch :ex or !shell command : ')
	endif
	call wheeltree#vector#argdo(command)
endfun

" ---- grep

fun! wheeltree#vector#grep (pattern, ...)
	" Grep in all files of circle
	" Filter files with optional argument
	if a:0 > 0
		let sieve = a:1
	else
		let sieve = '\m.'
	endif
	let pattern = a:pattern
	let pattern = escape(pattern, '#')
	let files = wheeltree#vector#files (sieve)
	if empty(files)
		echomsg 'wheeltree vector grep : no file matching filter'
		return v:false
	endif
	" File list as string
	let files = join(files)
	" Quote if needed
	if pattern !~ "'"
		let pattern = "'" .. pattern .. "'"
	elseif pattern !~ '"'
		let pattern = '"' .. pattern .. '"'
	endif
	" Run grep
	let grep = g:wheeltree_config.grep
	if ! wheeltree#chain#is_inside(grep, ['grep', 'vimgrep'])
		echoerr 'wheeltree vector grep : bad g:wheeltree_config.grep value'
		return v:false
	endif
	let grep ..= '!'
	" do not jump to first pattern
	if grep ==# 'vimgrep'
		let pattern ..= 'j'
	endif
	execute 'silent!' grep pattern files
	return v:true
endfun

fun! wheeltree#vector#copen ()
	" Open quickfix with a golden ratio
	let height = float2nr(wheeltree#spiral#height ())
	execute 'copen' height
endfun

" ---- propagate changes in quickfix

fun! wheeltree#vector#cdo (newlines)
	" Apply change of current line in grep edit mode
	let newlines = a:newlines
	if ! empty(newlines)
		let line = remove(newlines, 0)
		call setline('.', line)
	else
		echomsg 'wheeltree cdo : quickfix list is prematurely empty'
	endif
endfun
