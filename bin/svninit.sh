#!/usr/bin/env bash

rootUrl=$1;
label=$2;

trunkUrl="${rootUrl}/trunk"


echo "-----------------------------------------------------------------------------------------------------"
echo "svninit.sh"
echo "=========="
echo "  Script to upload existing git repo to subversion repository."
echo "  Based on:"
echo "    http://stackoverflow.com/questions/661018/pushing-an-existing-git-repository-to-svn/772881#772881"
echo "-----------------------------------------------------------------------------------------------------"
echo "";
echo "   *** Uploading ${label} to ${rootUrl} ***";
echo "";

echo "Creating server paths..."
svn mkdir --parents "${trunkUrl}" -m "Importing git repo ${label}"
echo "";

echo "Create local git repo if not already exists."
git init
echo "";

echo "Initilizing git-svn..."
git svn init --prefix=origin/ "${rootUrl}" -s
echo "";

echo "Fetching..."
git svn fetch --log-window-size 100000
echo "";

echo "Rebasing..."
git rebase origin/trunk
echo "";
echo "-----------------------------------------------------------------------------------------------------"
echo "Finshed.";
echo "";

echo "Status:"
git status
echo "";

echo "Resolve remaining conflicts (if any) repeating below commands as needed:"
echo "   | git add (conflicted-files)"
echo "   | git rebase --continue"
echo "";
echo "...and then:";
echo "   | git svn dcommit";
echo "";

