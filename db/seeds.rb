# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Article.all.empty?
  article_one = Article.create(title: "first article title")
  ArticleVariant.create!(article_id: article_one.id, variant_name: "first_variant")
  ArticleVariant.create!(article_id: article_one.id, variant_name: "second_variant")
  ArticleVariant.create!(article_id: article_one.id, variant_name: "third_variant")

  article_two = Article.create(title: "second article title")
  ArticleVariant.create!(article_id: article_two.id, variant_name: "first_variant")
  ArticleVariant.create!(article_id: article_two.id, variant_name: "second_variant")
  ArticleVariant.create!(article_id: article_two.id, variant_name: "third_variant")
end
