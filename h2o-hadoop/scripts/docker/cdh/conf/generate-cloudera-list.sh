#! /bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function print_red {
  echo -e "${RED}${1}${NC}"
}

function print_ok {
  echo -e "\t[ ${GREEN}OK${NC} ]"
}

if [ ! ${CDH_VERSION} ]; then
  echo "CDH_VERSION must be set"
  exit 1
fi

case "${CDH_VERSION}" in
  5.[45678] | 5.10)
    CDH_VERSION=${CDH_VERSION}.0
    echo "Generating cloudera.list for CDH ${CDH_VERSION}"
    ;;
  *)
    print_red "CDH version ${CDH_VERSION} not supported"
    exit 1
    ;;
esac

LIST_CONTENT="# Packages for Cloudera's Distribution for Hadoop, Version 5, on Ubuntu 14.04 amd64\n\
deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh${CDH_VERSION} contrib\n\
deb-src http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh${CDH_VERSION} contrib"

echo -e ${LIST_CONTENT} > /etc/apt/sources.list.d/cloudera.list
