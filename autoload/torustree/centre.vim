" vim: set ft=vim fdm=indent iskeyword&:

" Centre
"
" Meta command, mappings

" ---- script constants

if exists('s:subcommands_actions')
	unlockvar s:subcommands_actions
endif
let s:subcommands_actions = torustree#diadem#fetch('command/meta/actions')
lockvar s:subcommands_actions

if exists('s:prompt_actions')
	unlockvar s:prompt_actions
endif
let s:prompt_actions = torustree#diadem#fetch('command/meta/prompt/actions')
lockvar s:prompt_actions

if exists('s:dedibuf_actions')
	unlockvar s:dedibuf_actions
endif
let s:dedibuf_actions = torustree#diadem#fetch('command/meta/dedibuf/actions')
lockvar s:dedibuf_actions

if exists('s:normal_plugs')
	unlockvar s:normal_plugs
endif
let s:normal_plugs = torustree#geode#fetch('plugs/normal')
lockvar s:normal_plugs

if exists('s:visual_plugs')
	unlockvar s:visual_plugs
endif
let s:visual_plugs = torustree#geode#fetch('plugs/visual')
lockvar s:visual_plugs

if exists('s:expr_plugs')
	unlockvar s:expr_plugs
endif
let s:expr_plugs = torustree#geode#fetch('plugs/expr')
lockvar s:expr_plugs

if exists('s:level_0_normal_maps')
	unlockvar s:level_0_normal_maps
endif
let s:level_0_normal_maps = torustree#geode#fetch('maps/level_0/normal')
lockvar s:level_0_normal_maps

if exists('s:level_1_normal_maps')
	unlockvar s:level_1_normal_maps
endif
let s:level_1_normal_maps = torustree#geode#fetch('maps/level_1/normal')
lockvar s:level_1_normal_maps

if exists('s:level_2_normal_maps')
	unlockvar s:level_2_normal_maps
endif
let s:level_2_normal_maps = torustree#geode#fetch('maps/level_2/normal')
lockvar s:level_2_normal_maps

if exists('s:level_2_visual_maps')
	unlockvar s:level_2_visual_maps
endif
let s:level_2_visual_maps = torustree#geode#fetch('maps/level_2/visual')
lockvar s:level_2_visual_maps

if exists('s:level_20_normal_maps')
	unlockvar s:level_20_normal_maps
endif
let s:level_20_normal_maps = torustree#geode#fetch('maps/level_20/normal')
lockvar s:level_20_normal_maps

" ---- commands

fun! torustree#centre#meta (subcommand, ...)
	" Function for meta command
	let subcommand = a:subcommand
	let arguments = a:000
	" ---- subcommands without argument
	if empty(arguments)
		let action_dict = torustree#matrix#items2dict(s:subcommands_actions)
		let action = action_dict[subcommand]
		if action ==# 'torustree#void#nope'
			echomsg 'Torustree centre meta-command : this action need a third argument'
			return v:false
		endif
		return torustree#metafun#call(action)
	endif
	" ---- prompt
	if subcommand ==# 'prompt'
		let action_dict = torustree#matrix#items2dict(s:prompt_actions)
		let subcom = arguments[0]
		let action = action_dict[subcom]
		return torustree#metafun#call(action)
	endif
	" ---- dedibuf
	if subcommand ==# 'dedibuf'
		let action_dict = torustree#matrix#items2dict(s:dedibuf_actions)
		let subcom = arguments[0]
		let action = action_dict[subcom]
		return torustree#metafun#call(action)
	endif
	" ---- other subcommand with argument(s)
	let action_dict = torustree#matrix#items2dict(s:subcommands_actions)
	let action = action_dict[subcommand]
	if subcommand ==# 'batch'
		let arguments = join(arguments)
		return call(action, [ arguments ])
	endif
	return call(action, arguments)
endfun

fun! torustree#centre#commands ()
	" Define commands
	" ---- meta command
	command! -nargs=* -complete=customlist,torustree#complete#meta_command
				\ Torustree call torustree#centre#meta(<f-args>)
endfun

" ---- plugs

fun! torustree#centre#plugs ()
	" Link <plug> mappings to torustree functions
	" ---- normal maps
	let begin = 'nnoremap <plug>('
	let middle = ') <cmd>call'
	let end = '<cr>'
	for item in s:normal_plugs
		let left = item[0]
		let right = item[1]
		if right !~ ')$'
			let right ..= '()'
		endif
		execute begin .. left .. middle right .. end
	endfor
	" ---- visual maps
	let begin = 'vnoremap <plug>('
	" use colon instead of <cmd> to catch the range
	let middle = ') :call'
	for item in s:visual_plugs
		let left = item[0]
		let right = item[1]
		if right !~ ')$'
			let right ..= '()'
		endif
		execute begin .. left .. middle right .. end
	endfor
	" ---- expr maps
	let begin = 'nnoremap <expr> <plug>('
	let middle = ')'
	for item in s:expr_plugs
		let left = item[0]
		let right = item[1]
		if right !~ ')$'
			let right ..= '()'
		endif
		execute begin .. left .. middle right
	endfor
