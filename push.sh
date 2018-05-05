#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  cd dist
  tar -cvzf AltAnalyze.app.tar.gz AltAnalyze.app
  git checkout -b osxapp
  git add -f dist/AltAnalyze.app.tar.gz
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  git remote add origin-pages https://${GH_TOKEN}@github.com/michalkouril/altanalyze.git > /dev/null 2>&1
  git push --quiet --set-upstream origin-pages osxapp 
}

setup_git
commit_website_files
upload_files
