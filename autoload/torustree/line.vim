" vim: set ft=vim fdm=indent iskeyword&:

" Line
"
" Native action on the cursor line :
"
" - going to an element
" - paste
" - undo & diff
"
" called by loop#navigation

" ---- script constants

if exists('s:field_separ')
	unlockvar s:field_separ
endif
let s:field_separ = torustree#crystal#fetch('separator/field')
lockvar s:field_separ

" ---- buffers, tabs, wins

fun! torustree#line#buffer (settings)
	" Go to buffer
	" ---- settings
	let settings = a:settings
	let component = settings.selection.component
	let fields = split(component, s:field_separ)
	let bufnum = str2nr(fields[0])
	let filename = fnamemodify(fields[3], ':p')
	let target = settings.target
	" ---- navigation
	let coordin = torustree#projection#closest ('torustree', filename)
	if ! empty(coordin)
		call torustree#vortex#chord (coordin)
		call torustree#vortex#jump (target)
	else
		call torustree#vortex#target (target)
		execute 'silent hide buffer' bufnum
	endif
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

fun! torustree#line#tabwin (settings)
	" Go to tab & win
	" ---- settings
	let settings = a:settings
	let component = settings.selection.component
	let fields = split(component, s:field_separ)
	let tabnum = fields[0]
	let winum = fields[1]
	" ---- navigation
	execute 'noautocmd tabnext' tabnum
	execute 'noautocmd' winum 'wincmd w'
	doautocmd WinEnter
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

fun! torustree#line#tabwin_tree (settings)
	" Go to tab & win in tree fold
	" ---- settings
	let settings = a:settings
	let hierarchy = settings.selection.component
	let tabnum = hierarchy[0]
	" ---- actions
	execute 'noautocmd tabnext' tabnum
	if len(hierarchy) > 1
		let winum = hierarchy[1]
		execute 'noautocmd' winum 'wincmd w'
	endif
	doautocmd WinEnter
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

" ---- search file

fun! torustree#line#mru (settings)
	" Edit Most Recently Used file
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let component = settings.selection.component
	let fields = split(component, s:field_separ)
	let filename = fields[1]
	" ---- go
	call torustree#vortex#target (target)
	execute 'silent hide edit' filename
	normal! '"
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	return win_getid ()
endfun

fun! torustree#line#locate (settings)
	" Find file with locate command
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let filename = settings.selection.component
	" ---- go
	call torustree#vortex#target (target)
	execute 'silent hide edit' filename
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

fun! torustree#line#find (settings)
	" Find file with find command
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let filename = settings.selection.component
	let filename = trim(filename, ' ')
	" ---- go
	call torustree#vortex#target (target)
	execute 'silent hide edit' filename
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

" ---- search in file

fun! torustree#line#occur (settings)
	" Go to buffer line matching pattern
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let component = settings.selection.component
	let bufnum = a:settings.related.bufnum
	" ---- go
	let fields = split(component, s:field_separ)
	let line = str2nr(fields[0])
	call torustree#vortex#target (target)
	execute 'silent hide buffer' bufnum
	call cursor(line, 1)
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

fun! torustree#line#grep (settings)
	" Go to grep quickfix line
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let component = settings.selection.component
	let fields = split(component, s:field_separ)
	" ---- go
	call torustree#vortex#target (target)
	" -- using error number
	let errnum = fields[0]
	execute 'cc' errnum
	" -- using buffer, line & col
	"let bufnum = str2nr(fields[1])
	"let line = str2nr(fields[3])
	"let col = str2nr(fields[4])
	"execute 'silent hide buffer' bufnum
	"call cursor(line, col)
	" ---- coda
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

fun! torustree#line#marker (settings)
	" Go to vim marker
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let component = settings.selection.component
	let fields = split(component, s:field_separ)
	let mark = fields[0]
	"let line = fields[1]
	"let column = fields[2]
	" ---- go
	call torustree#vortex#target (target)
	execute "normal! `" .. mark
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

fun! torustree#line#jump (settings)
	" Go to element in jumps list
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let component = settings.selection.component
	let fields = split(component, s:field_separ)
	let bufnum = fields[0]
	let linum = str2nr(fields[1])
	let colnum = str2nr(fields[2])
	" ---- go
	call torustree#vortex#target (target)
	execute 'silent hide buffer' bufnum
	call cursor(linum, colnum)
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

fun! torustree#line#change (settings)
	" Go to element in changes list
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let component = settings.selection.component
	let fields = split(component, s:field_separ)
	let linum = str2nr(fields[0])
	let colnum = str2nr(fields[1])
	let bufnum = a:settings.related.bufnum
	" ---- go
	call torustree#vortex#target (target)
	execute 'silent hide buffer' bufnum
	call cursor(linum, colnum)
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

fun! torustree#line#tag (settings)
	" Go to tag
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let component = settings.selection.component
	let fields = split(component, s:field_separ)
	let file = fields[2]
	let search = fields[3][1:]
	let search = escape(search, '*')
	" ---- go
	call torustree#vortex#target (target)
	execute 'silent hide edit' file
	let found = search(search, 'sw')
	if found == 0
		echomsg 'torustree : tag not found : maybe you should update your tag file'
	endif
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

fun! torustree#line#narrow_file (settings)
	" Go to narrowed line of current file
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let component = settings.selection.component
	let bufnum = settings.bufnum
	let fields = split(component, s:field_separ)
	let linum = str2nr(fields[0])
	" ---- go
	call torustree#vortex#target (target)
	execute 'silent hide buffer' bufnum
	call cursor(linum, 1)
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

