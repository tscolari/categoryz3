require 'spec_helper'

module Categoryz3
  describe Item do
    let(:category) { FactoryGirl.build(:category) }
    let(:item)     { FactoryGirl.create(:item, category: category) }

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
          count = category.child_items.count
          item.destroy
          category.reload
          category.child_items.count.should == count - 1
        end
      end

      context "multi level item" do
        let(:subcategory) { FactoryGirl.create(:category, :child, parent: FactoryGirl.create(:category, :child, parent: category))}

        it "should create child items for all subcategories when created" do
          item = FactoryGirl.create(:item, category: subcategory)
          subcategory.path.each do |category|
            child_item = category.child_items.first
            child_item.categorizable.should == item.categorizable
          end
        end

        it "should remove child items from all categories when deleted" do
          item = FactoryGirl.create(:item, category: subcategory)
          subcategory.path.each { |category| category.child_items.count.should == 1 }
          item.destroy
          subcategory.path.each { |category| category.child_items.count.should == 0 }
        end
      end

      context "reprocessing items" do
        let(:root_category) { FactoryGirl.create(:category) }
        let(:category)      { FactoryGirl.create(:category, :child, parent: root_category) }

        it "should recreate all child items on reprocess" do
          child_items = item.child_items.count
          item.child_items.each { |child_item| child_item.should_receive(:destroy).once }
          item.reprocess_child_items!
          item.child_items.count.should eq child_items
        end
      end

    end

  end
end
