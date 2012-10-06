require 'spec_helper'

describe DummyObject do
  let(:category) { FactoryGirl.create(:category) }
  let(:dummy_object) { FactoryGirl.create(:dummy_object) }

  context "adding a category" do
    describe "#add_category" do
      it "should add a category to categorizable" do
        dummy_object.add_category category
        dummy_object.categories.include?(category).should be_true
      end

      it "should add more than one category to categorizable" do
        categories = FactoryGirl.create_list(:category, 3)
        dummy_object.add_category categories[0], categories[1], categories[2]
        categories.each do |category|
          dummy_object.categories.include?(category).should be_true
        end
      end
    end
  end
end
