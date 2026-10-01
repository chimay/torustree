" vim: set ft=vim fdm=indent iskeyword&:

" Void
"
" Initialization of variables
"
" Enter the void, and ride the torustree

" ---- script constants

if exists('s:mandala_autocmds_group')
	unlockvar s:mandala_autocmds_group
endif
let s:mandala_autocmds_group = torustree#crystal#fetch('mandala/autocmds/group')
lockvar s:mandala_autocmds_group

" ---- no-op function

fun! torustree#void#nope (...)
	" Does nothing, returns its argument list
	" Application : for meta-command subcommands thas need a third argument
	return a:000
endfun

" ---- templates

" -- legacy

fun! torustree#void#template(init)
	" Generate template to add to g:torustree lists
	" Name = name in argument
	" Optional arguments : keys initialized as empty list
	let template = a:init
	let template.glossary = []
	let template.current = -1
	return template
endfun

" ---- initialize individual variables

" -- persistent variables

fun! torustree#void#torustree ()
	" Initialize torustree
	if ! exists('g:torustree')
		let g:torustree = {}
	endif
	" ---- locations group
	if ! has_key(g:torustree, 'circle')
		let g:torustree.circle = []
	endif
	" ---- list of subtrees
	if ! has_key(g:torustree, 'forest')
		let g:torustree.forest = []
	endif
	" ---- if true : current path is in local circle
	if ! has_key(g:torustree, 'here')
		let g:torustree.here = v:true
	endif
	" ---- last time current path was in local circle
	if ! has_key(g:torustree, 'timestamp')
		let g:torustree.timestamp = -1
	endif
endfun

fun! torustree#void#helix ()
	" Initialize helix : index of locations
	if ! exists('g:torustree_helix')
		let g:torustree_helix = {}
	endif
	if ! has_key(g:torustree_helix, 'table')
		let g:torustree_helix.table = []
	endif
	if ! has_key(g:torustree_helix, 'timestamp')
		let g:torustree_helix.timestamp = -1
	endif
endfun

fun! torustree#void#grid ()
	" Initialize grid : index of circles
	if ! exists('g:torustree_grid')
		let g:torustree_grid = {}
	endif
	if ! has_key(g:torustree_grid, 'table')
		let g:torustree_grid.table = []
	endif
	if ! has_key(g:torustree_grid, 'timestamp')
		let g:torustree_grid.timestamp = -1
	endif
endfun

fun! torustree#void#files ()
	" Initialize index of files
	if ! exists('g:torustree_files')
		let g:torustree_files = {}
	endif
	if ! has_key(g:torustree_files, 'table')
		let g:torustree_files.table = []
	endif
	if ! has_key(g:torustree_files, 'timestamp')
		let g:torustree_files.timestamp = -1
	endif
endfun

fun! torustree#void#history ()
	" Initialize history
	if ! exists('g:torustree_history')
		let g:torustree_history = {}
	endif
	" ---- naturally sorted time line
	if ! has_key(g:torustree_history, 'line')
		let g:torustree_history.line = []
	endif
	" ---- rolled time loop
	if ! has_key(g:torustree_history, 'circuit')
		let g:torustree_history.circuit = []
	endif
	" ---- alternate locations
	if ! has_key(g:torustree_history, 'alternate')
		let g:torustree_history.alternate = {}
	endif
	" ---- frequent + recent
	if ! has_key(g:torustree_history, 'frecency')
		let g:torustree_history.frecency = []
	endif
endfun

fun! torustree#void#input ()
	" Initialize input history
	if ! exists('g:torustree_input')
		let g:torustree_input = []
	endif
endfun

fun! torustree#void#shelve ()
	" Initialize shelve : misc status variables
	if ! exists('g:torustree_shelve')
		let g:torustree_shelve = {}
	endif
	" ---- current
	if ! has_key(g:torustree_shelve, 'current')
		let g:torustree_shelve.current = {}
	endif
	" -- torustree file
	if ! has_key(g:torustree_shelve.current, 'torustree')
		let g:torustree_shelve.current.torustree = ''
	endif
	" -- session file
	if ! has_key(g:torustree_shelve.current, 'session')
		let g:torustree_shelve.current.session = ''
	endif
	" ---- yank ring
	if ! has_key(g:torustree_shelve, 'yank')
		let g:torustree_shelve.yank = {}
	endif
	if ! has_key(g:torustree_shelve.yank, 'default_register')
		let g:torustree_shelve.yank.default_register = 'unnamed'
	endif
	" ---- tabs and windows layouts
	if ! has_key(g:torustree_shelve, 'layout')
		let g:torustree_shelve.layout = {}
	endif
	" ---- backup some vars if needed
	if ! has_key(g:torustree_shelve, 'backup')
		let g:torustree_shelve.backup = {}
	endif
