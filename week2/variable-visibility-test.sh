#!/bin/bash

# Write a script that illustrates variable visibility. 
# ake your script print out the process identifiers (PIDs) of the shells. 
# This implies the creation of one local variable that would be set 
# in the first shell but would not in a second shell.

foo=bar
echo -e "this shell:\nfoo: "$foo "PID:" $BASHPID
echo "other shell:"; bash -c 'echo "foo:" $foo "PID:" $BASHPID'
export foo
echo "after export: "
bash -c 'echo "foo:" $foo "PID:" $BASHPID' 
