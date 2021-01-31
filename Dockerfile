# Ruby on Rails 開発環境
# Ruby : 2.7.2
# Rails : 6.0.3

FROM ruby:2.7.2

LABEL maintainer="hato <hato.deve@gmail.com>"
# bashを指定
SHELL ["/bin/bash", "-c"]

RUN echo "now building..."

# 一応Rails開発用のディレクトリに移動
RUN mkdir /Developments
RUN cd /Developments

# apt-getの更新
RUN apt-get update -y
RUN apt-get upgrade -y

# コンパイラ、必要ツールのインストール
RUN apt-get install build-essential -y
RUN apt-get install -y libssl-dev libreadline-dev zlib1g-dev
RUN apt-get install git wget curl -y

# Node, sqlite3のインストール
RUN apt-get install -y nodejs

# インタラクティブなインストールとなっているため工夫が必要かもAsia(6), Tokyo(79)
RUN apt-get install -y libsqlite3-dev

# yarnをインストールしないとrails sした際にwebpackerでエラーが出る
# aptだと最新のyarnをインストールできないため、下記コマンドで最新verを入手
# 古いyarnを削除
RUN apt-get remove cmdtest -y
RUN apt-get remove yarn -y

# 最新のyarnを取得
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt install yarn

# Railsのインストール
RUN gem install rails -v "6.0.3"

RUN source ~/.bashrc
