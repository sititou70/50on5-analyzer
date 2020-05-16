#!/bin/bash
set -eu
cd $(dirname $0)

. ../settings.sh

# main
## create word list
if [ ! -e "$WORDLIST_FILE" ]; then
  ### clone mozc
  MECAB_DIR="TEMP_mecab"
  if [ ! -e "$MECAB_DIR" ]; then
    mkdir $MECAB_DIR
    cd $MECAB_DIR
    git init
    git remote add origin https://github.com/taku910/mecab.git
    git fetch --depth 1 origin 3a07c4eefaffb4e7a0690a7f4e5e0263d3ddb8a3
    git checkout FETCH_HEAD
    cd ..
  fi

  cat $MECAB_DIR/mecab-ipadic/Noun*.csv |
    iconv -f=euc-jp -t=utf8 |
    cut -d "," -f 12 \
      >$WORDLIST_FILE.notuniq
  cat $MECAB_DIR/mecab-ipadic/Verb.csv |
    iconv -f=euc-jp -t=utf8 |
    grep ",基本形," |
    cut -d "," -f 12 \
      >>$WORDLIST_FILE.notuniq
  cat $MECAB_DIR/mecab-ipadic/Adj.csv |
    iconv -f=euc-jp -t=utf8 |
    grep ",基本形," |
    cut -d "," -f 12 \
      >>$WORDLIST_FILE.notuniq
  cat $WORDLIST_FILE.notuniq | sort | uniq >$WORDLIST_FILE
  rm -rf $WORDLIST_FILE.notuniq
fi
