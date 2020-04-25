RSpec.shared_examples "api PUT" do |endpoint|
  let(:request_url) { "https://www.yammer.com/api/v1/#{endpoint}" }

  describe "custom options" do
    before do 
      options.merge! custom: "optionValue"
      subject
    end
    it "passes through custom options" do
      # @see https://github.com/bblimke/webmock/wiki/RSpec-support
      # for how to set expectations in RSpec on a POST request
      # assume this also applies to PUT
      expect(WebMock).to have_requested(:put, request_url)
        .with {
        |req| JSON.parse(req.body)["custom"] == "optionValue"
      }.once
    end
  end

end
