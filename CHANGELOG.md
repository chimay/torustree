
# Version 3.8

Changes of keys :

- g:wheeltree_config.project_markers -> g:wheeltree_config.project.markers
- g:wheeltree_config.auto_chdir_project -> g:wheeltree_config.project.auto_chdir
- new key : g:wheeltree_config.storage.torustree.folder
- g:wheeltree_config.file -> g:wheeltree_config.storage.torustree.name
- g:wheeltree_config.autoread -> g:wheeltree_config.storage.torustree.autoread
- g:wheeltree_config.autowrite -> g:wheeltree_config.storage.torustree.autowrite
- g:wheeltree_config.session_dir -> g:wheeltree_config.storage.session.folder
- g:wheeltree_config.session_file -> g:wheeltree_config.storage.session.name
- g:wheeltree_config.autoread_session -> g:wheeltree_config.storage.session.autoread
- g:wheeltree_config.autowrite_session -> g:wheeltree_config.storage.session.autowrite
- g:wheeltree_config.backups -> g:wheeltree_config.storage.backups

# Version 3.7

Manage as many sessions files as you want.

Load & store all sessions from a session directory.

Default session file has changed :

- vim : '~/.vim/torustree/session/default.vim'
- nvim : '~/.local/share/nvim/torustree/session/default.vim'

# 2023 may 26

Little change in config :

g:wheeltree_config.display.message -> g:wheeltree_config.display.dedibuf_msg
