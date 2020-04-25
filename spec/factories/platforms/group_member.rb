FactoryBot.define do
  factory :group_member, class: "Platforms::GroupMember" do
    association :platforms_user,  factory: :user
    association :platforms_group, factory: :group
    role { 0 }
  end
end
