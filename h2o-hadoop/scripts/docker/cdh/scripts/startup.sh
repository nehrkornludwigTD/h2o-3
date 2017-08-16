#! /bin/bash

NC='\033[0m'
RED='\033[91m'

if [[ -d /startup && $(ls /startup) ]]; then
  cd /startup
  echo
  echo "###### Adding custom startup scripts ######"
  for x in $(ls); do
    echo -e "\tAdding startup script ${RED}${x}${NC}"
    cp ${x} /etc/startup
    chmod 700 /etc/startup/${x}
  done
  echo "###### Custom startup scripts added ######"
  echo
fi

cd /etc/startup/
for x in $(ls . | sort -n); do
  ./${x}
done

retval=0
if [[ $(echo ${RUN_TESTS} | tr -s '[:upper:]' '[:lower:]') == 'true' ]]; then
  failed=$((0))
  succeeded=$((0))
  total=$((0))
  cd /home/h2o/tests/python
  echo
  echo "Running tests from $(pwd)"
  for x in $(ls *.py); do
    total=$(($total + 1))
    echo
    echo "####### Running test file ${x} #######"
    python ${x}
    if [ $? -ne 0 ]; then
      failed=$(($failed + 1))
      echo "###### FAILED ######"
      retval=1
    else
      succeeded=$(($succeeded + 1))
    fi
    echo "###### Test file ${x} completed ######"
    echo
  done
  echo "###### TEST RESULTS ######"
  echo -e "\tSUCCEEDED:\t${succeeded}"
  echo -e "\tFAILED:\t\t${failed}"
  echo "--------------------------"
  echo -e "\tTOTAL:\t\t${total}"
fi

if [[ $(echo ${ENTER_BASH} | tr -s '[:upper:]' '[:lower:]') == 'true' ]]; then
  /bin/bash
fi

exit $retval
