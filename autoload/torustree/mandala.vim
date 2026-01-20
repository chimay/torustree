" vim: set ft=vim fdm=indent iskeyword&:

" Mandala
"
" Generic torustree dedicated buffers = mandala buffers
"
" A mandala is made of lines, like a buffer
"
" Sane defaults : may be overriden by more specific buffers
"
" Search, Filter
" Select
" Trigger action

" ---- script constants

if exists('s:map_keys')
	unlockvar s:map_keys
endif
let s:map_keys = torustree#crystal#fetch('map/keys')
lockvar s:map_keys

if exists('s:mandala_autocmds_group')
	unlockvar s:mandala_autocmds_group
endif
let s:mandala_autocmds_group = torustree#crystal#fetch('mandala/autocmds/group')
lockvar s:mandala_autocmds_group

if exists('s:mandala_autocmds_events')
	unlockvar s:mandala_autocmds_events
endif
let s:mandala_autocmds_events = torustree#crystal#fetch('mandala/autocmds/events')
lockvar s:mandala_autocmds_events

if exists('s:mandala_vars')
	unlockvar s:mandala_vars
endif
let s:mandala_vars = torustree#crystal#fetch('mandala/vars')
lockvar s:mandala_vars

" ---- init

fun! torustree#mandala#init ()
	" Init mandala buffer variables
	" -- general qualities
	if ! exists('b:wheel_nature')
		let b:wheel_nature = {}
		let b:wheel_nature.empty = v:true
		let b:wheel_nature.class = 'generic'
		let b:wheel_nature.type = 'empty'
		let b:wheel_nature.is_treeish = v:false
		let b:wheel_nature.is_writable = v:false
		let b:wheel_nature.has_filter = v:false
		let b:wheel_nature.has_selection = v:false
		let b:wheel_nature.has_preview = v:false
		let b:wheel_nature.has_navigation = v:false
	endif
	" -- related buffer
	if ! exists('b:wheel_related')
		let b:wheel_related = {}
		let b:wheel_related.tabnum = 'undefined'
		let b:wheel_related.winum = 'undefined'
		let b:wheel_related.winiden = 'undefined'
		let b:wheel_related.bufnum = 'undefined'
	endif
	" -- all original lines
	if ! exists('b:wheel_lines')
		let b:wheel_lines = []
	endif
	" -- all original full information
	" -- useful for treeish buffers
	if ! exists('b:wheel_full')
		let b:wheel_full = []
	endif
	" -- filter
	if ! exists('b:wheel_filter')
		let b:wheel_filter = {}
		let b:wheel_filter.words = []
		let b:wheel_filter.indexes = []
		let b:wheel_filter.lines = []
	endif
	" -- selection
	if ! exists('b:wheel_selection')
		let b:wheel_selection = {}
		let b:wheel_selection.indexes = []
		let b:wheel_selection.components = []
	endif
	" -- preview
	if ! exists('b:wheel_preview')
		let b:wheel_preview = {}
		let b:wheel_preview.used = v:false
		let b:wheel_preview.follow = v:false
		let b:wheel_preview.original = {}
	endif
	" -- settings for action on line
	if ! exists('b:wheel_settings')
		let b:wheel_settings = {}
	endif
	" -- reload function
	if ! exists('b:wheel_reload')
		let b:wheel_reload = ''
	endif
	" -- leaf ring
	call torustree#book#init ()
endfun

" ---- refresh

fun! torustree#mandala#refresh ()
	" Refresh mandala buffer : unfilter & deselect all
	" e.g. when reloading
	" -- filter
	let b:wheel_filter = {}
	let b:wheel_filter.words = []
	let b:wheel_filter.indexes = []
	let b:wheel_filter.lines = []
	" -- selection
	let b:wheel_selection = {}
	let b:wheel_selection.indexes = []
	let b:wheel_selection.components = []
endfun

" ---- wrap

fun! torustree#mandala#wrap_up ()
	" Line up, or line 1 -> end of file
	" If fold is closed, take the first line of it
	if &l:foldenable
		let line = foldclosed('.')
		if line < 0
			let line = line('.')
		endif
	else
		let line = line('.')
	endif
	" Wrap
	if line == 1
		call cursor(line('$'), 1)
	else
		normal! k
	endif
	if ! torustree#cylinder#is_mandala ()
		" can also be mapped in regular buffer
		return v:true
	endif
	if b:wheel_preview.follow
		call torustree#orbiter#preview ()
	endif
	return v:true
