FactoryBot.define do
  factory :group, class: "Platforms::Group" do

    transient do
      group_prefix { "20" }
    end

    name          { "HR" }
    platform_id   { "#{group_prefix}7007".to_i }

    trait :alternate do
      name        { "Finance" }
      platform_id { "#{group_prefix}8007".to_i }
    end

    trait :missing do
      name        { "Sales" }
      platform_id { "#{group_prefix}9007".to_i }
    end

    trait :mi5 do
      transient do
        group_prefix { "30" }
      end
    end

    association :platforms_network, factory: :network
  end
end
