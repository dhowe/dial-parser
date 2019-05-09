#!/bin/bash
GRAMMAR=Dial
echo $GRAMMAR.g4 | entr -r  ./run-antlr.sh
