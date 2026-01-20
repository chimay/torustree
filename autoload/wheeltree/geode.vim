" vim: set ft=vim fdm=indent iskeyword&:

" Geode
"
" Internal Constants for plugs & maps

" ---- subprefixes

if exists('s:batch')
	unlockvar! s:batch
endif
let s:batch = '@'
lockvar! s:batch

if exists('s:async')
	unlockvar! s:async
endif
let s:async = '&'
lockvar! s:async

if exists('s:layout')
	unlockvar! s:layout
endif
let s:layout = 'z'
lockvar! s:layout

if exists('s:debug')
	unlockvar! s:debug
endif
let s:debug = 'Z'
lockvar! s:debug

" ---- plugs

if exists('s:plugs_normal')
	unlockvar! s:plugs_normal
endif
let s:plugs_normal = [
			\ [ 'wheeltree-menu-main'                         , 'wheeltree#helm#main'                                     ] ,
			\ [ 'wheeltree-menu-meta'                         , 'wheeltree#helm#meta'                                     ] ,
			\ [ 'wheeltree-info'                              , 'wheeltree#status#dashboard'                              ] ,
			\ [ 'wheeltree-sync-up'                           , 'wheeltree#projection#follow'                             ] ,
			\ [ 'wheeltree-sync-down'                         , 'wheeltree#vortex#jump'                                   ] ,
			\ [ 'wheeltree-prompt-read-wheeltree'                 , 'wheeltree#disc#read_wheel'                               ] ,
			\ [ 'wheeltree-prompt-write-wheeltree'                , 'wheeltree#disc#write_wheel'                              ] ,
			\ [ 'wheeltree-prompt-read-session'               , 'wheeltree#disc#read_session'                             ] ,
			\ [ 'wheeltree-prompt-write-session'              , 'wheeltree#disc#write_session'                            ] ,
			\ [ 'wheeltree-previous-location'                 , "wheeltree#vortex#previous('location')"                   ] ,
			\ [ 'wheeltree-next-location'                     , "wheeltree#vortex#next('location')"                       ] ,
			\ [ 'wheeltree-previous-circle'                   , "wheeltree#vortex#previous('circle')"                     ] ,
			\ [ 'wheeltree-next-circle'                       , "wheeltree#vortex#next('circle')"                         ] ,
			\ [ 'wheeltree-previous-torus'                    , "wheeltree#vortex#previous('torus')"                      ] ,
			\ [ 'wheeltree-next-torus'                        , "wheeltree#vortex#next('torus')"                          ] ,
			\ [ 'wheeltree-prompt-location'                   , "wheeltree#vortex#switch('location')"                     ] ,
			\ [ 'wheeltree-prompt-circle'                     , "wheeltree#vortex#switch('circle')"                       ] ,
			\ [ 'wheeltree-prompt-torus'                      , "wheeltree#vortex#switch('torus')"                        ] ,
			\ [ 'wheeltree-prompt-multi-switch'               , 'wheeltree#vortex#multi_switch'                           ] ,
			\ [ 'wheeltree-dedibuf-location'                  , "wheeltree#whirl#switch('location')"                      ] ,
			\ [ 'wheeltree-dedibuf-circle'                    , "wheeltree#whirl#switch('circle')"                        ] ,
			\ [ 'wheeltree-dedibuf-torus'                     , "wheeltree#whirl#switch('torus')"                         ] ,
			\ [ 'wheeltree-prompt-index'                      , 'wheeltree#vortex#helix'                                  ] ,
			\ [ 'wheeltree-prompt-index-circles'              , 'wheeltree#vortex#grid'                                   ] ,
			\ [ 'wheeltree-dedibuf-index'                     , 'wheeltree#whirl#helix'                                   ] ,
			\ [ 'wheeltree-dedibuf-index-circles'             , 'wheeltree#whirl#grid'                                    ] ,
			\ [ 'wheeltree-dedibuf-index-tree'                , 'wheeltree#whirl#tree'                                    ] ,
			\ [ 'wheeltree-history-newer'                     , 'wheeltree#waterclock#newer'                              ] ,
			\ [ 'wheeltree-history-older'                     , 'wheeltree#waterclock#older'                              ] ,
			\ [ 'wheeltree-history-newer-in-circle'           , "wheeltree#waterclock#newer('circle')"                    ] ,
			\ [ 'wheeltree-history-older-in-circle'           , "wheeltree#waterclock#older('circle')"                    ] ,
			\ [ 'wheeltree-history-newer-in-torus'            , "wheeltree#waterclock#newer('torus')"                     ] ,
			\ [ 'wheeltree-history-older-in-torus'            , "wheeltree#waterclock#older('torus')"                     ] ,
			\ [ 'wheeltree-prompt-history'                    , 'wheeltree#waterclock#history'                            ] ,
			\ [ 'wheeltree-dedibuf-history'                   , 'wheeltree#whirl#history'                                 ] ,
			\ [ 'wheeltree-alternate-anywhere'                , "wheeltree#caduceus#alternate('anywhere')"                ] ,
			\ [ 'wheeltree-alternate-same-torus'              , "wheeltree#caduceus#alternate('same_torus')"              ] ,
			\ [ 'wheeltree-alternate-same-circle'             , "wheeltree#caduceus#alternate('same_circle')"             ] ,
			\ [ 'wheeltree-alternate-other-torus'             , "wheeltree#caduceus#alternate('other_torus')"             ] ,
			\ [ 'wheeltree-alternate-other-circle'            , "wheeltree#caduceus#alternate('other_circle')"            ] ,
			\ [ 'wheeltree-alternate-same-torus-other-circle' , "wheeltree#caduceus#alternate('same_torus_other_circle')" ] ,
			\ [ 'wheeltree-alternate-window'                  , 'wheeltree#caduceus#alternate_window'                     ] ,
			\ [ 'wheeltree-alternate-menu'                    , 'wheeltree#caduceus#alternate_menu'                       ] ,
			\ [ 'wheeltree-prompt-frecency'                   , 'wheeltree#waterclock#frecency'                           ] ,
			\ [ 'wheeltree-dedibuf-frecency'                  , 'wheeltree#whirl#frecency'                                ] ,
			\ [ 'wheeltree-prompt-buffer'                     , 'wheeltree#sailing#buffer'                                ] ,
			\ [ 'wheeltree-dedibuf-buffer'                    , 'wheeltree#frigate#buffer'                                ] ,
			\ [ 'wheeltree-dedibuf-buffer-all'                , "wheeltree#frigate#buffer('all')"                         ] ,
			\ [ 'wheeltree-prompt-tabwin'                     , 'wheeltree#sailing#tabwin'                                ] ,
			\ [ 'wheeltree-dedibuf-tabwin'                    , 'wheeltree#frigate#tabwin'                                ] ,
			\ [ 'wheeltree-dedibuf-tabwin-tree'               , 'wheeltree#frigate#tabwin_tree'                           ] ,
			\ [ 'wheeltree-prompt-marker'                     , 'wheeltree#sailing#marker'                                ] ,
			\ [ 'wheeltree-prompt-jump'                       , 'wheeltree#sailing#jump'                                  ] ,
			\ [ 'wheeltree-prompt-change'                     , 'wheeltree#sailing#change'                                ] ,
			\ [ 'wheeltree-prompt-tag'                        , 'wheeltree#sailing#tag'                                   ] ,
			\ [ 'wheeltree-dedibuf-marker'                    , 'wheeltree#frigate#marker'                                ] ,
			\ [ 'wheeltree-dedibuf-jump'                      , 'wheeltree#frigate#jump'                                  ] ,
			\ [ 'wheeltree-dedibuf-change'                    , 'wheeltree#frigate#change'                                ] ,
			\ [ 'wheeltree-dedibuf-tag'                       , 'wheeltree#frigate#tag'                                   ] ,
			\ [ 'wheeltree-prompt-add-here'                   , 'wheeltree#tree#add_here'                                 ] ,
			\ [ 'wheeltree-prompt-add-circle'                 , 'wheeltree#tree#add_circle'                               ] ,
			\ [ 'wheeltree-prompt-add-torus'                  , 'wheeltree#tree#add_torus'                                ] ,
			\ [ 'wheeltree-prompt-add-file'                   , 'wheeltree#tree#add_file'                                 ] ,
			\ [ 'wheeltree-prompt-add-buffer'                 , 'wheeltree#tree#add_buffer'                               ] ,
			\ [ 'wheeltree-prompt-add-glob'                   , 'wheeltree#tree#add_glob'                                 ] ,
			\ [ 'wheeltree-dedibuf-reorder-location'          , "wheeltree#yggdrasil#reorder('location')"                 ] ,
			\ [ 'wheeltree-dedibuf-reorder-circle'            , "wheeltree#yggdrasil#reorder('circle')"                   ] ,
			\ [ 'wheeltree-dedibuf-reorder-torus'             , "wheeltree#yggdrasil#reorder('torus')"                    ] ,
			\ [ 'wheeltree-prompt-rename-location'            , "wheeltree#tree#rename('location')"                       ] ,
			\ [ 'wheeltree-prompt-rename-circle'              , "wheeltree#tree#rename('circle')"                         ] ,
			\ [ 'wheeltree-prompt-rename-torus'               , "wheeltree#tree#rename('torus')"                          ] ,
			\ [ 'wheeltree-prompt-rename-file'                , 'wheeltree#tree#rename_file'                              ] ,
			\ [ 'wheeltree-dedibuf-rename-location'           , "wheeltree#yggdrasil#rename('location')"                  ] ,
			\ [ 'wheeltree-dedibuf-rename-circle'             , "wheeltree#yggdrasil#rename('circle')"                    ] ,
			\ [ 'wheeltree-dedibuf-rename-torus'              , "wheeltree#yggdrasil#rename('torus')"                     ] ,
			\ [ 'wheeltree-dedibuf-rename-location-filename'  , 'wheeltree#yggdrasil#rename_file'                         ] ,
			\ [ 'wheeltree-prompt-delete-location'            , "wheeltree#tree#delete('location')"                       ] ,
			\ [ 'wheeltree-prompt-delete-circle'              , "wheeltree#tree#delete('circle')"                         ] ,
			\ [ 'wheeltree-prompt-delete-torus'               , "wheeltree#tree#delete('torus')"                          ] ,
			\ [ 'wheeltree-dedibuf-delete-location'           , "wheeltree#yggdrasil#delete('location')"                  ] ,
			\ [ 'wheeltree-dedibuf-delete-circle'             , "wheeltree#yggdrasil#delete('circle')"                    ] ,
			\ [ 'wheeltree-dedibuf-delete-torus'              , "wheeltree#yggdrasil#delete('torus')"                     ] ,
			\ [ 'wheeltree-prompt-copy-location'              , "wheeltree#tree#copy('location')"                         ] ,
			\ [ 'wheeltree-prompt-copy-circle'                , "wheeltree#tree#copy('circle')"                           ] ,
			\ [ 'wheeltree-prompt-copy-torus'                 , "wheeltree#tree#copy('torus')"                            ] ,
			\ [ 'wheeltree-prompt-move-location'              , "wheeltree#tree#move('location')"                         ] ,
			\ [ 'wheeltree-prompt-move-circle'                , "wheeltree#tree#move('circle')"                           ] ,
			\ [ 'wheeltree-dedibuf-copy-move-location'        , "wheeltree#yggdrasil#copy_move('location')"               ] ,
			\ [ 'wheeltree-dedibuf-copy-move-circle'          , "wheeltree#yggdrasil#copy_move('circle')"                 ] ,
			\ [ 'wheeltree-dedibuf-copy-move-torus'           , "wheeltree#yggdrasil#copy_move('torus')"                  ] ,
			\ [ 'wheeltree-dedibuf-reorganize'                , 'wheeltree#yggdrasil#reorganize'                          ] ,
			\ [ 'wheeltree-dedibuf-reorg-tabwin'              , 'wheeltree#mirror#reorg_tabwin'                           ] ,
			\ [ 'wheeltree-dedibuf-grep-edit'                 , 'wheeltree#shadow#grep_edit'                              ] ,
			\ [ 'wheeltree-dedibuf-narrow'                    , 'wheeltree#shadow#narrow_file'                            ] ,
			\ [ 'wheeltree-dedibuf-narrow-circle'             , 'wheeltree#shadow#narrow_circle'                          ] ,
			\ [ 'wheeltree-prompt-find'                       , 'wheeltree#sailing#find'                                  ] ,
			\ [ 'wheeltree-dedibuf-find'                      , 'wheeltree#frigate#find'                                  ] ,
			\ [ 'wheeltree-dedibuf-async-find'                , 'wheeltree#frigate#async_find'                            ] ,
			\ [ 'wheeltree-prompt-mru'                        , 'wheeltree#sailing#mru'                                   ] ,
			\ [ 'wheeltree-dedibuf-mru'                       , 'wheeltree#frigate#mru'                                   ] ,
			\ [ 'wheeltree-dedibuf-locate'                    , 'wheeltree#frigate#locate'                                ] ,
			\ [ 'wheeltree-prompt-occur'                      , 'wheeltree#sailing#occur'                                 ] ,
			\ [ 'wheeltree-dedibuf-occur'                     , 'wheeltree#frigate#occur'                                 ] ,
			\ [ 'wheeltree-dedibuf-grep'                      , 'wheeltree#frigate#grep'                                  ] ,
			\ [ 'wheeltree-prompt-outline'                    , 'wheeltree#sailing#outline'                               ] ,
			\ [ 'wheeltree-dedibuf-outline'                   , 'wheeltree#frigate#outline'                               ] ,
			\ [ 'wheeltree-prompt-switch-default-register'    , 'wheeltree#codex#switch_default_register'                 ] ,
			\ [ 'wheeltree-prompt-yank-plain-linewise-after'  , 'wheeltree#codex#yank_plain'                              ] ,
			\ [ 'wheeltree-prompt-yank-plain-charwise-after'  , "wheeltree#codex#yank_plain('charwise-after')"            ] ,
			\ [ 'wheeltree-prompt-yank-plain-linewise-before' , "wheeltree#codex#yank_plain('linewise-before')"           ] ,
			\ [ 'wheeltree-prompt-yank-plain-charwise-before' , "wheeltree#codex#yank_plain('charwise-before')"           ] ,
			\ [ 'wheeltree-prompt-yank-list-linewise-after'   , 'wheeltree#codex#yank_list'                               ] ,
			\ [ 'wheeltree-prompt-yank-list-charwise-after'   , "wheeltree#codex#yank_list('charwise-after')"             ] ,
			\ [ 'wheeltree-prompt-yank-list-linewise-before'  , "wheeltree#codex#yank_list('linewise-before')"            ] ,
			\ [ 'wheeltree-prompt-yank-list-charwise-before'  , "wheeltree#codex#yank_list('charwise-before')"            ] ,
			\ [ 'wheeltree-dedibuf-yank-plain'                , "wheeltree#clipper#yank('plain')"                         ] ,
			\ [ 'wheeltree-dedibuf-yank-list'                 , "wheeltree#clipper#yank('list')"                          ] ,
			\ [ 'wheeltree-dedibuf-undo-list'                 , 'wheeltree#triangle#undolist'                             ] ,
			\ [ 'wheeltree-dedibuf-command'                   , 'wheeltree#mandala#command'                               ] ,
			\ [ 'wheeltree-dedibuf-async'                     , 'wheeltree#mandala#async'                                 ] ,
			\ [ 'wheeltree-mandala-add'                       , "wheeltree#cylinder#add('furtive')"                       ] ,
			\ [ 'wheeltree-mandala-delete'                    , 'wheeltree#cylinder#delete'                               ] ,
			\ [ 'wheeltree-mandala-forward'                   , 'wheeltree#cylinder#forward'                              ] ,
			\ [ 'wheeltree-mandala-backward'                  , 'wheeltree#cylinder#backward'                             ] ,
			\ [ 'wheeltree-mandala-switch'                    , 'wheeltree#cylinder#switch'                               ] ,
			\ [ 'wheeltree-layout-zoom'                       , 'wheeltree#mosaic#zoom'                                   ] ,
			\ [ 'wheeltree-layout-tabs-locations'             , "wheeltree#mosaic#tabs('location')"                       ] ,
			\ [ 'wheeltree-layout-tabs-circles'               , "wheeltree#mosaic#tabs('circle')"                         ] ,
			\ [ 'wheeltree-layout-tabs-toruses'               , "wheeltree#mosaic#tabs('torus')"                          ] ,
			\ [ 'wheeltree-layout-split-locations'            , "wheeltree#mosaic#split('location')"                      ] ,
			\ [ 'wheeltree-layout-split-circles'              , "wheeltree#mosaic#split('circle')"                        ] ,
			\ [ 'wheeltree-layout-split-toruses'              , "wheeltree#mosaic#split('torus')"                         ] ,
			\ [ 'wheeltree-layout-vsplit-locations'           , "wheeltree#mosaic#split('location', 'vertical')"          ] ,
			\ [ 'wheeltree-layout-vsplit-circles'             , "wheeltree#mosaic#split('circle', 'vertical')"            ] ,
			\ [ 'wheeltree-layout-vsplit-toruses'             , "wheeltree#mosaic#split('torus', 'vertical')"             ] ,
			\ [ 'wheeltree-layout-main-top-locations'         , "wheeltree#mosaic#split('location', 'main_top')"          ] ,
			\ [ 'wheeltree-layout-main-top-circles'           , "wheeltree#mosaic#split('circle', 'main_top')"            ] ,
			\ [ 'wheeltree-layout-main-top-toruses'           , "wheeltree#mosaic#split('torus', 'main_top')"             ] ,
			\ [ 'wheeltree-layout-main-left-locations'        , "wheeltree#mosaic#split('location', 'main_left')"         ] ,
			\ [ 'wheeltree-layout-main-left-circles'          , "wheeltree#mosaic#split('circle', 'main_left')"           ] ,
			\ [ 'wheeltree-layout-main-left-toruses'          , "wheeltree#mosaic#split('torus', 'main_left')"            ] ,
			\ [ 'wheeltree-layout-grid-locations'             , "wheeltree#mosaic#split_grid('location')"                 ] ,
			\ [ 'wheeltree-layout-grid-circles'               , "wheeltree#mosaic#split_grid('circle')"                   ] ,
			\ [ 'wheeltree-layout-grid-toruses'               , "wheeltree#mosaic#split_grid('torus')"                    ] ,
			\ [ 'wheeltree-layout-tab-win-torus'              , "wheeltree#pyramid#steps('torus')"                        ] ,
			\ [ 'wheeltree-layout-tab-win-circle'             , "wheeltree#pyramid#steps('circle')"                       ] ,
			\ [ 'wheeltree-layout-rotate-counter-clockwise'   , 'wheeltree#mosaic#rotate_counter_clockwise'               ] ,
			\ [ 'wheeltree-layout-rotate-clockwise'           , 'wheeltree#mosaic#rotate_clockwise'                       ] ,
			\ [ 'wheeltree-spiral-cursor'                     , 'wheeltree#spiral#cursor'                                 ] ,
			\ [ 'wheeltree-debug-fresh-wheeltree'                 , 'wheeltree#void#fresh_wheel'                              ] ,
			\ [ 'wheeltree-debug-clear-echo-area'             , 'wheeltree#status#clear'                                  ] ,
			\ [ 'wheeltree-debug-clear-messages'              , 'wheeltree#status#clear_messages'                         ] ,
			\ [ 'wheeltree-debug-clear-signs'                 , 'wheeltree#chakra#clear'                                  ] ,
			\ [ 'wheeltree-debug-prompt-history-circuit'      , 'wheeltree#waterclock#history_circuit'                    ] ,
			\ [ 'wheeltree-debug-dedibuf-history-circuit'     , 'wheeltree#whirl#history_circuit'                         ] ,
			\ ]
