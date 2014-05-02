module Categoryz3
  class ChildItem < ActiveRecord::Base
    belongs_to :category, inverse_of: :child_items, counter_cache: :child_items_count
    belongs_to :master_item, class_name: 'Categoryz3::Item', inverse_of: :child_items
    belongs_to :categorizable, polymorphic: true, inverse_of: :child_category_items

    validates :category, :master_item, :categorizable, presence: true
    validates :category_id, uniqueness: { scope: [:categorizable_type, :categorizable_id] }
    validates_with Categoryz3::Validators::ChildItemCategoryValidator
  end
end