endfun

fun! torustree#mandala#wrap_down ()
	" Line down, or line end of file -> 1
	" If fold is closed, take the last line of it
	if &l:foldenable
		let line = foldclosedend('.')
		if line < 0
			let line = line('.')
		endif
	else
		let line = line('.')
	endif
	if line == line('$')
		call cursor(1, 1)
	else
		normal! j
	endif
	if ! torustree#cylinder#is_mandala ()
		" can also be mapped in regular buffer
		return v:true
	endif
	if b:wheel_preview.follow
		call torustree#orbiter#preview ()
	endif
	return v:true
endfun

" ---- nature

fun! torustree#mandala#is_empty ()
	" Whether mandala is empty
	return b:wheel_nature.empty
endfun

fun! torustree#mandala#type ()
	" Type of a mandala buffer
	return b:wheel_nature.type
endfun

" ---- clearing things

fun! torustree#mandala#clear_options ()
	" Clear mandala local options
	setlocal nofoldenable
endfun

fun! torustree#mandala#clear_maps ()
	" Clear mandala local maps
	call torustree#ouroboros#unmap(s:map_keys)
endfun

fun! torustree#mandala#clear_autocmds ()
	" Clear mandala local autocommands
	let group = s:mandala_autocmds_group
	let events = s:mandala_autocmds_events
	call torustree#ouroboros#clear_autocmds (group, events)
endfun

fun! torustree#mandala#clear_vars ()
	" Clear mandala local variables, except the leaves ring
	call torustree#ouroboros#unlet (s:mandala_vars)
endfun

fun! torustree#mandala#clear ()
	" Clear mandala
	" -- clear state
	call torustree#mandala#clear_options ()
	call torustree#mandala#clear_maps ()
	call torustree#mandala#clear_autocmds ()
	call torustree#mandala#clear_vars ()
	" -- clear lines
	call torustree#mandala#unlock ()
	call torustree#gear#delete (1, '$')
	call torustree#mandala#lock ()
	" -- init vars
	call torustree#mandala#init ()
endfun

" ---- mandala type

fun! torustree#mandala#set_type (type)
	" Set mandala type
	let type = a:type
	let b:wheel_nature.type = type
	if type ==# 'empty'
		let b:wheel_nature.empty = v:true
	else
		let b:wheel_nature.empty = v:false
		call torustree#cylinder#update_type ()
	endif
endfun

" ---- related buffer

fun! torustree#mandala#guess_related ()
	" Guess related buffer
	if torustree#cylinder#is_mandala ()
		return torustree#rectangle#previous ()
	endif
	let related = {}
	let related.tabnum = tabpagenr()
	let related.winum = winnr()
	let related.winiden = win_getid()
	let related.bufnum = bufnr('%')
	return related
endfun

fun! torustree#mandala#goto_related ()
	" Go to window of related buffer if visible, or edit it in first window of tab
	" optional argument :
	"   - buffer number
	"   - default : related buffer number
	" if no optional argument and no related buffer : go to previous window
	if ! torustree#cylinder#is_mandala ()
		return v:false
	endif
	let bufnum = b:wheel_related.bufnum
	if bufnum ==# 'undefined'
		wincmd p
		return 'undefined'
	endif
	call torustree#rectangle#find_or_load (bufnum)
	return bufnum
endfun

" ---- options

fun! torustree#mandala#unlock ()
	" Set local options to be able to edit mandala
	setlocal noreadonly
	setlocal modifiable
endfun

fun! torustree#mandala#lock ()
	" Set local options to prevent mandala edition
	setlocal readonly
	setlocal nomodifiable
endfun

fun! torustree#mandala#post_edit (lock = 'lock')
	" Restore local options after edition
	"   Optional argument :
	"   - lock : relock if not writable
	"   - dont-lock : don't lock
	let lock = a:lock
	if lock ==# 'dont-lock'
		return v:true
	endif
	if ! torustree#polyphony#is_writable ()
		call torustree#mandala#lock ()
	endif
	return v:true
endfun

fun! torustree#mandala#common_options ()
	" Set local common options
	setlocal filetype=torustree
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal nobuflisted
	setlocal noswapfile
	setlocal cursorline
	setlocal nofoldenable
	" non writable by default
	call torustree#mandala#lock ()
