" vim: set ft=vim fdm=indent iskeyword&:

" Frigate
"
" Native navigation, dedicated buffers

" ---- helpers

fun! wheeltree#frigate#generic (type)
	" Generic whirl buffer
	let type = a:type
	let Perspective = function('wheeltree#perspective#' .. type)
	let lines = Perspective ()
	if empty(lines)
		echomsg 'wheeltree frigate generic : empty lines in' type
		return v:false
	endif
	call wheeltree#mandala#blank (type)
	let settings = #{ function : 'wheeltree#line#' .. type }
	call wheeltree#river#template (settings)
	call wheeltree#mandala#fill(lines)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#frigate#' .. type)
endfun

" ---- buffers, tabs, windows

fun! wheeltree#frigate#buffer (scope = 'listed')
	" Buffers
	" To be run before opening the mandala buffer
	" Optional argument scope :
	"   - listed (default) : don't return unlisted buffers
	"   - all : also return unlisted buffers
	let scope = a:scope
	let lines = wheeltree#perspective#buffer (scope)
	if empty(lines)
		echomsg 'wheeltree frigate buffer : empty result'
		return v:false
	endif
	" mandala buffer
	if scope ==# 'listed'
		let type = 'buffer'
	elseif scope ==# 'all'
		let type = 'buffer/all'
	else
		echomsg 'wheeltree frigate buffer : bad optional argument'
		return []
	endif
	call wheeltree#mandala#blank (type)
	let settings = #{ function : 'wheeltree#line#buffer' }
	call wheeltree#river#template (settings)
	call wheeltree#mandala#fill(lines)
	" context menu
	call wheeltree#boomerang#launch_map (type)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#frigate#buffer', scope)
endfun

fun! wheeltree#frigate#tabwin_tree ()
	" Buffers visible in tree of tabs & wins
	" To be run before opening the mandala buffer
	let lines = wheeltree#perspective#tabwin_tree ()
	if empty(lines)
		echomsg 'wheeltree frigate tabwin tree : empty result'
		return v:false
	endif
	call wheeltree#mandala#blank ('tabwin/tree')
	let settings = #{ function : 'wheeltree#line#tabwin_tree' }
	call wheeltree#river#template (settings)
	call wheeltree#origami#folding_options ('tabwin_folding_text')
	call wheeltree#mandala#fill (lines)
	" properties
	let b:wheel_nature.is_treeish = v:true
	" full information
	let b:wheel_full = wheeltree#cuboctahedron#tabwin ()
	" reload
	call wheeltree#mandala#set_reload('wheeltree#frigate#tabwin_tree')
	" Context menu
	call wheeltree#boomerang#launch_map ('tabwin_tree')
endfun

fun! wheeltree#frigate#tabwin ()
	" Buffers visible in tabs & wins
	" To be run before opening the mandala buffer
	let lines = wheeltree#perspective#tabwin ()
	if empty(lines)
		echomsg 'wheeltree frigate tabwin : empty result'
		return v:false
	endif
	call wheeltree#mandala#blank ('tabwin')
	let settings = #{ function : 'wheeltree#line#tabwin' }
	call wheeltree#river#template (settings)
	call wheeltree#mandala#fill (lines)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#frigate#tabwin')
	" Context menu
	call wheeltree#boomerang#launch_map ('tabwin')
endfun

" ---- vim lists

fun! wheeltree#frigate#marker ()
	" Markers
	if wheeltree#cylinder#is_mandala ()
		call wheeltree#rectangle#goto_previous ()
	endif
	call wheeltree#frigate#generic('marker')
endfun

fun! wheeltree#frigate#jump ()
	" Jumps list
	if wheeltree#cylinder#is_mandala ()
		call wheeltree#rectangle#goto_previous ()
	endif
	let lines = wheeltree#perspective#jump ()
	if empty(lines)
		echomsg 'wheeltree frigate jump : empty result'
		return v:false
	endif
	" mandala buffer
	call wheeltree#mandala#blank ('jump')
	let settings = #{ function : 'wheeltree#line#jump' }
	call wheeltree#river#template (settings)
	call wheeltree#mandala#fill(lines)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#frigate#jump')
endfun

fun! wheeltree#frigate#change ()
	" Jumps list
	if wheeltree#cylinder#is_mandala ()
		call wheeltree#rectangle#goto_previous ()
	endif
	let lines = wheeltree#perspective#change ()
	if empty(lines)
		echomsg 'wheeltree frigate change : empty result'
		return v:false
	endif
	" mandala buffer
	call wheeltree#mandala#blank ('change')
	let settings = #{ function : 'wheeltree#line#change' }
	call wheeltree#river#template (settings)
	call wheeltree#mandala#fill(lines)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#frigate#change')
endfun

fun! wheeltree#frigate#tag ()
	" Tags file
	call wheeltree#frigate#generic('tag')
endfun

" ---- search files

fun! wheeltree#frigate#mru ()
	" Most recenty used files
	call wheeltree#frigate#generic('mru')
endfun

