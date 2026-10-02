" vim: set ft=vim fdm=indent iskeyword&:

" River
"
" Navigation aspect of mandala

" ---- script constants

if exists('s:torustree_content_generators')
	unlockvar s:torustree_content_generators
endif
let s:torustree_content_generators = torustree#crystal#fetch('function/generator/torustree')
lockvar s:torustree_content_generators

" ---- default values

fun! torustree#river#default (settings)
	" Default settings values
	let settings = a:settings
	if ! settings->has_key('function')
		let settings.function = 'torustree#curve#switch'
	endif
	if ! settings->has_key('selection')
		let settings.selection = {}
		let settings.selection.index = -1
		let settings.selection.component = ''
	endif
	if ! settings->has_key('level')
		let settings.level = 'location'
	endif
	if ! settings->has_key('target')
		let settings.target = 'here'
	endif
	if ! settings->has_key('related')
		let settings.related = b:torustree_related
	endif
	if ! settings->has_key('follow')
		let settings.follow = v:false
	endif
	if ! settings->has_key('close')
		let settings.close = v:true
	endif
endfun

" ---- helpers

fun! torustree#river#mappings (settings)
	" Define whirl maps & set navigation property
	let settings = copy(a:settings)
	" ---- property
	let b:torustree_nature.has_navigation = v:true
	" ---- maps
	let nmap = 'nnoremap <buffer>'
	let loopnav = '<cmd>call torustree#loop#navigation('
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
	call torustree#pencil#mappings ()
	" -- preview
	call torustree#orbiter#mappings ()
	" -- context menu
	call torustree#boomerang#launch_map ('navigation')
endfun

fun! torustree#river#template (settings)
	" Template
	let settings = a:settings
	call torustree#mandala#template (settings)
	call torustree#river#mappings (settings)
endfun

fun! torustree#river#generic (type)
	" Generic whirl buffer
	let type = a:type
	if type->torustree#chain#is_inside(s:torustree_content_generators)
		let Generator = function('torustree#flower#' .. type)
	else
		let Generator = function('torustree#perspective#' .. type)
	endif
	let lines = Generator ()
	if empty(lines)
		echomsg 'torustree whirl generic : empty lines in' type
		return v:false
	endif
	call torustree#mandala#blank (type)
	let settings = #{ function : 'torustree#curve#' .. type }
	call torustree#river#template (settings)
	call torustree#mandala#fill(lines)
	" reload
	call torustree#mandala#set_reload('torustree#whirl#' .. type)
endfun
