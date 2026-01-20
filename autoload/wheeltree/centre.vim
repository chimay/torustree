" vim: set ft=vim fdm=indent iskeyword&:

" Centre
"
" Meta command, mappings

" ---- script constants

if exists('s:subcommands_actions')
	unlockvar s:subcommands_actions
endif
let s:subcommands_actions = wheeltree#diadem#fetch('command/meta/actions')
lockvar s:subcommands_actions

if exists('s:prompt_actions')
	unlockvar s:prompt_actions
endif
let s:prompt_actions = wheeltree#diadem#fetch('command/meta/prompt/actions')
lockvar s:prompt_actions

if exists('s:dedibuf_actions')
	unlockvar s:dedibuf_actions
endif
let s:dedibuf_actions = wheeltree#diadem#fetch('command/meta/dedibuf/actions')
lockvar s:dedibuf_actions

if exists('s:normal_plugs')
	unlockvar s:normal_plugs
endif
let s:normal_plugs = wheeltree#geode#fetch('plugs/normal')
lockvar s:normal_plugs

if exists('s:visual_plugs')
	unlockvar s:visual_plugs
endif
let s:visual_plugs = wheeltree#geode#fetch('plugs/visual')
lockvar s:visual_plugs

if exists('s:expr_plugs')
	unlockvar s:expr_plugs
endif
let s:expr_plugs = wheeltree#geode#fetch('plugs/expr')
lockvar s:expr_plugs

if exists('s:level_0_normal_maps')
	unlockvar s:level_0_normal_maps
endif
let s:level_0_normal_maps = wheeltree#geode#fetch('maps/level_0/normal')
lockvar s:level_0_normal_maps

if exists('s:level_1_normal_maps')
	unlockvar s:level_1_normal_maps
endif
let s:level_1_normal_maps = wheeltree#geode#fetch('maps/level_1/normal')
lockvar s:level_1_normal_maps

if exists('s:level_2_normal_maps')
	unlockvar s:level_2_normal_maps
endif
let s:level_2_normal_maps = wheeltree#geode#fetch('maps/level_2/normal')
lockvar s:level_2_normal_maps

if exists('s:level_2_visual_maps')
	unlockvar s:level_2_visual_maps
endif
let s:level_2_visual_maps = wheeltree#geode#fetch('maps/level_2/visual')
lockvar s:level_2_visual_maps

if exists('s:level_20_normal_maps')
	unlockvar s:level_20_normal_maps
endif
let s:level_20_normal_maps = wheeltree#geode#fetch('maps/level_20/normal')
lockvar s:level_20_normal_maps

" ---- commands

fun! wheeltree#centre#meta (subcommand, ...)
	" Function for meta command
	let subcommand = a:subcommand
	let arguments = a:000
	" ---- subcommands without argument
	if empty(arguments)
		let action_dict = wheeltree#matrix#items2dict(s:subcommands_actions)
		let action = action_dict[subcommand]
		if action ==# 'wheeltree#void#nope'
			echomsg 'Wheeltree centre meta-command : this action need a third argument'
			return v:false
		endif
		return wheeltree#metafun#call(action)
	endif
	" ---- prompt
	if subcommand ==# 'prompt'
		let action_dict = wheeltree#matrix#items2dict(s:prompt_actions)
		let subcom = arguments[0]
		let action = action_dict[subcom]
		return wheeltree#metafun#call(action)
	endif
	" ---- dedibuf
	if subcommand ==# 'dedibuf'
		let action_dict = wheeltree#matrix#items2dict(s:dedibuf_actions)
		let subcom = arguments[0]
		let action = action_dict[subcom]
		return wheeltree#metafun#call(action)
	endif
	" ---- other subcommand with argument(s)
	let action_dict = wheeltree#matrix#items2dict(s:subcommands_actions)
	let action = action_dict[subcommand]
	if subcommand ==# 'batch'
		let arguments = join(arguments)
		return call(action, [ arguments ])
	endif
	return call(action, arguments)
endfun

fun! wheeltree#centre#commands ()
	" Define commands
	" ---- meta command
	command! -nargs=* -complete=customlist,wheeltree#complete#meta_command
				\ Wheeltree call wheeltree#centre#meta(<f-args>)
endfun

" ---- plugs

fun! wheeltree#centre#plugs ()
	" Link <plug> mappings to wheeltree functions
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

fun! wheeltree#centre#mappings (level, mode = 'normal')
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

