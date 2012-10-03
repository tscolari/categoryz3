FactoryGirl.define do

  factory :item, class: 'Categoryz3::Item' do
    association :category
    association :categorizable, factory: :dummy_object
  end

end
