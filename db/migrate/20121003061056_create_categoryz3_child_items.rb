class CreateCategoryz3ChildItems < ActiveRecord::Migration
  def change
    create_table :categoryz3_child_items do |t|
      t.references :category, null: false
      t.references :categorizable, polymorphic: true, null: false
      t.references :master_item, null: false
      t.timestamps
    end
    add_index :categoryz3_child_items, [:category_id, :created_at]
    add_index :categoryz3_child_items, [:category_id, :categorizable_type, :categorizable_id, :master_item_id], unique: true, name: 'child_items_unq_idx'
    add_index :categoryz3_child_items, [:categorizable_type, :categorizable_id], name: 'child_items_categorizable_idx'
    add_index :categoryz3_child_items, [:master_item_id]
  end
end
