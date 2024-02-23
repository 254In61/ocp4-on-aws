#!/usr/bin/bash
yamllint ../aap-workflow-lab
git status
git add *
git commit -m "Updates"
git push
git status