lockvar! s:plugs_normal

if exists('s:plugs_visual')
	unlockvar! s:plugs_visual
endif
let s:plugs_visual = [
			\ [ 'wheeltree-dedibuf-narrow', 'wheeltree#shadow#narrow_file' ],
			\ ]
lockvar! s:plugs_visual

if exists('s:plugs_expr')
	unlockvar! s:plugs_expr
endif
let s:plugs_expr = [
			\ [ 'wheeltree-dedibuf-narrow-operator', 'wheeltree#shadow#narrow_file_operator' ],
			\ ]
lockvar! s:plugs_expr

" ---- maps

if exists('s:maps_level_0_normal')
	unlockvar! s:maps_level_0_normal
endif
let s:maps_level_0_normal = [
			\ [ '<m-m>'        , 'wheeltree-menu-main'                          ] ,
			\ [ '='            , 'wheeltree-menu-meta'                          ] ,
			\ [ 'i'            , 'wheeltree-info'                               ] ,
			\ [ '<m-$>'        , 'wheeltree-sync-up'                            ] ,
			\ [ '$'            , 'wheeltree-sync-down'                          ] ,
			\ [ 'r'            , 'wheeltree-prompt-read-wheeltree'                  ] ,
			\ [ 'w'            , 'wheeltree-prompt-write-wheeltree'                 ] ,
			\ [ 'R'            , 'wheeltree-prompt-read-session'                ] ,
			\ [ 'W'            , 'wheeltree-prompt-write-session'               ] ,
			\ [ '<pageup>'     , 'wheeltree-previous-location'                  ] ,
			\ [ '<pagedown>'   , 'wheeltree-next-location'                      ] ,
			\ [ '<c-pageup>'   , 'wheeltree-previous-circle'                    ] ,
			\ [ '<c-pagedown>' , 'wheeltree-next-circle'                        ] ,
			\ [ '<s-pageup>'   , 'wheeltree-previous-torus'                     ] ,
			\ [ '<s-pagedown>' , 'wheeltree-next-torus'                         ] ,
			\ [ '<home>'       , 'wheeltree-history-newer'                      ] ,
			\ [ '<end>'        , 'wheeltree-history-older'                      ] ,
			\ [ '<c-home>'     , 'wheeltree-history-newer-in-circle'            ] ,
			\ [ '<c-end>'      , 'wheeltree-history-older-in-circle'            ] ,
			\ [ '<s-home>'     , 'wheeltree-history-newer-in-torus'             ] ,
			\ [ '<s-end>'      , 'wheeltree-history-older-in-torus'             ] ,
			\ [ '<c-^>'        , 'wheeltree-alternate-anywhere'                 ] ,
			\ [ '<m-^>'        , 'wheeltree-alternate-same-circle'              ] ,
			\ [ '<m-c-^>'      , 'wheeltree-alternate-same-torus-other-circle'  ] ,
			\ [ '^'            , 'wheeltree-alternate-menu'                     ] ,
			\ [ 'a'            , 'wheeltree-prompt-add-here'                    ] ,
			\ [ '<c-a>'        , 'wheeltree-prompt-add-circle'                  ] ,
			\ [ 'A'            , 'wheeltree-prompt-add-torus'                   ] ,
			\ [ '+f'           , 'wheeltree-prompt-add-file'                    ] ,
			\ [ '+b'           , 'wheeltree-prompt-add-buffer'                  ] ,
			\ [ '*'            , 'wheeltree-prompt-add-glob'                    ] ,
			\ ]
