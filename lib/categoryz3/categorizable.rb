module Categoryz3
  module Categorizable
    extend ActiveSupport::Concern
    included do
      has_many :direct_category_items , class_name: 'Categoryz3::Item'      , as: :categorizable
      has_many :child_category_items  , class_name: 'Categoryz3::ChildItem' , as: :categorizable
      scope :having_category        , ->(category) { joins(:child_category_items).where('categoryz3_child_items.category_id = ?' , category.id) }
      scope :having_direct_category , ->(category) { joins(:direct_category_items).where('categoryz3_items.category_id = ?'      , category.id) }
    end

    def categories
      category_ids = direct_category_items.all.map { |category| category.id }
      Categoryz3::Category.where(id: category_ids)
    end

    def add_category(*categories)
      categories.each do |category|
        category.direct_items.create(categorizable: self)
      end
    end

  end
end
