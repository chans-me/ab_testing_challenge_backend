class CreateVisitors < ActiveRecord::Migration[5.2]
  def change
    create_table :visitors do |t|
      t.string :visitor_address
      t.timestamps
    end
    add_index :visitors, :visitor_address, unique: true
  end
end
