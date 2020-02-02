#!/bin/bash
ulimit -n 4000
hcitool hci0 up
java -jar ruuvi-collector-0.2.jar