fun! wheeltree#frigate#locate (...)
	" Search files using locate
	if a:0 > 0
		let pattern = a:1
	else
		let prompt = 'Locate file matching : '
		let pattern = input(prompt)
	endif
	let lines = wheeltree#perspective#locate (pattern)
	if empty(lines)
		echomsg 'wheeltree frigate locate : no match found'
		return v:false
	endif
	call wheeltree#mandala#blank ('locate')
	let settings = #{ function : 'wheeltree#line#locate' }
	call wheeltree#river#template (settings)
	call wheeltree#mandala#fill(lines)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#frigate#locate', pattern)
endfun

fun! wheeltree#frigate#find (...)
	" Find files in current directory using **/*pattern* glob
	if a:0 > 0
		let pattern = a:1
	else
		let prompt = 'Find file matching : '
		let pattern = input(prompt)
	endif
	let lines = wheeltree#perspective#find (pattern)
	if empty(lines)
		echomsg 'wheeltree frigate find : no match found'
		return v:false
	endif
	call wheeltree#mandala#blank ('find')
	let settings = #{ function : 'wheeltree#line#find' }
	call wheeltree#river#template (settings)
	call wheeltree#mandala#fill(lines)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#frigate#find', pattern)
endfun

fun! wheeltree#frigate#async_find (...)
	" Search files in current directory using find in async job
	if ! has('unix')
		echomsg 'wheeltree async find : this function is only supported on Unix systems'
		return v:false
	endif
	if a:0 > 0
		let pattern = a:1
	else
		let prompt = 'Async find file matching : '
		let input = input(prompt)
		let input = escape(input, '*')
		let wordlist = split(input)
		let pattern = '*'
		for word in wordlist
			let pattern ..= word .. '*'
		endfor
	endif
	echomsg 'wheeltree async find : using pattern' pattern
	" mandala
	let settings = #{ function : 'wheeltree#line#find' }
	" job
	let command = ['find', '.', '-type', 'f', '-path', pattern]
	let settings = #{ mandala_type : 'async_find' }
	if has('nvim')
		let job = wheeltree#wave#start(command, settings)
	else
		let job = wheeltree#ripple#start(command, settings)
	endif
	let settings = #{ function : 'wheeltree#line#find' }
	call wheeltree#river#template (settings)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#frigate#async_find', pattern)
endfun

" ---- search inside files

fun! wheeltree#frigate#occur (...)
	" Lines matching pattern
	if a:0 > 0
		let pattern = a:1
	else
		let pattern = input('Lines matching pattern : ')
	endif
	if wheeltree#cylinder#is_mandala ()
		call wheeltree#rectangle#goto_previous ()
	endif
	" To be run before opening the mandala buffer
	let lines = wheeltree#perspective#occur (pattern)
	if empty(lines)
		echomsg 'wheeltree frigate occur : no match found'
		return v:false
	endif
	let filetype = &l:filetype
	call wheeltree#mandala#blank ('occur')
	let &l:filetype = filetype
	let settings = #{ function : 'wheeltree#line#occur' }
	call wheeltree#river#template (settings)
	call wheeltree#mandala#fill (lines)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#frigate#occur', pattern)
endfun

fun! wheeltree#frigate#grep (...)
	" Grep results
	if a:0 > 0
		let pattern = a:1
	else
		let pattern = input('Grep circle files for pattern : ')
	endif
	if a:0 > 1
		let sieve = a:2
	else
		let sieve = '\m.'
	endif
	let lines = wheeltree#perspective#grep (pattern, sieve)
	if empty(lines)
		echomsg 'wheeltree frigate grep : no match found'
		return v:false
	endif
	if wheeltree#cylinder#is_mandala ()
		call wheeltree#rectangle#goto_previous ()
	endif
	let word = substitute(pattern, '\W.*', '', '')
	call wheeltree#mandala#blank ('grep/' .. word)
	let settings = #{ function : 'wheeltree#line#grep' }
	call wheeltree#river#template (settings)
	call wheeltree#mandala#fill (lines)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#frigate#grep', pattern, sieve)
	" Context menu
	call wheeltree#boomerang#launch_map ('grep')
	" Useful if we choose edit mode on the context menu
	let b:wheel_settings.pattern = pattern
	let b:wheel_settings.sieve = sieve
	return lines
endfun

fun! wheeltree#frigate#outline (...)
	" Outline fold headers
	if a:0 > 0
		let mode = a:1
	else
		let prompt = 'Outline mode ? '
		let mode = confirm(prompt, "&Folds\n&Markdown\n&Org mode\nVimwiki", 1)
	endif
	if mode == 1
		let marker = split(&l:foldmarker, ',')[0]
		let grep_ex_command = g:wheeltree_config.grep
		if grep_ex_command =~ '^:\?grep' && &grepprg !~ '^grep'
			let marker = escape(marker, '{')
		endif
		let lines = wheeltree#frigate#grep (marker)
	elseif mode == 2
		let lines = wheeltree#frigate#grep ('^#', '\.md$')
	elseif mode == 3
		let lines = wheeltree#frigate#grep ('^\*', '\.org$')
	elseif mode == 4
		let lines = wheeltree#frigate#grep ('^=.*=$', '\.wiki$')
	endif
	if ! empty(lines)
		call wheeltree#mandala#set_type ('outline')
		" reload
		call wheeltree#mandala#set_reload('wheeltree#frigate#outline', mode)
	endif
endfun
