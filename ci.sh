#!/bin/sh
git scribe gen all > gen.log
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

git status
git branch -v
git remote -v
git config --global user.email ${GIT_EMAIL}
git config --global user.name ${GIT_NAME}
git remote set-url --push origin $REPO_URL
git remote set-branches --add origin $GH_BRANCH
git fetch
git checkout -- .
git status
git checkout --track -b gh-pages origin/gh-pages
git status
mv output/site/* ./
mv output/book.* ./
git add .
git status
git commit -m "Update gh-pages after TravisCI build"
git push origin $GH_BRANCH

