" vim: set ft=vim fdm=indent iskeyword&:

" Tower
"
" Menu leaf for mandalas

" script constants

if exists('s:fun_is_navigation')
	unlockvar s:fun_is_navigation
endif
let s:fun_is_navigation = torustree#crystal#fetch('function/pattern/navigation')
lockvar s:fun_is_navigation

if exists('s:fun_opens_mandala')
	unlockvar s:fun_opens_mandala
endif
let s:fun_opens_mandala = torustree#crystal#fetch('function/pattern/mandala/opens')
lockvar s:fun_opens_mandala

if exists('s:fun_needs_mandala')
	unlockvar s:fun_needs_mandala
endif
let s:fun_needs_mandala = torustree#crystal#fetch('function/pattern/mandala/needs')
lockvar s:fun_needs_mandala

" ---- booleans

fun! torustree#tower#is_navigation (function)
	" Whether function is a navigation one
	let function = a:function
	for pattern in s:fun_is_navigation
		if function =~ pattern
			return v:true
		endif
	endfor
	return v:false
endfun

fun! torustree#tower#opens_mandala (function)
	" Whether function opens a mandala
	let function = a:function
	for pattern in s:fun_opens_mandala
		if function =~ pattern
			return v:true
		endif
	endfor
	return v:false
endfun

fun! torustree#tower#needs_mandala (function)
	" Whether function needs a mandala
	let function = a:function
	for pattern in s:fun_needs_mandala
		if function =~ pattern
			return v:true
		endif
	endfor
	return v:false
endfun

" ---- main

fun! torustree#tower#action (settings)
	" Calls function given by the key = cursor line
	" settings is a dictionary containing settings.menu
	" settings.menu keys can be :
	" - linefun : name of a dictionary variable in storage.vim
	" - close : whether to close mandala buffer
	let settings = a:settings
	let menu_settings = settings.menu
	let dict = torustree#quartz#fetch (menu_settings.linefun, 'dict')
	let close = menu_settings.close
	" ---- pre checks
	let cursor_line = getline('.')
	if empty(cursor_line)
		echomsg 'torustree line menu : you selected an empty line'
		return v:false
	endif
	let key = cursor_line
	if ! dict->has_key(key)
		echomsg 'torustree line menu : key not found'
		return v:false
	endif
	" ---- function to use
	let function = dict[key]
	" ---- navigation functions needs to be on the previous, regular window
	if torustree#tower#is_navigation (function)
		call torustree#rectangle#goto_previous ()
	endif
	" --- if functions opens or needs a mandala, override the close setting
	let uses_mandala = torustree#tower#opens_mandala (function)
	let uses_mandala = uses_mandala || torustree#tower#needs_mandala (function)
	if uses_mandala
		let close = v:false
	endif
	" ---- call function linked to cursor line
	let winiden = torustree#metafun#call (function)
	" ---- coda
	if close
		call torustree#cylinder#close ()
		" -- go to last destination
		call torustree#gear#win_gotoid (winiden)
	else
		call torustree#gear#win_gotoid (winiden)
		call torustree#cylinder#recall()
	endif
	return v:true
endfun

fun! torustree#tower#mappings (settings)
	" Define maps
	let settings = deepcopy(a:settings)
	let menu_settings = settings.menu
	" ---- menu specific maps
	let map = 'nnoremap <buffer>'
	let linefun = '<cmd>call torustree#tower#action('
	let coda = ')<cr>'
	" ---- open / close : default in settings
	execute map '<cr>' linefun .. string(settings) .. coda
	" ---- leave the mandala opened
	let menu_settings.close = v:false
	execute map 'g<cr>'   linefun .. string(settings) .. coda
	execute map '<tab>'   linefun .. string(settings) .. coda
	execute map '<space>' linefun .. string(settings) .. coda
endfun

fun! torustree#tower#staircase (menuset, settings = {})
	" Replace buffer content by a {line -> fun} leaf
	" Define dict maps
	" Used for :
	"   - meta menu & submenus
	"   - context menu leaf
	let menuset = a:menuset
	let settings = deepcopy(a:settings)
	let dictname = menuset.linefun
	let settings.menu = menuset
	" ---- blank mandala
	call torustree#mandala#blank (dictname)
	call torustree#mandala#template ()
	" ---- mappings
	call torustree#tower#mappings (settings)
	" ---- fill with dict keys
	let items = torustree#quartz#fetch (dictname)
	let lines = torustree#matrix#items2keys (items)
	call torustree#mandala#fill (lines)
	" ---- properties
	let b:torustree_nature.class = menuset.class
	let b:torustree_nature.has_filter = v:true
	" ---- save settings
	let b:torustree_settings = settings
endfun
