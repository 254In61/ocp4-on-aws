#!/usr/bin/bash
git status
git add *
git commit -m "$(date) - Updates"
git push
echo ""
git status
echo ""