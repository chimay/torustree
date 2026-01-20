" vim: set ft=vim fdm=indent iskeyword&:

" Complete
"
" Completion list functions

" Return entries as list
"
" vim does not filter the entries,
" if needed, it has to be done
" in the function body
"
" Note : kyusu#pour makes a deepcopy of the list before
" processing, no need to do it here

" ---- script constants

if exists('s:field_separ')
	unlockvar s:field_separ
endif
let s:field_separ = torustree#crystal#fetch('separator/field')
lockvar s:field_separ

if exists('s:registers_symbols')
	unlockvar s:registers_symbols
endif
let s:registers_symbols = torustree#crystal#fetch('registers-symbols')
lockvar s:registers_symbols

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

" ---- empty

fun! torustree#complete#empty (arglead, cmdline, cursorpos)
	return []
endfun

" ---- torustree

fun! torustree#complete#torus (arglead, cmdline, cursorpos)
	" Complete torus name
	if ! has_key(g:torustree, 'glossary')
		return []
	endif
	let toruses = g:torustree.glossary
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, toruses)
endfun

fun! torustree#complete#circle (arglead, cmdline, cursorpos)
	" Complete circle name
	let cur_torus = torustree#referen#torus ()
	if ! has_key(cur_torus, 'glossary')
		return []
	endif
	let circles = cur_torus.glossary
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, circles)
endfun

fun! torustree#complete#location (arglead, cmdline, cursorpos)
	" Complete location name
	let cur_circle = torustree#referen#circle ()
	if ! has_key(cur_circle, 'glossary')
		return []
	endif
	let locations = cur_circle.glossary
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, locations)
endfun

fun! torustree#complete#helix (arglead, cmdline, cursorpos)
	" Complete coordinates in index
	let choices = torustree#flower#helix ()
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

fun! torustree#complete#grid  (arglead, cmdline, cursorpos)
	" Complete location coordinates in index
	let choices = torustree#flower#grid ()
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

fun! torustree#complete#history (arglead, cmdline, cursorpos)
	" Complete coordinates in history timeline
	let choices = torustree#flower#history ()
	let wordlist = split(a:cmdline)
	return torustree#kyusu#drop(wordlist, choices)
endfun

fun! torustree#complete#history_circuit (arglead, cmdline, cursorpos)
	" Complete coordinates in history circuit
	let choices = torustree#flower#history_circuit ()
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

fun! torustree#complete#frecency (arglead, cmdline, cursorpos)
	" Complete coordinates in history timeline
	let choices = torustree#flower#frecency ()
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

" ---- mandalas = dedicated buffers

fun! torustree#complete#mandala (arglead, cmdline, cursorpos)
	" Complete mandala buffer name
	let bufring = g:torustree_bufring
	let names = bufring.names
	let types = bufring.types
	if empty(names)
		return []
	endif
	let choices = []
	for index in torustree#chain#rangelen(names)
		let title = names[index] .. s:field_separ .. types[index]
		eval choices->add(title)
	endfor
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

" ---- leaves = mandala layers, implemented as a ring

fun! torustree#complete#leaf (arglead, cmdline, cursorpos)
	" Complete leaf type
	let forest = copy( torustree#book#ring ('nature') )
	if empty(forest)
		return []
	endif
	let choices = map(forest, { ind, val -> ind .. s:field_separ .. val.type })
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

" ---- files & dirs

fun! torustree#complete#file (arglead, cmdline, cursorpos)
	" Complete with file name
	" Use glob(expr, nosuf, list, alllinks)
	" nosuf, list, alllinks = false by default
	let cmdline = a:cmdline
	let arglead = a:arglead
	let cursorpos = a:cursorpos
	" ---- first char
	let firstchar = cmdline[0]
	" ---- ending slash
	if cmdline ==# '~'
		let glob = glob('~/*', v:false, v:true)
		eval glob->map({ _, val -> substitute(val, $HOME, '~', 'g') })
		return glob
	endif
	if firstchar ==# '/' || firstchar ==# '~'
		let glob = glob(cmdline .. '*', v:false, v:true)
		eval glob->map({ _, val -> substitute(val, $HOME, '~', 'g') })
		return glob
	endif
	if cmdline[:1] ==# './' || cmdline[:2] ==# '../'
		let glob = glob(cmdline .. '*', v:false, v:true)
		return glob
	endif
	" ---- get tree of files & directories
	let tree = glob('**', v:false, v:true)
	let wordlist = split(cmdline)
	return torustree#kyusu#pour(wordlist, tree)
endfun

fun! torustree#complete#directory (arglead, cmdline, cursorpos)
	" Complete with directory name
	let tree = torustree#complete#file (a:arglead, a:cmdline, a:cursorpos)
	eval tree->filter({ _, val -> isdirectory(val) })
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, tree)
endfun

