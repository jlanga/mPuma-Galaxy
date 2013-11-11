#!/bin/sh

# This script copies and edits the necesary files to deploy mPuma tools in a galaxy server

# !!! Dangerous and fragile !!!

# Stop Galaxy

# Change Galaxy path in variable "galaxy" to fit your path

galaxy="/home/mikel/galaxy-dist/"

# Rest of the paths should be left as is

galaxy_mpuma=$galaxy"tools/mPuma/"
main_tool_conf=$galaxy"tool_conf.xml"
tmp_tool_conf=$galaxy"tool_conf.xml.tmp"

# Create mPuma directory if it doesn't exist 

if [ ! -d $galaxy_mpuma ]; then
  mkdir $galaxy_mpuma
fi
 
# Copy the necessary files 
 
cp galaxy-dist/tools/mPuma/* $galaxy_mpuma
cp galaxy-dist/test-data/* $galaxy"test-data"

# Edit tool_conf: it will add the tool_conf.xml bit to the tool_confx.xml of the galaxy server you want mPuma to be installed in
# (mPuma will appear at the end: it can also handle already existing mPuma sections, if there are at the end, if they are not it 
# will delete everything till </toolbox>, and you will have to recover from tool_conf.xml.bk)

cp $main_tool_conf $galaxy"tool_conf.xml.bk"
cat $main_tool_conf | sed '/<section name="mPuma/,/<\/toolbox>/d' | grep -v "</toolbox>" > $tmp_tool_conf
less galaxy-dist/tool_conf.xml >> $tmp_tool_conf
mv $tmp_tool_conf $main_tool_conf

# Start Galaxy