endfun

fun! torustree#void#attic ()
	" Initialize most recently used files
	if ! exists('g:torustree_attic')
		let g:torustree_attic = []
	endif
endfun

fun! torustree#void#yank ()
	" Initialize yank history
	if ! exists('g:torustree_yank')
		let g:torustree_yank = {}
	endif
	if ! has_key(g:torustree_yank, 'unnamed')
		let g:torustree_yank.unnamed = []
	endif
	if ! has_key(g:torustree_yank, 'clipboard')
		let g:torustree_yank.clipboard = []
	endif
	if ! has_key(g:torustree_yank, 'primary')
		let g:torustree_yank.primary = []
	endif
	if ! has_key(g:torustree_yank, 'small')
		let g:torustree_yank.small = []
	endif
	if ! has_key(g:torustree_yank, 'inserted')
		let g:torustree_yank.inserted = []
	endif
	if ! has_key(g:torustree_yank, 'search')
		let g:torustree_yank.search = []
	endif
	if ! has_key(g:torustree_yank, 'command')
		let g:torustree_yank.command = []
	endif
	if ! has_key(g:torustree_yank, 'expression')
		let g:torustree_yank.expression = []
	endif
	if ! has_key(g:torustree_yank, 'file')
		let g:torustree_yank.file = []
	endif
	if ! has_key(g:torustree_yank, 'alternate')
		let g:torustree_yank.alternate = []
	endif
endfun

" -- config

