" vim: set ft=vim fdm=indent iskeyword&:

" Diadem
"
" Internal Constants for commands

" ---- commands

if exists('s:command_meta_actions')
	unlockvar! s:command_meta_actions
endif
let s:command_meta_actions = [
			\ [ 'info'                  , 'wheeltree#status#dashboard'                                            ] ,
			\ [ 'jump'                  , 'wheeltree#vortex#jump'                                                 ] ,
			\ [ 'follow'                , 'wheeltree#projection#follow'                                           ] ,
			\ [ 'sync-down'             , 'wheeltree#vortex#jump'                                                 ] ,
			\ [ 'sync-up'               , 'wheeltree#projection#follow'                                           ] ,
			\ [ 'next-location'         , "wheeltree#vortex#next('location')"                                     ] ,
			\ [ 'previous-location'     , "wheeltree#vortex#previous('location')"                                 ] ,
			\ [ 'next-circle'           , "wheeltree#vortex#next('circle')"                                       ] ,
			\ [ 'previous-circle'       , "wheeltree#vortex#previous('circle')"                                   ] ,
			\ [ 'next-torus'            , "wheeltree#vortex#next('torus')"                                        ] ,
			\ [ 'previous-torus'        , "wheeltree#vortex#previous('torus')"                                    ] ,
			\ [ 'newer'                 , 'wheeltree#waterclock#newer_anywhere'                                   ] ,
			\ [ 'older'                 , 'wheeltree#waterclock#older_anywhere'                                   ] ,
			\ [ 'newer-in-circle'       , "wheeltree#waterclock#newer('circle')"                                  ] ,
			\ [ 'older-in-circle'       , "wheeltree#waterclock#older('circle')"                                  ] ,
			\ [ 'newer-in-torus'        , "wheeltree#waterclock#newer('torus')"                                   ] ,
			\ [ 'older-in-torus'        , "wheeltree#waterclock#older('torus')"                                   ] ,
			\ [ 'alternate-anywhere'    , "wheeltree#caduceus#alternate('anywhere')"                              ] ,
			\ [ 'alternate-same-torus'  , "wheeltree#caduceus#alternate('same_torus')"                            ] ,
			\ [ 'alternate-same-circle' , "wheeltree#caduceus#alternate('same_circle')"                           ] ,
			\ [ 'alternate-other-torus' , "wheeltree#caduceus#alternate('other_torus')"                           ] ,
			\ [ 'alternate-other-circle' , "wheeltree#caduceus#alternate('other_circle')"                         ] ,
			\ [ 'alternate-same-torus-other-circle' , "wheeltree#caduceus#alternate('same_torus_other_circle')"   ] ,
			\ [ 'alternate-window'      , 'wheeltree#caduceus#alternate_window()'                                 ] ,
			\ [ 'mkdir'                 , 'wheeltree#disc#mkdir'                                                  ] ,
			\ [ 'rename'                , 'wheeltree#disc#rename'                                                 ] ,
			\ [ 'copy'                  , 'wheeltree#disc#copy'                                                   ] ,
			\ [ 'delete'                , 'wheeltree#disc#delete'                                                 ] ,
			\ [ 'autogroup'             , 'wheeltree#group#menu'                                                  ] ,
			\ [ 'batch'                 , 'wheeltree#vector#batch'                                                ] ,
			\ [ 'tree-script'           , 'wheeltree#disc#tree_script'                                            ] ,
			\ [ 'symlink-tree'          , 'wheeltree#disc#symlink_tree'                                           ] ,
			\ [ 'copied-tree'           , 'wheeltree#disc#copied_tree'                                            ] ,
			\ [ 'clear-signs'           , 'wheeltree#chakra#clear'                                                ] ,
			\ [ 'prompt'                , 'wheeltree#void#nope'                                                   ] ,
			\ [ 'dedibuf'               , 'wheeltree#void#nope'                                                   ] ,
			\ ]
lockvar! s:command_meta_actions

if exists('s:command_meta_prompt_actions')
	unlockvar! s:command_meta_prompt_actions
