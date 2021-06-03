class CreateVisitorArticlePageViews < ActiveRecord::Migration[5.2]
  def change
    create_table :visitor_article_page_views do |t|
      t.references :visitor_article_mapping, index: true, foreign_key: true
      t.timestamps
    end
  end
end
