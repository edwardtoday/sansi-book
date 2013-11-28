#!/bin/sh
git scribe gen all > gen.log
cat gen.log

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

export REPO="$(pwd | sed s,^/home/travis/builds/,,g)"
ssh -o StrictHostKeyChecking=no
git checkout gh-pages
mv output/site/* ./
mv output/book.* ./
git add .
git commit -m "Update gh-pages after TravisCI build"
git push https://$(GH_USER):$(GH_PASSWORD)@github.com/${REPO} gh-pages

