require 'spec_helper'

describe DummyObject do
  let(:category)     { FactoryGirl.create(:category) }
  let(:category2)    { FactoryGirl.create(:category) }
  let(:child_category1) { FactoryGirl.create(:category, parent: category) }
  let(:child_category2) { FactoryGirl.create(:category, parent: category2) }
  let(:dummy_object) { FactoryGirl.create(:dummy_object) }

  context "adding and removing categories" do
    describe "#category=" do
      it "should add a category to categorizable" do
        dummy_object.categories << category
        dummy_object.categories.include?(category).should be_true
      end

      it "should add more than one category to categorizable" do
        categories = FactoryGirl.create_list(:category, 3)
        dummy_object.categories << [categories[0], categories[1], categories[2]]
        categories.each do |category|
          dummy_object.categories.include?(category).should be_true
        end
      end

      it "should replace existing categories" do
        dummy_object.categories << category
        dummy_object.categories.include?(category).should be_true
        dummy_object.reload
        dummy_object.categories = [category2]
        dummy_object.categories.include?(category).should be_false
        dummy_object.categories.include?(category2).should be_true
      end
    end

    describe "#categories_list=" do
      it "should receive a string with ids and insert them as categories to the model" do
        dummy_object.categories_list = "#{category.id}, #{category2.id}"
        dummy_object.categories.all.should =~ [category, category2]
      end

      it "should replace the model categories" do
        dummy_object.categories << category
        dummy_object.reload
        dummy_object.categories_list = "#{category2.id}"
        dummy_object.categories.all.should =~ [category2]
      end
    end

    describe "#remove_category" do
      before(:each) do
        dummy_object.categories << category
      end

      it "should remove a category from the object" do
        dummy_object.categories.all.include?(category).should be_true
        dummy_object.remove_category category
        dummy_object.reload
        dummy_object.categories.all.include?(category).should be_false
      end

      it "should remove a list of categories from the object" do
        dummy_object.categories << category2
        dummy_object.categories.all.include?(category).should be_true
        dummy_object.categories.all.include?(category2).should be_true
        dummy_object.remove_category category, category2
        dummy_object.reload
        dummy_object.categories.all.include?(category).should be_false
        dummy_object.categories.all.include?(category2).should be_false
      end
    end
  end

  describe "#root_categories" do
    it "should list all categories that are connected, and have parent -> nil" do
      dummy_object.categories << child_category1
      dummy_object.categories << child_category2
      dummy_object.root_categories.all.should =~ [category, category2]
    end
  end

  context "scopes" do
    describe "#inside_category" do
      it "should only find items from the category" do
        correct_dummy_list = FactoryGirl.create_list(:dummy_object, 4)
        correct_dummy_list.each { |dummy| dummy.categories << category }
        wrong_dummy_list = FactoryGirl.create_list(:dummy_object, 4)
        dummy_matches = DummyObject.inside_category(category).all
        dummy_matches.should =~ correct_dummy_list
        dummy_matches.should_not =~ wrong_dummy_list
      end

      it "should list items from all subcategories" do
        wrong_dummy_list   = FactoryGirl.create_list(:dummy_object, 4)
        correct_dummy_list = FactoryGirl.create_list(:dummy_object, 4)
        subcategory        = FactoryGirl.create(:category, :child, parent: category)
        correct_dummy_list.each { |dummy| dummy.categories << subcategory }
        dummy_matches = DummyObject.inside_category(category).all
        dummy_matches.should =~ correct_dummy_list
        dummy_matches.should_not =~ wrong_dummy_list
      end
    end

    describe "#having_category" do
      it "should only find items from the category" do
        correct_dummy_list = FactoryGirl.create_list(:dummy_object, 4)
        correct_dummy_list.each { |dummy| dummy.categories << category }
        wrong_dummy_list = FactoryGirl.create_list(:dummy_object, 4)
        dummy_matches = DummyObject.having_category(category).all
        dummy_matches.should =~ correct_dummy_list
        dummy_matches.should_not =~ wrong_dummy_list
      end

      it "should not find items from subcategories" do
        wrong_dummy_list   = FactoryGirl.create_list(:dummy_object, 4)
        correct_dummy_list = FactoryGirl.create_list(:dummy_object, 4)
        subcategory        = FactoryGirl.create(:category, :child, parent: category)
        correct_dummy_list.each { |dummy| dummy.categories << subcategory }
        dummy_matches = DummyObject.having_category(category).all
        dummy_matches.should be_empty
      end
    end
  end

  describe "#categories_list" do
    it "should return the ids from model's categories" do
      dummy_object.categories << [category, category2]
      dummy_object.categories_list.include?(category2.id.to_s).should be_true
      dummy_object.categories_list.include?(category.id.to_s).should be_true
    end
  end



end
