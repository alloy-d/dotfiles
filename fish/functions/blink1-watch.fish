function blink1-watch --description "use a blink(1) to show the status of a long-running process - args are a command that exits 0 while process is running"
  blink1-tool -q --clearpattern
  blink1-tool -q -m 1800 --rgb '#000000' --setpattline 0
  blink1-tool -q -m 1800 --rgb '#0000ff' --setpattline 1

  blink1-tool -q --play 1

  while eval $argv > /dev/null
    sleep 2
  end

  blink1-tool -q -m 100 -t 200 --rgb '#00ff00' --blink 20
  blink1-tool -q --rgb '#00ff00'
end
