class ArticleVariant < ApplicationRecord
  belongs_to :article
  has_many :visitor_article_mappings, dependent: :destroy

  scope :get_article_variants, -> (article_id) { 
    joins("av left join visitor_article_mappings vam on vam.article_variant_id = av.id")
    .where("av.article_id = #{article_id}")
    .group("av.id")
    .select("count(vam.article_variant_id) as visitor_count, av.id, av.variant_name, count(vam.signup_event) as signedup_count")
  }
end