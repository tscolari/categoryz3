FactoryGirl.define do

  factory :child_item, class: 'Categoryz3::ChildItem' do
    association :category
    association :categorizable, factory: :dummy_object
    master_item { |f| FactoryGirl.build(:item, category: f.category) }
  end

end
