RSpec.shared_examples "#switch_identity User and Network" do
  before(:each) { subject }

  describe "Platforms::User 234007" do
    let(:model) { Platforms::User.find_by(platform_id: 234007) }

    it { expect(model.name).to        eq "James Bond (MI5)" }
    it { expect(model.platform_id).to eq "234007" }
    it { expect(model.platforms_network.platform_id).to eq "44009" }
  end

  describe "Platforms::Network 44007" do
    let(:model) { Platforms::Network.find_by(platform_id: 44007) }

    it { expect(model.name).to          eq "MI6" }
    it { expect(model.permalink).to     eq "mi6.gov.uk" }
    it { expect(model.platform_type).to eq "yammer" }
    it { expect(model.trial).to         eq false }
  end

  describe "Platforms::Network 44009" do
    let(:model) { Platforms::Network.find_by(platform_id: 44009) }

    it { expect(model.name).to          eq "MI5" }
    it { expect(model.permalink).to     eq "spyagency" }
    it { expect(model.platform_type).to eq "yammer" }
    it { expect(model.trial).to         eq false }
  end

end

RSpec.shared_examples "#switch_identity Groups" do
  before(:each) { subject }

  let(:model) do
    Platforms::GroupMember.
      joins(:platforms_user, :platforms_group).
      where(platforms_groups: { platform_id: model_group_id }, platforms_users: { platform_id: 234007 })
  end

  describe "Platforms::Group model Group 307007" do
    let(:model_group_id) { 307007 }
    it { expect(model.count).to eq 1 }
  end

  describe "Platforms::Group model Group 308007" do
    let(:model_group_id) { 308007 }
    it { expect(model.count).to eq 1 }
  end

  describe "Platforms::Group NOT model Group 309007" do
    let(:model_group_id) { 309007 }
    it { expect(model.count).to eq 0 }
  end

end

RSpec.shared_examples "#switch_identity updates User" do
  describe "Platforms::User 234007" do
    it "changes name" do
      expect { subject }.to change { 
        Platforms::User.find_by(platform_id: 234007).name
      }.
      from("Joe Bloggs").to("James Bond (MI5)")
    end
  end
end
