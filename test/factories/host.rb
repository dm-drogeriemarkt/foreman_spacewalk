FactoryBot.modify do
  factory :host do
    trait :with_spacewalk do
      spacewalk_proxy do
        FactoryBot.create(:smart_proxy, :spacewalk)
      end
    end
  end
end
