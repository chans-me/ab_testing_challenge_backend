class Article < ApplicationRecord
  has_many :article_variants, dependent: :destroy
  has_many :visitor_article_mappings, dependent: :destroy
end