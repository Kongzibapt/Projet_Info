#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2018.2 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Tue May 24 11:24:43 CEST 2022
# SW Build 2258646 on Thu Jun 14 20:02:38 MDT 2018
#
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep xsim test_chemin_donnees_behav -key {Behavioral:sim_1:Functional:test_chemin_donnees} -tclbatch test_chemin_donnees.tcl -view /home/ingargio/4IR/Projet_Info/Processor/test_chemin_donnees_behav.wcfg -log simulate.log
