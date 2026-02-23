if status --is-login; and test -d /opt/homebrew/
  fish_add_path --path --prepend --move /opt/homebrew/bin
  fish_add_path --path --append /opt/homebrew/sbin
end

alias lsregister='/System/Library/Frameworks/CoreServices.framework/Versions/Current/Frameworks/LaunchServices.framework/Versions/Current/Support/lsregister'
