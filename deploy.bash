#!/bin/bash
git config --global user.email "davidsiaw@gmail.com"
git config --global user.name "David Siaw (via Circle CI)"

git clone git@github.com:fliptable-circle/fliptable-circle.github.io.git build
cp -r build/.git ./gittemp
bundle exec weaver build -r https://fliptable.astrobunny.net
cp -r ./gittemp build/.git
pushd build
echo fliptable.astrobunny.net > CNAME
cp 404/index.html 404.html
git add .
git add -u
git commit -m "update `date`"
ssh-agent bash -c 'ssh-add ~/.ssh/id_github.com; git push'
popd
