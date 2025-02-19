#!/bin/bash
clear
if [[ "$(hostname -I | grep -w 10.60.220.2)" ]]; then curl -L https://zeraa.gov.iq; else echo "Server IP does not match"; fi



#code here
