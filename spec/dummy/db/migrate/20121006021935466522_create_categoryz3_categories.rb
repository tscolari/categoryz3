class CreateCategoryz3Categories < ActiveRecord::Migration
  def change
    create_table :categoryz3_categories do |t|
      t.string :name
      t.references :parent
      t.integer :items_count       , default: 0
      t.integer :child_items_count , default: 0
      t.integer :childrens_count   , default: 0
      t.timestamps
    end
    add_index :categoryz3_categories, :parent_id
    add_index :categoryz3_categories, :name
  end
end
