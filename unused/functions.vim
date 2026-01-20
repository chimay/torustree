" vim: set ft=vim fdm=indent iskeyword&:

" Unused functions

fun! torustree#disc#write (pointer, file, where = '>')
	" Write variable referenced by pointer to file
	" in a format that can be :sourced
	" Note : pointer = variable name in vim script
	" If optional argument 1 is :
	"   - '>' : replace file content (default)
	"   - '>>' : append to file content
	" Doesn't work well with some abbreviated echoed variables content in vim
	" disc#writefile is more reliable with vim
	let pointer = a:pointer
	if ! exists(pointer)
		return
	endif
	let file = fnamemodify(a:file, ':p')
	let where = a:where
	" create directory if needed
	let directory = fnamemodify(file, ':h')
	let returnstring = torustree#disc#mkdir(directory)
	if returnstring ==# 'failure'
		return v:false
	endif
	" write
	let var = {pointer}
	redir => content
	silent! echo 'let' pointer '=' var
	redir END
	let content = substitute(content, '\m[=,]', '\0\n\\', 'g')
	let content = substitute(content, '\m\n\{2,}', '\n', 'g')
	exec 'redir!' where file
	silent! echo content
	redir END
endfun

fun! torustree#disc#read (file)
	" Read file
	let file = fnamemodify(a:file, ':p')
	if ! filereadable(file)
		echomsg 'Could not read' file
	endif
	execute 'source' file
endfun

fun! torustree#pendulum#older (level = 'torustree')
	" Go to older entry in g:torustree_history.circuit
	let level = a:level
	if torustree#referen#is_empty(level)
		echomsg 'torustree older :' level 'is empty'
		return v:false
	endif
	if level ==# 'torustree'
		return torustree#pendulum#older_anywhere ()
	endif
	" current coordin
	let names = torustree#referen#names ()
	" index for range in coordin
	let level_index = torustree#referen#coordin_index (level)
	" back in history
	let timeloop = g:torustree_history.circuit
	let timeloop = torustree#chain#rotate_left (timeloop)
	let coordin = timeloop[0].coordin
	let counter = 0
	let length = len(timeloop)
	while names[:level_index] != coordin[:level_index] && counter < length
		let timeloop = torustree#chain#rotate_left (timeloop)
		let coordin = timeloop[0].coordin
		let counter += 1
	endwhile
	" older found in same torus or circle ?
	if names[:level_index] != coordin[:level_index]
		echomsg 'torustree older : no location found in same' level
		return v:false
	endif
	" update timeloop : rotate left / right return a copy
	let g:torustree_history.circuit = timeloop
	" jump
	call torustree#vortex#chord(coordin)
	return torustree#vortex#jump ()
endfun

fun! torustree#pendulum#newer (level = 'torustree')
	" Go to newer entry in g:torustree_history.circuit
	let level = a:level
	if torustree#referen#is_empty(level)
		echomsg 'torustree newer :' level 'is empty'
		return v:false
	endif
	if level ==# 'torustree'
		return torustree#pendulum#newer_anywhere ()
	endif
	" current coordin
	let names = torustree#referen#names ()
	" index for range in coordin
	let level_index = torustree#referen#coordin_index (level)
	" back in history
	let timeloop = g:torustree_history.circuit
	let timeloop = torustree#chain#rotate_right (timeloop)
	let coordin = timeloop[0].coordin
	let counter = 0
	let length = len(timeloop)
	while names[:level_index] != coordin[:level_index] && counter < length
		let timeloop = torustree#chain#rotate_right (timeloop)
		let coordin = timeloop[0].coordin
		let counter += 1
	endwhile
	" newer found in same torus or circle ?
	if names[:level_index] != coordin[:level_index]
		echomsg 'torustree newer : no location found in same' level
		return v:false
	endif
	" update timeloop : rotate left / right return a deepcopy
	let g:torustree_history.circuit = timeloop
	" jump
	call torustree#vortex#chord(coordin)
	return torustree#vortex#jump ()
endfun

