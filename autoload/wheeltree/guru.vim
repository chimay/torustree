" vim: set ft=vim fdm=indent iskeyword&:

" Guru
"
" Help

" ---- script constants

if exists('s:subcommands_actions')
	unlockvar s:subcommands_actions
endif
let s:subcommands_actions = wheeltree#diadem#fetch('command/meta/actions')
lockvar s:subcommands_actions

if exists('s:prompt_actions')
	unlockvar s:prompt_actions
endif
let s:prompt_actions = wheeltree#diadem#fetch('command/meta/prompt/actions')
lockvar s:prompt_actions

if exists('s:dedibuf_actions')
	unlockvar s:dedibuf_actions
endif
let s:dedibuf_actions = wheeltree#diadem#fetch('command/meta/dedibuf/actions')
lockvar s:dedibuf_actions

if exists('s:file_subcommands')
	unlockvar s:file_subcommands
endif
let s:file_subcommands = wheeltree#diadem#fetch('command/meta/subcommands/file')
lockvar s:file_subcommands

" ---- help helpers

fun! wheeltree#guru#execute_current_line ()
	" Execute current line content
	let line = getline('.')
	if line =~ '<.*>'
		return v:false
	endif
	execute line
	return v:true
endfun

" ---- general help

fun! wheeltree#guru#help ()
	" Inline help
	tab help wheeltree.txt
endfun

fun! wheeltree#guru#mappings ()
	" List of mappings in a dedicated buffer
	let prefix = g:wheeltree_config.prefix
	let command = 'map ' .. prefix
	call wheeltree#mandala#command (command)
endfun

fun! wheeltree#guru#plugs ()
	" List of plugs mappings in a dedicated buffer
	call wheeltree#mandala#command ('map <plug>(wheeltree-')
endfun

fun! wheeltree#guru#autocommands ()
	" List of wheeltree autocommands in a dedicated buffer
	let group = input('Name of your wheeltree autocommand group ? ', 'wheeltree')
	let command = 'autocmd ' .. group
	call wheeltree#mandala#command (command)
endfun

fun! wheeltree#guru#meta_command ()
	" List of available subcommands for meta command
	let subcommands = wheeltree#matrix#items2keys(s:subcommands_actions)
	let lines = []
	for subcmd in subcommands
		if subcmd ==# 'prompt'
			let actions = wheeltree#matrix#items2keys(s:prompt_actions)
			for iter in actions
				let command = 'Wheeltree ' .. subcmd .. ' ' .. iter
				eval lines->add(command)
			endfor
			continue
		endif
		if subcmd ==# 'dedibuf'
			let actions = wheeltree#matrix#items2keys(s:dedibuf_actions)
			for iter in actions
				let command = 'Wheeltree ' .. subcmd .. ' ' .. iter
				eval lines->add(command)
			endfor
			continue
		endif
		if subcmd ==# 'mkdir'
			let command = 'Wheeltree ' .. subcmd .. ' <directory>'
		elseif subcmd ==# 'delete'
			let command = 'Wheeltree ' .. subcmd .. ' <file>'
		elseif subcmd->wheeltree#chain#is_inside(s:file_subcommands)
			let command = 'Wheeltree ' .. subcmd .. ' <source> <destination>'
		else
			let command = 'Wheeltree ' .. subcmd
		endif
		eval lines->add(command)
	endfor
	" ---- mandala
	call wheeltree#mandala#blank ('meta-command')
	call wheeltree#mandala#template ()
	call wheeltree#mandala#fill (lines)
	" --- map to execute current line
	nnoremap <buffer> <cr> <cmd>call wheeltree#guru#execute_current_line()<cr>
endfun

" ---- mandala local help

fun! wheeltree#guru#mandala ()
	" Basic help of a dedicated buffer
	echomsg 'q : quit                   | r : reload           | <M-n> : relabel buffer'
	echomsg '<M-k> : previous layer     | <M-l> : switch layer | <M-j> : next layer'
	echomsg '<Backspace> : delete layer | <F1> : this help     | <F2>  : local maps'
endfun

fun! wheeltree#guru#mandala_mappings ()
	" Local maps in a dedicated buffer
	call wheeltree#cylinder#recall ()
	let command = 'map <buffer>'
	call wheeltree#mandala#command (command)
endfun
