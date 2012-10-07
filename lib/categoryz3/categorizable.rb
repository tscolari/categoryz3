module Categoryz3
  # Adds the categorizable behavior to models
  #
  # This will give the model 2 scopes:
  #
  #   * inside_category(category) : Filter objects that belongs to the category or any of it's subcategories
  #   * having_category(category) : Filter objects that belongs only to the category
  #
  # And 2 new relations:
  #
  #   * direct_category_items : This maps the model to the categories it is directly linked
  #   * child_category_items : This is an auxiliary relation to fast map the objet to any subcategory
  #
  module Categorizable
    extend ActiveSupport::Concern
    included do
      has_many :direct_category_items , class_name: 'Categoryz3::Item'      , as: :categorizable
      has_many :child_category_items  , class_name: 'Categoryz3::ChildItem' , as: :categorizable
      scope :inside_category , ->(category) { joins(:child_category_items).where('categoryz3_child_items.category_id = ?' , category.id) }
      scope :having_category , ->(category) { joins(:direct_category_items).where('categoryz3_items.category_id = ?'      , category.id) }
    end

    # Public: List all object categories
    # Categories are retrieved from direct_category_items association, no subcategories included
    #
    def categories
      return @categories if @categories
      category_ids = direct_category_items.all.map { |category| category.id }
      @categories = Categoryz3::Category.where(id: category_ids)
    end

    # Public: Adds a category, or categories, to the model
    #
    # Examples:
    #
    #   categorizable_object.category = dummy_category
    #   categorizable_object.categories = [dummy_category1, dummy_category2]
    #
    def category=(categories)
      self.direct_category_items.destroy_all
      [categories].flatten.each do |category|
        category.direct_items.create(categorizable: self) if category
      end
      @categories = nil
    end
    alias_method :categories=, :category=

    # Public: Removes a category, or categories, from the model
    #
    # Examples:
    #
    #   categorizable_object.remove_category dummy_category
    #   categorizable_object.remove_categories dummy_category1, dummy_category2
    #
    def remove_category(*categories)
      categories.each do |category|
        direct_category_items.where(category_id: category).destroy_all
      end
      @categories = nil
    end
    alias_method :remove_categories, :remove_category

    # Public: Returns the id list of the categories linked to the model
    #
    def categories_list
      categories.map(&:id).join(",")
    end

    # Public: Accepts an array of category ids as parameter and adds all
    # of them to the model
    #
    def categories_list=(ids)
      ids = ids.is_a?(String) ? ids.split(',') : ids
      self.categories = ids.map do |id|
        Category.where(id: id).first
      end
    end

  end
end
