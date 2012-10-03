FactoryGirl.define do

  factory :category, class: 'Categoryz3::Category' do
    name { Faker::Name.name }

    trait :child do
      association :parent, factory: :category
    end
  end

end