fun! torustree#cylinder#first (window = 'furtive')
	" Add first mandala buffer
	" Optional argument :
	"   - furtive (default) : use current window and go back to previous buffer at the end
	"   - split : use a split
	let window = a:window
	let bufring = g:torustree_bufring
	let mandalas = g:torustree_bufring.mandalas
	" ---- pre-checks
	if ! window->torustree#chain#is_inside(['split', 'furtive'])
		echomsg 'torustree cylinder first : bad window argument'
		return v:false
	endif
	" -- empty ring ?
	if ! empty(mandalas)
		echomsg 'torustree cylinder first : mandala ring is not empty'
		return v:false
	endif
	call torustree#cylinder#delete_unused ()
	" ---- pre op buffer
	let cur_buffer = bufnr('%')
	let empty_cur_buffer = empty(bufname(cur_buffer))
	" ---- new buffer
	if window ==# 'split'
		call torustree#cylinder#split ()
		hide enew
	else
		if empty_cur_buffer
			" :enew does not create a new buffer if current one has no name
			" so we need to use :new
			new
		else
			hide enew
		endif
	endif
	let novice = bufnr('%')
	" ---- add
	let bufring.current = 0
	let iden = bufring.iden
	let names = bufring.names
	let types = bufring.types
	eval mandalas->add(novice)
	eval iden->add(0)
	eval names->add('0')
	eval types->add('')
	" ---- set filename
	call torustree#cylinder#filename ()
	" ---- init mandala
	call torustree#mandala#init ()
	call torustree#mandala#common_maps ()
	" ---- coda
	if window ==# 'furtive'
		if empty_cur_buffer
			" :new has opened a split, close it
			noautocmd close
		else
			execute 'silent hide buffer' cur_buffer
		endif
	endif
	call torustree#status#mandala_leaf ()
	return v:true
endfun

fun! torustree#cylinder#add (window = 'furtive')
	" Add new mandala buffer
	" Optional argument :
	"   - furtive (default) : use current window and go back to previous buffer at the end
	"   - split : use a split
	let window = a:window
	let bufring = g:torustree_bufring
	" ---- pre-checks
	if ! window->torustree#chain#is_inside(['split', 'furtive'])
		echomsg 'torustree cylinder first : bad window argument'
		return v:false
	endif
	call torustree#cylinder#check ()
	call torustree#cylinder#delete_unused ()
	" ---- first one
	let mandalas = bufring.mandalas
	if empty(mandalas)
		return torustree#cylinder#first (window)
	endif
	" ---- not the first one
	" -- is current buffer a mandala buffer ?
	let was_mandala = torustree#cylinder#is_mandala ()
	" -- previous current mandala
	let current = bufring.current
	let elder = mandalas[current]
	" -- mandala window
	if window ==# 'split'
		call torustree#cylinder#window ('window')
	endif
	" -- pre op buffer
	let cur_buffer = bufnr('%')
	let empty_cur_buffer = empty(bufname(cur_buffer))
	" -- new buffer
	if window ==# 'split'
		call torustree#cylinder#split ()
		hide enew
	else
		if empty_cur_buffer
			" :enew does not create a new buffer if current want has no name
			" so we need to use :new
			new
		else
			hide enew
		endif
	endif
	let novice = bufnr('%')
	if novice == elder
		echomsg 'torustree mandala add : buffer' novice 'already in ring'
		return v:false
	endif
	" -- add
	let next = current + 1
	eval mandalas->insert(novice, next)
	let bufring.current = next
	let iden = bufring.iden
	let names = bufring.names
	let types = bufring.types
	let novice_iden = torustree#chain#lowest_outside (iden)
	let novice_name = string(novice_iden)
	eval iden->insert(novice_iden, next)
	eval names->insert(novice_name, next)
	eval types->insert('', next)
	" -- set filename
	call torustree#cylinder#filename ()
	" -- init mandala
	call torustree#mandala#init ()
	call torustree#mandala#common_maps ()
	" -- coda
	if window ==# 'furtive' && ! was_mandala
		if empty_cur_buffer
			" :new has opened a split, close it
			noautocmd close
		else
			execute 'silent hide buffer' cur_buffer
		endif
	endif
	call torustree#status#mandala_leaf ()
	return v:true
endfun

" vim: set ft=vim fdm=indent iskeyword&:

" Origami
"
" Folding in mandalas

" Script constants

if ! exists('s:fold_1')
	let s:fold_1 = torustree#crystal#fetch('fold/one')
	lockvar s:fold_1
