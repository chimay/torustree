" vim: set ft=vim fdm=indent iskeyword&:

" Ripple
"
" Job control, vim 8

if ! has('unix')
	echomsg 'torustree : ripple is only supported on Unix systems'
	finish
endif

if has('nvim')
	echomsg 'torustree ripple is for vim : see wave for neovim'
	finish
endif

if ! exists('*appendbufline')
	echomsg 'You need appendbufline to handle jobs'
	finish
endif

" ---- callback

fun! torustree#ripple#callback_exit (chan, code)
	" Callback ou exit event
	let text = printf('%s %s', a:chan, a:code)
	eval g:torustree_ripple->remove(-1)
	echomsg text
endfun

" ---- mandala

fun! torustree#ripple#template (mandala_type)
	" Job buffer template
	call torustree#mandala#template ()
	let b:wheel_nature.is_writable = v:true
	setlocal noreadonly
	setlocal modifiable
endfun

fun! torustree#ripple#stop_map ()
	" Map to stop the job
	let map = 'nnoremap <buffer>'
	let callme = '<cmd>call torustree#ripple#stop()<cr>'
	execute map '<c-s>' callme
endfun

" ---- main

fun! torustree#ripple#start (command, ...)
	" Start a new job
	let command = a:command
	let kind = type(a:command)
	if kind == v:t_list
		let command = a:command
	elseif kind == v:t_string
		let command = split(a:command)
	else
		echomsg 'torustree ripple start : bad command format'
		return
	endif
	if a:0 > 0
		let options = a:1
	else
		let options = {'mandala_type' : 'ripple'}
	endif
	" mandala
	let mandala_type = options.mandala_type
	call torustree#mandala#blank (mandala_type)
	call torustree#ripple#template (mandala_type)
	call torustree#mandala#fill('')
	2 delete _
	" job
	let jobopts = {}
	let jobopts.out_io = 'buffer'
	let bufname = bufname('%')
	let jobopts.out_name = bufname
	let jobopts.exit_cb = 'torustree#ripple#callback_exit'
	let job = job_start(command, jobopts)
	eval g:torustree_ripple->add(job)
	call torustree#ripple#stop_map ()
	return job
endfun

fun! torustree#ripple#stop (...)
	" Stop job
	if a:0 > 0
		let job = a:1
	else
		if ! empty(g:torustree_ripple)
			let job = g:torustree_ripple[-1]
		else
			echomsg 'torustree ripple stop : no more job left'
			return v:false
		endif
	endif
	call job_stop(job)
	" remove of job in g:torustree_ripple is done in callback_exit
endfun
