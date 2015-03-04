function dockerdown
  docker stop (docker ps -a -q)
  boot2docker down
end