endif

if ! exists('s:fold_2')
	let s:fold_2 = torustree#crystal#fetch('fold/two')
	lockvar s:fold_2
endif

" Fold for torus, circle and location

fun! torustree#origami#chord_level ()
	" Torustree level of fold line : torus, circle or location
	if ! &l:foldenable
		echomsg 'torustree gear fold level : fold is disabled in buffer'
		return v:false
	endif
	let line = getline('.')
	if line =~ s:fold_1
		return 'torus'
	elseif line =~ s:fold_2
		return 'circle'
	else
		return 'location'
	endif
endfun

fun! torustree#origami#chord_parent ()
	" Go to line of parent fold in torustree tree
	let level = torustree#origami#chord_level ()
	if level ==# 'circle'
		let pattern = '\m' .. s:fold_1 .. '$'
	elseif level ==# 'location'
		let pattern = '\m' .. s:fold_2 .. '$'
	else
		" torus line : we stay there
		return
	endif
	call search(pattern, 'b')
endfun

fun! torustree#origami#chord ()
	" Return torustree coordinates of line in folded mandala buffer
	let position = getcurpos()
	let cursor_line = getline('.')
	let cursor_line = torustree#pencil#unmarked (cursor_line)
	let cursor_list = split(cursor_line)
	if empty(cursor_line)
		return []
	endif
	let level = torustree#origami#chord_level ()
	if level ==# 'torus'
		" torus line
		let torus = cursor_list[0]
		let coordin = [torus]
	elseif level ==# 'circle'
		" circle line : search torus
		let circle = cursor_list[0]
		call torustree#origami#chord_parent ()
		let line = getline('.')
		let line = torustree#pencil#unmarked (line)
		let fields = split(line)
		let torus = fields[0]
		let coordin = [torus, circle]
	elseif level ==# 'location'
		" location line : search circle & torus
		let location = cursor_line
		call torustree#origami#chord_parent ()
		let line = getline('.')
		let line = torustree#pencil#unmarked (line)
		let fields = split(line)
		let circle = fields[0]
		call torustree#origami#chord_parent ()
		let line = getline('.')
		let line = torustree#pencil#unmarked (line)
		let fields = split(line)
		let torus = fields[0]
		let coordin = [torus, circle, location]
	else
		echomsg 'torustree line coordin : wrong fold level'
	endif
	call torustree#gear#restore_cursor (position)
	return coordin
endfun

" Fold for tabs & windows

fun! torustree#origami#tabwin_level ()
	" Tab & window : level of fold line, tab or filename
	if ! &l:foldenable
		echomsg 'torustree gear fold level : fold is disabled in buffer'
		return v:false
	endif
	let line = getline('.')
	if line =~ s:fold_1
		return 'tab'
	else
		return 'filename'
	endif
endfun

fun! torustree#origami#tabwin_parent ()
	" Go to line of parent fold in tabwin tree
	let level = torustree#origami#tabwin_level ()
	if level ==# 'filename'
		let pattern = '\m' .. s:fold_1 .. '$'
		call search(pattern, 'b')
	else
		" tab line : we stay there
		return
	endif
endfun

fun! torustree#origami#tabwin ()
	" Return tab & filename of line in folded mandala buffer
	let position = getcurpos()
	let cursor_line = getline('.')
	let cursor_line = torustree#pencil#unmarked (cursor_line)
	let cursor_list = split(cursor_line)
	if empty(cursor_line)
		return []
	endif
	let level = torustree#origami#tabwin_level ()
	if level ==# 'tab'
		" tab line
		let tabnum = str2nr(cursor_list[1])
		let coordin = [tabnum]
	elseif level ==# 'filename'
		" filename line : find window tab-local number & tab index
		let filename = cursor_list[0]
		let fileline = line('.')
		call torustree#origami#tabwin_parent ()
		let tabline = line('.')
		let winum = fileline - tabline
		let line = getline('.')
		let line = torustree#pencil#unmarked (line)
		let fields = split(line)
		let tabnum = str2nr(fields[1])
		let coordin = [tabnum, winum, filename]
	else
		echomsg 'tabwin hierarchy : wrong fold level'
	endif
	call torustree#gear#restore_cursor (position)
	return coordin
endfun