fun! torustree#line#narrow_circle (settings)
	" Go to narrowed line in circle
	" ---- settings
	let settings = a:settings
	let target = settings.target
	let pattern = settings.pattern
	let index = settings.selection.index
	let component = settings.selection.component
	let fields = split(component, s:field_separ)
	let bufnum = str2nr(fields[0])
	let linum = str2nr(fields[1])
	let destination = [bufnum, linum]
	if len(fields) == 4
		let content = fields[3]
	else
		let content = ''
	endif
	" ---- go
	call torustree#vortex#target (a:settings.target)
	if content =~ pattern
		" grep result
		let pairs = getqflist()->map({ _, val -> [ val.bufnr, val.lnum ] })
		let index = pairs->index(destination)
		let errnum = index + 1
		execute 'cc' errnum
	else
		" context line
		execute 'silent hide buffer' bufnum
		call cursor(linum, 1)
	endif
	" ---- coda
	call torustree#origami#view_cursor ()
	call torustree#chakra#place_native ()
	silent doautocmd User TorustreeAfterNative
	return win_getid ()
endfun

" ---- paste

fun! torustree#line#paste_plain (where = 'linewise-after', close = 'close')
	" Paste line(s) from yank buffer in plain mode
	let where = a:where
	let close = a:close
	" ---- format selection
	let selection = torustree#pencil#selection ()
	let content = deepcopy(selection.components)
	if empty(content)
		return v:false
	endif
	" --- climbing content
	call torustree#codex#climb(content)
	" --- clipboard option registers
	let clipreg = substitute(&clipboard, 'unnamedplus', '+', '')
	let clipreg = substitute(clipreg, 'unnamed', '*', '')
	let clipboard = [ '"' ]->extend(split(clipreg, ','))
	" ---- paste
	call torustree#rectangle#goto_previous ()
	if where ==# 'linewise-after'
		for register in clipboard
			call setreg(register, content, 'l')
		endfor
		silent put =content
	elseif where ==# 'linewise-before'
		for register in clipboard
			call setreg(register, content, 'l')
		endfor
		silent put! =content
	elseif where ==# 'charwise-after'
		for register in clipboard
			call setreg(register, content, 'c')
		endfor
		silent normal! p
	elseif where ==# 'charwise-before'
		for register in clipboard
			call setreg(register, content, 'c')
		endfor
		silent normal! P
	endif
	" ---- coda
	call torustree#cylinder#recall ()
	if close ==# 'close'
		call torustree#cylinder#close ()
	endif
	return win_getid ()
endfun

fun! torustree#line#paste_visual (...)
	" Paste visual selection from yank buffer in plain mode
	if a:0 > 0
		let where = a:1
	else
		let where = 'after'
	endif
	if a:0 > 1
		let close = a:2
	else
		let close = 'close'
	endif
	normal! gvy
	call torustree#rectangle#goto_previous ()
	if where ==# 'after'
		silent normal! p
	elseif where ==# 'before'
		silent normal! P
	endif
	call torustree#cylinder#recall ()
	if close ==# 'close'
		call torustree#cylinder#close ()
	endif
	return win_getid ()
endfun

fun! torustree#line#paste_list (where = 'linewise-after', close = 'close')
	" Paste line(s) from yank buffer in list mode
	let where = a:where
	let close = a:close
	" ---- format selection
	let selection = torustree#pencil#selection ()
	let content = deepcopy(selection.components)
	eval content->map({ _, list_string -> eval(list_string) })
	eval content->map({ _, list -> join(list, "\n") })
	" --- climbing content
	call torustree#codex#climb(content)
	" --- clipboard option registers
	let clipreg = substitute(&clipboard, 'unnamedplus', '+', '')
	let clipreg = substitute(clipreg, 'unnamed', '*', '')
	let clipboard = [ '"' ]->extend(split(clipreg, ','))
	" ---- paste
	call torustree#rectangle#goto_previous ()
	if where ==# 'linewise-after'
		for register in clipboard
			call setreg(register, content, 'l')
		endfor
		silent put =content
	elseif where ==# 'linewise-before'
		for register in clipboard
			call setreg(register, content, 'l')
		endfor
		silent put! =content
	elseif where ==# 'charwise-after'
		for register in clipboard
			call setreg(register, content, 'c')
		endfor
		silent normal! p
	elseif where ==# 'charwise-before'
		for register in clipboard
			call setreg(register, content, 'c')
		endfor
		silent normal! P
	endif
	" ---- coda
	call torustree#cylinder#recall ()
	if close ==# 'close'
		call torustree#cylinder#close ()
	endif
	return win_getid ()
endfun

" ---- undo list

fun! torustree#line#undolist (bufnum)
	" Apply change in undo list
	let iden = torustree#delta#undo_iden ()
	call torustree#rectangle#find_or_load (a:bufnum)
	execute 'undo' iden
	call torustree#cylinder#recall ()
endfun

fun! torustree#line#undo_diff (bufnum)
	" Visualize diff between last state & undo
	let iden = torustree#delta#undo_iden ()
	" ---- original buffer
	call torustree#rectangle#find_or_load (a:bufnum)
	let save = {}
	let save.name = expand('%')
	let save.filetype = &l:filetype
	" ---- copy of original buffer
	vnew
	silent read #
	call torustree#gear#delete (1)
	let diff_buf = bufnr('%')
	setlocal buftype=nofile
	execute 'silent file' 'torustree/diff/' .. save.name
	let &l:filetype = save.filetype
	diffthis
	setlocal nomodifiable readonly
	" ---- original buffer
	call torustree#rectangle#find_or_load (a:bufnum)
	execute 'undo' iden
	diffthis
	" ---- back to mandala
	call torustree#cylinder#recall ()
	let b:torustree_settings.diff_buf = diff_buf
endfun
