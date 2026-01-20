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

" ---- helpers

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
	if ! has_key(g:torustree, 'locations')
		let g:torustree.locations = []
	endif
	if ! has_key(g:torustree, 'trees')
		let g:torustree.trees = []
	endif
	if ! has_key(g:torustree, 'glossary')
		let g:torustree.glossary = []
	endif
	if ! has_key(g:torustree, 'current')
		let g:torustree.current = -1
	endif
	if ! has_key(g:torustree, 'timestamp')
		let g:torustree.timestamp = -1
	endif
endfun

fun! torustree#void#helix ()
	" Initialize helix : index of locations
	if ! exists('g:wheeltree_helix')
		let g:wheeltree_helix = {}
	endif
	if ! has_key(g:wheeltree_helix, 'table')
		let g:wheeltree_helix.table = []
	endif
	if ! has_key(g:wheeltree_helix, 'timestamp')
		let g:wheeltree_helix.timestamp = -1
	endif
endfun

fun! torustree#void#grid ()
	" Initialize grid : index of circles
	if ! exists('g:wheeltree_grid')
		let g:wheeltree_grid = {}
	endif
	if ! has_key(g:wheeltree_grid, 'table')
		let g:wheeltree_grid.table = []
	endif
	if ! has_key(g:wheeltree_grid, 'timestamp')
		let g:wheeltree_grid.timestamp = -1
	endif
endfun

fun! torustree#void#files ()
	" Initialize index of files
	if ! exists('g:wheeltree_files')
		let g:wheeltree_files = {}
	endif
	if ! has_key(g:wheeltree_files, 'table')
		let g:wheeltree_files.table = []
	endif
	if ! has_key(g:wheeltree_files, 'timestamp')
		let g:wheeltree_files.timestamp = -1
	endif
endfun

fun! torustree#void#history ()
	" Initialize history
	if ! exists('g:wheeltree_history')
		let g:wheeltree_history = {}
	endif
	" ---- naturally sorted time line
	if ! has_key(g:wheeltree_history, 'line')
		let g:wheeltree_history.line = []
	endif
	" ---- rolled time loop
	if ! has_key(g:wheeltree_history, 'circuit')
		let g:wheeltree_history.circuit = []
	endif
	" ---- alternate locations
	if ! has_key(g:wheeltree_history, 'alternate')
		let g:wheeltree_history.alternate = {}
	endif
	" ---- frequent + recent
	if ! has_key(g:wheeltree_history, 'frecency')
		let g:wheeltree_history.frecency = []
	endif
endfun

fun! torustree#void#input ()
	" Initialize input history
	if ! exists('g:wheeltree_input')
		let g:wheeltree_input = []
	endif
endfun

fun! torustree#void#shelve ()
	" Initialize shelve : misc status variables
	if ! exists('g:wheeltree_shelve')
		let g:wheeltree_shelve = {}
	endif
	" ---- current
	if ! has_key(g:wheeltree_shelve, 'current')
		let g:wheeltree_shelve.current = {}
	endif
	" -- torustree file
	if ! has_key(g:wheeltree_shelve.current, 'torustree')
		let g:wheeltree_shelve.current.torustree = ''
	endif
	" -- session file
	if ! has_key(g:wheeltree_shelve.current, 'session')
		let g:wheeltree_shelve.current.session = ''
	endif
	" ---- yank ring
	if ! has_key(g:wheeltree_shelve, 'yank')
		let g:wheeltree_shelve.yank = {}
	endif
	if ! has_key(g:wheeltree_shelve.yank, 'default_register')
		let g:wheeltree_shelve.yank.default_register = 'unnamed'
	endif
	" ---- tabs and windows layouts
	if ! has_key(g:wheeltree_shelve, 'layout')
		let g:wheeltree_shelve.layout = {}
	endif
	" ---- backup some vars if needed
	if ! has_key(g:wheeltree_shelve, 'backup')
		let g:wheeltree_shelve.backup = {}
	endif
endfun

fun! torustree#void#attic ()
	" Initialize most recently used files
	if ! exists('g:wheeltree_attic')
		let g:wheeltree_attic = []
	endif
