" vim: set ft=vim fdm=indent iskeyword&:

" Kintsugi
"
" Check & fix
"
" Kintsugi is a traditional japanese art
" that fixes a broken object by highlighting the joins.
" The damages are considered a part of the object history

" ---- script constants

if exists('s:mandala_vars')
	unlockvar s:mandala_vars
endif
let s:mandala_vars = wheeltree#crystal#fetch('mandala/vars')
lockvar s:mandala_vars

" ---- checks

fun! wheeltree#kintsugi#glossaries ()
	" Check & fix glossaries in wheeltree & current torus & circle
	" Names in toruses, circles and locations are considered to be the right ones
	let success = 1
	let coordin = wheeltree#referen#circle('all')
	let cur_torus = coordin[0]
	let cur_circle = coordin[1]
	" Wheeltree glossary
	echomsg 'Checking wheeltree glossary'
	let ind = 0
	let length = len(g:wheeltree.toruses)
	let glossary = g:wheeltree.glossary
	while ind < length
		let torus = g:wheeltree.toruses[ind]
		if torus.name != glossary[ind]
			let success = 0
			if ind < len(glossary)
				echomsg 'Fixing' glossary[ind] '->' torus.name
				let glossary[ind] = torus.name
			elseif ind == len(glossary)
				echomsg 'Adding' torus.name
				let glossary = add(glossary, torus.name)
			else
				echomsg 'Error in check glossaries : wheeltree glossary is too short'
				break
			endif
		endif
		let ind += 1
	endwhile
	" Torus glossary
	echomsg 'Checking torus glossary'
	let ind = 0
	let length = len(cur_torus.circles)
	let glossary = cur_torus.glossary
	while ind < length
		let circle = cur_torus.circles[ind]
		if circle.name != glossary[ind]
			let success = 0
			if ind < len(glossary)
				echomsg 'Fixing' glossary[ind] '->' circle.name
				let glossary[ind] = circle.name
			elseif ind == len(glossary)
				echomsg 'Adding' circle.name
				let glossary = add(glossary, circle.name)
			else
				echomsg 'Error in check glossaries : torus glossary is too short'
				break
			endif
		endif
		let ind += 1
	endwhile
	" Circle glossary
	echomsg 'Checking circle glossary'
	let ind = 0
	let length = len(cur_circle.locations)
	let glossary = cur_circle.glossary
	while ind < length
		let location = cur_circle.locations[ind]
		if location.name != glossary[ind]
			let success = 0
			if ind < len(glossary)
				echomsg 'Fixing' glossary[ind] '->' location.name
				let glossary[ind] = location.name
			elseif ind == len(glossary)
				echomsg 'Adding' location.name
				let glossary = add(glossary, location.name)
			else
				echomsg 'Error in check glossaries : circle glossary is too short'
				break
			endif
		endif
		let ind += 1
	endwhile
	" Return
	return success
endfun

" ---- display

fun! wheeltree#kintsugi#mandala_vars ()
	" Display mandala vars
	for varname in s:mandala_vars
		echomsg varname ': ' string({varname})
	endfor
endfun

" ---- conversion from old data structure

fun! wheeltree#kintsugi#pre ()
	" Convert old keys to new ones, called before config init
	" Run in void foundation, before vars initialization
	if ! exists('g:wheeltree_config')
		return v:false
	endif
	" ---- chdir project
	if has_key(g:wheeltree_config, 'cd_project')
		let g:wheeltree_config.project.auto_chdir = g:wheeltree_config.cd_project
		unlet g:wheeltree_config.cd_project
		let info = 'wheeltree config : cd_project is deprecated. '
		let info ..= 'Please use project.auto_chdir instead.'
		echomsg info
	endif
	" ---- default_yanks, other_yanks
	if has_key(g:wheeltree_config.maxim, 'yanks')
		let max_yanks = g:wheeltree_config.maxim.yanks
		let g:wheeltree_config.maxim.unnamed_yanks = max_yanks
		let g:wheeltree_config.maxim.other_yanks = float2nr(round(max_yanks/10))
		unlet g:wheeltree_config.maxim.yanks
		let info = 'wheeltree config : maxim.yanks is deprecated. '
		let info ..= 'Please use maxim.unnamed_yanks and maxim.other_yanks instead.'
		echomsg info
	endif
	if has_key(g:wheeltree_config.maxim, 'default_yanks')
		let max_yanks = g:wheeltree_config.maxim.default_yanks
		let g:wheeltree_config.maxim.unnamed_yanks = max_yanks
		unlet g:wheeltree_config.maxim.default_yanks
		let info = 'wheeltree config : maxim.default_yanks is deprecated. '
		let info ..= 'Please use maxim.unnamed_yanks instead.'
		echomsg info
	endif
	" ---- display message -> display dedibuf_msg
	if has_key(g:wheeltree_config.display, 'message')
		let g:wheeltree_config.display.dedibuf_msg = g:wheeltree_config.display.message
		unlet g:wheeltree_config.display.message
		let info = 'wheeltree config : display.message is deprecated. '
		let info ..= 'Please use display.dedibuf_msg instead.'
		echomsg info
	endif
	if has_key(g:wheeltree_config.display, 'dedibuf')
		let g:wheeltree_config.display.dedibuf_msg = g:wheeltree_config.display.dedibuf
		unlet g:wheeltree_config.display.dedibuf
		let info = 'wheeltree config : display.dedibuf is deprecated. '
		let info ..= 'Please use display.dedibuf_msg instead.'
		echomsg info
	endif
	" ---- coda
	return v:true
endfun

