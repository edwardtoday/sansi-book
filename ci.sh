#!/bin/sh
git scribe gen site > gen.log
# cat gen.log

checkerror(){
  if grep -i 'error' gen.log; then
    retval=1
  else
    retval=0
  fi
  return "$retval"
}

checkerror

rm gen.log

git config --global user.email "edwardtoday@gmail.com"
git config --global user.name "Pei Qing 卿培"
git remote set-url origin $REPO_URL
git checkout --track -b gh-pages origin/gh-pages
mv output/site/* ./
mv output/book.* ./
git add .
git commit -m "Update gh-pages after TravisCI build"
git push --quiet origin gh-pages

