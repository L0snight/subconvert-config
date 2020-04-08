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
  rm -rf Rules
  assert  git clone https://github.com/L0snight/Rules.git --recursive
  echo "Clone Rules repo"
}

function _install() {
  assert cp base/* ../base
  assert cp config/* ../config
  assert cp profiles/* ../profiles
  assert cp -r Rules ../Rules
  assert cp pref.yml ./pref.yml
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