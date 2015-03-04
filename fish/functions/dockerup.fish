function dockerup
    boot2docker init

    for line in (boot2docker up)
      switch $line
        case '*set -x*'
            eval $line
      end
    end

    set -xU DOCKER_HOST $DOCKER_HOST
    set -xU DOCKER_CERT_PATH $DOCKER_CERT_PATH
    set -xU DOCKER_TLS_VERIFY $DOCKER_TLS_VERIFY
end
