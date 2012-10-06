require 'spec_helper'

module Categoryz3
  describe ChildItem do
    let(:item) { FactoryGirl.create(:item) }
    let(:child_item) { FactoryGirl.create(:child_item) }

    context "validations" do
      context "category" do
        it "should be invalid if category is not in master_item.category.path" do
          child_item = FactoryGirl.build(:child_item)
          item       = FactoryGirl.build(:item)
          child_item.master_item = item
          child_item.should_not be_valid
        end

        it "should be valid if category and master_item.category are the same" do
          category = FactoryGirl.build(:category)
          item     = FactoryGirl.build(:item, category: category)
          child_item = FactoryGirl.build(:child_item, category: category)
          child_item.master_item = item
          child_item.should be_valid
        end
      end
    end

  end
end
