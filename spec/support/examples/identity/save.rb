RSpec.shared_examples "#save_identity User and Network" do
  before(:each) { subject }

  describe "Platforms::User 123007" do
    let(:model) { Platforms::User.find_by(platform_id: 123007) }

    it { expect(model.name).to        eq "James Bond" }
    it { expect(model.platform_id).to eq "123007" }
    it { expect(model.platforms_network.platform_id).to eq "44007" }
  end

  describe "Platforms::Network 44007" do
    let(:model) { Platforms::Network.find_by(platform_id: 44007) }

    it { expect(model.name).to          eq "MI6" }
    it { expect(model.permalink).to     eq "bond.com" }
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

RSpec.shared_examples "#save_identity Groups" do
  before(:each) { subject }

  let(:model) do
    Platforms::GroupMember.
      joins(:platforms_user, :platforms_group).
      where(platforms_groups: { platform_id: model_group_id }, platforms_users: { platform_id: 123007 })
  end

  describe "Platforms::Group model Group 207007" do
    let(:model_group_id) { 207007 }
    it { expect(model.count).to eq 1 }
  end

  describe "Platforms::Group model Group 208007" do
    let(:model_group_id) { 208007 }
    it { expect(model.count).to eq 1 }
  end

  describe "Platforms::Group NOT model Group 209007" do
    let(:model_group_id) { 209007 }
    it { expect(model.count).to eq 0 }
  end

end

RSpec.shared_examples "#save_identity updates User and Network" do
  describe "Platforms::User 123007" do
    it "changes name" do
      expect { subject }.to change { 
        Platforms::User.find_by(platform_id: 123007).name
      }.
      from("Joe Bloggs").to("James Bond")
    end
  end

  describe "Platforms::Network 44007" do
    it "changes permalink" do 
      expect { subject }.to change {
        Platforms::Network.find_by(platform_id: 44007).permalink
      }.
      from("mi6.gov.uk").to("bond.com")
    end 
  end
end