endif
let s:command_meta_prompt_actions = [
			\ [ 'location'                , "wheeltree#vortex#switch('location')"           ] ,
			\ [ 'circle'                  , "wheeltree#vortex#switch('circle')"             ] ,
			\ [ 'torus'                   , "wheeltree#vortex#switch('torus')"              ] ,
			\ [ 'multi-switch'            , 'wheeltree#vortex#multi_switch'                 ] ,
			\ [ 'index-locations'         , 'wheeltree#vortex#helix'                        ] ,
			\ [ 'index-circles'           , 'wheeltree#vortex#grid'                         ] ,
			\ [ 'history'                 , 'wheeltree#waterclock#history'                  ] ,
			\ [ 'frecency'                , 'wheeltree#waterclock#frecency'                 ] ,
			\ [ 'read-wheeltree'              , 'wheeltree#disc#read_wheel'                     ] ,
			\ [ 'write-wheeltree'             , 'wheeltree#disc#write_wheel'                    ] ,
			\ [ 'read-session'            , 'wheeltree#disc#read_session'                   ] ,
			\ [ 'write-session'           , 'wheeltree#disc#write_session'                  ] ,
			\ [ 'buffer'                  , 'wheeltree#sailing#buffer'                      ] ,
			\ [ 'tabwin'                  , 'wheeltree#sailing#tabwin'                      ] ,
			\ [ 'marker'                  , 'wheeltree#sailing#marker'                      ] ,
			\ [ 'jump'                    , 'wheeltree#sailing#jump'                        ] ,
			\ [ 'change'                  , 'wheeltree#sailing#change'                      ] ,
			\ [ 'tag'                     , 'wheeltree#sailing#tag'                         ] ,
			\ [ 'add-here'                , 'wheeltree#tree#add_here'                       ] ,
			\ [ 'add-circle'              , 'wheeltree#tree#add_circle'                     ] ,
			\ [ 'add-torus'               , 'wheeltree#tree#add_torus'                      ] ,
			\ [ 'add-file'                , 'wheeltree#tree#add_file'                       ] ,
			\ [ 'add-buffer'              , 'wheeltree#tree#add_buffer'                     ] ,
			\ [ 'add-glob'                , 'wheeltree#tree#add_glob'                       ] ,
			\ [ 'rename-location'         , "wheeltree#tree#rename('location')"             ] ,
			\ [ 'rename-file'             , 'wheeltree#tree#rename_file'                    ] ,
			\ [ 'rename-circle'           , "wheeltree#tree#rename('circle')"               ] ,
			\ [ 'rename-torus'            , "wheeltree#tree#rename('torus')"                ] ,
			\ [ 'delete-location'         , "wheeltree#tree#delete('location')"             ] ,
			\ [ 'delete-circle'           , "wheeltree#tree#delete('circle')"               ] ,
			\ [ 'delete-torus'            , "wheeltree#tree#delete('torus')"                ] ,
			\ [ 'copy-location'           , "wheeltree#tree#copy('location')"               ] ,
			\ [ 'copy-circle'             , "wheeltree#tree#copy('circle')"                 ] ,
			\ [ 'copy-torus'              , "wheeltree#tree#copy('torus')"                  ] ,
			\ [ 'move-location'           , "wheeltree#tree#move('location')"               ] ,
			\ [ 'move-circle'             , "wheeltree#tree#move('circle')"                 ] ,
			\ [ 'move-torus'              , "wheeltree#tree#move('torus')"                  ] ,
			\ [ 'find'                    , 'wheeltree#sailing#find'                        ] ,
			\ [ 'mru'                     , 'wheeltree#sailing#mru'                         ] ,
			\ [ 'occur'                   , 'wheeltree#sailing#occur'                       ] ,
			\ [ 'switch-default-register' , 'wheeltree#codex#switch_default_register'       ] ,
			\ [ 'outline'                 , 'wheeltree#sailing#outline'                     ] ,
			\ [ 'yank-linewise-after'     , 'wheeltree#codex#yank_plain'                    ] ,
			\ [ 'yank-charwise-after'     , "wheeltree#codex#yank_plain('charwise-after')"  ] ,
			\ [ 'yank-linewise-before'    , "wheeltree#codex#yank_plain('linewise-before')" ] ,
			\ [ 'yank-charwise-before'    , "wheeltree#codex#yank_plain('charwise-before')" ] ,
			\ [ 'default-register'        , 'wheeltree#codex#switch_default_register'       ] ,
			\ ]
lockvar! s:command_meta_prompt_actions

if exists('s:command_meta_dedibuf_actions')
	unlockvar! s:command_meta_dedibuf_actions
