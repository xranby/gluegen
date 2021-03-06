#! /bin/sh

SDIR=`dirname $0` 

if [ -e $SDIR/setenv-build-jogamp-x86_64.sh ] ; then
    . $SDIR/setenv-build-jogamp-x86_64.sh
fi

if [ -e $SDIR/setenv-android-tools.sh ] ; then
    . $SDIR/setenv-android-tools.sh
fi

export NODE_LABEL=.

export HOST_UID=jogamp
# jogamp02 - 10.1.0.122
export HOST_IP=10.1.0.122
export HOST_RSYNC_ROOT=PROJECTS/JogAmp

export TARGET_UID=jogamp
export TARGET_IP=panda02
#export TARGET_IP=jautab03
#export TARGET_IP=jauphone04
export TARGET_ADB_PORT=5555
# needs executable bit (probably su)
export TARGET_ROOT=/data/projects
export TARGET_ANT_HOME=/usr/share/ant

export ANDROID_VERSION=24
export SOURCE_LEVEL=1.8
export TARGET_LEVEL=1.8
export TARGET_RT_JAR=/opt-share/jre1.8.0_212/lib/rt.jar

export GCC_VERSION=4.9
HOST_ARCH=linux-x86_64
export TARGET_TRIPLE=i686-linux-android
export TOOLCHAIN_NAME=x86

export NDK_TOOLCHAIN_ROOT=$NDK_ROOT/toolchains/${TOOLCHAIN_NAME}-${GCC_VERSION}/prebuilt/${HOST_ARCH}
export TARGET_PLATFORM_SYSROOT=${NDK_ROOT}/platforms/android-${ANDROID_VERSION}/arch-x86

# Need to add toolchain bins to the PATH. 
# May need to create symbolic links within $NDK_TOOLCHAIN_ROOT/$TARGET_TRIPLE/bin
#   cd $NDK_TOOLCHAIN_ROOT/$TARGET_TRIPLE/bin
#   ln -s ../../bin/i686-linux-android-gcc gcc
export PATH="$NDK_TOOLCHAIN_ROOT/$TARGET_TRIPLE/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/$ANDROID_BUILD_TOOLS_VERSION:$PATH"

export GLUEGEN_CPPTASKS_FILE="lib/gluegen-cpptasks-android-x86.xml"

#export JUNIT_DISABLED="true"
#export JUNIT_RUN_ARG0="-Dnewt.test.Screen.disableScreenMode"

echo PATH $PATH 2>&1 | tee make.gluegen.all.android-x86-cross.log
echo gcc `which gcc` 2>&1 | tee -a make.gluegen.all.android-x86-cross.log

#export JOGAMP_JAR_CODEBASE="Codebase: *.jogamp.org"
export JOGAMP_JAR_CODEBASE="Codebase: *.goethel.localnet"

#BUILD_ARCHIVE=true \
ant \
    -Drootrel.build=build-android-x86 \
    $* 2>&1 | tee -a make.gluegen.all.android-x86-cross.log