fun! torustree#void#config ()
	" Initialize config
	if ! exists('g:torustree_config')
		let g:torustree_config = {}
	endif
	if ! has_key(g:torustree_config, 'mappings')
		let g:torustree_config.mappings = 0
	endif
	if ! has_key(g:torustree_config, 'prefix')
		let g:torustree_config.prefix = '<M-w>'
	endif
	if ! has_key(g:torustree_config, 'locate_db')
		let g:torustree_config.locate_db = ''
	endif
	if ! has_key(g:torustree_config, 'grep')
		" defaults to internal vimgrep,
		" in case external grep is not available
		let g:torustree_config.grep = 'vimgrep'
	endif
	" ---- project
	if ! has_key(g:torustree_config, 'project')
		let g:torustree_config.project = {}
	endif
	if ! has_key(g:torustree_config.project, 'markers')
		let g:torustree_config.project.markers = '.git'
	endif
	if ! has_key(g:torustree_config.project, 'auto_chdir')
		let g:torustree_config.project.auto_chdir = 0
	endif
	" ---- storage
	if ! has_key(g:torustree_config, 'storage')
		let g:torustree_config.storage = {}
	endif
	" -- storage torustree
	if ! has_key(g:torustree_config.storage, 'torustree')
		let g:torustree_config.storage.torustree = {}
	endif
	if ! has_key(g:torustree_config.storage.torustree, 'folder')
		if has('nvim')
			let g:torustree_config.storage.torustree.folder = '~/.local/share/nvim/torustree'
		else
			let g:torustree_config.storage.torustree.folder = '~/.vim/torustree'
		endif
	endif
	if ! has_key(g:torustree_config.storage.torustree, 'name')
		let g:torustree_config.storage.torustree.name = 'torustree.vim'
	endif
	if ! has_key(g:torustree_config.storage.torustree, 'autowrite')
		let g:torustree_config.storage.torustree.autowrite = 0
	endif
	if ! has_key(g:torustree_config.storage.torustree, 'autoread')
		let g:torustree_config.storage.torustree.autoread = 0
	endif
	" -- storage session
	if ! has_key(g:torustree_config.storage, 'session')
		let g:torustree_config.storage.session = {}
	endif
	if ! has_key(g:torustree_config.storage.session, 'folder')
		if has('nvim')
			let g:torustree_config.storage.session.folder = '~/.local/share/nvim/torustree/session'
		else
			let g:torustree_config.storage.session.folder = '~/.vim/torustree/session'
		endif
	endif
	if ! has_key(g:torustree_config.storage.session, 'name')
		let g:torustree_config.storage.session.name = 'session.vim'
	endif
	if ! has_key(g:torustree_config.storage.session, 'autowrite')
		let g:torustree_config.storage.session.autowrite = 0
	endif
	if ! has_key(g:torustree_config.storage.session, 'autoread')
		let g:torustree_config.storage.session.autoread = 0
	endif
	" -- backups
	if ! has_key(g:torustree_config.storage, 'backups')
		let g:torustree_config.storage.backups = 3
	endif
	" ---- maxim
	if ! has_key(g:torustree_config, 'maxim')
		let g:torustree_config.maxim = {}
	endif
	if ! has_key(g:torustree_config.maxim, 'history')
		let g:torustree_config.maxim.history = 500
	endif
	if ! has_key(g:torustree_config.maxim, 'input')
		let g:torustree_config.maxim.input = 500
	endif
	if ! has_key(g:torustree_config.maxim, 'mru')
		let g:torustree_config.maxim.mru = 500
	endif
	if ! has_key(g:torustree_config.maxim, 'unnamed_yanks')
		let g:torustree_config.maxim.unnamed_yanks = 500
	endif
	if ! has_key(g:torustree_config.maxim, 'other_yanks')
		let g:torustree_config.maxim.other_yanks = 50
	endif
	if ! has_key(g:torustree_config.maxim, 'yank_lines')
		let g:torustree_config.maxim.yank_lines = 30
	endif
	if ! has_key(g:torustree_config.maxim, 'yank_size')
		let g:torustree_config.maxim.yank_size = 3000
	endif
	if ! has_key(g:torustree_config.maxim, 'layers')
		let g:torustree_config.maxim.layers = 5
	endif
	if ! has_key(g:torustree_config.maxim, 'tabs')
		let g:torustree_config.maxim.tabs = 15
	endif
	if ! has_key(g:torustree_config.maxim, 'horizontal')
		let g:torustree_config.maxim.horizontal = 3
	endif
	if ! has_key(g:torustree_config.maxim, 'vertical')
		let g:torustree_config.maxim.vertical = 4
	endif
	" ---- frecency
	if ! has_key(g:torustree_config, 'frecency')
		let g:torustree_config.frecency = {}
	endif
	if ! has_key(g:torustree_config.frecency, 'reward')
		let g:torustree_config.frecency.reward = 50
	endif
	if ! has_key(g:torustree_config.frecency, 'penalty')
		let g:torustree_config.frecency.penalty = 1
	endif
	" -- completion
	if ! has_key(g:torustree_config, 'completion')
		let g:torustree_config.completion = {}
	endif
	if ! has_key(g:torustree_config.completion, 'vocalize')
		let g:torustree_config.completion.vocalize = 0
	endif
	if ! has_key(g:torustree_config.completion, 'wordize')
		let g:torustree_config.completion.wordize = 0
	endif
	if ! has_key(g:torustree_config.completion, 'fuzzy')
		let g:torustree_config.completion.fuzzy = 0
	endif
	if ! has_key(g:torustree_config.completion, 'scores')
		let g:torustree_config.completion.scores = 0
	endif
	" ---- display
	if ! has_key(g:torustree_config, 'display')
		let g:torustree_config.display = {}
	endif
	if ! has_key(g:torustree_config.display, 'statusline')
		let g:torustree_config.display.statusline = 1
	endif
	if ! has_key(g:torustree_config.display, 'dedibuf_msg')
		let g:torustree_config.display.dedibuf_msg = 'one-line'
	endif
	if ! has_key(g:torustree_config.display, 'prompt')
		let g:torustree_config.display.prompt = torustree#crystal#fetch ('mandala/prompt')
	endif
	if ! has_key(g:torustree_config.display, 'prompt_writable')
		let g:torustree_config.display.prompt_writable = torustree#crystal#fetch ('mandala/prompt/writable')
	endif
	if ! has_key(g:torustree_config.display, 'selection')
		let g:torustree_config.display.selection = torustree#crystal#fetch ('selection/mark')
	endif
	" -- display sign
	if ! has_key(g:torustree_config.display, 'sign')
		let g:torustree_config.display.sign = {}
	endif
	if ! has_key(g:torustree_config.display.sign, 'switch')
		let g:torustree_config.display.sign.switch = 1
	endif
	if ! has_key(g:torustree_config.display.sign, 'settings')
		let settings = deepcopy(torustree#crystal#fetch ('sign/settings'))
		let g:torustree_config.display.sign.settings = settings
	endif
	if ! has_key(g:torustree_config.display.sign, 'native_settings')
		let native_settings = deepcopy(torustree#crystal#fetch ('sign/settings/native'))
		let g:torustree_config.display.sign.native_settings = native_settings
	endif
	" ---- debug
	if ! has_key(g:torustree_config, 'debug')
		let g:torustree_config.debug = 0
	endif
endfun

" -- non persistent variables

fun! torustree#void#mandalas ()
	" Initialize mandala buffers list
	if ! exists('g:torustree_bufring')
		let g:torustree_bufring = {}
	endif
	if ! has_key(g:torustree_bufring, 'mandalas')
		let g:torustree_bufring.mandalas = []
	endif
	if ! has_key(g:torustree_bufring, 'current')
		let g:torustree_bufring.current = -1
	endif
	if ! has_key(g:torustree_bufring, 'iden')
		let g:torustree_bufring.iden = []
	endif
	if ! has_key(g:torustree_bufring, 'names')
		let g:torustree_bufring.names = []
	endif
	if ! has_key(g:torustree_bufring, 'types')
		let g:torustree_bufring.types = []
	endif
endfun

fun! torustree#void#autogroup ()
	" Define empty torustree-mandala auto command group
	execute 'augroup' s:mandala_autocmds_group
		autocmd!
	augroup END
endfun

fun! torustree#void#signs ()
	" Initialize signs list
	if ! exists('g:torustree_signs')
		let g:torustree_signs = {}
	endif
	" ---- locations signs
	if ! has_key(g:torustree_signs, 'iden')
		let g:torustree_signs.iden = []
	endif
	if ! has_key(g:torustree_signs, 'table')
		let g:torustree_signs.table = []
	endif
	" ---- native navigation signs
	if ! has_key(g:torustree_signs, 'native_iden')
		let g:torustree_signs.native_iden = []
	endif
	if ! has_key(g:torustree_signs, 'native_table')
		let g:torustree_signs.native_table = []
	endif
endfun

fun! torustree#void#wave ()
	" Initialize jobs dictionary
	" ---- for neovim
	if has('nvim') && ! exists('g:torustree_wave')
		let g:torustree_wave = []
	endif
	" ---- same thing for vim
	if ! has('nvim') && ! exists('g:torustree_ripple')
		let g:torustree_ripple = []
	endif
endfun

fun! torustree#void#volatile ()
	" Store non persistent state
	if ! exists('g:torustree_volatile')
		let g:torustree_volatile = {}
	endif
	" ---- Remember number of file args at startup
	" ---- before :argadd, :argdel or similar command
	if ! has_key(g:torustree_volatile, 'argc')
		let g:torustree_volatile.argc = argc()
	endif
	if ! has_key(g:torustree_volatile, 'argv')
		let g:torustree_volatile.argv = argv()
	endif
	" ---- First time read / write
	if ! has_key(g:torustree_volatile, 'first')
		let g:torustree_volatile.first = {}
		let g:torustree_volatile.first.write_torustree = v:true
		let g:torustree_volatile.first.read_torustree = v:true
		let g:torustree_volatile.first.write_session = v:true
		let g:torustree_volatile.first.read_session = v:true
	endif
endfun

" ---- initialize all variables & augroup

fun! torustree#void#foundation ()
	" Initialize torustree
	" ---- pre conversion from old keys
	call torustree#kintsugi#pre ()
	" ---- persistent torustree variables
	call torustree#void#torustree ()
	call torustree#void#helix ()
	call torustree#void#grid ()
	call torustree#void#files ()
	call torustree#void#history ()
	call torustree#void#input ()
	call torustree#void#shelve ()
	call torustree#void#attic ()
	call torustree#void#yank ()
	" ---- config
	call torustree#void#config ()
	" ---- non persistent torustree variables
	call torustree#void#mandalas ()
	call torustree#void#autogroup ()
	call torustree#void#signs ()
	call torustree#void#wave ()
	call torustree#void#volatile ()
	" ---- post conversion from old keys
	call torustree#kintsugi#post ()
endfun

" ---- wipe mandala buffers

fun! torustree#void#wipe_mandalas ()
	" Wipe mandalas buffers
	let buflist = getbufinfo()
	let mandalas = g:torustree_bufring.mandalas
	for buffer in buflist
		let bufnum = buffer.bufnr
		if torustree#chain#is_inside(bufnum, mandalas)
			execute 'silent bwipe!' bufnum
		endif
	endfor
endfun

" ---- unlet variables

fun! torustree#void#clean ()
	" Clean variables before writing torustree to file
	" ---- torustree history
	if has_key(g:torustree_history.alternate, 'window')
		unlet g:torustree_history.alternate.window
	endif
	" ---- torustree shelve
	let g:torustree_shelve.layout.window = 'none'
	let g:torustree_shelve.layout.split = 'none'
	let g:torustree_shelve.layout.tab = 'none'
	let g:torustree_shelve.layout.tabnames = []
endfun

fun! torustree#void#vanish ()
	" Unlet torustree variables
	" No need to save them in viminfo or shada file
	" since you can save them in g:torustree_config.storage.torustree.name
	" ---- should not be necessary, since only
	" ---- uppercase global vars are stored in viminfo / shada
	return
	let varlist = [
				\ 'g:torustree',
				\ 'g:torustree_helix',
				\ 'g:torustree_grid',
				\ 'g:torustree_files',
				\ 'g:torustree_history',
				\ 'g:torustree_input',
				\ 'g:torustree_attic',
				\ 'g:torustree_yank',
				\ 'g:torustree_shelve',
				\ 'g:torustree_config',
				\ 'g:torustree_bufring',
				\ 'g:torustree_wave',
				\ 'g:torustree_ripple',
				\ 'g:torustree_volatile',
				\ 'g:torustree_signs',
				\ ]
	call torustree#ouroboros#unlet (varlist)
endfun

" ---- init & exit

fun! torustree#void#init ()
	" Main init function
	"if g:torustree_volatile.argc == 0 && has('nvim')
		"echomsg 'torustree hello !'
	"endif
	" ---- keep tabs & wins ?
	if g:torustree_volatile.argc == 0
		let keep_tabwins = 'dont-keep'
	else
		let keep_tabwins = 'keep'
	endif
	" ---- no message at vim enter
	let verbose = v:false
	" ---- read torustree
	if g:torustree_config.storage.torustree.autoread > 0
		call torustree#disc#read_torustree ('', keep_tabwins, verbose)
	endif
	" ---- read session
	if g:torustree_config.storage.session.autoread > 0
		call torustree#disc#read_session ('', keep_tabwins, verbose)
	endif
endfun

fun! torustree#void#exit ()
	" Main exit function
	"if g:torustree_volatile.argc == 0 && has('nvim')
		"echomsg 'torustree bye !'
	"endif
	" ---- clean vars before writing
	call torustree#void#clean ()
	" ---- no message at vim leave
	let verbose = v:false
	" ---- save session
	if g:torustree_config.storage.session.autowrite > 0
		call torustree#disc#write_session ('', verbose)
	endif
	" ---- save torustree, and unlet
	if g:torustree_config.storage.torustree.autowrite > 0
		call torustree#disc#write_torustree('', verbose)
	endif
	call torustree#void#wipe_mandalas ()
	call torustree#void#vanish ()
endfun

" ---- fresh empty torustree, for testing

fun! torustree#void#fresh_torustree ()
	" Fresh empty torustree variables
	let prompt = 'Write old torustree to file before emptying torustree ?'
	let confirm = confirm(prompt, "&Yes\n&No", 1)
	if confirm == 1
		call torustree#disc#write_torustree ()
	endif
	let varlist = [
				\ 'g:torustree',
				\ 'g:torustree_helix',
				\ 'g:torustree_grid',
				\ 'g:torustree_files',
				\ 'g:torustree_history',
				\ 'g:torustree_input',
				\ 'g:torustree_attic',
				\ 'g:torustree_wave',
				\ 'g:torustree_ripple',
				\ 'g:torustree_yank',
				\ 'g:torustree_bufring',
				\ 'g:torustree_signs',
				\ 'g:torustree_shelve',
				\ ]
	call torustree#ouroboros#unlet (varlist)
	call torustree#void#foundation ()
endfun
