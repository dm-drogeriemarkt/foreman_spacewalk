FactoryBot.modify do
  factory :smart_proxy do
    trait :spacewalk do
      features { |sp| [sp.association(:feature, :spacewalk)] }
    end
  end
end
