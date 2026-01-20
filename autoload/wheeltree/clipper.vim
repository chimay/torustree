" vim: set ft=vim fdm=indent iskeyword&:

" Clipper
"
" Yank dedicated buffers

" ---- script constants

if exists('s:registers_symbols')
	unlockvar s:registers_symbols
endif
let s:registers_symbols = wheeltree#crystal#fetch('registers-symbols')
lockvar s:registers_symbols

" ---- functions

fun! wheeltree#clipper#yank (mode)
	" Choose yank and paste
	let mode = a:mode
	let default_register = g:wheeltree_shelve.yank.default_register
	let lines = wheeltree#perspective#yank_mandala (mode, default_register)
	" ---- type from mode & register
	if mode ==# 'plain'
		let type = 'yank/'
	elseif mode ==# 'list'
		let type = 'yank/list/'
	endif
	if default_register ==# 'overview'
		let type ..= 'overview'
	elseif default_register ==# 'file'
		let type ..= '%%'
	else
		let symbols_dict = wheeltree#matrix#items2dict(s:registers_symbols)
		let type ..= symbols_dict[default_register]
	endif
	" ---- mandala
	call wheeltree#mandala#blank (type)
	let settings = #{
				\ mode : mode,
				\ yank : #{ register : default_register },
				\ }
	call wheeltree#codex#template(settings)
	call wheeltree#mandala#fill (lines)
	setlocal nomodified
	" ---- reload
	call wheeltree#mandala#set_reload('wheeltree#clipper#yank', mode)
endfun
