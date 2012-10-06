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

  context "scopes" do
    describe "#having_category" do
      it "should only find items from the category" do
        correct_dummy_list = FactoryGirl.create_list(:dummy_object, 4)
        correct_dummy_list.each { |dummy| dummy.add_category(category) }
        wrong_dummy_list = FactoryGirl.create_list(:dummy_object, 4)
        dummy_matches = DummyObject.having_category(category).all
        dummy_matches.should =~ correct_dummy_list
        dummy_matches.should_not =~ wrong_dummy_list
      end

      it "should list items from all subcategories" do
        wrong_dummy_list   = FactoryGirl.create_list(:dummy_object, 4)
        correct_dummy_list = FactoryGirl.create_list(:dummy_object, 4)
        subcategory        = FactoryGirl.create(:category, :child, parent: category)
        correct_dummy_list.each { |dummy| dummy.add_category(subcategory) }
        dummy_matches = DummyObject.having_category(category).all
        dummy_matches.should =~ correct_dummy_list
        dummy_matches.should_not =~ wrong_dummy_list
      end
    end
  end

end
