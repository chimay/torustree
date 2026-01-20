" vim: set ft=vim fdm=indent iskeyword&:

" Scroll
"
" Input history

fun! torustree#scroll#record (content)
	" Add content to beginning of input history
	let content = a:content
	if type(content) == v:t_list
		let content = join(content)
	endif
	let input = g:torustree_input
	let index = input->index(content)
	if index >= 0
		eval input->remove(index)
	endif
	eval input->insert(content)
	let maxim = g:torustree_config.maxim.input
	" we need to use g:torustree_input here
	" because input[:maxim - 1] makes a copy
	let g:torustree_input = input[:maxim - 1]
endfun

fun! torustree#scroll#newer ()
	" Replace first line by newer element in input history
	if line('.') != 1
		return v:false
	endif
	let input = g:torustree_input
	let line = torustree#teapot#without_prompt ()
	if empty(line)
		call torustree#teapot#set_prompt (input[0], 'dont-lock')
		return v:true
	endif
	let g:torustree_input = torustree#taijitu#rotate_right (input)
	call torustree#teapot#set_prompt (g:torustree_input[0], 'dont-lock')
	return v:true
endfun

fun! torustree#scroll#older ()
	" Replace first line by older element in input history
	if line('.') != 1
		return v:false
	endif
	let input = g:torustree_input
	let line = torustree#teapot#without_prompt ()
	if empty(line)
		call torustree#teapot#set_prompt (input[0], 'dont-lock')
		return v:true
	endif
	let g:torustree_input = torustree#taijitu#rotate_left (input)
	call torustree#teapot#set_prompt (g:torustree_input[0], 'dont-lock')
	return v:true
endfun

fun! torustree#scroll#filtered_newer ()
	" Replace first line by newer element that matches line until cursor
	if line('.') != 1
		return v:false
	endif
	let input = copy(g:torustree_input)
	let line = getline(1)
	let colnum = col('.')
	if empty(line)
		call torustree#scroll#newer ()
		return v:true
	endif
	let before = strpart(line, 0, colnum - 1)
	let before = torustree#teapot#without_prompt (before)
	let pattern = '\m^' .. before
	let reversed = reverse(input)
	let index = match(reversed, pattern, 0)
	if index >= 0
		let reversed = reversed->torustree#taijitu#roll_right(index)
		let g:torustree_input = reverse(copy(reversed))
		call torustree#teapot#set_prompt (g:torustree_input[0], 'dont-lock')
	endif
	call cursor(1, colnum)
	return v:true
endfun

fun! torustree#scroll#filtered_older ()
	" Replace first line by older element that matches line until cursor
	if line('.') != 1
		return v:false
	endif
	let input = g:torustree_input
	let line = getline(1)
	let colnum = col('.')
	if empty(line)
		call torustree#scroll#older ()
		return v:true
	endif
	let before = strpart(line, 0, colnum - 1)
	let before = torustree#teapot#without_prompt (before)
	let pattern = '\m^' .. before
	let index = match(input, pattern, 1)
	if index >= 0
		let g:torustree_input = g:torustree_input->torustree#taijitu#roll_left(index)
		call torustree#teapot#set_prompt (g:torustree_input[0], 'dont-lock')
	endif
	call cursor(1, colnum)
	return v:true
endfun

" ---- mappings

fun! torustree#scroll#mappings ()
	" Define local input history maps
	" Use Up / Down & M-p / M-n
	" C-p / C-n is taken by (neo)vim completion
	inoremap <buffer> <up> <cmd>call torustree#scroll#older()<cr>
	inoremap <buffer> <down> <cmd>call torustree#scroll#newer()<cr>
	inoremap <buffer> <M-p> <cmd>call torustree#scroll#older()<cr>
	inoremap <buffer> <M-n> <cmd>call torustree#scroll#newer()<cr>
	" PageUp / PageDown & M-r / M-s : next / prev matching line
	inoremap <buffer> <PageUp> <cmd>call torustree#scroll#filtered_older()<cr>
	inoremap <buffer> <PageDown> <cmd>call torustree#scroll#filtered_newer()<cr>
	inoremap <buffer> <M-r> <cmd>call torustree#scroll#filtered_older()<cr>
	inoremap <buffer> <M-s> <cmd>call torustree#scroll#filtered_newer()<cr>
endfun
