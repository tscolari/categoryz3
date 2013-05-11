module Categoryz3
  class Item < ActiveRecord::Base
    belongs_to :category, inverse_of: :direct_items, counter_cache: 'items_count'
    belongs_to :categorizable, polymorphic: true, inverse_of: :direct_category_items
    has_many   :child_items, foreign_key: 'master_item_id', inverse_of: :master_item, dependent: :destroy

    validates :category, :categorizable, presence: true
    validates :category_id, uniqueness: { scope: [:categorizable_type, :categorizable_id] }

    after_create :create_child_items

    # Public: Destroy the child items and recreate them
    #
    def reprocess_child_items!
      self.child_items.destroy_all
      create_child_items
    end

    private

    # Private: Creates a child item for the category
    #
    def create_child_item_for_category(category)
      category.child_items.find_or_create_by(categorizable_type: self.categorizable.class.base_class.name, categorizable_id: self.categorizable.id, master_item_id: self.id)
    end

    # Private: Create a child_item for each subcategory the category from this item have
    # Also creates a child_item for this category
    #
    def create_child_items
      self.category.path.each do |parent_category|
        create_child_item_for_category parent_category
      end
    end

  end
end
