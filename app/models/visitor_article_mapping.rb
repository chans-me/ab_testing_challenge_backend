class VisitorArticleMapping < ApplicationRecord
  belongs_to :visitor
  belongs_to :article
  belongs_to :article_variant
  has_many :visitor_article_page_views, dependent: :destroy
end