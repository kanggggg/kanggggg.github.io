#!/bin/bash
cd source
read -p "输入新文章名字：" PAGENAME
hexo new "$PAGENAME"