endfun

fun! torustree#void#yank ()
	" Initialize yank history
	if ! exists('g:wheeltree_yank')
		let g:wheeltree_yank = {}
	endif
	if ! has_key(g:wheeltree_yank, 'unnamed')
		let g:wheeltree_yank.unnamed = []
	endif
	if ! has_key(g:wheeltree_yank, 'clipboard')
		let g:wheeltree_yank.clipboard = []
	endif
	if ! has_key(g:wheeltree_yank, 'primary')
		let g:wheeltree_yank.primary = []
	endif
	if ! has_key(g:wheeltree_yank, 'small')
		let g:wheeltree_yank.small = []
	endif
	if ! has_key(g:wheeltree_yank, 'inserted')
		let g:wheeltree_yank.inserted = []
	endif
	if ! has_key(g:wheeltree_yank, 'search')
		let g:wheeltree_yank.search = []
	endif
	if ! has_key(g:wheeltree_yank, 'command')
		let g:wheeltree_yank.command = []
	endif
	if ! has_key(g:wheeltree_yank, 'expression')
		let g:wheeltree_yank.expression = []
	endif
	if ! has_key(g:wheeltree_yank, 'file')
		let g:wheeltree_yank.file = []
	endif
	if ! has_key(g:wheeltree_yank, 'alternate')
		let g:wheeltree_yank.alternate = []
	endif
endfun

" -- config

