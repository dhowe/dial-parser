#!/bin/bash

GRAMMAR=Dial
START_RULE=chat
INPUT_FILE=input.txt

# not yet used
OUTPUT_DIR=target/generated-sources/antlr4 # not yet used

ANTLR_JAR=/usr/local/lib/antlr-4.7.2-complete.jar
CLASSPATH=$ANTLR_JAR:.

echo
echo Cleaning...

# cleanup
rm *.java *.class *.interp *.tokens 2> /dev/null

if [[ $1 == "-c" ]]; then
  exit
fi

echo Parsing $GRAMMAR.g4

# generate java
java -jar $ANTLR_JAR "./$GRAMMAR.g4"

# -o target/generated-sources/antlr4 -listener -no-visitor -encoding UTF-8

if [[ $1 == "-a" ]]; then
  exit
fi

echo Compiling...
# compile java
javac -classpath $CLASSPATH:. *.java

echo Running $INPUT_FILE

# run grammar
grun $GRAMMAR $START_RULE -tokens -tree $INPUT_FILE | sed -e $'s/(chat/\\\n(chat/g' | sed -e $'s/(line/\\\n  (line/g'
