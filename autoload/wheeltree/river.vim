" vim: set ft=vim fdm=indent iskeyword&:

" River
"
" Navigation aspect of mandala

" ---- script constants

if exists('s:wheel_content_generators')
	unlockvar s:wheel_content_generators
endif
let s:wheel_content_generators = wheeltree#crystal#fetch('function/generator/wheeltree')
lockvar s:wheel_content_generators

" ---- default values

fun! wheeltree#river#default (settings)
	" Default settings values
	let settings = a:settings
	if ! has_key(settings, 'function')
		let settings.function = 'wheeltree#curve#switch'
	endif
	if ! has_key(settings, 'selection')
		let settings.selection = {}
		let settings.selection.index = -1
		let settings.selection.component = ''
	endif
	if ! has_key(settings, 'level')
		let settings.level = 'location'
	endif
	if ! has_key(settings, 'target')
		let settings.target = 'here'
	endif
	if ! has_key(settings, 'related')
		let settings.related = b:wheel_related
	endif
	if ! has_key(settings, 'follow')
		let settings.follow = v:false
	endif
	if ! has_key(settings, 'close')
		let settings.close = v:true
	endif
endfun

" ---- helpers

fun! wheeltree#river#mappings (settings)
	" Define whirl maps & set navigation property
	let settings = copy(a:settings)
	" ---- property
	let b:wheel_nature.has_navigation = v:true
	" ---- maps
	let nmap = 'nnoremap <buffer>'
	let loopnav = '<cmd>call wheeltree#loop#navigation('
	let coda = ')<cr>'
	" -- close after navigation
	let settings.close = v:true
	let settings.target = 'here'
	execute nmap '<cr>' loopnav .. string(settings) .. coda
	let settings.target = 'tab'
	execute nmap 't' loopnav .. string(settings) .. coda
	let settings.target = 'horizontal_split'
	execute nmap 'h' loopnav .. string(settings) .. coda
	let settings.target = 'vertical_split'
	execute nmap 'v' loopnav .. string(settings) .. coda
	let settings.target = 'horizontal_golden'
	execute nmap 'H' loopnav .. string(settings) .. coda
	let settings.target = 'vertical_golden'
	execute nmap 'V' loopnav .. string(settings) .. coda
	" -- leave open after navigation
	let settings.close = v:false
	let settings.target = 'here'
	execute nmap 'g<cr>' loopnav .. string(settings) .. coda
	let settings.target = 'tab'
	execute nmap 'gt' loopnav .. string(settings) .. coda
	let settings.target = 'horizontal_split'
	execute nmap 'gh' loopnav .. string(settings) .. coda
	let settings.target = 'vertical_split'
	execute nmap 'gv' loopnav .. string(settings) .. coda
	let settings.target = 'horizontal_golden'
	execute nmap 'gH' loopnav .. string(settings) .. coda
	let settings.target = 'vertical_golden'
	execute nmap 'gV' loopnav .. string(settings) .. coda
	" -- selection
	call wheeltree#pencil#mappings ()
	" -- preview
	call wheeltree#orbiter#mappings ()
	" -- context menu
	call wheeltree#boomerang#launch_map ('navigation')
endfun

fun! wheeltree#river#template (settings)
	" Template
	let settings = a:settings
	call wheeltree#mandala#template (settings)
	call wheeltree#river#mappings (settings)
endfun

fun! wheeltree#river#generic (type)
	" Generic whirl buffer
	let type = a:type
	if type->wheeltree#chain#is_inside(s:wheel_content_generators)
		let Generator = function('wheeltree#flower#' .. type)
	else
		let Generator = function('wheeltree#perspective#' .. type)
	endif
	let lines = Generator ()
	if empty(lines)
		echomsg 'wheeltree whirl generic : empty lines in' type
		return v:false
	endif
	call wheeltree#mandala#blank (type)
	let settings = #{ function : 'wheeltree#curve#' .. type }
	call wheeltree#river#template (settings)
	call wheeltree#mandala#fill(lines)
	" reload
	call wheeltree#mandala#set_reload('wheeltree#whirl#' .. type)
endfun
