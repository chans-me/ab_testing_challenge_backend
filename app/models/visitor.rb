class Visitor < ApplicationRecord
  has_many :visitor_article_mappings, dependent: :destroy
end