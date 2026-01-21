" vim: set ft=vim fdm=indent iskeyword&:

" Orbiter
"
" Preview for dedicated buffers
"
" Note : b:torustree_preview.follow has nothing to do
" with settings.follow. The latter is used to decide
" whether to use projection#follow on target locations

" ---- booleans

fun! torustree#orbiter#has_preview ()
	" Whether current mandala has preview
	return b:torustree_nature.has_preview
endfun

" ---- functions

fun! torustree#orbiter#preview ()
	" Preview buffer matching current line
	if ! b:torustree_preview.used
		let b:torustree_preview.used = v:true
		let b:torustree_preview.original = torustree#rectangle#previous ()
	endif
	let settings = b:torustree_settings
	call torustree#river#default (settings)
	let cursor_info = torustree#pencil#cursor ()
	let settings.selection.index = cursor_info.index
	let settings.selection.component = cursor_info.component
	let settings.follow = v:false
	call torustree#rectangle#goto_previous ()
	call torustree#projection#follow ()
	" ---- user update autocmd
	silent doautocmd User TorustreeBeforeJump
	" ---- call mandala function
	let Fun = settings.function
	let winiden = torustree#metafun#call (Fun, settings)
	call torustree#cylinder#recall ()
	return winiden
endfun

fun! torustree#orbiter#switch_off ()
	" Switch off preview local variables
	let b:torustree_preview.used = v:false
	let b:torustree_preview.follow = v:false
	let b:torustree_preview.original = {}
endfun

fun! torustree#orbiter#original ()
	" Restore original buffer
	if ! b:torustree_preview.used
		return {}
	endif
	let original = copy(b:torustree_preview.original)
	call torustree#orbiter#switch_off ()
	call torustree#rectangle#goto (original)
	call torustree#projection#follow ()
	call torustree#cylinder#recall ()
	return original
endfun

fun! torustree#orbiter#follow ()
	" Preview current line each time the cursor move with j/k
	if ! b:torustree_preview.used
		let b:torustree_preview.used = v:true
		let b:torustree_preview.original = torustree#rectangle#previous ()
	endif
	call torustree#orbiter#preview ()
	let b:torustree_preview.follow = v:true
endfun

fun! torustree#orbiter#unfollow ()
	" Cancel preview following
	return torustree#orbiter#original ()
endfun

fun! torustree#orbiter#toggle_follow ()
	" Toggle preview following
	if b:torustree_preview.follow
		call torustree#orbiter#unfollow ()
	else
		call torustree#orbiter#follow ()
	endif
endfun

fun! torustree#orbiter#mappings ()
	" Define preview maps
	nnoremap <buffer> p <cmd>call torustree#orbiter#preview()<cr>
	nnoremap <buffer> o <cmd>call torustree#orbiter#original()<cr>
	nnoremap <buffer> f <cmd>call torustree#orbiter#toggle_follow()<cr>
	" ---- properties
	let b:torustree_nature.has_preview = v:true
endfun
