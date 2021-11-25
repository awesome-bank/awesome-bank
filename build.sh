#!/bin/bash
#
# We could pass below options to build the individual service. 
# If we don't pass any options by default it builds each service.
#
# --acount or -a to build awesome-bank-account-service
# --card or -ca to build awesome-bank-card-service
# --config or -co to build awesome-bank-config-server
# --loan or -l to build awesome-bank-loan-service
#
# e.g.
# sh build.sh                                  ==> To rebuild all services 
# sh build.sh --account  OR  sh build.sh -a    ==> To rebuild awesome-bank-account-service service
# sh build.sh --card     OR  sh build.sh -ca   ==> To rebuild awesome-bank-card-service service
# sh build.sh --loan     OR  sh build.sh -l    ==> To rebuild awesome-bank-loan-service service
# sh build.sh --config   OR  sh build.sh -co   ==> To rebuild awesome-bank-config-server service
#

buildAccountService()
{
    cd awesome-bank-account-service
    mvn clean install -DskipTests
    cd ..
}

buildCardService()
{
    cd awesome-bank-card-service
    mvn clean install -DskipTests
    cd ..
}

buildLoanService()
{
    cd awesome-bank-loan-service
    mvn clean install -DskipTests
    cd ..
}

buildConfigServer()
{
    cd awesome-bank-config-server
    mvn clean install -DskipTests
    cd ..
}

OPTS=`getopt -a -l account -l card -l loan -l config -- "$0" "$@"`
if [ $? != 0 ] # There was an error parsing the options
then
  exit 1 
fi

eval set -- "$OPTS"

while true; do
  case "$1" in
    --account) echo "BUILDING ACCOUNT SERVICE";buildAccountService; shift;;
    --card) echo "BUILDING CARD SERVICE"; buildCardService; shift;;
    --loan) echo "BUILDING LOAN SERVICE"; buildLoanService; shift;;
    --config) echo "BUILDING CONFIG SERVER"; buildConfigServer; shift;;
    --) echo "BUILDING ALL APPLICATIONS"; buildAccountService; buildCardService; buildLoanService; buildConfigServer; shift; break;;
  esac
done