fun! torustree#complete#current_file (arglead, cmdline, cursorpos)
	" Complete different flavours or current filename
	let basis = expand('%:p')
	" replace spaces par non-breaking spaces
	let basis = substitute(basis, ' ', ' ', 'g')
	" flavours
	let root = fnamemodify(basis, ':t:r')
	let simple = fnamemodify(basis, ':t')
	let relative = torustree#disc#relative_path(basis)
	let absolute = basis
	let filenames = [root, simple, relative, absolute]
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, filenames)
endfun

fun! torustree#complete#current_directory (arglead, cmdline, cursorpos)
	" Complete different flavours or current file directory
	let basis = expand('%:p:h')
	" replace spaces par non-breaking spaces
	let basis = substitute(basis, ' ', ' ', 'g')
	" flavours
	let simple = fnamemodify(basis, ':t')
	let relative = torustree#disc#relative_path(basis)
	let absolute = basis
	let directories = [simple, relative, absolute]
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, directories)
endfun

fun! torustree#complete#dir_or_subdir (arglead, cmdline, cursorpos)
	" Complete current dir or subdir
	let current = torustree#complete#current_directory (a:arglead, a:cmdline, a:cursorpos)
	let tree = torustree#complete#directory (a:arglead, a:cmdline, a:cursorpos)
	let directories = current + tree
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, directories)
endfun

fun! torustree#complete#link_copy (arglead, cmdline, cursorpos)
	" Complete command to generate tree reflecting torustree in filesystem
	" Link or copy
	" See also torustree#disc#tree_script
	let commands = ['ln -s', 'cp -n']
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, commands)
endfun

" ---- mru non torustree files

fun! torustree#complete#mru (arglead, cmdline, cursorpos)
	" Complete mru file
	let files = torustree#perspective#mru ()
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, files)
endfun

" ---- buffers

fun! torustree#complete#buffer (arglead, cmdline, cursorpos)
	" Complete with buffer name
	let choices = torustree#perspective#buffer ('all')
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

fun! torustree#complete#visible_buffer (arglead, cmdline, cursorpos)
	" Complete buffer visible in tabs & windows
	let choices = torustree#perspective#tabwin ()
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

" ---- buffer lines

fun! torustree#complete#line (arglead, cmdline, cursorpos)
	" Complete buffer line
	let linelist = getline(1,'$')
	eval linelist->map({ ind, val -> string(ind + 1) .. s:field_separ .. val })
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, linelist)
endfun

" ---- vim lists

fun! torustree#complete#marker (arglead, cmdline, cursorpos)
	" Complete marker
	let choices = torustree#perspective#marker ()
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

fun! torustree#complete#jump (arglead, cmdline, cursorpos)
	" Complete jump
	let choices = torustree#perspective#jump ()
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

fun! torustree#complete#change (arglead, cmdline, cursorpos)
	" Complete change
	let choices = torustree#perspective#change ()
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

fun! torustree#complete#tag (arglead, cmdline, cursorpos)
	" Complete tag
	let table = torustree#symbol#table ()
	let choices = []
	for fields in table
		let iden = fields[0]
		let filename = fields[1]
		let search = fields[2]
		let type = fields[3]
		let iden = printf('%5s', iden)
		let type = printf('%2s', type)
		let entry = [iden, filename, search, type]
		let record = join(entry, s:field_separ)
		eval choices->add(record)
	endfor
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

