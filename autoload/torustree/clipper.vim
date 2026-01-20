" vim: set ft=vim fdm=indent iskeyword&:

" Clipper
"
" Yank dedicated buffers

" ---- script constants

if exists('s:registers_symbols')
	unlockvar s:registers_symbols
endif
let s:registers_symbols = torustree#crystal#fetch('registers-symbols')
lockvar s:registers_symbols

" ---- functions

fun! torustree#clipper#yank (mode)
	" Choose yank and paste
	let mode = a:mode
	let default_register = g:torustree_shelve.yank.default_register
	let lines = torustree#perspective#yank_mandala (mode, default_register)
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
		let symbols_dict = torustree#matrix#items2dict(s:registers_symbols)
		let type ..= symbols_dict[default_register]
	endif
	" ---- mandala
	call torustree#mandala#blank (type)
	let settings = #{
				\ mode : mode,
				\ yank : #{ register : default_register },
				\ }
	call torustree#codex#template(settings)
	call torustree#mandala#fill (lines)
	setlocal nomodified
	" ---- reload
	call torustree#mandala#set_reload('torustree#clipper#yank', mode)
endfun
