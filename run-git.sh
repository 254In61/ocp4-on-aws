#!/usr/bin/bash
git status
git add *
git add -f roles/ignition/templates/*
git commit -m "$(date) - Updates"
git push
echo ""
git status
echo ""