#!/bin/bash

#相关变量
SUBCONVERT_HOME="/path/to/subconverter"
SUBSCRIBE_URL="https://subscribe/url"
PROFILE_TOKEN="your_token"

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
  assert git clone https://github.com/L0snight/Rules.git --recursive
  echo "Clone Rules repo"
}

function _config() {
  assert_command sed 'sed not found'
  assert sed -i "s/api_access_token.*$/api_access_token: ${PROFILE_TOKEN}/g" ${SUBCONVERT_HOME}/pref-new.yml
  assert sed -i "s@^url=.*\$@url=${SUBSCRIBE_URL}@g" profiles/clash.ini
}

function _install() {
  assert cp base/* ${SUBCONVERT_HOME}/base
  assert cp config/* ${SUBCONVERT_HOME}/config
  assert cp profiles/* ${SUBCONVERT_HOME}/profiles
  assert rm -rf ${SUBCONVERT_HOME}/rules/*
  assert cp -r Rules/* ${SUBCONVERT_HOME}/rules
  assert cp -r template ${SUBCONVERT_HOME}/template
  assert cp ${SUBCONVERT_HOME}/pref-new.yml ${SUBCONVERT_HOME}/pref.yml
}

function _help() {
  echo "Usage: ./install.sh ACTION [OPTIONS]"
  echo "Note: Before installing, config the subconverter dirpath first."
  echo ""
  echo "ACTION:"
  echo "    build       clone Rules repo"
  echo "    config      config subscribe url and profile token"
  echo "    install     cp base,config,profiles and pref"
  echo ""
  exit 1
}

case "$1" in
  "build")
  shift
  _build "$@"
  ;;
  "config")
  shift
  _config "$@"
  ;;
  "install")
  shift
  _install "$@"
  ;;
  *)
  _help
  ;;
esac
