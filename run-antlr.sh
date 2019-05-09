#!/bin/bash

GRAMMAR=Dial
START_RULE=chat
INPUT_FILE=input.txt

ANTLR_JAR=/usr/local/lib/antlr-4.7.2-complete.jar
CLASSPATH=$ANTLR_JAR:.

# cleanup
rm *.java  2> /dev/null
rm *.class  2> /dev/null
rm *.interp  2> /dev/null
rm *.tokens  2> /dev/null

if [[ $1 == "-c" ]]; then
  exit
fi

# generate java
java -jar $ANTLR_JAR "./$GRAMMAR.g4"

if [[ $1 == "-a" ]]; then
  exit
fi

# compile java
javac -classpath $CLASSPATH:. *.java

# run grammar
grun $GRAMMAR $START_RULE -tokens -tree $INPUT_FILE | sed -e $'s/(chat/\\\n(chat/g' | sed -e $'s/(line/\\\n  (line/g'
