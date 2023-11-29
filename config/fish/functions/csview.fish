function csview --wraps "xsv table"
  xsv table $argv | less -S --header 1
end
