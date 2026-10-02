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
let s:mandala_vars = torustree#crystal#fetch('mandala/vars')
lockvar s:mandala_vars

" ---- checks

fun! torustree#kintsugi#glossaries ()
	" Check & fix glossaries in torustree & current torus & circle
	" Names in toruses, circles and locations are considered to be the right ones
	let success = 1
	let coordin = torustree#referen#circle('all')
	let cur_torus = coordin[0]
	let cur_circle = coordin[1]
	" Torustree glossary
	echomsg 'Checking torustree glossary'
	let ind = 0
	let length = len(g:torustree.toruses)
	let glossary = g:torustree.glossary
	while ind < length
		let torus = g:torustree.toruses[ind]
		if torus.name != glossary[ind]
			let success = 0
			if ind < len(glossary)
				echomsg 'Fixing' glossary[ind] '->' torus.name
				let glossary[ind] = torus.name
			elseif ind == len(glossary)
				echomsg 'Adding' torus.name
				let glossary = add(glossary, torus.name)
			else
				echomsg 'Error in check glossaries : torustree glossary is too short'
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
	let length = len(cur_circle.stones)
	let glossary = cur_circle.glossary
	while ind < length
		let location = cur_circle.stones[ind]
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

fun! torustree#kintsugi#mandala_vars ()
	" Display mandala vars
	for varname in s:mandala_vars
		echomsg varname ': ' string({varname})
	endfor
endfun

" ---- conversion from old data structure

fun! torustree#kintsugi#pre ()
	" Convert old keys to new ones, called before config init
	" Run in void foundation, before vars initialization
	if ! exists('g:torustree_config')
		return v:false
	endif
	" ---- chdir project
	if g:torustree_config->has_key('cd_project')
		let g:torustree_config.project.auto_chdir = g:torustree_config.cd_project
		unlet g:torustree_config.cd_project
		let info = 'torustree config : cd_project is deprecated. '
		let info ..= 'Please use project.auto_chdir instead.'
		echomsg info
	endif
	" ---- default_yanks, other_yanks
	if g:torustree_config.maxim->has_key('yanks')
		let max_yanks = g:torustree_config.maxim.yanks
		let g:torustree_config.maxim.unnamed_yanks = max_yanks
		let g:torustree_config.maxim.other_yanks = float2nr(round(max_yanks/10))
		unlet g:torustree_config.maxim.yanks
		let info = 'torustree config : maxim.yanks is deprecated. '
		let info ..= 'Please use maxim.unnamed_yanks and maxim.other_yanks instead.'
		echomsg info
	endif
	if g:torustree_config.maxim->has_key('default_yanks')
		let max_yanks = g:torustree_config.maxim.default_yanks
		let g:torustree_config.maxim.unnamed_yanks = max_yanks
		unlet g:torustree_config.maxim.default_yanks
		let info = 'torustree config : maxim.default_yanks is deprecated. '
		let info ..= 'Please use maxim.unnamed_yanks instead.'
		echomsg info
	endif
	" ---- display message -> display dedibuf_msg
	if g:torustree_config.display->has_key('message')
		let g:torustree_config.display.dedibuf_msg = g:torustree_config.display.message
		unlet g:torustree_config.display.message
		let info = 'torustree config : display.message is deprecated. '
		let info ..= 'Please use display.dedibuf_msg instead.'
		echomsg info
	endif
	if g:torustree_config.display->has_key('dedibuf')
		let g:torustree_config.display.dedibuf_msg = g:torustree_config.display.dedibuf
		unlet g:torustree_config.display.dedibuf
		let info = 'torustree config : display.dedibuf is deprecated. '
		let info ..= 'Please use display.dedibuf_msg instead.'
		echomsg info
	endif
	" ---- coda
	return v:true
endfun

