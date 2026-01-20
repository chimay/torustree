" vim: set ft=vim fdm=indent iskeyword&:

" Void
"
" Initialization of variables
"
" Enter the void, and ride the wheeltree

" ---- script constants

if exists('s:mandala_autocmds_group')
	unlockvar s:mandala_autocmds_group
endif
let s:mandala_autocmds_group = wheeltree#crystal#fetch('mandala/autocmds/group')
lockvar s:mandala_autocmds_group

" ---- no-op function

fun! wheeltree#void#nope (...)
	" Does nothing, returns its argument list
	" Application : for meta-command subcommands thas need a third argument
	return a:000
endfun

" ---- helpers

fun! wheeltree#void#template(init)
	" Generate template to add to g:wheeltree lists
	" Name = name in argument
	" Optional arguments : keys initialized as empty list
	let template = a:init
	let template.glossary = []
	let template.current = -1
	return template
endfun

" ---- initialize individual variables

" -- persistent variables

fun! wheeltree#void#wheeltree ()
	" Initialize wheeltree
	if ! exists('g:wheeltree')
		let g:wheeltree = {}
	endif
	if ! has_key(g:wheeltree, 'elements')
		let g:wheeltree.toruses = []
	endif
	if ! has_key(g:wheeltree, 'glossary')
		let g:wheeltree.glossary = []
	endif
	if ! has_key(g:wheeltree, 'current')
		let g:wheeltree.current = -1
	endif
	if ! has_key(g:wheeltree, 'timestamp')
		let g:wheeltree.timestamp = -1
	endif
endfun

fun! wheeltree#void#helix ()
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

fun! wheeltree#void#grid ()
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

fun! wheeltree#void#files ()
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

fun! wheeltree#void#history ()
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

fun! wheeltree#void#input ()
	" Initialize input history
	if ! exists('g:wheeltree_input')
		let g:wheeltree_input = []
	endif
endfun

fun! wheeltree#void#shelve ()
	" Initialize shelve : misc status variables
	if ! exists('g:wheeltree_shelve')
		let g:wheeltree_shelve = {}
	endif
	" ---- current
	if ! has_key(g:wheeltree_shelve, 'current')
		let g:wheeltree_shelve.current = {}
	endif
	" -- wheeltree file
	if ! has_key(g:wheeltree_shelve.current, 'wheeltree')
		let g:wheeltree_shelve.current.wheeltree = ''
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

fun! wheeltree#void#attic ()
	" Initialize most recently used files
	if ! exists('g:wheeltree_attic')
		let g:wheeltree_attic = []
	endif
endfun

fun! wheeltree#void#yank ()
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

