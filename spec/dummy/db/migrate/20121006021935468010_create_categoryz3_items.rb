class CreateCategoryz3Items < ActiveRecord::Migration
  def change
    create_table :categoryz3_items do |t|
      t.references :category, null: false
      t.references :categorizable, polymorphic: true, null: false
      t.timestamps
    end
    add_index :categoryz3_items, [:category_id, :categorizable_type, :categorizable_id], unique: true, name: 'items_unq_idx'
    add_index :categoryz3_items, [:category_id, :created_at]
    add_index :categoryz3_items, [:categorizable_type, :categorizable_id], name: 'items_categorizable_idx'
  end
end
