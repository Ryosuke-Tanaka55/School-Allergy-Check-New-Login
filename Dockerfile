# ruby 2.6.3がベースイメージ
FROM ruby:2.6.3

ENV RAILS_ENV=production

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# railsの実行に必要なnodejsとpostgresqlをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /app
# 作業用のディレクトリを指定
WORKDIR /app
# ローカルファイルをコンテナへコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install
# Dockerファイルが置いてあるフォルダのファイルすべてをコンテナ内のappディレクトリにコピー
COPY . /app

COPY start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["sh", "/start.sh"]