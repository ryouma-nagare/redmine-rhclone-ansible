#!/bin/bash

REDMINE_DIR=/opt/redmine

REDMINE_PLUGIN_DIR=`find ${REDMINE_DIR}/plugins -mindepth 1 -maxdepth 1 -type d`
REDMINE_THEME_DIR=`find ${REDMINE_DIR}/public/themes -mindepth 1 -maxdepth 1 -type d`
REDMINE_OWNER=apache

# ソースアップデート
sudo su -s /bin/bash - ${REDMINE_OWNER} -c "cd ${REDMINE_DIR};svn up"

# プラグインアップデート
for PLUGIN in ${REDMINE_PLUGIN_DIR}
do
echo ${PLUGIN}
  if [ -d "${PLUGIN}/.git" ]; then
    sudo su -s /bin/bash - ${REDMINE_OWNER} -c "cd ${PLUGIN};git fetch"

  elif [ -d "${PLUGIN}/.hg" ]; then
    sudo su -s /bin/bash - ${REDMINE_OWNER} -c "cd ${PLUGIN};hg pull;hg update"
  fi
done

# gemアップデート
sudo su -s /bin/bash - ${REDMINE_OWNER} -c "cd ${REDMINE_DIR};bundle install"

# テーマアップデート
for THEME in ${REDMINE_THEME_DIR}
do
echo ${THEME}
  if [ -d "${THEME}/.git" ]; then
    sudo su -s /bin/bash - ${REDMINE_OWNER} -c "cd ${THEME};git fetch"

  elif [ -d "${THEME}/.hg" ]; then
    sudo su -s /bin/bash - ${REDMINE_OWNER} -c "cd ${THEME};hg pull;hg update"
  fi
done