endif
let s:command_meta_dedibuf_actions = [
			\ [ 'menu-main'                  , 'wheeltree#helm#main'                       ] ,
			\ [ 'menu-meta'                  , 'wheeltree#helm#meta'                       ] ,
			\ [ 'location'                   , "wheeltree#whirl#switch('location')"        ] ,
			\ [ 'circle'                     , "wheeltree#whirl#switch('circle')"          ] ,
			\ [ 'torus'                      , "wheeltree#whirl#switch('torus')"           ] ,
			\ [ 'index-locations'            , 'wheeltree#whirl#helix'                     ] ,
			\ [ 'index-circles'              , 'wheeltree#whirl#grid'                      ] ,
			\ [ 'index-tree'                 , 'wheeltree#whirl#tree'                      ] ,
			\ [ 'history'                    , 'wheeltree#whirl#history'                   ] ,
			\ [ 'frecency'                   , 'wheeltree#whirl#frecency'                  ] ,
			\ [ 'buffer'                     , 'wheeltree#frigate#buffer'                  ] ,
			\ [ 'buffer-all'                 , "wheeltree#frigate#buffer('all')"           ] ,
			\ [ 'tabwin'                     , 'wheeltree#frigate#tabwin'                  ] ,
			\ [ 'tabwin-tree'                , 'wheeltree#frigate#tabwin_tree'             ] ,
			\ [ 'marker'                     , 'wheeltree#frigate#marker'                  ] ,
			\ [ 'jump'                       , 'wheeltree#frigate#jump'                    ] ,
			\ [ 'change'                     , 'wheeltree#frigate#change'                  ] ,
			\ [ 'tag'                        , 'wheeltree#frigate#tag'                     ] ,
			\ [ 'reorder-locations'          , "wheeltree#yggdrasil#reorder('location')"   ] ,
			\ [ 'reorder-circles'            , "wheeltree#yggdrasil#reorder('circle')"     ] ,
			\ [ 'reorder-toruses'            , "wheeltree#yggdrasil#reorder('torus')"      ] ,
			\ [ 'rename-locations'           , "wheeltree#yggdrasil#rename('location')"    ] ,
			\ [ 'rename-circles'             , "wheeltree#yggdrasil#rename('circle')"      ] ,
			\ [ 'rename-toruses'             , "wheeltree#yggdrasil#rename('torus')"       ] ,
			\ [ 'rename-locations-filenames' , 'wheeltree#yggdrasil#rename_file'           ] ,
			\ [ 'delete-locations'           , "wheeltree#yggdrasil#delete('location')"    ] ,
			\ [ 'delete-circles'             , "wheeltree#yggdrasil#delete('circle')"      ] ,
			\ [ 'delete-toruses'             , "wheeltree#yggdrasil#delete('torus')"       ] ,
			\ [ 'copy-move-location'         , "wheeltree#yggdrasil#copy_move('location')" ] ,
			\ [ 'copy-move-circle'           , "wheeltree#yggdrasil#copy_move('circle')"   ] ,
			\ [ 'copy-move-torus'            , "wheeltree#yggdrasil#copy_move('torus')"    ] ,
			\ [ 'reorganize'                 , 'wheeltree#yggdrasil#reorganize'            ] ,
			\ [ 'reorganize-tabwin'          , 'wheeltree#yggdrasil#reorg_tabwin'          ] ,
			\ [ 'grep-edit'                  , 'wheeltree#shadow#grep_edit'                ] ,
			\ [ 'narrow-file'                , 'wheeltree#shadow#narrow_file'              ] ,
			\ [ 'narrow-circle'              , 'wheeltree#shadow#narrow_circle'            ] ,
			\ [ 'find'                       , 'wheeltree#frigate#find'                    ] ,
			\ [ 'async-find'                 , 'wheeltree#frigate#async_find'              ] ,
			\ [ 'mru'                        , 'wheeltree#frigate#mru'                     ] ,
			\ [ 'locate'                     , 'wheeltree#frigate#locate'                  ] ,
			\ [ 'occur'                      , 'wheeltree#frigate#occur'                   ] ,
			\ [ 'grep'                       , 'wheeltree#frigate#grep'                    ] ,
			\ [ 'outline'                    , 'wheeltree#frigate#outline'                 ] ,
			\ [ 'yank-plain'                 , "wheeltree#clipper#yank('plain')"           ] ,
			\ [ 'yank-list'                  , "wheeltree#clipper#yank('list')"            ] ,
			\ [ 'undo-list'                  , 'wheeltree#triangle#undolist'               ] ,
			\ [ 'command'                    , 'wheeltree#mandala#command'                 ] ,
			\ [ 'async'                      , 'wheeltree#mandala#async'                   ] ,
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

fun! wheeltree#diadem#fetch (varname, conversion = 'no-conversion')
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
		return wheeltree#matrix#items2dict ({varname})
	else
		return {varname}
	endif
endfun
