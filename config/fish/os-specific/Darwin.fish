if test -d /opt/homebrew/
  fish_add_path --path --prepend /opt/homebrew/bin
  fish_add_path --path --append /opt/homebrew/sbin
end

alias swift="env PATH=/System/Library/Frameworks/Python.framework/Versions/Current/bin:$PATH swift"
