class CreateArticleVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :article_variants do |t|
      t.references :article, index: true, foreign_key: true
      t.string :variant_name
      t.timestamps
    end
    add_index :article_variants, ["article_id", "variant_name"], :unique => true, name: 'article_variants_unique_composite_keys'
  end
end
