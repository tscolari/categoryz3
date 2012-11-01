require 'spec_helper'

module Categoryz3
  describe Category do

    let(:category) { FactoryGirl.build(:category) }

    context "parent association" do
      it "should have an association with category as parent" do
        child_category = FactoryGirl.build(:category, :child, parent: category) 
        child_category.parent.should == category
      end

      it "should list children categories" do
        children = FactoryGirl.create_list(:category, 5, :child, parent: category)
        category.children.should =~ children
      end
    end

    context "path listing" do
      it "should list the category path" do
        first_level_category = FactoryGirl.build(:category, :child, parent: category)
        second_level_category = FactoryGirl.build(:category, :child, parent: first_level_category)
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

    context "moving category from parent" do
      context "with child categories" do
        let(:child_category_1) { FactoryGirl.create(:category, :child, parent: category         , name: 'child_1') }
        let(:child_category_2) { FactoryGirl.create(:category, :child, parent: child_category_1 , name: 'child_2') }
        let(:child_category_3) { FactoryGirl.create(:category, :child, parent: child_category_2 , name: 'child_3') }

        before(:each) do
          FactoryGirl.create(:item, category: child_category_2)
          FactoryGirl.create(:item, category: child_category_3)
        end

        it "should chain reprocess all child categories" do
          category.child_items.count.should eq 2
          new_root_category       = FactoryGirl.create(:category, name: 'new_root')
          child_category_2.parent = new_root_category
          child_category_2.save

          category.reload
          child_category_1.reload
          child_category_2.reload
          new_root_category.reload

          category.child_items.count.should eq 0
          child_category_1.child_items.count.should eq 0
          child_category_2.child_items.count.should eq 2
          child_category_3.child_items.count.should eq 1
          new_root_category.child_items.count.should eq 2
        end
      end


    end

  end
end
