#!/usr/bin/env bash

DIR=$(pwd)
APP_DIR="app"

function Help() {
  cat << EOF
Usage: app.sh COMMAND

Commands:
  help|--help    Display this help
  composer       execute any composer command on the app
EOF
  exit 0;
}

function Composer() {
  local uid=$(id -u);
  local gid=$(id -g);
  local cmd=$1;
  local args="${@:2} --ignore-platform-reqs";
  if [ ${cmd} = "install" ]; then
    args="${args} --no-suggest --prefer-dist";
  fi
  echo "${cmd} ${args}";
  docker run --rm -v "${DIR}/${APP_DIR}":/app --user ${uid}:${gid} composer:1.8 $cmd $args
}

function route() {
  case $1 in
    -h|--help|help)
      Help
      ;;
    composer)
      Composer "${@:2}"
      ;;
  esac
}

function main() {
  route "$@"
}

main "$@"