endfun

" ---- mappings

fun! torustree#mandala#common_maps ()
	" Define mandala common maps
	" ---- normal mode
	" -- help
	nnoremap <buffer> <nowait> <f1> <cmd>call torustree#guru#mandala()<cr>
	nnoremap <buffer> <nowait> <f2> <cmd>call torustree#guru#mandala_mappings()<cr>
	" -- quit
	nnoremap <buffer> q      <cmd>call torustree#cylinder#close()<cr>
	" -- movement
	nnoremap <buffer> j      <cmd>call torustree#mandala#wrap_down()<cr>
	nnoremap <buffer> k      <cmd>call torustree#mandala#wrap_up()<cr>
	nnoremap <buffer> <down> <cmd>call torustree#mandala#wrap_down()<cr>
	nnoremap <buffer> <up>   <cmd>call torustree#mandala#wrap_up()<cr>
	" -- reload mandala
	nnoremap <buffer> r      <cmd>call torustree#mandala#reload ()<cr>
	" -- rename mandala
	nnoremap <buffer> <m-n>  <cmd>call torustree#cylinder#rename ()<cr>
	" -- navigate in leaf ring
	nnoremap <buffer> <m-j>       <cmd>call torustree#book#forward ()<cr>
	nnoremap <buffer> <m-k>       <cmd>call torustree#book#backward ()<cr>
	nnoremap <buffer> <m-down>    <cmd>call torustree#book#forward ()<cr>
	nnoremap <buffer> <m-up>      <cmd>call torustree#book#backward ()<cr>
	nnoremap <buffer> <m-l>       <cmd>call torustree#book#switch ()<cr>
	nnoremap <buffer> <c-down>    <cmd>call torustree#book#switch ()<cr>
	nnoremap <buffer> <backspace> <cmd>call torustree#book#delete ()<cr>
endfun

" ---- template

fun! torustree#mandala#template (...)
	" Template with filter & input history
	" No selection, preview or fold
	if a:0 > 0
		let b:wheel_settings = a:1
	endif
	call torustree#mandala#common_maps ()
	" filter
	call torustree#teapot#mappings ()
	" input history
	call torustree#scroll#mappings ()
endfun

" ---- blank sheet

fun! torustree#mandala#blank (type)
	" Open a mandala buffer, add new blank leaf if needed
	let type = a:type
	" ---- create / open current mandala
	if ! torustree#cylinder#recall()
		call torustree#cylinder#first ()
	endif
	" ---- add new leaf, clear mandala, set type & options
	call torustree#book#add ('clear')
	call torustree#mandala#set_type (type)
	call torustree#mandala#common_options ()
	" ---- set related buffer
	let b:wheel_related = torustree#mandala#guess_related ()
endfun

" ---- content

fun! torustree#mandala#set_var_lines ()
	" Set lines in local mandala variables, from visible lines
	" Affected :
	"   - b:wheel_lines
	let start = torustree#teapot#first_data_line ()
	let lines = getline(start, '$')
	let b:wheel_lines = lines
	return v:true
endfun

fun! torustree#mandala#replace (content, first = 'empty-prompt-first', lock = 'lock')
	" Replace mandala buffer with content
	" Content can be :
	"   - a monoline string
	"   - a list of lines
	" Optional arguments :
	"   - first handle the first line filtering input :
	"     + empty-prompt-first (default) : blank first line with just a prompt
	"     + prompt-first : keep input, add prompt if not present
	"     + keep-first  : keep first line
	"     + delete-first : delete first line
	"   - lock :
	"     + lock : relock if not writable
	"     + dont-lock : don't lock
	if ! torustree#cylinder#is_mandala ()
		echomsg 'torustree mandala fill : not in mandala buffer'
	endif
	" ---- arguments
	let content = a:content
	let first = a:first
	let lock = a:lock
	" ---- cursor
	let position = getcurpos()
	" ---- options to edit
	call torustree#mandala#unlock ()
	" ---- delete old content
	call torustree#gear#delete (2, '$')
	" ---- append content
	call cursor(1, 1)
	call append('.', content)
	" ---- first line
	if first ==# 'prompt-first'
		call torustree#teapot#set_prompt (getline(1), lock)
	elseif first ==# 'empty-prompt-first'
		call torustree#teapot#set_prompt ('', lock)
	elseif  first ==# 'keep-first'
		call torustree#mandala#post_edit (lock)
	elseif first ==# 'delete-first'
		call torustree#gear#delete (1)
		call torustree#mandala#post_edit (lock)
	endif
	" ---- tell (neo)vim the buffer is unmodified
	setlocal nomodified
	" ---- restore cursor if possible, else place it on line 1
	call torustree#gear#restore_cursor (position, 1)
