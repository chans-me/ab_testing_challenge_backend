class Api::V1::AbTestingController < ApiBaseController
  skip_before_action :verify_authenticity_token

  def variant_info
    begin
      visitor_address = params['visitor_address']
      article_id = params['article_id']
      raise Exceptions::BadRequestError.new("Invalid info") if visitor_address.blank? || article_id.blank?
      variant_name, visitor_id = QualifiedVariant.new(visitor_address, article_id) 
      render ok({variant_name: variant_name, visitor_id: visitor_id})
    rescue Exceptions::BadRequestError => error
      render bad_request(error.message)
    rescue StandardError => error
      render internal_error("Internal server error, #{error.message}")
    end
  end

  def signup_event
    begin
      visitor_id = params["visitor_id"]
      article_id = params["article_id"]
      response_message = ""
      raise Exceptions::BadRequestError.new("Invalid info") if visitor_id.blank? || article_id.blank?
      visitor_mapping = VisitorArticleMapping.find_by_visitor_id_and_article_id(visitor_id, article_id)
      if visitor_mapping.present? && !visitor_mapping.signup_event
        visitor_mapping.update_attributes(signup_event: true)
        response_message = "Visitor Signed up successfully!"
      else
        response_message = "Visitor already signed up!"
      end
      render ok({response_message: response_message})
    rescue Exceptions::BadRequestError => error
      render bad_request(error.message)
    rescue StandardError => error
      render internal_error("Internal server error, #{error.message}")
    end
  end

  def test_results
    begin
      article_id = params["article_id"]
      raise Exceptions::BadRequestError.new("Invalid info") if article_id.blank?
      article_data = ArticleVariant.get_article_variants(article_id)
        .order("signedup_count desc, visitor_count")
        .limit(1)
      render ok({data: article_data})
    rescue Exceptions::BadRequestError => error
      render bad_request(error.message)
    rescue StandardError => error
      render internal_error("Internal server error, #{error.message}")
    end
  end
end