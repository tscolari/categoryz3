module Categoryz3
  class Category < ActiveRecord::Base
    belongs_to :parent     , class_name: 'Categoryz3::Category'  , inverse_of: :children
    has_many :children     , class_name: 'Categoryz3::Category'  , foreign_key: :parent_id , inverse_of: :parent , dependent: :destroy
    has_many :direct_items , class_name: 'Categoryz3::Item'      , inverse_of: :category   , dependent: :destroy
    has_many :child_items  , class_name: 'Categoryz3::ChildItem' , inverse_of: :category   , dependent: :destroy
    validates :name        , presence: true
    validates_with Categoryz3::Validators::ParentCategoryValidator

    scope :root_categories,   -> { where(parent_id: nil) }
    scope :parent_categories, -> { root_categories       }
    attr_accessible :name, :parent, :parent_id
    
    before_update :mark_as_dirty_if_parent_changed
    after_update  :update_children_if_parent_changed

    # Public: Returns the full categories path from the root category until this category
    #
    # Example:
    #
    #   subcategory3.path
    #   #=> [category, subcategory1, subcategory2, subcategory3]
    #
    def path
      @path_array ||= parent ? [parent.path, self].flatten : [self]
    end

    # Public: Reprocess all items from this category
    #
    def reprocess_items!
      @path_array = nil
      self.direct_items.each { |item| item.reprocess_child_items! }
      self.children.each     { |category| category.reprocess_items! }
    end

    private

    def mark_as_dirty_if_parent_changed
      @dirty_parent = parent_id_changed?
      true
    end

    # Private: Reprocess all items in case the parent category
    #          of this category has changed.
    def update_children_if_parent_changed
      if @dirty_parent
        reprocess_items!
      end
    end

  end
end
