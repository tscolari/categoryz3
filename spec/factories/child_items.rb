FactoryGirl.define do

  factory :child_item, class: 'Categoryz3::ChildItem' do
    association :category
    association :categorizable, factory: :dummy_object
  end

end
