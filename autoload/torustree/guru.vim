" vim: set ft=vim fdm=indent iskeyword&:

" Guru
"
" Help

" ---- script constants

if exists('s:subcommands_actions')
	unlockvar s:subcommands_actions
endif
let s:subcommands_actions = torustree#diadem#fetch('command/meta/actions')
lockvar s:subcommands_actions

if exists('s:prompt_actions')
	unlockvar s:prompt_actions
endif
let s:prompt_actions = torustree#diadem#fetch('command/meta/prompt/actions')
lockvar s:prompt_actions

if exists('s:dedibuf_actions')
	unlockvar s:dedibuf_actions
endif
let s:dedibuf_actions = torustree#diadem#fetch('command/meta/dedibuf/actions')
lockvar s:dedibuf_actions

if exists('s:file_subcommands')
	unlockvar s:file_subcommands
endif
let s:file_subcommands = torustree#diadem#fetch('command/meta/subcommands/file')
lockvar s:file_subcommands

" ---- help helpers

fun! torustree#guru#execute_current_line ()
	" Execute current line content
	let line = getline('.')
	if line =~ '<.*>'
		return v:false
	endif
	execute line
	return v:true
endfun

" ---- general help

fun! torustree#guru#help ()
	" Inline help
	tab help torustree.txt
endfun

fun! torustree#guru#mappings ()
	" List of mappings in a dedicated buffer
	let prefix = g:wheeltree_config.prefix
	let command = 'map ' .. prefix
	call torustree#mandala#command (command)
endfun

fun! torustree#guru#plugs ()
	" List of plugs mappings in a dedicated buffer
	call torustree#mandala#command ('map <plug>(torustree-')
endfun

fun! torustree#guru#autocommands ()
	" List of torustree autocommands in a dedicated buffer
	let group = input('Name of your torustree autocommand group ? ', 'torustree')
	let command = 'autocmd ' .. group
	call torustree#mandala#command (command)
endfun

fun! torustree#guru#meta_command ()
	" List of available subcommands for meta command
	let subcommands = torustree#matrix#items2keys(s:subcommands_actions)
	let lines = []
	for subcmd in subcommands
		if subcmd ==# 'prompt'
			let actions = torustree#matrix#items2keys(s:prompt_actions)
			for iter in actions
				let command = 'Torustree ' .. subcmd .. ' ' .. iter
				eval lines->add(command)
			endfor
			continue
		endif
		if subcmd ==# 'dedibuf'
			let actions = torustree#matrix#items2keys(s:dedibuf_actions)
			for iter in actions
				let command = 'Torustree ' .. subcmd .. ' ' .. iter
				eval lines->add(command)
			endfor
			continue
		endif
		if subcmd ==# 'mkdir'
			let command = 'Torustree ' .. subcmd .. ' <directory>'
		elseif subcmd ==# 'delete'
			let command = 'Torustree ' .. subcmd .. ' <file>'
		elseif subcmd->torustree#chain#is_inside(s:file_subcommands)
			let command = 'Torustree ' .. subcmd .. ' <source> <destination>'
		else
			let command = 'Torustree ' .. subcmd
		endif
		eval lines->add(command)
	endfor
	" ---- mandala
	call torustree#mandala#blank ('meta-command')
	call torustree#mandala#template ()
	call torustree#mandala#fill (lines)
	" --- map to execute current line
	nnoremap <buffer> <cr> <cmd>call torustree#guru#execute_current_line()<cr>
endfun

" ---- mandala local help

fun! torustree#guru#mandala ()
	" Basic help of a dedicated buffer
	echomsg 'q : quit                   | r : reload           | <M-n> : relabel buffer'
	echomsg '<M-k> : previous layer     | <M-l> : switch layer | <M-j> : next layer'
	echomsg '<Backspace> : delete layer | <F1> : this help     | <F2>  : local maps'
endfun

fun! torustree#guru#mandala_mappings ()
	" Local maps in a dedicated buffer
	call torustree#cylinder#recall ()
	let command = 'map <buffer>'
	call torustree#mandala#command (command)
endfun
