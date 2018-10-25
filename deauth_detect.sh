#!/bin/bash

#################################################################################
################### TOOL - WiFi Deauth detecter - under GPLv3 ###################
################### by Phil, Puzzle guy                       ###################
################### From the 3rd bench                        ###################
################### Thanks to the community!                  ###################
#################################################################################

##########################################################
#  INFORMATIONS                                          #
#   This Script detects Deauth pacets                    #
#                                                        #
##########################################################

mon_interface="wlp0s20u2"
filter="wlan.fc.type_subtype == 0xc"

prepare() {
sudo ifconfig $mon_interface down
sudo iwconfig $mon_interface mode monitor
sudo ifconfig $mon_interface up
}

tshark_filter() {
  output=`tshark -i $mon_interface -Y "$filter" -c 100`
  if [ -z $output ];
  then
    echo "no deauth found"
  else
    echo "deauth found"
  fi
}

# main
prepare
while true; do
  tshark_filter
done
