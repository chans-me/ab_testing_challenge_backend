class ArticleVariant < ApplicationRecord
  belongs_to :article
  has_many :visitor_article_mappings, dependent: :destroy

  scope :get_article_variants, -> (article_id) { 
    joins("av left join visitor_article_mappings vam on vam.article_variant_id = av.id")
    .where("av.article_id = #{article_id}")
    .group("av.id")
    .select("count(vam.article_variant_id) as visitor_count, av.id, av.variant_name, count(vam.signup_event) as signedup_count")
  }

  def self.get_article_page_views article_id
    joins("av left join visitor_article_mappings vam on vam.article_variant_id = av.id 
      left join (
        select count(pgav.id) as page_views, pgav.id from article_variants pgav 
        join visitor_article_mappings pgvam on pgvam.article_variant_id = pgav.id 
        join visitor_article_page_views pgvapv on pgvapv.visitor_article_mapping_id = pgvam.id 
        where pgav.article_id = #{article_id} group by pgav.id
      ) aggregate_views on aggregate_views.id = av.id")
    .select("count(vam.article_variant_id) as visitor_count, 
      av.id, av.variant_name, count(vam.signup_event) as signedup_count, aggregate_views.*")
    .where("av.article_id = #{article_id}")
    .group("av.id, aggregate_views.id, aggregate_views.page_views")
  end
end