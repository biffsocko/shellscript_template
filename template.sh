#!/bin/sh
##########################################################
# BiffSocko
# template.sh
#
# shell template with included functions and framework
##########################################################

DATE=`date | sed 's/ /_/g'`
PGM="`basename $0`"
DEBUG=0
STATE_ERR=1
STATE_SUCCESS=0
LOGFILE="/var/tmp/$PGM.log"
#############################################
# function chkerr_exit()
#############################################
chkerr_exit(){
    $@ 2> /dev/null

    if [ $? -ne 0 ]
    then
         logit "$PGM: failed executing $@ .. exiting"
         exit $STATE_ERR
    fi
} # END chkerr_exit()

#############################################
# usage()
#############################################
usage(){
    echo "usage: $PGM <stuff here>"
    exit $STATE_SUCCESS
}
#############################################
# function chkfile()
#############################################
chkfile(){
    FILE=$@
    if [ ! -f ${FILE} ]
    then
        logit "$PGM: file ${FILE} does not exist .. exiting"
        exit $STATE_ERR
    fi
}

#############################################
# function logit
#############################################
logit(){
    if [ ${DEBUG} -gt 0 ]
    then
        echo "$PGM: $@"
    fi
    echo "$PGM: $@" >> $LOGFILE
    logger "$PGM : $@"
}


#############################################
#  function finish
#############################################
finish(){
    logit "$PGM finished `date`  - SUCCESS"
    exit $STATE_SUCCESS
}


#############################################
# function start
#############################################
start(){

    if [ $DEBUG -eq 0 ]
    then
        #get rid of the old logfile
        if [ -f $LOGFILE ]
        then
            chkerr_exit "rm -f $LOGFILE"
        fi
    fi

    logit "$PGM started"
}

################################################
# verify that root is running this pgm
################################################
function chkroot() {
    if [ $UID -ne 0 ]
    then
        echo "you must be root to run this program .. exiting"
        exit 1
    fi
}


#############################################
# MAIN
#############################################
main(){
    start
    # do stuff here
    finish
}



###############################
# check options before  main()
###############################
while getopts e option_read; do
  case $option_read in
    e)  echo "happy easter"
        echo "you found the egg"
        exit 0
        ;;
    *)  echo "this does not take options"
        echo "usage $0"
        # get out!
        exit 1
        ;;
  esac
done


main $@

