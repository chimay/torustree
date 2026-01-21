" vim: set ft=vim fdm=indent iskeyword&:

" Diadem
"
" Internal Constants for commands

" ---- commands

if exists('s:command_meta_actions')
	unlockvar! s:command_meta_actions
endif
let s:command_meta_actions = [
			\ [ 'info'                  , 'torustree#status#dashboard'                                            ] ,
			\ [ 'jump'                  , 'torustree#vortex#jump'                                                 ] ,
			\ [ 'follow'                , 'torustree#projection#follow'                                           ] ,
			\ [ 'sync-down'             , 'torustree#vortex#jump'                                                 ] ,
			\ [ 'sync-up'               , 'torustree#projection#follow'                                           ] ,
			\ [ 'next-location'         , "torustree#vortex#next('location')"                                     ] ,
			\ [ 'previous-location'     , "torustree#vortex#previous('location')"                                 ] ,
			\ [ 'next-circle'           , "torustree#vortex#next('circle')"                                       ] ,
			\ [ 'previous-circle'       , "torustree#vortex#previous('circle')"                                   ] ,
			\ [ 'next-torus'            , "torustree#vortex#next('torus')"                                        ] ,
			\ [ 'previous-torus'        , "torustree#vortex#previous('torus')"                                    ] ,
			\ [ 'newer'                 , 'torustree#waterclock#newer_anywhere'                                   ] ,
			\ [ 'older'                 , 'torustree#waterclock#older_anywhere'                                   ] ,
			\ [ 'newer-in-circle'       , "torustree#waterclock#newer('circle')"                                  ] ,
			\ [ 'older-in-circle'       , "torustree#waterclock#older('circle')"                                  ] ,
			\ [ 'newer-in-torus'        , "torustree#waterclock#newer('torus')"                                   ] ,
			\ [ 'older-in-torus'        , "torustree#waterclock#older('torus')"                                   ] ,
			\ [ 'alternate-anywhere'    , "torustree#caduceus#alternate('anywhere')"                              ] ,
			\ [ 'alternate-same-torus'  , "torustree#caduceus#alternate('same_torus')"                            ] ,
			\ [ 'alternate-same-circle' , "torustree#caduceus#alternate('same_circle')"                           ] ,
			\ [ 'alternate-other-torus' , "torustree#caduceus#alternate('other_torus')"                           ] ,
			\ [ 'alternate-other-circle' , "torustree#caduceus#alternate('other_circle')"                         ] ,
			\ [ 'alternate-same-torus-other-circle' , "torustree#caduceus#alternate('same_torus_other_circle')"   ] ,
			\ [ 'alternate-window'      , 'torustree#caduceus#alternate_window()'                                 ] ,
			\ [ 'mkdir'                 , 'torustree#disc#mkdir'                                                  ] ,
			\ [ 'rename'                , 'torustree#disc#rename'                                                 ] ,
			\ [ 'copy'                  , 'torustree#disc#copy'                                                   ] ,
			\ [ 'delete'                , 'torustree#disc#delete'                                                 ] ,
			\ [ 'autogroup'             , 'torustree#group#menu'                                                  ] ,
			\ [ 'batch'                 , 'torustree#vector#batch'                                                ] ,
			\ [ 'tree-script'           , 'torustree#disc#tree_script'                                            ] ,
			\ [ 'symlink-tree'          , 'torustree#disc#symlink_tree'                                           ] ,
			\ [ 'copied-tree'           , 'torustree#disc#copied_tree'                                            ] ,
			\ [ 'clear-signs'           , 'torustree#chakra#clear'                                                ] ,
			\ [ 'prompt'                , 'torustree#void#nope'                                                   ] ,
			\ [ 'dedibuf'               , 'torustree#void#nope'                                                   ] ,
			\ ]
lockvar! s:command_meta_actions

if exists('s:command_meta_prompt_actions')
	unlockvar! s:command_meta_prompt_actions
