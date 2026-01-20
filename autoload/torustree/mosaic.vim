" vim: set ft=vim fdm=indent iskeyword&:

" Mosaic
"
" Tabs & windows layouts

" ---- helpers

fun! torustree#mosaic#one_tab ()
	" One tab
	if tabpagenr('$') > 1
		let prompt = 'Remove all tabs except current one ?'
		let confirm = confirm(prompt, "&Yes\n&No", 2)
		if confirm == 1
			tabonly
		else
			return v:false
		endif
	endif
	let g:wheeltree_shelve.layout.tab = 'none'
	let g:wheeltree_shelve.layout.tabnames = []
	call torustree#projection#follow ()
	return v:true
endfun

fun! torustree#mosaic#one_window ()
	" One window
	if winnr('$') > 1
		let prompt = 'Remove all windows except current one ?'
		let confirm = confirm(prompt, "&Yes\n&No", 2)
		if confirm == 1
			only
		else
			return v:false
		endif
	endif
	let g:wheeltree_shelve.layout.window = 'none'
	let g:wheeltree_shelve.layout.split = 'none'
	let w:coordin = [0, 0]
	call torustree#projection#follow ()
	return v:true
endfun

fun! torustree#mosaic#rowcol (level)
	" Number of rows and cols for grid layout
	let ratio = torustree#rectangle#ratio ()
	let rows = g:wheeltree_config.maxim.horizontal
	let cols = g:wheeltree_config.maxim.vertical
	let upper = torustree#referen#upper (a:level)
	let elements = torustree#referen#elements (upper)
	let length = len(elements)
	if length == 0
		return
	endif
	while v:true
		let course = round(cols) / round(rows)
		if course > ratio && (cols - 1) * rows >= length
			let cols -= 1
		elseif course < ratio && cols * (rows - 1) >= length
			let rows -= 1
		elseif (cols - 1) * rows >= length
			let cols -= 1
		elseif cols * (rows - 1) >= length
			let rows -= 1
		else
			break
		endif
	endwhile
	return [rows, cols]
endfun

" ---- rotate window buffers, like in bspwm

fun! torustree#mosaic#rotate_clockwise ()
	" Rotate buffers of current tab page clockwise
	" Useful for main left & main top layouts
	wincmd t
	let buffers = torustree#rectangle#tab_buffers ()
	let buffers = torustree#taijitu#rotate_right (buffers)
	for bufnum in buffers
		execute 'hide buffer' bufnum
		wincmd w
	endfor
endfun

fun! torustree#mosaic#rotate_counter_clockwise ()
	" Rotate buffers of current tab page counter-clockwise
	" Useful for main left & main top layouts
	wincmd t
	let buffers = torustree#rectangle#tab_buffers ()
	let buffers = torustree#taijitu#rotate_left (buffers)
	for bufnum in buffers
		execute 'hide buffer' bufnum
		wincmd w
	endfor
endfun

" ---- layouts

fun! torustree#mosaic#zoom (...)
	" One tab, one window
	let tab = torustree#mosaic#one_tab ()
	let window = torustree#mosaic#one_window ()
	return tab && window
endfun

fun! torustree#mosaic#tabs (level)
	" One level element per tab
	if ! torustree#mosaic#one_tab ()
		return
	endif
	let level = a:level
	let maxtabs = g:wheeltree_config.maxim.tabs
	let upper = torustree#referen#upper (level)
	let upper_level = torustree#referen#upper_level_name (level)
	let name = torustree#referen#current (level).name
	let glossary = copy(upper.glossary)
	let g:wheeltree_shelve.layout.tabnames = glossary[:maxtabs - 1]
	let elements = torustree#referen#elements (upper)
	let length = len(elements)
	if length == 0
		return
	endif
	call torustree#vortex#jump ('here')
	for index in range(min([maxtabs - 1, length - 1]))
		tabnew
		call torustree#vortex#next (level, 'new')
	endfor
	tabrewind
	call torustree#projection#follow (upper_level)
	let g:wheeltree_shelve.layout.tab = level
endfun

fun! torustree#mosaic#split (level, action = 'horizontal', ...)
	" One level element per split
	" Optional arguments :
	" 1. action to obtain split layout
	" 2. settings to pass as argument -> action(settings)
	let level = a:level
	let action = a:action
	if a:0 > 0
		let settings = a:1
	else
		let settings = {'golden' : v:false}
	endif
	if ! torustree#mosaic#one_window ()
		return
	endif
	let upper = torustree#referen#upper (level)
	let upper_level = torustree#referen#upper_level_name (level)
	let elements = torustree#referen#elements (upper)
	let length = len(elements)
	if length == 0
		return
	endif
	call torustree#vortex#jump ('here')
	for index in range(length - 1)
		let alright = torustree#mosaic#{action} (settings)
		if ! alright
			break
		endif
		call torustree#vortex#next (level, 'new')
	endfor
	wincmd t
	call torustree#projection#follow (upper_level)
	let g:wheeltree_shelve.layout.window = level
	let g:wheeltree_shelve.layout.split = action
endfun

fun! torustree#mosaic#golden (level, ...)
	" Grid layout
	" Optional argument : action to obtain split layout
	if a:0 > 0
		let action = a:1
	else
		let action = 'main_left'
	endif
	let settings = {}
	let settings.golden = v:true
	call torustree#mosaic#split(a:level, action, settings)
endfun

fun! torustree#mosaic#split_grid (level)
	" Grid layout
	let settings = {}
	let settings.maxim = torustree#mosaic#rowcol (a:level)
	call torustree#mosaic#split(a:level, 'grid', settings)
endfun

