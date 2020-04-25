RSpec.shared_examples "api endpoint" do

  it "only sends one request" do
    subject
    expect(WebMock).to have_requested(:any, /yammer.com/).once
  end

  it "passes through Authorization header" do
    subject
    expect(WebMock).to have_requested(:any, /yammer.com/)
      .with(headers:{"Authorization" => "Bearer shakenn0tst1rr3d"}).once
  end

  describe "custom headers" do
    before do 
      headers.merge! custom: "HeaderValue"
      subject
    end
    it "passes through custom headers" do
      expect(WebMock).to have_requested(:any, /yammer.com/)
        .with(headers:{"Custom" => "HeaderValue"}).once
    end
  end

  describe "invalid Authorization response code" do
    let!(:failure) do
      stub_request(:any, /yammer.com/).with(
        headers: {
          'Authorization' => 'Bearer NotToken'
        }
      ).
      to_return(status: 401, body: "Not Authorized", headers: {})
    end

    let(:headers) { { "AUTHORIZATION" => "Bearer NotToken" } }

    it { expect { subject }.to raise_error Faraday::UnauthorizedError }
  end
end