endif
let s:command_meta_prompt_actions = [
			\ [ 'location'                , "torustree#vortex#switch('location')"           ] ,
			\ [ 'circle'                  , "torustree#vortex#switch('circle')"             ] ,
			\ [ 'torus'                   , "torustree#vortex#switch('torus')"              ] ,
			\ [ 'multi-switch'            , 'torustree#vortex#multi_switch'                 ] ,
			\ [ 'index-locations'         , 'torustree#vortex#helix'                        ] ,
			\ [ 'index-circles'           , 'torustree#vortex#grid'                         ] ,
			\ [ 'history'                 , 'torustree#waterclock#history'                  ] ,
			\ [ 'frecency'                , 'torustree#waterclock#frecency'                 ] ,
			\ [ 'read-torustree'              , 'torustree#disc#read_torustree'                     ] ,
			\ [ 'write-torustree'             , 'torustree#disc#write_torustree'                    ] ,
			\ [ 'read-session'            , 'torustree#disc#read_session'                   ] ,
			\ [ 'write-session'           , 'torustree#disc#write_session'                  ] ,
			\ [ 'buffer'                  , 'torustree#sailing#buffer'                      ] ,
			\ [ 'tabwin'                  , 'torustree#sailing#tabwin'                      ] ,
			\ [ 'marker'                  , 'torustree#sailing#marker'                      ] ,
			\ [ 'jump'                    , 'torustree#sailing#jump'                        ] ,
			\ [ 'change'                  , 'torustree#sailing#change'                      ] ,
			\ [ 'tag'                     , 'torustree#sailing#tag'                         ] ,
			\ [ 'add-here'                , 'torustree#tree#add_here'                       ] ,
			\ [ 'add-circle'              , 'torustree#tree#add_circle'                     ] ,
			\ [ 'add-torus'               , 'torustree#tree#add_torus'                      ] ,
			\ [ 'add-file'                , 'torustree#tree#add_file'                       ] ,
			\ [ 'add-buffer'              , 'torustree#tree#add_buffer'                     ] ,
			\ [ 'add-glob'                , 'torustree#tree#add_glob'                       ] ,
			\ [ 'rename-location'         , "torustree#tree#rename('location')"             ] ,
			\ [ 'rename-file'             , 'torustree#tree#rename_file'                    ] ,
			\ [ 'rename-circle'           , "torustree#tree#rename('circle')"               ] ,
			\ [ 'rename-torus'            , "torustree#tree#rename('torus')"                ] ,
			\ [ 'delete-location'         , "torustree#tree#delete('location')"             ] ,
			\ [ 'delete-circle'           , "torustree#tree#delete('circle')"               ] ,
			\ [ 'delete-torus'            , "torustree#tree#delete('torus')"                ] ,
			\ [ 'copy-location'           , "torustree#tree#copy('location')"               ] ,
			\ [ 'copy-circle'             , "torustree#tree#copy('circle')"                 ] ,
			\ [ 'copy-torus'              , "torustree#tree#copy('torus')"                  ] ,
			\ [ 'move-location'           , "torustree#tree#move('location')"               ] ,
			\ [ 'move-circle'             , "torustree#tree#move('circle')"                 ] ,
			\ [ 'move-torus'              , "torustree#tree#move('torus')"                  ] ,
			\ [ 'find'                    , 'torustree#sailing#find'                        ] ,
			\ [ 'mru'                     , 'torustree#sailing#mru'                         ] ,
			\ [ 'occur'                   , 'torustree#sailing#occur'                       ] ,
			\ [ 'switch-default-register' , 'torustree#codex#switch_default_register'       ] ,
			\ [ 'outline'                 , 'torustree#sailing#outline'                     ] ,
			\ [ 'yank-linewise-after'     , 'torustree#codex#yank_plain'                    ] ,
			\ [ 'yank-charwise-after'     , "torustree#codex#yank_plain('charwise-after')"  ] ,
			\ [ 'yank-linewise-before'    , "torustree#codex#yank_plain('linewise-before')" ] ,
			\ [ 'yank-charwise-before'    , "torustree#codex#yank_plain('charwise-before')" ] ,
			\ [ 'default-register'        , 'torustree#codex#switch_default_register'       ] ,
			\ ]
lockvar! s:command_meta_prompt_actions

if exists('s:command_meta_dedibuf_actions')
	unlockvar! s:command_meta_dedibuf_actions
