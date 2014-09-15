#! /bin/bash

#first define paths

#here we use the texmacs installed files, but can also be the downloaded source
Texmacs_math_plugin_files=/Applications/TeXmacs-1.99.1.app/Contents/Resources/share/TeXmacs/plugins/mathematica

#Mathematica files from your installation
Mathlink_Path="/Applications/Mathematica.app/SystemFiles/Links/MathLink/DeveloperKit/MacOSX-x86-64/CompilerAdditions"
#above, replace "Linux-x86-64" to suit your system. 
#In this directory we'll use the header mathlink.h and a shared library libMLxxx.so where xxx depends on the architecture
#for me, the library is "libML64i3.so" :

lib_name=libMLi3.a

#for Linux, normally no editting needed below this line
Texmacs_home=$HOME"/.TeXmacs"

lib_option=${lib_name:3:${#lib_name}-5} #strip "lib" and ".a"

#make the dynamic library accessible at runtime in the usual system library path (needs admin rights):
sudo ln -s $Mathlink_Path/$lib_name /usr/lib/$lib_name

#make temporary writable copy of souce and use as working directory:
cp -rf $Texmacs_math_plugin_files/src.lazy /tmp/mathem
cd /tmp/mathem

#copy necessary header
cp $Mathlink_Path/mathlink.h mathlink.h

#compile (you may need to reinstall command line tools)
gcc -o tm_mathematica.bin tm_mathematica.c -L$Mathlink_Path -l$lib_option -lstdc++ -framework Foundation -lm -lpthread

#finally install executable
cp tm_mathematica.bin $Texmacs_home/bin/tm_mathematica.bin