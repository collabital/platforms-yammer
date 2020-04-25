RSpec.shared_examples "api POST" do |endpoint|

  it_behaves_like "api endpoint"

  it { expect(subject.body).to be_a Hash }
  it { expect(subject.body).to include("status" => "ok") }
  it { expect(subject.status).to eq 201 }

  describe "custom options" do
    before do 
      options.merge! custom: "optionValue"
      subject
    end
    it "passes through custom options" do
      # @see https://github.com/bblimke/webmock/wiki/RSpec-support
      # for how to set expectations in RSpec on a POST request
      expect(mock).to have_requested(:post, request_url)
        .with {
        |req| JSON.parse(req.body)["custom"] == "optionValue"
      }.once
    end
  end

end
