#!/bin/sh

setup_git() {
  echo "Setup GIT"
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  echo "Commit files"
  cd dist
  tar -cvjf AltAnalyze.app.tar.bz2 AltAnalyze.app
  cd ..
  git checkout -b osxapp
  git add -f dist/AltAnalyze.app.tar.bz2
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  echo "Upload files"
  git remote add origin-pages https://${GH_TOKEN}@github.com/michalkouril/altanalyze.git > /dev/null 2>&1
  git push --quiet --set-upstream origin-pages osxapp 
}

setup_git
commit_website_files
upload_files
