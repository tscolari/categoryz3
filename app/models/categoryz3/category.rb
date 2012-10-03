module Categoryz3
  class Category < ActiveRecord::Base
    belongs_to :parent, class_name: 'Categoryz3::Category', includes: [:parent]
    has_many :children, class_name: 'Categoryz3::Category', foreign_key: :parent_id

    validates :name, presence: true

    has_many :direct_items, class_name: 'Categoryz3::Item'
    has_many :child_items, class_name: 'Categoryz3::ChildItem'

    scope :parent_categories, -> { where(parent_id: nil) }
  end
end