fun! torustree#void#config ()
	" Initialize config
	if ! exists('g:wheeltree_config')
		let g:wheeltree_config = {}
	endif
	if ! has_key(g:wheeltree_config, 'mappings')
		let g:wheeltree_config.mappings = 0
	endif
	if ! has_key(g:wheeltree_config, 'prefix')
		let g:wheeltree_config.prefix = '<M-w>'
	endif
	if ! has_key(g:wheeltree_config, 'locate_db')
		let g:wheeltree_config.locate_db = ''
	endif
	if ! has_key(g:wheeltree_config, 'grep')
		" defaults to internal vimgrep,
		" in case external grep is not available
		let g:wheeltree_config.grep = 'vimgrep'
	endif
	" ---- project
	if ! has_key(g:wheeltree_config, 'project')
		let g:wheeltree_config.project = {}
	endif
	if ! has_key(g:wheeltree_config.project, 'markers')
		let g:wheeltree_config.project.markers = '.git'
	endif
	if ! has_key(g:wheeltree_config.project, 'auto_chdir')
		let g:wheeltree_config.project.auto_chdir = 0
	endif
	" ---- storage
	if ! has_key(g:wheeltree_config, 'storage')
		let g:wheeltree_config.storage = {}
	endif
	" -- storage torustree
	if ! has_key(g:wheeltree_config.storage, 'torustree')
		let g:wheeltree_config.storage.torustree = {}
	endif
	if ! has_key(g:wheeltree_config.storage.torustree, 'folder')
		if has('nvim')
			let g:wheeltree_config.storage.torustree.folder = '~/.local/share/nvim/torustree'
		else
			let g:wheeltree_config.storage.torustree.folder = '~/.vim/torustree'
		endif
	endif
	if ! has_key(g:wheeltree_config.storage.torustree, 'name')
		let g:wheeltree_config.storage.torustree.name = 'torustree.vim'
	endif
	if ! has_key(g:wheeltree_config.storage.torustree, 'autowrite')
		let g:wheeltree_config.storage.torustree.autowrite = 0
	endif
	if ! has_key(g:wheeltree_config.storage.torustree, 'autoread')
		let g:wheeltree_config.storage.torustree.autoread = 0
	endif
	" -- storage session
	if ! has_key(g:wheeltree_config.storage, 'session')
		let g:wheeltree_config.storage.session = {}
	endif
	if ! has_key(g:wheeltree_config.storage.session, 'folder')
		if has('nvim')
			let g:wheeltree_config.storage.session.folder = '~/.local/share/nvim/torustree/session'
		else
			let g:wheeltree_config.storage.session.folder = '~/.vim/torustree/session'
		endif
	endif
	if ! has_key(g:wheeltree_config.storage.session, 'name')
		let g:wheeltree_config.storage.session.name = 'session.vim'
	endif
	if ! has_key(g:wheeltree_config.storage.session, 'autowrite')
		let g:wheeltree_config.storage.session.autowrite = 0
	endif
	if ! has_key(g:wheeltree_config.storage.session, 'autoread')
		let g:wheeltree_config.storage.session.autoread = 0
	endif
	" -- backups
	if ! has_key(g:wheeltree_config.storage, 'backups')
		let g:wheeltree_config.storage.backups = 3
	endif
	" ---- maxim
	if ! has_key(g:wheeltree_config, 'maxim')
		let g:wheeltree_config.maxim = {}
	endif
	if ! has_key(g:wheeltree_config.maxim, 'history')
		let g:wheeltree_config.maxim.history = 500
	endif
	if ! has_key(g:wheeltree_config.maxim, 'input')
		let g:wheeltree_config.maxim.input = 500
	endif
	if ! has_key(g:wheeltree_config.maxim, 'mru')
		let g:wheeltree_config.maxim.mru = 500
	endif
	if ! has_key(g:wheeltree_config.maxim, 'unnamed_yanks')
		let g:wheeltree_config.maxim.unnamed_yanks = 500
	endif
	if ! has_key(g:wheeltree_config.maxim, 'other_yanks')
		let g:wheeltree_config.maxim.other_yanks = 50
	endif
	if ! has_key(g:wheeltree_config.maxim, 'yank_lines')
		let g:wheeltree_config.maxim.yank_lines = 30
	endif
	if ! has_key(g:wheeltree_config.maxim, 'yank_size')
		let g:wheeltree_config.maxim.yank_size = 3000
	endif
	if ! has_key(g:wheeltree_config.maxim, 'layers')
		let g:wheeltree_config.maxim.layers = 5
	endif
	if ! has_key(g:wheeltree_config.maxim, 'tabs')
		let g:wheeltree_config.maxim.tabs = 15
	endif
	if ! has_key(g:wheeltree_config.maxim, 'horizontal')
		let g:wheeltree_config.maxim.horizontal = 3
	endif
	if ! has_key(g:wheeltree_config.maxim, 'vertical')
		let g:wheeltree_config.maxim.vertical = 4
	endif
	" ---- frecency
	if ! has_key(g:wheeltree_config, 'frecency')
		let g:wheeltree_config.frecency = {}
	endif
	if ! has_key(g:wheeltree_config.frecency, 'reward')
		let g:wheeltree_config.frecency.reward = 50
	endif
	if ! has_key(g:wheeltree_config.frecency, 'penalty')
		let g:wheeltree_config.frecency.penalty = 1
	endif
	" -- completion
	if ! has_key(g:wheeltree_config, 'completion')
		let g:wheeltree_config.completion = {}
	endif
	if ! has_key(g:wheeltree_config.completion, 'vocalize')
		let g:wheeltree_config.completion.vocalize = 0
	endif
	if ! has_key(g:wheeltree_config.completion, 'wordize')
		let g:wheeltree_config.completion.wordize = 0
	endif
	if ! has_key(g:wheeltree_config.completion, 'fuzzy')
		let g:wheeltree_config.completion.fuzzy = 0
	endif
	if ! has_key(g:wheeltree_config.completion, 'scores')
		let g:wheeltree_config.completion.scores = 0
	endif
	" ---- display
	if ! has_key(g:wheeltree_config, 'display')
		let g:wheeltree_config.display = {}
	endif
	if ! has_key(g:wheeltree_config.display, 'statusline')
		let g:wheeltree_config.display.statusline = 1
	endif
	if ! has_key(g:wheeltree_config.display, 'dedibuf_msg')
		let g:wheeltree_config.display.dedibuf_msg = 'one-line'
	endif
	if ! has_key(g:wheeltree_config.display, 'prompt')
		let g:wheeltree_config.display.prompt = torustree#crystal#fetch ('mandala/prompt')
	endif
	if ! has_key(g:wheeltree_config.display, 'prompt_writable')
		let g:wheeltree_config.display.prompt_writable = torustree#crystal#fetch ('mandala/prompt/writable')
	endif
	if ! has_key(g:wheeltree_config.display, 'selection')
		let g:wheeltree_config.display.selection = torustree#crystal#fetch ('selection/mark')
	endif
	" -- display sign
	if ! has_key(g:wheeltree_config.display, 'sign')
		let g:wheeltree_config.display.sign = {}
	endif
	if ! has_key(g:wheeltree_config.display.sign, 'switch')
		let g:wheeltree_config.display.sign.switch = 1
	endif
	if ! has_key(g:wheeltree_config.display.sign, 'settings')
		let settings = deepcopy(torustree#crystal#fetch ('sign/settings'))
		let g:wheeltree_config.display.sign.settings = settings
	endif
	if ! has_key(g:wheeltree_config.display.sign, 'native_settings')
		let native_settings = deepcopy(torustree#crystal#fetch ('sign/settings/native'))
		let g:wheeltree_config.display.sign.native_settings = native_settings
	endif
	" ---- debug
	if ! has_key(g:wheeltree_config, 'debug')
		let g:wheeltree_config.debug = 0
	endif
endfun

" -- non persistent variables

fun! torustree#void#mandalas ()
	" Initialize mandala buffers list
	if ! exists('g:wheeltree_bufring')
		let g:wheeltree_bufring = {}
	endif
	if ! has_key(g:wheeltree_bufring, 'mandalas')
		let g:wheeltree_bufring.mandalas = []
	endif
	if ! has_key(g:wheeltree_bufring, 'current')
		let g:wheeltree_bufring.current = -1
	endif
	if ! has_key(g:wheeltree_bufring, 'iden')
		let g:wheeltree_bufring.iden = []
	endif
	if ! has_key(g:wheeltree_bufring, 'names')
		let g:wheeltree_bufring.names = []
	endif
	if ! has_key(g:wheeltree_bufring, 'types')
		let g:wheeltree_bufring.types = []
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
	if ! exists('g:wheeltree_signs')
		let g:wheeltree_signs = {}
	endif
	" ---- locations signs
	if ! has_key(g:wheeltree_signs, 'iden')
		let g:wheeltree_signs.iden = []
	endif
	if ! has_key(g:wheeltree_signs, 'table')
		let g:wheeltree_signs.table = []
	endif
	" ---- native navigation signs
	if ! has_key(g:wheeltree_signs, 'native_iden')
		let g:wheeltree_signs.native_iden = []
	endif
	if ! has_key(g:wheeltree_signs, 'native_table')
		let g:wheeltree_signs.native_table = []
	endif
endfun

fun! torustree#void#wave ()
	" Initialize jobs dictionary
	" ---- for neovim
	if has('nvim') && ! exists('g:wheeltree_wave')
		let g:wheeltree_wave = []
	endif
	" ---- same thing for vim
	if ! has('nvim') && ! exists('g:wheeltree_ripple')
		let g:wheeltree_ripple = []
	endif
endfun

fun! torustree#void#volatile ()
	" Store non persistent state
	if ! exists('g:wheeltree_volatile')
		let g:wheeltree_volatile = {}
	endif
	" ---- Remember number of file args at startup
	" ---- before :argadd, :argdel or similar command
	if ! has_key(g:wheeltree_volatile, 'argc')
		let g:wheeltree_volatile.argc = argc()
	endif
	if ! has_key(g:wheeltree_volatile, 'argv')
		let g:wheeltree_volatile.argv = argv()
	endif
	" ---- First time read / write
	if ! has_key(g:wheeltree_volatile, 'first')
		let g:wheeltree_volatile.first = {}
		let g:wheeltree_volatile.first.write_wheel = v:true
		let g:wheeltree_volatile.first.read_wheel = v:true
		let g:wheeltree_volatile.first.write_session = v:true
		let g:wheeltree_volatile.first.read_session = v:true
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
	let mandalas = g:wheeltree_bufring.mandalas
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
	if has_key(g:wheeltree_history.alternate, 'window')
		unlet g:wheeltree_history.alternate.window
	endif
	" ---- torustree shelve
	let g:wheeltree_shelve.layout.window = 'none'
	let g:wheeltree_shelve.layout.split = 'none'
	let g:wheeltree_shelve.layout.tab = 'none'
	let g:wheeltree_shelve.layout.tabnames = []
endfun

fun! torustree#void#vanish ()
	" Unlet torustree variables
	" No need to save them in viminfo or shada file
	" since you can save them in g:wheeltree_config.storage.torustree.name
	" ---- should not be necessary, since only
	" ---- uppercase global vars are stored in viminfo / shada
	return
	let varlist = [
				\ 'g:torustree',
				\ 'g:wheeltree_helix',
				\ 'g:wheeltree_grid',
				\ 'g:wheeltree_files',
				\ 'g:wheeltree_history',
				\ 'g:wheeltree_input',
				\ 'g:wheeltree_attic',
				\ 'g:wheeltree_yank',
				\ 'g:wheeltree_shelve',
				\ 'g:wheeltree_config',
				\ 'g:wheeltree_bufring',
				\ 'g:wheeltree_wave',
				\ 'g:wheeltree_ripple',
				\ 'g:wheeltree_volatile',
				\ 'g:wheeltree_signs',
				\ ]
	call torustree#ouroboros#unlet (varlist)
endfun

" ---- init & exit

fun! torustree#void#init ()
	" Main init function
	"if g:wheeltree_volatile.argc == 0 && has('nvim')
		"echomsg 'torustree hello !'
	"endif
	" ---- keep tabs & wins ?
	if g:wheeltree_volatile.argc == 0
		let keep_tabwins = 'dont-keep'
	else
		let keep_tabwins = 'keep'
	endif
	" ---- no message at vim enter
	let verbose = v:false
	" ---- read torustree
	if g:wheeltree_config.storage.torustree.autoread > 0
		call torustree#disc#read_wheel ('', keep_tabwins, verbose)
	endif
	" ---- read session
	if g:wheeltree_config.storage.session.autoread > 0
		call torustree#disc#read_session ('', keep_tabwins, verbose)
	endif
endfun

fun! torustree#void#exit ()
	" Main exit function
	"if g:wheeltree_volatile.argc == 0 && has('nvim')
		"echomsg 'torustree bye !'
	"endif
	" ---- clean vars before writing
	call torustree#void#clean ()
	" ---- no message at vim leave
	let verbose = v:false
	" ---- save session
	if g:wheeltree_config.storage.session.autowrite > 0
		call torustree#disc#write_session ('', verbose)
	endif
	" ---- save torustree, and unlet
	if g:wheeltree_config.storage.torustree.autowrite > 0
		call torustree#disc#write_wheel('', verbose)
	endif
	call torustree#void#wipe_mandalas ()
	call torustree#void#vanish ()
endfun

" ---- fresh empty torustree, for testing

fun! torustree#void#fresh_wheel ()
	" Fresh empty torustree variables
	let prompt = 'Write old torustree to file before emptying torustree ?'
	let confirm = confirm(prompt, "&Yes\n&No", 1)
	if confirm == 1
		call torustree#disc#write_wheel ()
	endif
	let varlist = [
				\ 'g:torustree',
				\ 'g:wheeltree_helix',
				\ 'g:wheeltree_grid',
				\ 'g:wheeltree_files',
				\ 'g:wheeltree_history',
				\ 'g:wheeltree_input',
				\ 'g:wheeltree_attic',
				\ 'g:wheeltree_wave',
				\ 'g:wheeltree_ripple',
				\ 'g:wheeltree_yank',
				\ 'g:wheeltree_bufring',
				\ 'g:wheeltree_signs',
				\ 'g:wheeltree_shelve',
				\ ]
	call torustree#ouroboros#unlet (varlist)
	call torustree#void#foundation ()
endfun
