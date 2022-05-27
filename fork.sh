#!/bin/sh
# Usage: ./fork.sh MyUsername MyModName

username=$1
modname=$2

# Replace release link + CI badge
sed -i README.md fork.sh -e "s/deltanedas/$username/g"
# Replace mod name
sed -i $(find . -type f -not -path '*/\.git/*') -e "s/ExamplePlugin/$modname/g"
# Rename main class (youll have to rename the package yourself)
mv src/example/ExamplePlugin.java "src/example/$modname.java"
# Change remote for quick pushing
git remote set-url origin "ssh://git@github.com/$username/$modname"
