require 'spec_helper'

module Categoryz3
  let(:category) { FactoryGirl.create(:category) }
  let(:item)     { FactoryGirl.create(:item, category: category) }

  describe Item do

    context "child items" do
      context "first level item" do
        it "should create child items when created" do
          item
          child_item = category.child_items.first
          child_item.categorizable.should == item.categorizable
          child_item.category.should == item.category
        end

        it "should remove the child items when deleted" do
          item
          category.child_items.count.should == 1
          item.destroy
          category.reload
          category.child_items.count.should == 0
        end
      end

      context "multi level item" do
        let(:subcategory) { FactoryGirl.create(:category, :child, category: FactoryGirl.create(:category, :child, category: category))}

        it "should create child items for all subcategories when created" do
          item = FactoryGirl.create(:item, category: subcategory)
          subcategory.path.each do |category|
            child_item = category.child_items.first
            child_item.dummy.should == item.dummy
          end
        end

        it "should remove child items from all categories when deleted" do
          item = FactoryGirl.create(:item, category: subcategory)
          subcategory.path.each { |category| category.child_items.count.should == 1 }
          item.destroy
          subcategory.path.each { |category| category.child_items.count.should == 0 }
        end
      end
    end

  end
end
