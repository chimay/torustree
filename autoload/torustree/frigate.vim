" vim: set ft=vim fdm=indent iskeyword&:

" Frigate
"
" Native navigation, dedicated buffers

" ---- helpers

fun! torustree#frigate#generic (type)
	" Generic whirl buffer
	let type = a:type
	let Perspective = function('torustree#perspective#' .. type)
	let lines = Perspective ()
	if empty(lines)
		echomsg 'torustree frigate generic : empty lines in' type
		return v:false
	endif
	call torustree#mandala#blank (type)
	let settings = #{ function : 'torustree#line#' .. type }
	call torustree#river#template (settings)
	call torustree#mandala#fill(lines)
	" reload
	call torustree#mandala#set_reload('torustree#frigate#' .. type)
endfun

" ---- buffers, tabs, windows

fun! torustree#frigate#buffer (scope = 'listed')
	" Buffers
	" To be run before opening the mandala buffer
	" Optional argument scope :
	"   - listed (default) : don't return unlisted buffers
	"   - all : also return unlisted buffers
	let scope = a:scope
	let lines = torustree#perspective#buffer (scope)
	if empty(lines)
		echomsg 'torustree frigate buffer : empty result'
		return v:false
	endif
	" mandala buffer
	if scope ==# 'listed'
		let type = 'buffer'
	elseif scope ==# 'all'
		let type = 'buffer/all'
	else
		echomsg 'torustree frigate buffer : bad optional argument'
		return []
	endif
	call torustree#mandala#blank (type)
	let settings = #{ function : 'torustree#line#buffer' }
	call torustree#river#template (settings)
	call torustree#mandala#fill(lines)
	" context menu
	call torustree#boomerang#launch_map (type)
	" reload
	call torustree#mandala#set_reload('torustree#frigate#buffer', scope)
endfun

fun! torustree#frigate#tabwin_tree ()
	" Buffers visible in tree of tabs & wins
	" To be run before opening the mandala buffer
	let lines = torustree#perspective#tabwin_tree ()
	if empty(lines)
		echomsg 'torustree frigate tabwin tree : empty result'
		return v:false
	endif
	call torustree#mandala#blank ('tabwin/tree')
	let settings = #{ function : 'torustree#line#tabwin_tree' }
	call torustree#river#template (settings)
	call torustree#origami#folding_options ('tabwin_folding_text')
	call torustree#mandala#fill (lines)
	" properties
	let b:wheel_nature.is_treeish = v:true
	" full information
	let b:wheel_full = torustree#cuboctahedron#tabwin ()
	" reload
	call torustree#mandala#set_reload('torustree#frigate#tabwin_tree')
	" Context menu
	call torustree#boomerang#launch_map ('tabwin_tree')
endfun

fun! torustree#frigate#tabwin ()
	" Buffers visible in tabs & wins
	" To be run before opening the mandala buffer
	let lines = torustree#perspective#tabwin ()
	if empty(lines)
		echomsg 'torustree frigate tabwin : empty result'
		return v:false
	endif
	call torustree#mandala#blank ('tabwin')
	let settings = #{ function : 'torustree#line#tabwin' }
	call torustree#river#template (settings)
	call torustree#mandala#fill (lines)
	" reload
	call torustree#mandala#set_reload('torustree#frigate#tabwin')
	" Context menu
	call torustree#boomerang#launch_map ('tabwin')
endfun

" ---- vim lists

fun! torustree#frigate#marker ()
	" Markers
	if torustree#cylinder#is_mandala ()
		call torustree#rectangle#goto_previous ()
	endif
	call torustree#frigate#generic('marker')
endfun

fun! torustree#frigate#jump ()
	" Jumps list
	if torustree#cylinder#is_mandala ()
		call torustree#rectangle#goto_previous ()
	endif
	let lines = torustree#perspective#jump ()
	if empty(lines)
		echomsg 'torustree frigate jump : empty result'
		return v:false
	endif
	" mandala buffer
	call torustree#mandala#blank ('jump')
	let settings = #{ function : 'torustree#line#jump' }
	call torustree#river#template (settings)
	call torustree#mandala#fill(lines)
	" reload
	call torustree#mandala#set_reload('torustree#frigate#jump')
endfun

fun! torustree#frigate#change ()
	" Jumps list
	if torustree#cylinder#is_mandala ()
		call torustree#rectangle#goto_previous ()
	endif
	let lines = torustree#perspective#change ()
	if empty(lines)
		echomsg 'torustree frigate change : empty result'
		return v:false
	endif
	" mandala buffer
	call torustree#mandala#blank ('change')
	let settings = #{ function : 'torustree#line#change' }
	call torustree#river#template (settings)
	call torustree#mandala#fill(lines)
	" reload
	call torustree#mandala#set_reload('torustree#frigate#change')