lockvar! s:maps_level_0_normal

if exists('s:maps_level_1_normal')
	unlockvar! s:maps_level_1_normal
endif
let s:maps_level_1_normal = [
			\ [ '<cr>'             , 'wheeltree-prompt-location'                  ],
			\ [ '<c-cr>'           , 'wheeltree-prompt-circle'                    ],
			\ [ '<s-cr>'           , 'wheeltree-prompt-torus'                     ],
			\ [ '<m-cr>'           , 'wheeltree-prompt-multi-switch'              ],
			\ [ '<space>'          , 'wheeltree-dedibuf-location'                 ],
			\ [ '<c-space>'        , 'wheeltree-dedibuf-circle'                   ],
			\ [ '<s-space>'        , 'wheeltree-dedibuf-torus'                    ],
			\ [ 'x'                , 'wheeltree-prompt-index'                     ],
			\ [ '<c-x>'            , 'wheeltree-prompt-index-circles'             ],
			\ [ 'X'                , 'wheeltree-dedibuf-index'                    ],
			\ [ '<m-x>'            , 'wheeltree-dedibuf-index-tree'               ],
			\ [ '<m-s-x>'          , 'wheeltree-dedibuf-index-circles'            ],
			\ [ 'h'                , 'wheeltree-prompt-history'                   ],
			\ [ '<m-h>'            , 'wheeltree-dedibuf-history'                  ],
			\ [ 'e'                , 'wheeltree-prompt-frecency'                  ],
			\ [ '<m-e>'            , 'wheeltree-dedibuf-frecency'                 ],
			\ [ s:batch .. 'o'     , 'wheeltree-dedibuf-reorder-location'         ],
			\ [ s:batch .. '<c-o>' , 'wheeltree-dedibuf-reorder-circle'           ],
			\ [ s:batch .. 'O'     , 'wheeltree-dedibuf-reorder-torus'            ],
			\ [ 'n'                , 'wheeltree-prompt-rename-location'           ],
			\ [ '<c-n>'            , 'wheeltree-prompt-rename-circle'             ],
			\ [ 'N'                , 'wheeltree-prompt-rename-torus'              ],
			\ [ '<m-n>'            , 'wheeltree-prompt-rename-file'               ],
			\ [ s:batch .. 'n'     , 'wheeltree-dedibuf-rename-location'          ],
			\ [ s:batch .. '<c-n>' , 'wheeltree-dedibuf-rename-circle'            ],
			\ [ s:batch .. 'N'     , 'wheeltree-dedibuf-rename-torus'             ],
			\ [ s:batch .. '<m-n>' , 'wheeltree-dedibuf-rename-location-filename' ],
			\ [ 'd'                , 'wheeltree-prompt-delete-location'           ],
			\ [ '<c-d>'            , 'wheeltree-prompt-delete-circle'             ],
			\ [ 'D'                , 'wheeltree-prompt-delete-torus'              ],
			\ [ s:batch .. 'd'     , 'wheeltree-dedibuf-delete-location'          ],
			\ [ s:batch .. '<c-d>' , 'wheeltree-dedibuf-delete-circle'            ],
			\ [ s:batch .. 'D'     , 'wheeltree-dedibuf-delete-torus'             ],
			\ [ 'c'                , 'wheeltree-prompt-copy-location'             ],
			\ [ '<m-c>'            , 'wheeltree-prompt-copy-circle'               ],
			\ [ 'C'                , 'wheeltree-prompt-copy-torus'                ],
			\ [ 'm'                , 'wheeltree-prompt-move-location'             ],
			\ [ 'M'                , 'wheeltree-prompt-move-circle'               ],
			\ [ s:batch .. 'c'     , 'wheeltree-dedibuf-copy-move-location'       ],
			\ [ s:batch .. '<m-c>' , 'wheeltree-dedibuf-copy-move-circle'         ],
			\ [ s:batch .. 'C'     , 'wheeltree-dedibuf-copy-move-torus'          ],
			\ ]
