if which luarocks > /dev/null
  set -x LUA_PATH (luarocks path --lr-path)
  set -x LUA_CPATH (luarocks path --lr-cpath)

  prepend_to_path (luarocks path --lr-bin | string split ':')
end
