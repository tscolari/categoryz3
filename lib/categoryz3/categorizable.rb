module Categoryz3
  module Categorizable
    extend ActiveSupport::Concern
    included do
      has_many :direct_category_items , class_name: 'Categoryz3::Item'      , as: :categorizable
      has_many :child_category_items  , class_name: 'Categoryz3::ChildItem' , as: :categorizable
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
