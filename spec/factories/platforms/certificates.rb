FactoryBot.define do
  factory :certificate, class: "Platforms::Certificate" do
    client_id     { "OAuthClientId" }
    client_secret { "OAuthClientSecret" }
    name          { "Contoso" }
    strategy      { "yammer" }

    trait :alternate do
      name { "Fabrikam" }
    end
  end
end
