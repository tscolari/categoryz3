require 'spec_helper'

module Categoryz3
  describe Category do

    let(:category) { FactoryGirl.create(:category) }

    context "parent association" do
      it "should have an association with category as parent" do
        child_category = FactoryGirl.create(:category, :child, parent: category) 
        child_category.parent.should == category
      end

      it "should list children categories" do
        children = FactoryGirl.create_list(:category, 5, :child, parent: category)
        category.children.should =~ children
      end
    end

    context "path listing" do
      it "should list the category path" do
        first_level_category = FactoryGirl.create(:category, :child, parent: category)
        second_level_category = FactoryGirl.create(:category, :child, parent: first_level_category)
        third_level_category = FactoryGirl.create(:category, :child, parent: second_level_category)
        third_level_category.path.should == [category, first_level_category, second_level_category, third_level_category]
        second_level_category.path.should == [category, first_level_category, second_level_category]
        first_level_category.path.should == [category, first_level_category]
        category.path.should == [category]
      end
    end

    context "scopes" do
      it "should list only parent categories" do
        categories = FactoryGirl.create_list(:category, 5)
        subcategories = FactoryGirl.create_list(:category, 5, :child, parent: categories.first)
        Category.parent_categories.all.should =~ categories
      end
    end

  end
end
