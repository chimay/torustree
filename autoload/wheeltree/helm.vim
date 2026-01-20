" vim: set ft=vim fdm=indent iskeyword&:

" Helm
"
" Menus

" ---- script constants

if exists('s:fold_markers')
	unlockvar s:fold_markers
endif
let s:fold_markers = wheeltree#crystal#fetch('fold/markers')
let s:fold_markers = join(s:fold_markers, ',')
lockvar s:fold_markers

if exists('s:fold_1')
	unlockvar s:fold_1
endif
let s:fold_1 = wheeltree#crystal#fetch('fold/one')
lockvar s:fold_1

if exists('s:menu_list')
	unlockvar s:menu_list
endif
let s:menu_list = wheeltree#quartz#fetch('menu/list')
lockvar s:menu_list

" ---- booleans

fun! wheeltree#helm#is_menu ()
	" Whether mandala leaf is a menu
	return b:wheel_nature.class =~ '^menu'
endfun

" ---- folding

fun! wheeltree#helm#folding_options ()
	" Folding options for menu
	setlocal foldenable
	setlocal foldminlines=1
	setlocal foldlevel=0
	setlocal foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
	setlocal foldclose=
	setlocal foldmethod=marker
	let &l:foldmarker = s:fold_markers
	setlocal foldcolumn=2
	setlocal foldtext=wheeltree#helm#folding_text()
endfun

fun! wheeltree#helm#folding_text ()
	" Folding text for menu
	let numlines = v:foldend - v:foldstart
	let line = getline(v:foldstart)
	if v:foldlevel == 1
		let level = 'submenu'
	else
		let level = 'none'
	endif
	let marker = s:fold_markers[0]
	let pattern = '\m' .. marker .. '[12]'
	let repl = ':: ' .. level
	let line = substitute(line, pattern, repl, '')
	let text = line .. ' :: ' .. numlines .. ' lines ' .. v:folddashes
	return text
endfun

" ---- menus

fun! wheeltree#helm#main ()
	" Main menu in mandala buffer
	let menuset = #{
				\ class : 'menu/main',
				\ linefun : 'menu/main',
				\ close : v:true,
				\ }
	" ---- blank mandala
	call wheeltree#mandala#blank ('menu/main')
	call wheeltree#mandala#template ()
	" ---- mappings
	let settings = {}
	let settings.menu = menuset
	call wheeltree#tower#mappings (settings)
	" ---- build menu lines
	let mainmenu = []
	for category in s:menu_list
		let header = category .. s:fold_1
		let items = wheeltree#quartz#fetch('menu/' .. category)
		let submenu = wheeltree#matrix#items2keys (items)
		eval mainmenu->add(header)
		eval mainmenu->extend(submenu)
	endfor
	" ---- fill
	call wheeltree#mandala#fill(mainmenu)
	" ---- folding
	call wheeltree#helm#folding_options ()
	" -- properties
	let b:wheel_nature.class = 'menu/main'
	let b:wheel_nature.has_filter = v:true
	" ---- save settings
	let b:wheel_settings = settings
endfun

fun! wheeltree#helm#meta ()
	" Meta menu in mandala buffer
	let menuset = #{
				\ class : 'menu/meta',
				\ linefun : 'menu/meta',
				\ close : v:false,
				\ }
	call wheeltree#tower#staircase(menuset)
endfun

fun! wheeltree#helm#submenu (dictname)
	" Submenu
	let dictname = 'menu/' .. a:dictname
	let menuset = #{
				\ class : 'menu/submenu',
				\ linefun : dictname,
				\ close : v:true,
				\ }
	call wheeltree#tower#staircase (menuset)
endfun
