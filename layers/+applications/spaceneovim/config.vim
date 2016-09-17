function! s:update_spaceneovim_layers()
  let s:config_dir = $HOME . '/.config/nvim'
  let s:spacevim_layers_dir = expand(resolve(s:config_dir . '/spaceneovim-layers'))

  echo "Updating SpaceNeovim layers"
  let update_layers = jobstart([
  \  'cd'
  \, s:spacevim_layers_dir
  \, '&&'
  \, 'git'
  \, 'pull'
  \, 'origin'
  \, 'master'
  \])
  let waiting_for_update = jobwait([update_layers])
  echo "SpaceNeovim layers have been updated"
endfunction

if spacevim#is_layer_enabled('+applications/spaceneovim')
  command! UpdateSpaceNeovimLayers call s:update_spaceneovim_layers()
  let g:lmap.a = { 'name': '+applications' }
  call spacevim#bind('map', 'aU', 'update-spaceneovim-layers', 'UpdateSpaceNeovimLayers', 1)
endif