endfun

fun! torustree#mandala#fill (content, first = 'empty-prompt-first')
	" Fill mandala buffer with content
	" Arguments : see mandala#replace
	" ---- replace old content, fill if empty
	call torustree#mandala#replace(a:content, a:first)
	" -- fill b:wheel_lines
	call torustree#mandala#set_var_lines ()
	" ---- cursor on first data line
	let first_data_line = torustree#teapot#first_data_line ()
	if line('$') > 1
		call cursor(first_data_line, 1)
	endif
	" ---- folding, to save with syncup
	call torustree#origami#close ()
	call torustree#origami#view_cursor ()
	" ---- sync mandala -> leaf ring
	call torustree#book#syncup ()
	call torustree#status#mandala_leaf ()
endfun

" ---- relaad

fun! torustree#mandala#reload_string (function, ...)
	" Reload string
	let function = a:function
	let arguments = a:000
	" ---- no argument
	if empty(arguments)
		let reload = function
		return reload
	endif
	" ---- with argument(s)
	let length = len(arguments)
	let reload = function .. '('
	for index in range(length - 1)
		let reload ..= string(arguments[index]) .. ', '
	endfor
	let reload ..= string(arguments[-1]) .. ')'
	return reload
endfun

fun! torustree#mandala#set_reload(...)
	" Set reload in local variable
	if a:0 == 0
		echomsg 'torustree mandala set_reload : need at least one argument'
		return ''
	endif
	let reload = call('torustree#mandala#reload_string', a:000)
	let b:wheel_reload = reload
	return reload
endfun

fun! torustree#mandala#reload ()
	" Reload current mandala
	" ---- save type
	let type = b:wheel_nature.type
	" ---- mark the buffer as empty, to avoid adding a leaf in mandala#blank
	call torustree#mandala#set_type ('empty')
	" ---- reinitialize buffer vars
	call torustree#mandala#refresh ()
	" ---- reload content
	if ! empty(b:wheel_reload)
		let function = b:wheel_reload
		call torustree#metafun#call (function)
		call torustree#status#message('torustree :', function, 'reloaded')
	else
		" if b:wheel_reload is empty, replace the buffer with b:wheel_lines
		call torustree#mandala#replace (b:wheel_lines)
		" restore type
		call torustree#mandala#set_type (type)
		echomsg 'torustree : content reloaded'
	endif
endfun

" ---- generic commands

fun! torustree#mandala#command (...)
	" Generic ex or shell command
	" for shell command, just begin with !
	if a:0 > 0
		let command = a:1
	else
		let command = input('Ex or !shell command : ')
	endif
	if command[0] ==# '!'
		let command = command[1:]
		let current = getreg('%')
		let alter = getreg('#')
		let command = substitute(command, ' %', ' ' .. current, 'g')
		let command = substitute(command, ' #', ' ' .. alter, 'g')
		let command = substitute(command, '\~', $HOME, 'g')
		let lines = torustree#flower#execute (command, 'system')
	else
		let lines = torustree#flower#execute (command)
	endif
	call torustree#mandala#blank ('command')
	call torustree#mandala#template ()
	call torustree#mandala#fill (lines)
endfun

fun! torustree#mandala#async ()
	" Async command with output in torustree buffer
	if a:0 > 0
		let command = a:1
	else
		let prompt = 'async shell command : '
		let complete = 'customlist,torustree#complete#file'
		let command = input(prompt, '', complete)
	endif
	if empty(command)
		return v:false
	endif
	let current = getreg('%')
	let alter = getreg('#')
	let command = substitute(command, ' %', ' ' .. current, 'g')
	let command = substitute(command, ' #', ' ' .. alter, 'g')
	let command = substitute(command, '\~', $HOME, 'g')
	if has('nvim')
		let job = torustree#wave#start(command)
	else
		let job = torustree#ripple#start(command)
	endif
	return v:true
endfun
