# coding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include RecordCreate

# 言語
LanguageCategory.create_once(id: 1, name: 'japanese', label: "日本語")
LanguageCategory.create_once(id: 2, name: 'english', label: "英語")

# プランカテゴリー
PlanCategory.create_once(id: 1, name: 'active', label: "アクティブ")
PlanCategory.create_once(id: 2, name: 'indoor', label: "インドア")

# スポットカテゴリー
SpotCategory.create_once(id: 1, name: 'active', label: "アクティブ")
SpotCategory.create_once(id: 2, name: 'indoor', label: "インドア")


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?