fun! wheeltree#void#config ()
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
	" -- storage wheeltree
	if ! has_key(g:wheeltree_config.storage, 'wheeltree')
		let g:wheeltree_config.storage.wheeltree = {}
	endif
	if ! has_key(g:wheeltree_config.storage.wheeltree, 'folder')
		if has('nvim')
			let g:wheeltree_config.storage.wheeltree.folder = '~/.local/share/nvim/wheeltree'
		else
			let g:wheeltree_config.storage.wheeltree.folder = '~/.vim/wheeltree'
		endif
	endif
	if ! has_key(g:wheeltree_config.storage.wheeltree, 'name')
		let g:wheeltree_config.storage.wheeltree.name = 'wheeltree.vim'
	endif
	if ! has_key(g:wheeltree_config.storage.wheeltree, 'autowrite')
		let g:wheeltree_config.storage.wheeltree.autowrite = 0
	endif
	if ! has_key(g:wheeltree_config.storage.wheeltree, 'autoread')
		let g:wheeltree_config.storage.wheeltree.autoread = 0
	endif
	" -- storage session
	if ! has_key(g:wheeltree_config.storage, 'session')
		let g:wheeltree_config.storage.session = {}
	endif
	if ! has_key(g:wheeltree_config.storage.session, 'folder')
		if has('nvim')
			let g:wheeltree_config.storage.session.folder = '~/.local/share/nvim/wheeltree/session'
		else
			let g:wheeltree_config.storage.session.folder = '~/.vim/wheeltree/session'
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
		let g:wheeltree_config.display.prompt = wheeltree#crystal#fetch ('mandala/prompt')
	endif
	if ! has_key(g:wheeltree_config.display, 'prompt_writable')
		let g:wheeltree_config.display.prompt_writable = wheeltree#crystal#fetch ('mandala/prompt/writable')
	endif
	if ! has_key(g:wheeltree_config.display, 'selection')
		let g:wheeltree_config.display.selection = wheeltree#crystal#fetch ('selection/mark')
	endif
	" -- display sign
	if ! has_key(g:wheeltree_config.display, 'sign')
		let g:wheeltree_config.display.sign = {}
	endif
	if ! has_key(g:wheeltree_config.display.sign, 'switch')
		let g:wheeltree_config.display.sign.switch = 1
	endif
	if ! has_key(g:wheeltree_config.display.sign, 'settings')
		let settings = deepcopy(wheeltree#crystal#fetch ('sign/settings'))
		let g:wheeltree_config.display.sign.settings = settings
	endif
	if ! has_key(g:wheeltree_config.display.sign, 'native_settings')
		let native_settings = deepcopy(wheeltree#crystal#fetch ('sign/settings/native'))
		let g:wheeltree_config.display.sign.native_settings = native_settings
	endif
	" ---- debug
	if ! has_key(g:wheeltree_config, 'debug')
		let g:wheeltree_config.debug = 0
	endif
endfun

" -- non persistent variables

fun! wheeltree#void#mandalas ()
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

fun! wheeltree#void#autogroup ()
	" Define empty wheeltree-mandala auto command group
	execute 'augroup' s:mandala_autocmds_group
		autocmd!
	augroup END
endfun

fun! wheeltree#void#signs ()
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

fun! wheeltree#void#wave ()
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

fun! wheeltree#void#volatile ()
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

fun! wheeltree#void#foundation ()
	" Initialize wheeltree
	" ---- pre conversion from old keys
	call wheeltree#kintsugi#pre ()
	" ---- persistent wheeltree variables
	call wheeltree#void#wheeltree ()
	call wheeltree#void#helix ()
	call wheeltree#void#grid ()
	call wheeltree#void#files ()
	call wheeltree#void#history ()
	call wheeltree#void#input ()
	call wheeltree#void#shelve ()
	call wheeltree#void#attic ()
	call wheeltree#void#yank ()
	" ---- config
	call wheeltree#void#config ()
	" ---- non persistent wheeltree variables
	call wheeltree#void#mandalas ()
	call wheeltree#void#autogroup ()
	call wheeltree#void#signs ()
	call wheeltree#void#wave ()
	call wheeltree#void#volatile ()
	" ---- post conversion from old keys
	call wheeltree#kintsugi#post ()
endfun

" ---- wipe mandala buffers

fun! wheeltree#void#wipe_mandalas ()
	" Wipe mandalas buffers
	let buflist = getbufinfo()
	let mandalas = g:wheeltree_bufring.mandalas
	for buffer in buflist
		let bufnum = buffer.bufnr
		if wheeltree#chain#is_inside(bufnum, mandalas)
			execute 'silent bwipe!' bufnum
		endif
	endfor
endfun

" ---- unlet variables

fun! wheeltree#void#clean ()
	" Clean variables before writing wheeltree to file
	" ---- wheeltree history
	if has_key(g:wheeltree_history.alternate, 'window')
		unlet g:wheeltree_history.alternate.window
	endif
	" ---- wheeltree shelve
	let g:wheeltree_shelve.layout.window = 'none'
	let g:wheeltree_shelve.layout.split = 'none'
	let g:wheeltree_shelve.layout.tab = 'none'
	let g:wheeltree_shelve.layout.tabnames = []
endfun

fun! wheeltree#void#vanish ()
	" Unlet wheeltree variables
	" No need to save them in viminfo or shada file
	" since you can save them in g:wheeltree_config.storage.wheeltree.name
	" ---- should not be necessary, since only
	" ---- uppercase global vars are stored in viminfo / shada
	return
	let varlist = [
				\ 'g:wheeltree',
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
	call wheeltree#ouroboros#unlet (varlist)
endfun

" ---- init & exit

fun! wheeltree#void#init ()
	" Main init function
	"if g:wheeltree_volatile.argc == 0 && has('nvim')
		"echomsg 'wheeltree hello !'
	"endif
	" ---- keep tabs & wins ?
	if g:wheeltree_volatile.argc == 0
		let keep_tabwins = 'dont-keep'
	else
		let keep_tabwins = 'keep'
	endif
	" ---- no message at vim enter
	let verbose = v:false
	" ---- read wheeltree
	if g:wheeltree_config.storage.wheeltree.autoread > 0
		call wheeltree#disc#read_wheel ('', keep_tabwins, verbose)
	endif
	" ---- read session
	if g:wheeltree_config.storage.session.autoread > 0
		call wheeltree#disc#read_session ('', keep_tabwins, verbose)
	endif
endfun

fun! wheeltree#void#exit ()
	" Main exit function
	"if g:wheeltree_volatile.argc == 0 && has('nvim')
		"echomsg 'wheeltree bye !'
	"endif
	" ---- clean vars before writing
	call wheeltree#void#clean ()
	" ---- no message at vim leave
	let verbose = v:false
	" ---- save session
	if g:wheeltree_config.storage.session.autowrite > 0
		call wheeltree#disc#write_session ('', verbose)
	endif
	" ---- save wheeltree, and unlet
	if g:wheeltree_config.storage.wheeltree.autowrite > 0
		call wheeltree#disc#write_wheel('', verbose)
	endif
	call wheeltree#void#wipe_mandalas ()
	call wheeltree#void#vanish ()
endfun

" ---- fresh empty wheeltree, for testing

fun! wheeltree#void#fresh_wheel ()
	" Fresh empty wheeltree variables
	let prompt = 'Write old wheeltree to file before emptying wheeltree ?'
	let confirm = confirm(prompt, "&Yes\n&No", 1)
	if confirm == 1
		call wheeltree#disc#write_wheel ()
	endif
	let varlist = [
				\ 'g:wheeltree',
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
	call wheeltree#ouroboros#unlet (varlist)
	call wheeltree#void#foundation ()
endfun
