#!/usr/bin/bash
git status
git add *
git add .gitignore
git commit -m "$(date) - Updates"
git push