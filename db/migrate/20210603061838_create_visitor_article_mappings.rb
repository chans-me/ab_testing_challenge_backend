class CreateVisitorArticleMappings < ActiveRecord::Migration[5.2]
  def change
    create_table :visitor_article_mappings do |t|
      t.references :visitor, index: true, foreign_key: true
      t.references :article, index: true, foreign_key: true
      t.references :article_variant, index: true, foreign_key: true
      t.boolean :signup_event
      t.timestamps
    end
    add_index :visitor_article_mappings, ["visitor_id", "article_id"], :unique => true, name: 'visitor_article_mappings_unique_composite_keys'
  end
end
