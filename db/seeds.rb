# coding: utf-8

load(Rails.root.join("db", "seed", "#{Rails.env.downcase}.rb"))

# 開発環境
# ⇒rails db:seed

# 本番環境
# ⇒rails db:seed RAILS_ENV=production