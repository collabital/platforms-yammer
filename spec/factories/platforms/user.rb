FactoryBot.define do
  factory :user, class: "Platforms::User" do
    name          { "Joe Bloggs" }
    platform_id   { "123007" }
    thumbnail_url { "http://mypic" }
    web_url       { "http://myprofile" }
    email         { "joe@bloggs.com" }
    admin         { false }

    association :platforms_network, factory: :network

    trait :alternate do
      platform_id { "11" }
    end
  end
end
