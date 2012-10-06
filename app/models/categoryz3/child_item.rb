module Categoryz3
  class ChildItem < ActiveRecord::Base
    belongs_to :category, inverse_of: :child_items
    belongs_to :master_item, class_name: 'Categoryz3::Item', inverse_of: :child_items
    belongs_to :categorizable, polymorphic: true

    validates_with Categoryz3::Validators::ChildItemCategoryValidator
    attr_accessible :master_item, :categorizable
  end
end
