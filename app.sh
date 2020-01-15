#!/usr/bin/env bash

DIR=$(pwd)
APP_DIR="app"

function Help() {
  cat << EOF
Usage: app.sh COMMAND

Commands:
  help|--help    Display this help
  init           clone application, composer install
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
  echo "composer ${cmd} ${args}";
  docker run --rm -v "${DIR}/${APP_DIR}":/app --user ${uid}:${gid} composer:1.8 $cmd $args
}

function Init() {
  git clone --branch develop git@github.com:HomeCEU/certificate-manager.git ${APP_DIR}
  Composer install
  if [ ! -f .env ]; then
    cp sample.env .env
  fi
}

function route() {
  case $1 in
    -h|--help|help)
      Help
      ;;
    composer)
      Composer "${@:2}"
      ;;
    init)
      Init
      ;;
  esac
}

function main() {
  route "$@"
}

main "$@"
