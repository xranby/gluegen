#!/bin/sh

JAVA=java
GLUEGEN_JAR=../../../build/gluegen.jar
ANTLR_JAR=../../../../../ANTLR/antlr-2.7.5.jar

NAME=`uname`

if [[ $NAME == "Windows*" ]] ; then
  SEP=\;
elif [[ $NAME == "CYGWIN*" ]] ; then
  SEP=\;
else
  SEP=:
fi

java -cp $GLUEGEN_JAR$SEP$ANTLR_JAR com.jogamp.gluegen.GlueGen -I. -Ecom.jogamp.gluegen.JavaEmitter -Cfunction.cfg function.h