fun! torustree#mosaic#split_transposed_grid (level)
	" Transposed grid layout
	let settings = {}
	let settings.maxim = torustree#mosaic#rowcol (a:level)
	call torustree#mosaic#split(a:level, 'transposed_grid', settings)
endfun

" ---- split flavors

fun! torustree#mosaic#horizontal (...)
	" Horizontal split
	" Optional argument : settings containing golden value
	" golden : whether split is equal or golden ratio
	" w:coordin = [row number, col number]
	if a:0 > 0
		let settings = a:1
	else
		let settings = {'golden': v:false}
	endif
	if ! exists('w:coordin')
		let w:coordin = [0, 0]
	endif
	let next = w:coordin[0] + 1
	if next < g:wheeltree_config.maxim.horizontal
		if settings.golden
			call torustree#spiral#horizontal_split ()
		else
			split
		endif
		let w:coordin = [next, 0]
		return v:true
	else
		return v:false
	endif
endfun

fun! torustree#mosaic#vertical (...)
	" Vertical split
	" Optional argument : settings containing golden value
	" golden : whether split is equal or golden ratio
	" w:coordin = [row number, col number]
	if a:0 > 0
		let settings = a:1
	else
		let settings = {'golden': v:false}
	endif
	if ! exists('w:coordin')
		let w:coordin = [0, 0]
	endif
	let next = w:coordin[1] + 1
	if next < g:wheeltree_config.maxim.vertical
		if settings.golden
			call torustree#spiral#vertical_split ()
		else
			vsplit
		endif
		let w:coordin = [0, next]
		return v:true
	else
		return v:false
	endif
endfun

fun! torustree#mosaic#main_left (...)
	" Main window on left
	" Optional argument : settings containing golden value
	" golden : whether split is equal or golden ratio
	" w:coordin = [row number, col number]
	if a:0 > 0
		let settings = a:1
	else
		let settings = {'golden': v:false}
	endif
	if ! exists('w:coordin')
		let w:coordin = [0, 0]
	endif
	if w:coordin == [0, 0]
		if settings.golden
			call torustree#spiral#vertical_split ()
		else
			vsplit
		endif
		let w:coordin = [0, 1]
		return v:true
	endif
	let next = w:coordin[0] + 1
	if next < g:wheeltree_config.maxim.horizontal
		if settings.golden
			call torustree#spiral#horizontal_split ()
		else
			split
		endif
		let w:coordin = [next, 1]
		return v:true
	else
		return v:false
	endif
endfun

fun! torustree#mosaic#main_top (...)
	" Main window on top
	" Optional argument : settings containing golden value
	" golden : whether split is equal or golden ratio
	" w:coordin = [row number, col number]
	if a:0 > 0
		let settings = a:1
	else
		let settings = {'golden': v:false}
	endif
	if ! exists('w:coordin')
		let w:coordin = [0, 0]
	endif
	if w:coordin == [0, 0]
		if settings.golden
			call torustree#spiral#horizontal_split ()
		else
			split
		endif
		let w:coordin = [1, 0]
		return v:true
	endif
	let next = w:coordin[1] + 1
	if next < g:wheeltree_config.maxim.vertical
		if settings.golden
			call torustree#spiral#vertical_split ()
		else
			vsplit
		endif
		let w:coordin = [1, next]
		return v:true
	else
		return v:false
	endif
endfun

fun! torustree#mosaic#grid (settings)
	" Grid as row_1, row_2, ...
	" settings.done = [last_done_row, last_done_col]
	" settings.maxim = [max_row, max_col]
	let settings = a:settings
	if ! has_key(settings, 'done')
		let settings.done = [0, 0]
	endif
	let row = settings.done[0]
	let col = settings.done[1]
	let max_row = settings.maxim[0]
	let max_col = settings.maxim[1]
	wincmd t
	if row == 0
		if col > 0
			execute col .. 'wincmd l'
		endif
		if col < max_col - 1
			vsplit
			let settings.done = [row, col + 1]
			return v:true
		else
			execute col .. 'wincmd h'
			split
			let settings.done = [1, 0]
			return v:true
		endif
	else
		if col < max_col - 1
			execute string(col + 1) .. 'wincmd l'
			if row > 1
				execute string(row - 1) .. 'wincmd j'
			endif
			split
			let settings.done = [row, col + 1]
			return v:true
		elseif row < max_row - 1
			execute string(row) .. 'wincmd j'
			split
			let settings.done = [row + 1, 0]
			return v:true
		else
			return v:false
		endif
	endif
endfun

fun! torustree#mosaic#transposed_grid (settings)
	" Grid as col_1, col_2, ...
	" settings.done = [last_done_row, last_done_col]
	" settings.maxim = [max_row, max_col]
	let settings = a:settings
	if ! has_key(settings, 'done')
		let settings.done = [0, 0]
	endif
	let row = settings.done[0]
	let col = settings.done[1]
	let max_row = settings.maxim[0]
	let max_col = settings.maxim[1]
	wincmd t
	if col == 0
		if row > 0
			execute string(row) .. 'wincmd j'
		endif
		if row < max_row - 1
			split
			let settings.done = [row + 1, col]
			return v:true
		else
			execute string(row) .. 'wincmd k'
			vsplit
			let settings.done = [0, 1]
			return v:true
		endif
	else
		if row < max_row - 1
			execute string(row + 1) .. 'wincmd j'
			if col > 1
				execute string(col - 1) .. 'wincmd l'
			endif
			vsplit
			let settings.done = [row + 1, col]
			return v:true
		elseif col < max_col - 1
			execute string(col) .. 'wincmd l'
			vsplit
			let settings.done = [0, col + 1]
			return v:true
		else
			return v:false
		endif
	endif
endfun