fun! torustree#kintsugi#post ()
	" Convert old keys to new ones, called after config init
	" -- project
	if g:torustree_config->has_key('project_markers')
		let g:torustree_config.project.markers = g:torustree_config.project_markers
		unlet g:torustree_config.project_markers
		let info = 'torustree config : project_markers is deprecated. '
		let info ..= 'Please use project.markers instead.'
		echomsg info
	endif
	if g:torustree_config->has_key('auto_chdir_project')
		let g:torustree_config.project.auto_chdir = g:torustree_config.auto_chdir_project
		unlet g:torustree_config.project.auto_chdir_project
		let info = 'torustree config : auto_chdir_project is deprecated. '
		let info ..= 'Please use project.auto_chdir instead.'
		echomsg info
	endif
	" ---- storage
	" -- torustree
	if g:torustree_config->has_key('file')
		let path = g:torustree_config.file
		let g:torustree_config.storage.torustree.folder = fnamemodify(path, ':h')
		let g:torustree_config.storage.torustree.name = fnamemodify(path, ':t')
		unlet g:torustree_config.file
		let info = 'torustree config : file is deprecated. '
		let info ..= 'Please use storage.torustree.name instead.'
		echomsg info
	endif
	if g:torustree_config->has_key('autoread')
		let g:torustree_config.storage.torustree.autoread = g:torustree_config.autoread
		unlet g:torustree_config.autoread
		let info = 'torustree config : autoread is deprecated. '
		let info ..= 'Please use storage.torustree.autoread instead.'
		echomsg info
	endif
	if g:torustree_config->has_key('autowrite')
		let g:torustree_config.storage.torustree.autowrite = g:torustree_config.autowrite
		unlet g:torustree_config.autowrite
		let info = 'torustree config : autowrite is deprecated. '
		let info ..= 'Please use storage.torustree.autowrite instead.'
		echomsg info
	endif
	" -- session
	if g:torustree_config->has_key('session_file')
		let path = g:torustree_config.session_file
		let g:torustree_config.storage.session.folder = fnamemodify(path, ':h')
		let g:torustree_config.storage.session.name = fnamemodify(path, ':t')
		unlet g:torustree_config.session_file
		let info = 'torustree config : session_file is deprecated. '
		let info ..= 'Please use storage.session.name instead.'
		echomsg info
	endif
	if g:torustree_config->has_key('session_dir')
		let g:torustree_config.storage.session.folder = g:torustree_config.session_dir
		unlet g:torustree_config.session_dir
		let info = 'torustree config : session_dir is deprecated. '
		let info ..= 'Please use storage.session.folder instead.'
		echomsg info
	endif
	if g:torustree_config->has_key('autoread_session')
		let g:torustree_config.storage.session.autoread = g:torustree_config.autoread_session
		unlet g:torustree_config.autoread_session
		let info = 'torustree config : autoread_session is deprecated. '
		let info ..= 'Please use storage.session.autoread instead.'
		echomsg info
	endif
	if g:torustree_config->has_key('autowrite_session')
		let g:torustree_config.storage.session.autowrite = g:torustree_config.autowrite_session
		unlet g:torustree_config.autowrite_session
		let info = 'torustree config : autowrite_session is deprecated. '
		let info ..= 'Please use storage.session.autowrite instead.'
		echomsg info
	endif
	" -- backups
	if g:torustree_config->has_key('backups')
		let g:torustree_config.storage.backups = g:torustree_config.backups
		unlet g:torustree_config.backups
		let info = 'torustree config : backups is deprecated. '
		let info ..= 'Please use storage.backups instead.'
		echomsg info
	endif
	" ---- shelve session_file
	if g:torustree_shelve->has_key('session_file')
		let g:torustree_shelve.current.session = g:torustree_shelve.session_file
		unlet g:torustree_shelve.session_file
	endif
endfun

fun! torustree#kintsugi#torustree_file ()
	" Convert old data structure to new one
	" Run in read / write torustree file
	" ---- history
	if type(g:torustree_history) == v:t_list
		let new_history = {}
		let new_history.line = g:torustree_history
		if exists('g:torustree_track')
			let new_history.circuit = g:torustree_track
			let new_history.alternate = g:torustree_alternate
		else
			let new_history.circuit = g:torustree_history
			let new_history.alternate = {}
		endif
		let g:torustree_history = new_history
		unlet g:torustree_track
		unlet g:torustree_alternate
	endif
	if ! g:torustree_history->has_key('frecency')
		let g:torustree_history.frecency = []
	endif
	" ---- yank
	if type(g:torustree_yank) == v:t_list
		let new_yank = {}
		let new_yank.unnamed = g:torustree_yank
		let new_yank.clipboard = []
		let new_yank.primary = []
		let new_yank.small = []
		let new_yank.inserted = []
		let new_yank.search = []
		let new_yank.command = []
		let new_yank.expression = []
		let new_yank.file = []
		let new_yank.alternate = []
		let g:torustree_yank = new_yank
	endif
	if ! g:torustree_yank->has_key('unnamed')
		let g:torustree_yank.unnamed = g:torustree_yank.default
		unlet g:torustree_yank.default
	endif
	if ! g:torustree_shelve->has_key('yank')
		let g:torustree_shelve.yank = {}
	endif
	if ! g:torustree_shelve.yank->has_key('default_register')
		let g:torustree_shelve.yank.default_register = 'unnamed'
	endif
	" ---- coda
	return v:true
endfun
