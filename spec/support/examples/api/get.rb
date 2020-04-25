RSpec.shared_examples "api GET" do |endpoint|

  it_behaves_like "api endpoint"

  it { expect(subject.body).to be_a Hash }
  it { expect(subject.body).to include("status" => "ok") }
  it { expect(subject.status).to eq 200 }

  describe "custom options" do
    before do 
      options.merge! custom: "optionValue"
      subject
    end
    it "passes through custom options" do
      expect(mock).to have_requested(:get, request_url)
        .with(query: hash_including({"custom" => "optionValue"})).once
    end
  end

end
