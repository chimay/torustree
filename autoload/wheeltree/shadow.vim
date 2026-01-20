" vim: set ft=vim fdm=indent iskeyword&:

" Shadow
"
" Refactoring, dedicated buffers

" ---- grep edit

fun! wheeltree#shadow#grep_edit (...)
	" Grep in edit mode
	" ---- arguments
	if a:0 > 0
		let pattern = a:1
	else
		if wheeltree#boomerang#is_context_menu ()
			let settings = wheeltree#book#previous ('settings')
			let pattern = settings.pattern
		else
			let pattern = input('Grep circle files for pattern [edit mode] : ')
		endif
	endif
	if a:0 > 1
		let sieve = a:2
	else
		if wheeltree#boomerang#is_context_menu ()
			let settings = wheeltree#book#previous ('settings')
			let sieve = settings.sieve
		else
			let sieve = '\m.'
		endif
	endif
	" ---- lines
	let lines = wheeltree#perspective#grep (pattern, sieve)
	" ---- pre-checks
	if empty(lines)
		echomsg 'wheeltree shape grep edit : no match found'
		return v:false
	endif
	" ---- mandala
	call wheeltree#mandala#blank ('grep/edit')
	call wheeltree#mandala#common_maps ()
	call wheeltree#polyphony#temple ()
	call wheeltree#polyphony#score ('grep_edit')
	call wheeltree#mandala#fill (lines)
	" ---- reload
	call wheeltree#mandala#set_reload('wheeltree#shadow#grep_edit', pattern, sieve)
	" ---- coda
	echomsg 'adding or removing lines is not supported'
	return lines
endfun

" ---- narrow

fun! wheeltree#shadow#narrow_file_operator (argument = '')
	" Operator waiting for a movement or text object to select range
	" Use in a map like this :
	"   map <expr> <mykey> wheeltree#shadow#narrow_file_operator()
	let argument = a:argument
	" -- when called to find the rhs of the map
	if argument ==# ''
		set operatorfunc=wheeltree#shadow#narrow_file_operator
		return 'g@'
	endif
	" -- when called to execute wheeltree#shadow#narrow_file_operator
	" -- then, argument is 'line', 'block' or 'char'
	let first = line("'[")
	let last = line("']")
	call wheeltree#shadow#narrow_file (first, last)
endfun

fun! wheeltree#shadow#narrow_file (...) range
	" Lines matching pattern in current file
	call wheeltree#mandala#goto_related ()
	" 0 or 2 optional arguments
	if a:0 > 1
		let first = a:1
		let last = a:2
	else
		let first = a:firstline
		let last = a:lastline
	endif
	if first == last
		" assume the user does not launch it just for one line
		let range = input('Range of line to narrow ? ')
		if empty(range)
			let rangelist = [1, line('$')]
		endif
		for separ in [',', ';', ':', '-', ' ']
			if range =~ separ
				let rangelist = split(range, separ)
				break
			endif
		endfor
		let first = str2nr(rangelist[0])
		let last = str2nr(rangelist[1])
	endif
	" -- lines
	let lines = wheeltree#perspective#narrow_file (first, last)
	" -- pre op buffer
	let bufnum = bufnr('%')
	let filename = bufname(bufnum)
	let filename = fnamemodify(filename, ':t')
	let filetype = &l:filetype
	" -- mandala
	call wheeltree#mandala#blank ('narrow/file/' .. filename)
	let &l:filetype = filetype
	call wheeltree#mandala#common_maps ()
	let settings = #{
				\ function : 'wheeltree#line#narrow_file',
				\ bufnum : b:wheel_related.bufnum
				\ }
	call wheeltree#polyphony#template (settings)
	call wheeltree#polyphony#action_maps ('file')
	call wheeltree#polyphony#score ('narrow_file')
	call wheeltree#mandala#fill (lines)
	" -- settings
	let b:wheel_settings = settings
	" -- reload
	call wheeltree#mandala#set_reload('wheeltree#shadow#narrow_file', first, last)
endfun

fun! wheeltree#shadow#narrow_circle (...)
	" Lines matching pattern in all circle files
	" Like grep but with filter & edit
	if a:0 > 0
		let pattern = a:1
	else
		let pattern = input('Narrow circle files with pattern : ')
	endif
	if a:0 > 1
		let sieve = a:2
	else
		let sieve = '\m.'
	endif
	" ---- lines
	let lines = wheeltree#perspective#narrow_circle (pattern, sieve)
	" ---- pre-checks
	if empty(lines)
		echomsg 'wheeltree narrow circle : no match found'
		return v:false
	endif
	" ---- mandala
	let word = substitute(pattern, '\W.*', '', '')
	call wheeltree#mandala#blank ('narrow/circle/' .. word)
	call wheeltree#mandala#common_maps ()
	let settings = #{
				\ function : 'wheeltree#line#narrow_circle',
				\ pattern : pattern,
				\ }
	call wheeltree#polyphony#template (settings)
	call wheeltree#polyphony#action_maps ('circle')
	call wheeltree#polyphony#score ('narrow_circle')
	call wheeltree#mandala#fill (lines)
	" ---- settings
	let b:wheel_settings = settings
	" ---- reload
	call wheeltree#mandala#set_reload('wheeltree#shadow#narrow_circle', pattern, sieve)
	echomsg 'adding or removing lines is not supported'
endfun
