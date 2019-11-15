#! /bin/bash

set -e

get_arch() {
  local arch=`uname -m`
  case "${arch}" in
    x86_64) echo -n amd64; ;;
    *)      echo -n ${arch}; ;;
  esac
}

apt-get install -y apt-transport-https \
                   ca-certificates \
                   curl \
                   software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
       "deb [arch=`get_arch`] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"

apt-get -qy update

apt-get install -y docker-ce

