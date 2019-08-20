#!/bin/bash

function hexo_clean() {
    cd source
    hexo clean 
}

function hexo_server() {
    hexo_clean
    hexo g
    hexo server
}

function hexo_deploy() {
    ssh-add /Users/vince/Dev/github/github_id_rsa
    hexo_clean
    hexo g
    hexo d
}

function git_push() {
    hexo_clean
    cd ..
    ssh-add /Users/vince/Dev/github/github_id_rsa
    git add .
    git commit -m 'update'
    git push origin source
}

echo "请选择要执行的操作:"
echo "[1] clean"
echo "[2] 启动本地server"
echo "[3] deploy到GitHub Page"
echo "[4] 推送Source"

read SELECTION

if [ ! -n "$SELECTION" ];then

echo "输入无效"
exit 1

else

if [ $SELECTION = '1' ]; then 

echo "执行中..."
hexo_clean

elif [ $SELECTION = '2' ]; then

echo "执行中..."
hexo_server

elif [ $SELECTION = '3' ]; then

echo "执行中..."
hexo_deploy

elif [ $SELECTION = '4' ]; then

echo "执行中..."
git_push

else 

echo "输入无效"
exit 1

fi
fi