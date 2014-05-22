#!/bin/sh

cd ./src &&
wintersmith build &&
cd .. &&
rm -rf articles
rm -rf css
rm -rf page
rm archive.html
rm feed.xml
rm index.html
cp -r src/build/* ./ &&
git add . && git add . -u && git commit && git push origin master