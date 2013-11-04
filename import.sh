#!/bin/sh -e

workspace="`dirname $0`/workspace"
mkdir -p $workspace

# download all ontologies
./import.rb

# change into workspace
cd $workspace

# Initialize git repository if it does not exist
if [ ! -e .git ]; then
  git init
  git config user.email "import@ontohub"
  git config user.name  "Import"
fi

# Has anything changed?
status=`git status`

if [ -z "$status" ]; then
  # nothing to do
  echo nothing changed
else
  # commit  
  git add -A
  git commit -m "Ontologies updated"
fi
