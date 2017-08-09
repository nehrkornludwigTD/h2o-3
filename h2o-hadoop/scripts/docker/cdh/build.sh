#! /bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function print_red {
  echo -e "${RED}${1}${NC}"
}

cdh_version=$1
if [[ ${cdh_version} == '' ]]; then
  echo -n "Enter required CDH version (for example 5.8): "
  read cdh_version
  echo
fi

PATTERN="5.[45678]|10"
if [[ ! ${cdh_version} =~ ${PATTERN} ]]; then
  print_red "CDH version '${cdh_version}' not supported"
  exit 1
fi
docker build -t h2o-cdh-${cdh_version} --build-arg CDH_VERSION=${cdh_version} .