" ---- grep

fun! torustree#complete#outline_folds (arglead, cmdline, cursorpos)
	" Complete folds outline
	let marker = split(&l:foldmarker, ',')[0]
	let grep_ex_command = g:torustree_config.grep
	if grep_ex_command =~ '^:\?grep' && &grepprg !~ '^grep'
		let marker = escape(marker, '{')
	endif
	let choices = torustree#perspective#grep (marker, '\m.')
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

fun! torustree#complete#outline_markdown (arglead, cmdline, cursorpos)
	" Complete markdown outline
	let choices = torustree#perspective#grep ('^#', '\.md$')
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

fun! torustree#complete#outline_org (arglead, cmdline, cursorpos)
	" Complete org outline
	let choices = torustree#perspective#grep ('^\*', '\.org$')
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

fun! torustree#complete#outline_vimwiki (arglead, cmdline, cursorpos)
	" Complete vimwiki outline
	let choices = torustree#perspective#grep ('^=.*=$', '\.wiki$')
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

" ---- yank ring

fun! torustree#complete#register (arglead, cmdline, cursorpos)
	" Complete register name
	let choices = torustree#matrix#items2keys(s:registers_symbols)
	eval choices->add('overview')
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

fun! torustree#complete#yank_list (arglead, cmdline, cursorpos)
	" Complete yank from yank ring in list mode
	let register = g:torustree_shelve.yank.default_register
	let choices = torustree#perspective#yank_prompt ('list', register)
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

fun! torustree#complete#yank_plain (arglead, cmdline, cursorpos)
	" Complete yank from yank ring in plain mode
	let register = g:torustree_shelve.yank.default_register
	let choices = torustree#perspective#yank_prompt ('plain', register)
	let wordlist = split(a:cmdline)
	return torustree#kyusu#pour(wordlist, choices)
endfun

" ---- meta command

fun! torustree#complete#meta_command (arglead, cmdline, cursorpos)
	" Completion for :Torustree meta command
	let cmdline = a:cmdline
	let arglead = a:arglead
	let cursorpos = a:cursorpos
	" ---- words
	let wordlist = split(cmdline)
	let length =  len(wordlist)
	" ---- checks
	if length == 0
		return []
	endif
	if wordlist[0] !=# 'Torustree'
		return []
	endif
	" ---- last word
	let last = wordlist[-1]
	let last_list = split(last, '[,;]')
	" ---- cursor after a partial word ?
	let blank = cmdline[cursorpos - 1] =~ '\m\s'
	" ---- subcommand
	let subcommands = torustree#matrix#items2keys(s:subcommands_actions)
	if length == 1 && blank
		return subcommands
	endif
	if length == 2 && ! blank
		return torustree#kyusu#pour(last_list, subcommands)
	endif
	let subcommand = wordlist[1]
	" ---- prompting functions
	let prompt_subcmds = torustree#matrix#items2keys(s:prompt_actions)
	if subcommand ==# 'prompt'
		if blank
			return prompt_subcmds
		else
			return torustree#kyusu#pour(last_list, prompt_subcmds)
		endif
	endif
	" ---- dedicated buffers
	let dedibuf_subcmds = torustree#matrix#items2keys(s:dedibuf_actions)
	if subcommand ==# 'dedibuf'
		if blank
			return dedibuf_subcmds
		else
			return torustree#kyusu#pour(last_list, dedibuf_subcmds)
		endif
	endif
	" ---- file
	let wants_file = subcommand->torustree#chain#is_inside(s:file_subcommands)
	if wants_file
		if blank
			return glob('**', v:false, v:true)
		else
			let file_cmdline = join(last_list)
			let file_arglead = file_cmdline
			let file_cursorpos = len(file_cmdline)
			return torustree#complete#file (file_arglead, file_cmdline, file_cursorpos)
		endif
	endif
	return []
endfun
