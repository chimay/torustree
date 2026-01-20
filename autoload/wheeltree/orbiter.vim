" vim: set ft=vim fdm=indent iskeyword&:

" Orbiter
"
" Preview for dedicated buffers
"
" Note : b:wheel_preview.follow has nothing to do
" with settings.follow. The latter is used to decide
" whether to use projection#follow on target locations

" ---- booleans

fun! wheeltree#orbiter#has_preview ()
	" Whether current mandala has preview
	return b:wheel_nature.has_preview
endfun

" ---- functions

fun! wheeltree#orbiter#preview ()
	" Preview buffer matching current line
	if ! b:wheel_preview.used
		let b:wheel_preview.used = v:true
		let b:wheel_preview.original = wheeltree#rectangle#previous ()
	endif
	let settings = b:wheel_settings
	call wheeltree#river#default (settings)
	let cursor_info = wheeltree#pencil#cursor ()
	let settings.selection.index = cursor_info.index
	let settings.selection.component = cursor_info.component
	let settings.follow = v:false
	call wheeltree#rectangle#goto_previous ()
	call wheeltree#projection#follow ()
	" ---- user update autocmd
	silent doautocmd User WheelBeforeJump
	" ---- call mandala function
	let Fun = settings.function
	let winiden = wheeltree#metafun#call (Fun, settings)
	call wheeltree#cylinder#recall ()
	return winiden
endfun

fun! wheeltree#orbiter#switch_off ()
	" Switch off preview local variables
	let b:wheel_preview.used = v:false
	let b:wheel_preview.follow = v:false
	let b:wheel_preview.original = {}
endfun

fun! wheeltree#orbiter#original ()
	" Restore original buffer
	if ! b:wheel_preview.used
		return {}
	endif
	let original = copy(b:wheel_preview.original)
	call wheeltree#orbiter#switch_off ()
	call wheeltree#rectangle#goto (original)
	call wheeltree#projection#follow ()
	call wheeltree#cylinder#recall ()
	return original
endfun

fun! wheeltree#orbiter#follow ()
	" Preview current line each time the cursor move with j/k
	if ! b:wheel_preview.used
		let b:wheel_preview.used = v:true
		let b:wheel_preview.original = wheeltree#rectangle#previous ()
	endif
	call wheeltree#orbiter#preview ()
	let b:wheel_preview.follow = v:true
endfun

fun! wheeltree#orbiter#unfollow ()
	" Cancel preview following
	return wheeltree#orbiter#original ()
endfun

fun! wheeltree#orbiter#toggle_follow ()
	" Toggle preview following
	if b:wheel_preview.follow
		call wheeltree#orbiter#unfollow ()
	else
		call wheeltree#orbiter#follow ()
	endif
endfun

fun! wheeltree#orbiter#mappings ()
	" Define preview maps
	nnoremap <buffer> p <cmd>call wheeltree#orbiter#preview()<cr>
	nnoremap <buffer> o <cmd>call wheeltree#orbiter#original()<cr>
	nnoremap <buffer> f <cmd>call wheeltree#orbiter#toggle_follow()<cr>
	" ---- properties
	let b:wheel_nature.has_preview = v:true
endfun
