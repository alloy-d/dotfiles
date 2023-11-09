if command -q luarocks
  set -x LUA_PATH (luarocks path --lr-path)
  set -x LUA_CPATH (luarocks path --lr-cpath)

  fish_add_path --path --prepend (luarocks path --lr-bin | string split ':')
end
