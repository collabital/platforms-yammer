FactoryBot.define do
  factory :network, class: "Platforms::Network" do
    name          { "MI6" }
    permalink     { "mi6.gov.uk" }
    platform_id   { 44007 }
    platform_type { "yammer" }
    trial         { false }

    trait :alternate do
      name          { "MI5" }
      permalink     { "spyagency" }
      platform_id   { 44009 }
      platform_type { "yammer" }
      trial         { false }
    end
  end
end
