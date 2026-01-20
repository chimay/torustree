" vim: set ft=vim fdm=indent iskeyword&:

" Scroll
"
" Input history

fun! wheeltree#scroll#record (content)
	" Add content to beginning of input history
	let content = a:content
	if type(content) == v:t_list
		let content = join(content)
	endif
	let input = g:wheeltree_input
	let index = input->index(content)
	if index >= 0
		eval input->remove(index)
	endif
	eval input->insert(content)
	let maxim = g:wheeltree_config.maxim.input
	" we need to use g:wheeltree_input here
	" because input[:maxim - 1] makes a copy
	let g:wheeltree_input = input[:maxim - 1]
endfun

fun! wheeltree#scroll#newer ()
	" Replace first line by newer element in input history
	if line('.') != 1
		return v:false
	endif
	let input = g:wheeltree_input
	let line = wheeltree#teapot#without_prompt ()
	if empty(line)
		call wheeltree#teapot#set_prompt (input[0], 'dont-lock')
		return v:true
	endif
	let g:wheeltree_input = wheeltree#taijitu#rotate_right (input)
	call wheeltree#teapot#set_prompt (g:wheeltree_input[0], 'dont-lock')
	return v:true
endfun

fun! wheeltree#scroll#older ()
	" Replace first line by older element in input history
	if line('.') != 1
		return v:false
	endif
	let input = g:wheeltree_input
	let line = wheeltree#teapot#without_prompt ()
	if empty(line)
		call wheeltree#teapot#set_prompt (input[0], 'dont-lock')
		return v:true
	endif
	let g:wheeltree_input = wheeltree#taijitu#rotate_left (input)
	call wheeltree#teapot#set_prompt (g:wheeltree_input[0], 'dont-lock')
	return v:true
endfun

fun! wheeltree#scroll#filtered_newer ()
	" Replace first line by newer element that matches line until cursor
	if line('.') != 1
		return v:false
	endif
	let input = copy(g:wheeltree_input)
	let line = getline(1)
	let colnum = col('.')
	if empty(line)
		call wheeltree#scroll#newer ()
		return v:true
	endif
	let before = strpart(line, 0, colnum - 1)
	let before = wheeltree#teapot#without_prompt (before)
	let pattern = '\m^' .. before
	let reversed = reverse(input)
	let index = match(reversed, pattern, 0)
	if index >= 0
		let reversed = reversed->wheeltree#taijitu#roll_right(index)
		let g:wheeltree_input = reverse(copy(reversed))
		call wheeltree#teapot#set_prompt (g:wheeltree_input[0], 'dont-lock')
	endif
	call cursor(1, colnum)
	return v:true
endfun

fun! wheeltree#scroll#filtered_older ()
	" Replace first line by older element that matches line until cursor
	if line('.') != 1
		return v:false
	endif
	let input = g:wheeltree_input
	let line = getline(1)
	let colnum = col('.')
	if empty(line)
		call wheeltree#scroll#older ()
		return v:true
	endif
	let before = strpart(line, 0, colnum - 1)
	let before = wheeltree#teapot#without_prompt (before)
	let pattern = '\m^' .. before
	let index = match(input, pattern, 1)
	if index >= 0
		let g:wheeltree_input = g:wheeltree_input->wheeltree#taijitu#roll_left(index)
		call wheeltree#teapot#set_prompt (g:wheeltree_input[0], 'dont-lock')
	endif
	call cursor(1, colnum)
	return v:true
endfun

" ---- mappings

fun! wheeltree#scroll#mappings ()
	" Define local input history maps
	" Use Up / Down & M-p / M-n
	" C-p / C-n is taken by (neo)vim completion
	inoremap <buffer> <up> <cmd>call wheeltree#scroll#older()<cr>
	inoremap <buffer> <down> <cmd>call wheeltree#scroll#newer()<cr>
	inoremap <buffer> <M-p> <cmd>call wheeltree#scroll#older()<cr>
	inoremap <buffer> <M-n> <cmd>call wheeltree#scroll#newer()<cr>
	" PageUp / PageDown & M-r / M-s : next / prev matching line
	inoremap <buffer> <PageUp> <cmd>call wheeltree#scroll#filtered_older()<cr>
	inoremap <buffer> <PageDown> <cmd>call wheeltree#scroll#filtered_newer()<cr>
	inoremap <buffer> <M-r> <cmd>call wheeltree#scroll#filtered_older()<cr>
	inoremap <buffer> <M-s> <cmd>call wheeltree#scroll#filtered_newer()<cr>
endfun