lockvar! s:maps_level_1_normal

if exists('s:maps_level_2_normal')
	unlockvar! s:maps_level_2_normal
endif
let s:maps_level_2_normal = [
			\ [ 'b'                  , 'wheeltree-prompt-buffer'                     ] ,
			\ [ '<m-b>'              , 'wheeltree-dedibuf-buffer'                    ] ,
			\ [ '<c-b>'              , 'wheeltree-dedibuf-buffer-all'                ] ,
			\ [ 'v'                  , 'wheeltree-prompt-tabwin'                     ] ,
			\ [ '<m-v>'              , 'wheeltree-dedibuf-tabwin-tree'               ] ,
			\ [ '<c-v>'              , 'wheeltree-dedibuf-tabwin'                    ] ,
			\ [ "'"                  , 'wheeltree-prompt-marker'                     ] ,
			\ [ 'j'                  , 'wheeltree-prompt-jump'                       ] ,
			\ [ ','                  , 'wheeltree-prompt-change'                     ] ,
			\ [ 't'                  , 'wheeltree-prompt-tag'                        ] ,
			\ [ "<m-'>"              , 'wheeltree-dedibuf-marker'                    ] ,
			\ [ '<m-j>'              , 'wheeltree-dedibuf-jump'                      ] ,
			\ [ ';'                  , 'wheeltree-dedibuf-change'                    ] ,
			\ [ '<m-t>'              , 'wheeltree-dedibuf-tag'                       ] ,
			\ [ '<m-r>'              , 'wheeltree-dedibuf-reorganize'                ] ,
			\ [ '<c-r>'              , 'wheeltree-dedibuf-reorg-tabwin'              ] ,
			\ [ '<m-g>'              , 'wheeltree-dedibuf-grep-edit'                 ] ,
			\ [ '-%'                 , 'wheeltree-dedibuf-narrow'                    ] ,
			\ [ '--'                 , 'wheeltree-dedibuf-narrow-operator'           ] ,
			\ [ '-c'                 , 'wheeltree-dedibuf-narrow-circle'             ] ,
			\ [ 'f'                  , 'wheeltree-prompt-find'                       ] ,
			\ [ '<m-f>'              , 'wheeltree-dedibuf-find'                      ] ,
			\ [ s:async .. 'f'       , 'wheeltree-dedibuf-async-find'                ] ,
			\ [ 'u'                  , 'wheeltree-prompt-mru'                        ] ,
			\ [ '<m-u>'              , 'wheeltree-dedibuf-mru'                       ] ,
			\ [ 'l'                  , 'wheeltree-dedibuf-locate'                    ] ,
			\ [ 'o'                  , 'wheeltree-prompt-occur'                      ] ,
			\ [ '<m-o>'              , 'wheeltree-dedibuf-occur'                     ] ,
			\ [ 'g'                  , 'wheeltree-dedibuf-grep'                      ] ,
			\ [ '<c-o>'              , 'wheeltree-prompt-outline'                    ] ,
			\ [ '<s-o>'              , 'wheeltree-dedibuf-outline'                   ] ,
			\ [ '<c-y>'              , 'wheeltree-prompt-switch-default-register'    ] ,
			\ [ 'y'                  , 'wheeltree-prompt-yank-plain-linewise-after'  ] ,
			\ [ 'p'                  , 'wheeltree-prompt-yank-plain-charwise-after'  ] ,
			\ [ 'Y'                  , 'wheeltree-prompt-yank-plain-linewise-before' ] ,
			\ [ 'P'                  , 'wheeltree-prompt-yank-plain-charwise-before' ] ,
			\ [ '<m-y>'              , 'wheeltree-dedibuf-yank-plain'                ] ,
			\ [ '<m-p>'              , 'wheeltree-dedibuf-yank-list'                 ] ,
			\ [ '<c-u>'              , 'wheeltree-dedibuf-undo-list'                 ] ,
			\ [ ':'                  , 'wheeltree-dedibuf-command'                   ] ,
			\ [ s:async .. '&'       , 'wheeltree-dedibuf-async'                     ] ,
			\ [ '<tab>'              , 'wheeltree-mandala-add'                       ] ,
			\ [ '<backspace>'        , 'wheeltree-mandala-delete'                    ] ,
			\ [ '<left>'             , 'wheeltree-mandala-backward'                  ] ,
			\ [ '<right>'            , 'wheeltree-mandala-forward'                   ] ,
			\ [ '<up>'               , 'wheeltree-mandala-switch'                    ] ,
			\ [ s:layout .. 'z'      , 'wheeltree-layout-zoom'                       ] ,
			\ [ s:layout .. 't'      , 'wheeltree-layout-tabs-locations'             ] ,
			\ [ s:layout .. '<c-t>'  , 'wheeltree-layout-tabs-circles'               ] ,
			\ [ s:layout .. 'T'      , 'wheeltree-layout-tabs-toruses'               ] ,
			\ [ s:layout .. 's'      , 'wheeltree-layout-split-locations'            ] ,
			\ [ s:layout .. '<c-s>'  , 'wheeltree-layout-split-circles'              ] ,
			\ [ s:layout .. 'S'      , 'wheeltree-layout-split-toruses'              ] ,
			\ [ s:layout .. 'v'      , 'wheeltree-layout-vsplit-locations'           ] ,
			\ [ s:layout .. '<c-v>'  , 'wheeltree-layout-vsplit-circles'             ] ,
			\ [ s:layout .. 'V'      , 'wheeltree-layout-vsplit-toruses'             ] ,
			\ [ s:layout .. 'm'      , 'wheeltree-layout-main-top-locations'         ] ,
			\ [ s:layout .. '<c-m>'  , 'wheeltree-layout-main-top-circles'           ] ,
			\ [ s:layout .. 'M'      , 'wheeltree-layout-main-top-toruses'           ] ,
			\ [ s:layout .. 'l'      , 'wheeltree-layout-main-left-locations'        ] ,
			\ [ s:layout .. '<c-l>'  , 'wheeltree-layout-main-left-circles'          ] ,
			\ [ s:layout .. 'L'      , 'wheeltree-layout-main-left-toruses'          ] ,
			\ [ s:layout .. 'g'      , 'wheeltree-layout-grid-locations'             ] ,
			\ [ s:layout .. '<c-g>'  , 'wheeltree-layout-grid-circles'               ] ,
			\ [ s:layout .. 'G'      , 'wheeltree-layout-grid-toruses'               ] ,
			\ [ s:layout .. '&'      , 'wheeltree-layout-tab-win-circle'             ] ,
			\ [ s:layout .. '<M-&>'  , 'wheeltree-layout-tab-win-torus'              ] ,
			\ [ s:layout .. '<up>'   , 'wheeltree-layout-rotate-counter-clockwise'   ] ,
			\ [ s:layout .. '<down>' , 'wheeltree-layout-rotate-clockwise'           ] ,
			\ ]
lockvar! s:maps_level_2_normal

if exists('s:maps_level_2_visual')
	unlockvar! s:maps_level_2_visual
endif
let s:maps_level_2_visual = [
			\ [ '--', 'wheeltree-dedibuf-narrow' ]
			\ ]
lockvar! s:maps_level_2_visual

if exists('s:maps_level_20_normal')
	unlockvar! s:maps_level_20_normal
endif
let s:maps_level_20_normal = [
			\ [ s:debug .. 'Z'     , 'wheeltree-debug-fresh-wheeltree'             ] ,
			\ [ s:debug .. 'e'     , 'wheeltree-debug-clear-echo-area'         ] ,
			\ [ s:debug .. 'm'     , 'wheeltree-debug-clear-messages'          ] ,
			\ [ s:debug .. 's'     , 'wheeltree-debug-clear-signs'             ] ,
			\ [ s:debug .. 'h'     , 'wheeltree-debug-prompt-history-circuit'  ] ,
			\ [ s:debug .. '<m-h>' , 'wheeltree-debug-dedibuf-history-circuit' ] ,
			\ ]
lockvar! s:maps_level_20_normal

" ---- public interface

fun! wheeltree#geode#fetch (varname, conversion = 'no-conversion')
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
