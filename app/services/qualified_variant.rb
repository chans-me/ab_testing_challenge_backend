class QualifiedVariant
  attr_accessor :visitor_address, :article_id

  def initialize visitor_address, article_id
    @visitor_address = visitor_address
    @article_id = article_id
  end

  def get
    begin
      ActiveRecord::Base.transaction do
        visitor = get_visitor
        visitor_mapping = get_visitor_article_mapping visitor
        variant_name = get_variant_details visitor_mapping
        track_page_view visitor_mapping
        [variant_name, visitor.id]
      end
    rescue => error
      raise "Error in finding article variant: #{error.message}"
    end
  end

  def get_visitor
    visitor = Visitor.find_by_visitor_address(visitor_address)
    visitor = Visitor.create!(visitor_address: visitor_address) unless visitor.present?
    visitor
  end

  def get_visitor_article_mapping visitor
    visitor_mapping = VisitorArticleMapping.find_by_visitor_id_and_article_id(visitor.id, article_id)
    unless visitor_mapping.present?
      article_variant = get_qualified_article_variant
      visitor_mapping = VisitorArticleMapping.create!(
        visitor_id: visitor.id,
        article_id: article_id,
        article_variant_id: article_variant.id 
      )
    end
    visitor_mapping
  end

  def get_qualified_article_variant
    ArticleVariant.get_article_variants(article_id)
    .order("visitor_count, av.id")
    .limit(1)
    .first
  end

  def get_variant_details visitor_mapping
    ArticleVariant.find(visitor_mapping.article_variant_id).variant_name
  end

  def track_page_view visitor_mapping
    VisitorArticlePageView.create!(visitor_article_mapping_id: visitor_mapping.id)
  end
end