RSpec.shared_examples "api DELETE" do 

  describe "custom options" do

    before do 
      options.merge! custom: "optionValue"
      subject
    end

    it "passes through custom options" do
      expect(WebMock).to have_requested(:any, /yammer.com/)
        .with(query: hash_including({"custom" => "optionValue"})).once
    end

    it "typically empty response" do
      expect(subject.body).to be_empty
    end

  end

end