endfun

" ---- maps

fun! torustree#centre#mappings (level, mode = 'normal')
	" Normal maps of level
	let level = a:level
	let mode = a:mode
	" ---- mode dependent variables
	if mode ==# 'normal'
		let mapcmd = 'nmap'
	elseif mode ==# 'visual'
		let mapcmd = 'vmap'
	endif
	let level_maps = s:level_{level}_{mode}_maps
	" ---- variables
	let prefix = g:wheeltree_config.prefix
	let begin = mapcmd .. ' <silent> ' .. prefix
	let middle = '<plug>('
	let end = ')'
	" ---- loop
	for item in level_maps
		let left = item[0]
		let right = item[1]
		execute begin .. left middle .. right .. end
	endfor
endfun

fun! torustree#centre#prefixless ()
	" Prefix-less maps
	let nmap = 'nmap <silent>'
	let vmap = 'vmap <silent>'
	" Menus
	execute nmap '<m-m>         <plug>(torustree-menu-main)'
	execute nmap '<m-=>         <plug>(torustree-menu-meta)'
	" Sync
	execute nmap '<m-i>         <plug>(torustree-info)'
	execute nmap '<m-$>         <plug>(torustree-sync-up)'
	execute nmap '<c-$>         <plug>(torustree-sync-down)'
	" ---- navigate in the torustree
	" --  next / previous
	execute nmap '<m-pageup>    <plug>(torustree-previous-location)'
	execute nmap '<m-pagedown>  <plug>(torustree-next-location)'
	execute nmap '<c-pageup>    <plug>(torustree-previous-circle)'
	execute nmap '<c-pagedown>  <plug>(torustree-next-circle)'
	execute nmap '<s-pageup>    <plug>(torustree-previous-torus)'
	execute nmap '<s-pagedown>  <plug>(torustree-next-torus)'
	" -- switch
	execute nmap '<m-cr>        <plug>(torustree-prompt-location)'
	execute nmap '<c-cr>        <plug>(torustree-prompt-circle)'
	execute nmap '<s-cr>        <plug>(torustree-prompt-torus)'
	execute nmap '<m-space>     <plug>(torustree-dedibuf-location)'
	execute nmap '<c-space>     <plug>(torustree-dedibuf-circle)'
	execute nmap '<s-space>     <plug>(torustree-dedibuf-torus)'
	" -- index
	execute nmap '<m-x>         <plug>(torustree-prompt-index)'
	execute nmap '<m-s-x>       <plug>(torustree-dedibuf-index)'
	execute nmap '<m-c-x>       <plug>(torustree-dedibuf-index-tree)'
	" -- history
	execute nmap '<m-home>      <plug>(torustree-history-newer)'
	execute nmap '<m-end>       <plug>(torustree-history-older)'
	execute nmap '<c-home>      <plug>(torustree-history-newer-in-circle)'
	execute nmap '<c-end>       <plug>(torustree-history-older-in-circle)'
	execute nmap '<s-home>      <plug>(torustree-history-newer-in-torus)'
	execute nmap '<s-end>       <plug>(torustree-history-older-in-torus)'
	execute nmap '<m-h>         <plug>(torustree-prompt-history)'
	execute nmap '<m-c-h>       <plug>(torustree-dedibuf-history)'
	" -- alternate
	execute nmap '<c-^>         <plug>(torustree-alternate-anywhere)'
	execute nmap '<m-^>         <plug>(torustree-alternate-same-circle)'
	execute nmap '<m-c-^>       <plug>(torustree-alternate-same-torus-other-circle)'
	" -- frecency
	execute nmap '<m-e>         <plug>(torustree-prompt-frecency)'
	execute nmap '<m-c-e>       <plug>(torustree-dedibuf-frecency)'
	" ---- navigate with vim native tools
	" -- buffers
	execute nmap '<m-b>          <plug>(torustree-prompt-buffer)'
	execute nmap '<m-c-b>        <plug>(torustree-dedibuf-buffer)'
	execute nmap '<m-s-b>        <plug>(torustree-dedibuf-buffer-all)'
	" -- tabs & windows : visible buffers
	execute nmap '<m-v>          <plug>(torustree-prompt-tabwin)'
	execute nmap '<m-c-v>        <plug>(torustree-dedibuf-tabwin-tree)'
	execute nmap '<m-s-v>        <plug>(torustree-dedibuf-tabwin)'
	" -- (neo)vim lists
	execute nmap "<m-'>          <plug>(torustree-prompt-marker)"
	execute nmap "<m-k>          <plug>(torustree-prompt-marker)"
	execute nmap '<m-j>          <plug>(torustree-prompt-jump)'
	execute nmap '<m-,>          <plug>(torustree-prompt-change)'
	execute nmap '<m-c>          <plug>(torustree-prompt-change)'
	execute nmap '<m-t>          <plug>(torustree-prompt-tag)'
	execute nmap "<m-c-k>        <plug>(torustree-dedibuf-marker)"
	execute nmap '<m-c-j>        <plug>(torustree-dedibuf-jump)'
	execute nmap '<m-;>          <plug>(torustree-dedibuf-change)'
	execute nmap '<m-c-t>        <plug>(torustree-dedibuf-tag)'
	" ---- organize the torustree
	execute nmap '<m-insert>     <plug>(torustree-prompt-add-here)'
	execute nmap '<m-del>        <plug>(torustree-prompt-delete-location)'
	execute nmap '<m-r>          <plug>(torustree-dedibuf-reorganize)'
	" ---- organize other things
	execute nmap '<m-c-r>        <plug>(torustree-dedibuf-reorg-tabwin)'
	" ---- refactoring
	execute nmap '<m-c-g>        <plug>(torustree-dedibuf-grep-edit)'
	execute nmap '<m-n>          <plug>(torustree-dedibuf-narrow-operator)'
	execute vmap '<m-n>          <plug>(torustree-dedibuf-narrow)'
	execute nmap '<m-c-n>        <plug>(torustree-dedibuf-narrow-circle)'
	" ---- search
	" -- files
	execute nmap '<m-f>          <plug>(torustree-prompt-find)'
	execute nmap '<m-c-f>        <plug>(torustree-dedibuf-find)'
	execute nmap '<m-c-&>        <plug>(torustree-dedibuf-async-find)'
	execute nmap '<m-u>          <plug>(torustree-prompt-mru)'
	execute nmap '<m-c-u>        <plug>(torustree-dedibuf-mru)'
	execute nmap '<m-l>          <plug>(torustree-dedibuf-locate)'
	" -- inside files
	execute nmap '<m-o>          <plug>(torustree-prompt-occur)'
	execute nmap '<m-c-o>        <plug>(torustree-dedibuf-occur)'
	execute nmap '<m-g>          <plug>(torustree-dedibuf-grep)'
	execute nmap '<m-s-o>        <plug>(torustree-prompt-outline)'
	execute nmap '<c-s-o>        <plug>(torustree-dedibuf-outline)'
	" ---- yank ring
	execute nmap '<m-y>          <plug>(torustree-prompt-yank-plain-linewise-after)'
	execute nmap '<m-p>          <plug>(torustree-prompt-yank-plain-charwise-after)'
	execute nmap '<m-s-y>        <plug>(torustree-prompt-yank-plain-linewise-before)'
	execute nmap '<m-s-p>        <plug>(torustree-prompt-yank-plain-charwise-before)'
	execute nmap '<m-c-y>        <plug>(torustree-dedibuf-yank-plain)'
	execute nmap '<m-c-p>        <plug>(torustree-dedibuf-yank-list)'
	" ---- undo list
	execute nmap '<m-s-u>        <plug>(torustree-dedibuf-undo-list)'
	" ---- ex or shell command output
	execute nmap '<m-!>          <plug>(torustree-dedibuf-command)'
	execute nmap '<m-&>          <plug>(torustree-dedibuf-async)'
	" ---- dedicated buffers
	execute nmap '<m-tab>        <plug>(torustree-mandala-add)'
	execute nmap '<m-backspace>  <plug>(torustree-mandala-delete)'
	execute nmap '<m-left>       <plug>(torustree-mandala-backward)'
	execute nmap '<m-right>      <plug>(torustree-mandala-forward)'
	execute nmap '<c-up>         <plug>(torustree-mandala-switch)'
	" ---- layouts
	execute nmap '<m-z>          <plug>(torustree-zoom)'
endfun

" ---- link plugs & maps

fun! torustree#centre#cables ()
	" Link keys to <plug> mappings
	" ---- basic
	if g:wheeltree_config.mappings >= 0
		call torustree#centre#mappings (0)
	endif
	" ---- common
	if g:wheeltree_config.mappings >= 1
		call torustree#centre#mappings (1)
	endif
	" ---- advanced
	if g:wheeltree_config.mappings >= 2
		call torustree#centre#mappings (2)
		call torustree#centre#mappings (2, 'visual')
	endif
	" ---- without prefix
	if g:wheeltree_config.mappings >= 10
		call torustree#centre#prefixless ()
	endif
	" ---- debug
	if g:wheeltree_config.mappings >= 20
		call torustree#centre#mappings (20)
	endif
endfun
