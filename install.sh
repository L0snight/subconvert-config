#!/bin/bash

cd `dirname $0`

function assert() {
  "$@"
  if [ $? != 0 ];then
    echo "Command $@ failure"
    exit 1
  fi
}

function assert_command() {
  if !which $1 > /dev/null 2> /dev/null;then
    echo "$2"
  fi
}

function _build() {
  assert_command git 'git not found'
  assert  git clone https://github.com/L0snight/Rules.git --recursive
  echo "Clone rules repo"
}

function _install() {
  echo "Install"
}

function _help() {
  echo "help"
}

case "$1" in
  "build")
  shift
  _build "$@"
  ;;
  "install")
  shift
  _install "$@"
  ;;
  *)
  _help
  ;;
esac