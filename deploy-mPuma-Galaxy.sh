#!/bin/sh

# This script copies and edits the necesary files to deploy mPuma tools in a galaxy server, in order to test them

galaxy="/home/mikel/galaxy-dist/"
main_tool_conf=$galaxy"tool_conf.xml"
tmp_tool_conf=$galaxy"tool_conf.xml.tmp"

cp galaxy-dist/tools/mPuma/* $galaxy"tools/mPuma/"

cp $main_tool_conf $galaxy"tool_conf.xml.bk"
cat $main_tool_conf | sed '/<section name="mPuma/,/<\/toolbox>/d' | grep -v "</toolbox>" > $tmp_tool_conf
less galaxy-dist/tool_conf.xml >> $tmp_tool_conf
mv $tmp_tool_conf $main_tool_conf
