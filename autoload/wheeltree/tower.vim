" vim: set ft=vim fdm=indent iskeyword&:

" Tower
"
" Menu leaf for mandalas

" script constants

if exists('s:fun_is_navigation')
	unlockvar s:fun_is_navigation
endif
let s:fun_is_navigation = wheeltree#crystal#fetch('function/pattern/navigation')
lockvar s:fun_is_navigation

if exists('s:fun_opens_mandala')
	unlockvar s:fun_opens_mandala
endif
let s:fun_opens_mandala = wheeltree#crystal#fetch('function/pattern/mandala/opens')
lockvar s:fun_opens_mandala

if exists('s:fun_needs_mandala')
	unlockvar s:fun_needs_mandala
endif
let s:fun_needs_mandala = wheeltree#crystal#fetch('function/pattern/mandala/needs')
lockvar s:fun_needs_mandala

" ---- booleans

fun! wheeltree#tower#is_navigation (function)
	" Whether function is a navigation one
	let function = a:function
	for pattern in s:fun_is_navigation
		if function =~ pattern
			return v:true
		endif
	endfor
	return v:false
endfun

fun! wheeltree#tower#opens_mandala (function)
	" Whether function opens a mandala
	let function = a:function
	for pattern in s:fun_opens_mandala
		if function =~ pattern
			return v:true
		endif
	endfor
	return v:false
endfun

fun! wheeltree#tower#needs_mandala (function)
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

fun! wheeltree#tower#action (settings)
	" Calls function given by the key = cursor line
	" settings is a dictionary containing settings.menu
	" settings.menu keys can be :
	" - linefun : name of a dictionary variable in storage.vim
	" - close : whether to close mandala buffer
	let settings = a:settings
	let menu_settings = settings.menu
	let dict = wheeltree#quartz#fetch (menu_settings.linefun, 'dict')
	let close = menu_settings.close
	" ---- pre checks
	let cursor_line = getline('.')
	if empty(cursor_line)
		echomsg 'wheeltree line menu : you selected an empty line'
		return v:false
	endif
	let key = cursor_line
	if ! has_key(dict, key)
		echomsg 'wheeltree line menu : key not found'
		return v:false
	endif
	" ---- function to use
	let function = dict[key]
	" ---- navigation functions needs to be on the previous, regular window
	if wheeltree#tower#is_navigation (function)
		call wheeltree#rectangle#goto_previous ()
	endif
	" --- if functions opens or needs a mandala, override the close setting
	let uses_mandala = wheeltree#tower#opens_mandala (function)
	let uses_mandala = uses_mandala || wheeltree#tower#needs_mandala (function)
	if uses_mandala
		let close = v:false
	endif
	" ---- call function linked to cursor line
	let winiden = wheeltree#metafun#call (function)
	" ---- coda
	if close
		call wheeltree#cylinder#close ()
		" -- go to last destination
		call wheeltree#gear#win_gotoid (winiden)
	else
		call wheeltree#gear#win_gotoid (winiden)
		call wheeltree#cylinder#recall()
	endif
	return v:true
endfun

fun! wheeltree#tower#mappings (settings)
	" Define maps
	let settings = deepcopy(a:settings)
	let menu_settings = settings.menu
	" ---- menu specific maps
	let map = 'nnoremap <buffer>'
	let linefun = '<cmd>call wheeltree#tower#action('
	let coda = ')<cr>'
	" ---- open / close : default in settings
	execute map '<cr>' linefun .. string(settings) .. coda
	" ---- leave the mandala opened
	let menu_settings.close = v:false
	execute map 'g<cr>'   linefun .. string(settings) .. coda
	execute map '<tab>'   linefun .. string(settings) .. coda
	execute map '<space>' linefun .. string(settings) .. coda
endfun

fun! wheeltree#tower#staircase (menuset, settings = {})
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
	call wheeltree#mandala#blank (dictname)
	call wheeltree#mandala#template ()
	" ---- mappings
	call wheeltree#tower#mappings (settings)
	" ---- fill with dict keys
	let items = wheeltree#quartz#fetch (dictname)
	let lines = wheeltree#matrix#items2keys (items)
	call wheeltree#mandala#fill (lines)
	" ---- properties
	let b:wheel_nature.class = menuset.class
	let b:wheel_nature.has_filter = v:true
	" ---- save settings
	let b:wheel_settings = settings
endfun
