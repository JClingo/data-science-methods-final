#!/bin/sh

set -e

[ -z "${GITHUB_PAT}" ] && exit 0
[ "${TRAVIS_BRANCH}" != "main" ] && exit 0

git config --global user.email "joshuaclingo@gmail.com"
git config --global user.name "Joshua Clingo"

git clone -b gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git temp
cd temp
mv -f ../paper/paper.html index.html
git add index.html
git commit -m "Updated the reproduced analysis" || true
git push origin gh-pages