fun! wheeltree#kintsugi#post ()
	" Convert old keys to new ones, called after config init
	" -- project
	if has_key(g:wheeltree_config, 'project_markers')
		let g:wheeltree_config.project.markers = g:wheeltree_config.project_markers
		unlet g:wheeltree_config.project_markers
		let info = 'wheeltree config : project_markers is deprecated. '
		let info ..= 'Please use project.markers instead.'
		echomsg info
	endif
	if has_key(g:wheeltree_config, 'auto_chdir_project')
		let g:wheeltree_config.project.auto_chdir = g:wheeltree_config.auto_chdir_project
		unlet g:wheeltree_config.project.auto_chdir_project
		let info = 'wheeltree config : auto_chdir_project is deprecated. '
		let info ..= 'Please use project.auto_chdir instead.'
		echomsg info
	endif
	" ---- storage
	" -- wheeltree
	if has_key(g:wheeltree_config, 'file')
		let path = g:wheeltree_config.file
		let g:wheeltree_config.storage.wheeltree.folder = fnamemodify(path, ':h')
		let g:wheeltree_config.storage.wheeltree.name = fnamemodify(path, ':t')
		unlet g:wheeltree_config.file
		let info = 'wheeltree config : file is deprecated. '
		let info ..= 'Please use storage.wheeltree.name instead.'
		echomsg info
	endif
	if has_key(g:wheeltree_config, 'autoread')
		let g:wheeltree_config.storage.wheeltree.autoread = g:wheeltree_config.autoread
		unlet g:wheeltree_config.autoread
		let info = 'wheeltree config : autoread is deprecated. '
		let info ..= 'Please use storage.wheeltree.autoread instead.'
		echomsg info
	endif
	if has_key(g:wheeltree_config, 'autowrite')
		let g:wheeltree_config.storage.wheeltree.autowrite = g:wheeltree_config.autowrite
		unlet g:wheeltree_config.autowrite
		let info = 'wheeltree config : autowrite is deprecated. '
		let info ..= 'Please use storage.wheeltree.autowrite instead.'
		echomsg info
	endif
	" -- session
	if has_key(g:wheeltree_config, 'session_file')
		let path = g:wheeltree_config.session_file
		let g:wheeltree_config.storage.session.folder = fnamemodify(path, ':h')
		let g:wheeltree_config.storage.session.name = fnamemodify(path, ':t')
		unlet g:wheeltree_config.session_file
		let info = 'wheeltree config : session_file is deprecated. '
		let info ..= 'Please use storage.session.name instead.'
		echomsg info
	endif
	if has_key(g:wheeltree_config, 'session_dir')
		let g:wheeltree_config.storage.session.folder = g:wheeltree_config.session_dir
		unlet g:wheeltree_config.session_dir
		let info = 'wheeltree config : session_dir is deprecated. '
		let info ..= 'Please use storage.session.folder instead.'
		echomsg info
	endif
	if has_key(g:wheeltree_config, 'autoread_session')
		let g:wheeltree_config.storage.session.autoread = g:wheeltree_config.autoread_session
		unlet g:wheeltree_config.autoread_session
		let info = 'wheeltree config : autoread_session is deprecated. '
		let info ..= 'Please use storage.session.autoread instead.'
		echomsg info
	endif
	if has_key(g:wheeltree_config, 'autowrite_session')
		let g:wheeltree_config.storage.session.autowrite = g:wheeltree_config.autowrite_session
		unlet g:wheeltree_config.autowrite_session
		let info = 'wheeltree config : autowrite_session is deprecated. '
		let info ..= 'Please use storage.session.autowrite instead.'
		echomsg info
	endif
	" -- backups
	if has_key(g:wheeltree_config, 'backups')
		let g:wheeltree_config.storage.backups = g:wheeltree_config.backups
		unlet g:wheeltree_config.backups
		let info = 'wheeltree config : backups is deprecated. '
		let info ..= 'Please use storage.backups instead.'
		echomsg info
	endif
	" ---- shelve session_file
	if has_key(g:wheeltree_shelve, 'session_file')
		let g:wheeltree_shelve.current.session = g:wheeltree_shelve.session_file
		unlet g:wheeltree_shelve.session_file
	endif
endfun

fun! wheeltree#kintsugi#wheel_file ()
	" Convert old data structure to new one
	" Run in read / write wheeltree file
	" ---- history
	if type(g:wheeltree_history) == v:t_list
		let new_history = {}
		let new_history.line = g:wheeltree_history
		if exists('g:wheeltree_track')
			let new_history.circuit = g:wheeltree_track
			let new_history.alternate = g:wheeltree_alternate
		else
			let new_history.circuit = g:wheeltree_history
			let new_history.alternate = {}
		endif
		let g:wheeltree_history = new_history
		unlet g:wheeltree_track
		unlet g:wheeltree_alternate
	endif
	if ! has_key(g:wheeltree_history, 'frecency')
		let g:wheeltree_history.frecency = []
	endif
	" ---- yank
	if type(g:wheeltree_yank) == v:t_list
		let new_yank = {}
		let new_yank.unnamed = g:wheeltree_yank
		let new_yank.clipboard = []
		let new_yank.primary = []
		let new_yank.small = []
		let new_yank.inserted = []
		let new_yank.search = []
		let new_yank.command = []
		let new_yank.expression = []
		let new_yank.file = []
		let new_yank.alternate = []
		let g:wheeltree_yank = new_yank
	endif
	if ! has_key(g:wheeltree_yank, 'unnamed')
		let g:wheeltree_yank.unnamed = g:wheeltree_yank.default
		unlet g:wheeltree_yank.default
	endif
	if ! has_key(g:wheeltree_shelve, 'yank')
		let g:wheeltree_shelve.yank = {}
	endif
	if ! has_key(g:wheeltree_shelve.yank, 'default_register')
		let g:wheeltree_shelve.yank.default_register = 'unnamed'
	endif
	" ---- coda
	return v:true
endfun
