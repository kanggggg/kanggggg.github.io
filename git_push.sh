#!/bin/bash
./hexo_clean.sh
git add .
git commit -m 'update'
git push origin source