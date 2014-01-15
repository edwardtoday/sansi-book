#!/bin/sh
set -e
bin/git-scribe check
bin/git-scribe gen all > gen.log
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

git config --global user.email edwardtoday@gmail.com
git config --global user.name "Pei Qing 卿培"
git remote set-url --push origin $REPO_URL
git remote set-branches --add origin $GH_BRANCH
git fetch
git checkout -- .
git checkout --track -b gh-pages origin/gh-pages
cp -rf output/site/* ./
cp -f output/book.* ./
git add .
git commit -m "Update gh-pages after TravisCI build"
git push -q origin $GH_BRANCH