endif
let s:command_meta_dedibuf_actions = [
			\ [ 'menu-main'                  , 'torustree#helm#main'                       ] ,
			\ [ 'menu-meta'                  , 'torustree#helm#meta'                       ] ,
			\ [ 'location'                   , "torustree#whirl#switch('location')"        ] ,
			\ [ 'circle'                     , "torustree#whirl#switch('circle')"          ] ,
			\ [ 'torus'                      , "torustree#whirl#switch('torus')"           ] ,
			\ [ 'index-locations'            , 'torustree#whirl#helix'                     ] ,
			\ [ 'index-circles'              , 'torustree#whirl#grid'                      ] ,
			\ [ 'index-tree'                 , 'torustree#whirl#tree'                      ] ,
			\ [ 'history'                    , 'torustree#whirl#history'                   ] ,
			\ [ 'frecency'                   , 'torustree#whirl#frecency'                  ] ,
			\ [ 'buffer'                     , 'torustree#frigate#buffer'                  ] ,
			\ [ 'buffer-all'                 , "torustree#frigate#buffer('all')"           ] ,
			\ [ 'tabwin'                     , 'torustree#frigate#tabwin'                  ] ,
			\ [ 'tabwin-tree'                , 'torustree#frigate#tabwin_tree'             ] ,
			\ [ 'marker'                     , 'torustree#frigate#marker'                  ] ,
			\ [ 'jump'                       , 'torustree#frigate#jump'                    ] ,
			\ [ 'change'                     , 'torustree#frigate#change'                  ] ,
			\ [ 'tag'                        , 'torustree#frigate#tag'                     ] ,
			\ [ 'reorder-locations'          , "torustree#yggdrasil#reorder('location')"   ] ,
			\ [ 'reorder-circles'            , "torustree#yggdrasil#reorder('circle')"     ] ,
			\ [ 'reorder-toruses'            , "torustree#yggdrasil#reorder('torus')"      ] ,
			\ [ 'rename-locations'           , "torustree#yggdrasil#rename('location')"    ] ,
			\ [ 'rename-circles'             , "torustree#yggdrasil#rename('circle')"      ] ,
			\ [ 'rename-toruses'             , "torustree#yggdrasil#rename('torus')"       ] ,
			\ [ 'rename-locations-filenames' , 'torustree#yggdrasil#rename_file'           ] ,
			\ [ 'delete-locations'           , "torustree#yggdrasil#delete('location')"    ] ,
			\ [ 'delete-circles'             , "torustree#yggdrasil#delete('circle')"      ] ,
			\ [ 'delete-toruses'             , "torustree#yggdrasil#delete('torus')"       ] ,
			\ [ 'copy-move-location'         , "torustree#yggdrasil#copy_move('location')" ] ,
			\ [ 'copy-move-circle'           , "torustree#yggdrasil#copy_move('circle')"   ] ,
			\ [ 'copy-move-torus'            , "torustree#yggdrasil#copy_move('torus')"    ] ,
			\ [ 'reorganize'                 , 'torustree#yggdrasil#reorganize'            ] ,
			\ [ 'reorganize-tabwin'          , 'torustree#yggdrasil#reorg_tabwin'          ] ,
			\ [ 'grep-edit'                  , 'torustree#shadow#grep_edit'                ] ,
			\ [ 'narrow-file'                , 'torustree#shadow#narrow_file'              ] ,
			\ [ 'narrow-circle'              , 'torustree#shadow#narrow_circle'            ] ,
			\ [ 'find'                       , 'torustree#frigate#find'                    ] ,
			\ [ 'async-find'                 , 'torustree#frigate#async_find'              ] ,
			\ [ 'mru'                        , 'torustree#frigate#mru'                     ] ,
			\ [ 'locate'                     , 'torustree#frigate#locate'                  ] ,
			\ [ 'occur'                      , 'torustree#frigate#occur'                   ] ,
			\ [ 'grep'                       , 'torustree#frigate#grep'                    ] ,
			\ [ 'outline'                    , 'torustree#frigate#outline'                 ] ,
			\ [ 'yank-plain'                 , "torustree#clipper#yank('plain')"           ] ,
			\ [ 'yank-list'                  , "torustree#clipper#yank('list')"            ] ,
			\ [ 'undo-list'                  , 'torustree#triangle#undolist'               ] ,
			\ [ 'command'                    , 'torustree#mandala#command'                 ] ,
			\ [ 'async'                      , 'torustree#mandala#async'                   ] ,
			\ ]
lockvar! s:command_meta_dedibuf_actions

if exists('s:command_meta_subcommands_file')
	unlockvar! s:command_meta_subcommands_file
endif
let s:command_meta_subcommands_file = [
			\ 'mkdir', 'rename', 'copy', 'delete',
			\ ]
lockvar! s:command_meta_subcommands_file

" ---- public interface

fun! torustree#diadem#fetch (varname, conversion = 'no-conversion')
	" Return script variable called varname
	" The leading s: can be omitted
	" Optional argument :
	"   - no-conversion : simply returns the asked variable, dont convert anything
	"   - dict : if varname points to an items list, convert it to a dictionary
	let varname = a:varname
	let conversion = a:conversion
	" ---- variable name
	let varname = substitute(varname, '/', '_', 'g')
	let varname = substitute(varname, '-', '_', 'g')
	let varname = substitute(varname, ' ', '_', 'g')
	if varname !~ '\m^s:'
		let varname = 's:' .. varname
	endif
	" ---- raw or conversion
	if conversion ==# 'dict'
		return torustree#matrix#items2dict ({varname})
	else
		return {varname}
	endif
endfun