fun! wheeltree#centre#prefixless ()
	" Prefix-less maps
	let nmap = 'nmap <silent>'
	let vmap = 'vmap <silent>'
	" Menus
	execute nmap '<m-m>         <plug>(wheeltree-menu-main)'
	execute nmap '<m-=>         <plug>(wheeltree-menu-meta)'
	" Sync
	execute nmap '<m-i>         <plug>(wheeltree-info)'
	execute nmap '<m-$>         <plug>(wheeltree-sync-up)'
	execute nmap '<c-$>         <plug>(wheeltree-sync-down)'
	" ---- navigate in the wheeltree
	" --  next / previous
	execute nmap '<m-pageup>    <plug>(wheeltree-previous-location)'
	execute nmap '<m-pagedown>  <plug>(wheeltree-next-location)'
	execute nmap '<c-pageup>    <plug>(wheeltree-previous-circle)'
	execute nmap '<c-pagedown>  <plug>(wheeltree-next-circle)'
	execute nmap '<s-pageup>    <plug>(wheeltree-previous-torus)'
	execute nmap '<s-pagedown>  <plug>(wheeltree-next-torus)'
	" -- switch
	execute nmap '<m-cr>        <plug>(wheeltree-prompt-location)'
	execute nmap '<c-cr>        <plug>(wheeltree-prompt-circle)'
	execute nmap '<s-cr>        <plug>(wheeltree-prompt-torus)'
	execute nmap '<m-space>     <plug>(wheeltree-dedibuf-location)'
	execute nmap '<c-space>     <plug>(wheeltree-dedibuf-circle)'
	execute nmap '<s-space>     <plug>(wheeltree-dedibuf-torus)'
	" -- index
	execute nmap '<m-x>         <plug>(wheeltree-prompt-index)'
	execute nmap '<m-s-x>       <plug>(wheeltree-dedibuf-index)'
	execute nmap '<m-c-x>       <plug>(wheeltree-dedibuf-index-tree)'
	" -- history
	execute nmap '<m-home>      <plug>(wheeltree-history-newer)'
	execute nmap '<m-end>       <plug>(wheeltree-history-older)'
	execute nmap '<c-home>      <plug>(wheeltree-history-newer-in-circle)'
	execute nmap '<c-end>       <plug>(wheeltree-history-older-in-circle)'
	execute nmap '<s-home>      <plug>(wheeltree-history-newer-in-torus)'
	execute nmap '<s-end>       <plug>(wheeltree-history-older-in-torus)'
	execute nmap '<m-h>         <plug>(wheeltree-prompt-history)'
	execute nmap '<m-c-h>       <plug>(wheeltree-dedibuf-history)'
	" -- alternate
	execute nmap '<c-^>         <plug>(wheeltree-alternate-anywhere)'
	execute nmap '<m-^>         <plug>(wheeltree-alternate-same-circle)'
	execute nmap '<m-c-^>       <plug>(wheeltree-alternate-same-torus-other-circle)'
	" -- frecency
	execute nmap '<m-e>         <plug>(wheeltree-prompt-frecency)'
	execute nmap '<m-c-e>       <plug>(wheeltree-dedibuf-frecency)'
	" ---- navigate with vim native tools
	" -- buffers
	execute nmap '<m-b>          <plug>(wheeltree-prompt-buffer)'
	execute nmap '<m-c-b>        <plug>(wheeltree-dedibuf-buffer)'
	execute nmap '<m-s-b>        <plug>(wheeltree-dedibuf-buffer-all)'
	" -- tabs & windows : visible buffers
	execute nmap '<m-v>          <plug>(wheeltree-prompt-tabwin)'
	execute nmap '<m-c-v>        <plug>(wheeltree-dedibuf-tabwin-tree)'
	execute nmap '<m-s-v>        <plug>(wheeltree-dedibuf-tabwin)'
	" -- (neo)vim lists
	execute nmap "<m-'>          <plug>(wheeltree-prompt-marker)"
	execute nmap "<m-k>          <plug>(wheeltree-prompt-marker)"
	execute nmap '<m-j>          <plug>(wheeltree-prompt-jump)'
	execute nmap '<m-,>          <plug>(wheeltree-prompt-change)'
	execute nmap '<m-c>          <plug>(wheeltree-prompt-change)'
	execute nmap '<m-t>          <plug>(wheeltree-prompt-tag)'
	execute nmap "<m-c-k>        <plug>(wheeltree-dedibuf-marker)"
	execute nmap '<m-c-j>        <plug>(wheeltree-dedibuf-jump)'
	execute nmap '<m-;>          <plug>(wheeltree-dedibuf-change)'
	execute nmap '<m-c-t>        <plug>(wheeltree-dedibuf-tag)'
	" ---- organize the wheeltree
	execute nmap '<m-insert>     <plug>(wheeltree-prompt-add-here)'
	execute nmap '<m-del>        <plug>(wheeltree-prompt-delete-location)'
	execute nmap '<m-r>          <plug>(wheeltree-dedibuf-reorganize)'
	" ---- organize other things
	execute nmap '<m-c-r>        <plug>(wheeltree-dedibuf-reorg-tabwin)'
	" ---- refactoring
	execute nmap '<m-c-g>        <plug>(wheeltree-dedibuf-grep-edit)'
	execute nmap '<m-n>          <plug>(wheeltree-dedibuf-narrow-operator)'
	execute vmap '<m-n>          <plug>(wheeltree-dedibuf-narrow)'
	execute nmap '<m-c-n>        <plug>(wheeltree-dedibuf-narrow-circle)'
	" ---- search
	" -- files
	execute nmap '<m-f>          <plug>(wheeltree-prompt-find)'
	execute nmap '<m-c-f>        <plug>(wheeltree-dedibuf-find)'
	execute nmap '<m-c-&>        <plug>(wheeltree-dedibuf-async-find)'
	execute nmap '<m-u>          <plug>(wheeltree-prompt-mru)'
	execute nmap '<m-c-u>        <plug>(wheeltree-dedibuf-mru)'
	execute nmap '<m-l>          <plug>(wheeltree-dedibuf-locate)'
	" -- inside files
	execute nmap '<m-o>          <plug>(wheeltree-prompt-occur)'
	execute nmap '<m-c-o>        <plug>(wheeltree-dedibuf-occur)'
	execute nmap '<m-g>          <plug>(wheeltree-dedibuf-grep)'
	execute nmap '<m-s-o>        <plug>(wheeltree-prompt-outline)'
	execute nmap '<c-s-o>        <plug>(wheeltree-dedibuf-outline)'
	" ---- yank ring
	execute nmap '<m-y>          <plug>(wheeltree-prompt-yank-plain-linewise-after)'
	execute nmap '<m-p>          <plug>(wheeltree-prompt-yank-plain-charwise-after)'
	execute nmap '<m-s-y>        <plug>(wheeltree-prompt-yank-plain-linewise-before)'
	execute nmap '<m-s-p>        <plug>(wheeltree-prompt-yank-plain-charwise-before)'
	execute nmap '<m-c-y>        <plug>(wheeltree-dedibuf-yank-plain)'
	execute nmap '<m-c-p>        <plug>(wheeltree-dedibuf-yank-list)'
	" ---- undo list
	execute nmap '<m-s-u>        <plug>(wheeltree-dedibuf-undo-list)'
	" ---- ex or shell command output
	execute nmap '<m-!>          <plug>(wheeltree-dedibuf-command)'
	execute nmap '<m-&>          <plug>(wheeltree-dedibuf-async)'
	" ---- dedicated buffers
	execute nmap '<m-tab>        <plug>(wheeltree-mandala-add)'
	execute nmap '<m-backspace>  <plug>(wheeltree-mandala-delete)'
	execute nmap '<m-left>       <plug>(wheeltree-mandala-backward)'
	execute nmap '<m-right>      <plug>(wheeltree-mandala-forward)'
	execute nmap '<c-up>         <plug>(wheeltree-mandala-switch)'
	" ---- layouts
	execute nmap '<m-z>          <plug>(wheeltree-zoom)'
endfun

" ---- link plugs & maps

fun! wheeltree#centre#cables ()
	" Link keys to <plug> mappings
	" ---- basic
	if g:wheeltree_config.mappings >= 0
		call wheeltree#centre#mappings (0)
	endif
	" ---- common
	if g:wheeltree_config.mappings >= 1
		call wheeltree#centre#mappings (1)
	endif
	" ---- advanced
	if g:wheeltree_config.mappings >= 2
		call wheeltree#centre#mappings (2)
		call wheeltree#centre#mappings (2, 'visual')
	endif
	" ---- without prefix
	if g:wheeltree_config.mappings >= 10
		call wheeltree#centre#prefixless ()
	endif
	" ---- debug
	if g:wheeltree_config.mappings >= 20
		call wheeltree#centre#mappings (20)
	endif
endfun