endfun

fun! torustree#frigate#tag ()
	" Tags file
	call torustree#frigate#generic('tag')
endfun

" ---- search files

fun! torustree#frigate#mru ()
	" Most recenty used files
	call torustree#frigate#generic('mru')
endfun

fun! torustree#frigate#locate (...)
	" Search files using locate
	if a:0 > 0
		let pattern = a:1
	else
		let prompt = 'Locate file matching : '
		let pattern = input(prompt)
	endif
	let lines = torustree#perspective#locate (pattern)
	if empty(lines)
		echomsg 'torustree frigate locate : no match found'
		return v:false
	endif
	call torustree#mandala#blank ('locate')
	let settings = #{ function : 'torustree#line#locate' }
	call torustree#river#template (settings)
	call torustree#mandala#fill(lines)
	" reload
	call torustree#mandala#set_reload('torustree#frigate#locate', pattern)
endfun

fun! torustree#frigate#find (...)
	" Find files in current directory using **/*pattern* glob
	if a:0 > 0
		let pattern = a:1
	else
		let prompt = 'Find file matching : '
		let pattern = input(prompt)
	endif
	let lines = torustree#perspective#find (pattern)
	if empty(lines)
		echomsg 'torustree frigate find : no match found'
		return v:false
	endif
	call torustree#mandala#blank ('find')
	let settings = #{ function : 'torustree#line#find' }
	call torustree#river#template (settings)
	call torustree#mandala#fill(lines)
	" reload
	call torustree#mandala#set_reload('torustree#frigate#find', pattern)
endfun

fun! torustree#frigate#async_find (...)
	" Search files in current directory using find in async job
	if ! has('unix')
		echomsg 'torustree async find : this function is only supported on Unix systems'
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
	echomsg 'torustree async find : using pattern' pattern
	" mandala
	let settings = #{ function : 'torustree#line#find' }
	" job
	let command = ['find', '.', '-type', 'f', '-path', pattern]
	let settings = #{ mandala_type : 'async_find' }
	if has('nvim')
		let job = torustree#wave#start(command, settings)
	else
		let job = torustree#ripple#start(command, settings)
	endif
	let settings = #{ function : 'torustree#line#find' }
	call torustree#river#template (settings)
	" reload
	call torustree#mandala#set_reload('torustree#frigate#async_find', pattern)
endfun

" ---- search inside files

fun! torustree#frigate#occur (...)
	" Lines matching pattern
	if a:0 > 0
		let pattern = a:1
	else
		let pattern = input('Lines matching pattern : ')
	endif
	if torustree#cylinder#is_mandala ()
		call torustree#rectangle#goto_previous ()
	endif
	" To be run before opening the mandala buffer
	let lines = torustree#perspective#occur (pattern)
	if empty(lines)
		echomsg 'torustree frigate occur : no match found'
		return v:false
	endif
	let filetype = &l:filetype
	call torustree#mandala#blank ('occur')
	let &l:filetype = filetype
	let settings = #{ function : 'torustree#line#occur' }
	call torustree#river#template (settings)
	call torustree#mandala#fill (lines)
	" reload
	call torustree#mandala#set_reload('torustree#frigate#occur', pattern)
endfun

fun! torustree#frigate#grep (...)
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
	let lines = torustree#perspective#grep (pattern, sieve)
	if empty(lines)
		echomsg 'torustree frigate grep : no match found'
		return v:false
	endif
	if torustree#cylinder#is_mandala ()
		call torustree#rectangle#goto_previous ()
	endif
	let word = substitute(pattern, '\W.*', '', '')
	call torustree#mandala#blank ('grep/' .. word)
	let settings = #{ function : 'torustree#line#grep' }
	call torustree#river#template (settings)
	call torustree#mandala#fill (lines)
	" reload
	call torustree#mandala#set_reload('torustree#frigate#grep', pattern, sieve)
	" Context menu
	call torustree#boomerang#launch_map ('grep')
	" Useful if we choose edit mode on the context menu
	let b:wheel_settings.pattern = pattern
	let b:wheel_settings.sieve = sieve
	return lines
endfun

fun! torustree#frigate#outline (...)
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
		let lines = torustree#frigate#grep (marker)
	elseif mode == 2
		let lines = torustree#frigate#grep ('^#', '\.md$')
	elseif mode == 3
		let lines = torustree#frigate#grep ('^\*', '\.org$')
	elseif mode == 4
		let lines = torustree#frigate#grep ('^=.*=$', '\.wiki$')
	endif
	if ! empty(lines)
		call torustree#mandala#set_type ('outline')
		" reload
		call torustree#mandala#set_reload('torustree#frigate#outline', mode)
	endif
endfun
