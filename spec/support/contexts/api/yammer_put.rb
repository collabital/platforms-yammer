RSpec.shared_context "yammer PUT" do |endpoint|
  let(:request_url) { "https://www.yammer.com/api/v1/#{endpoint}" }
  let!(:mock) {
    stub_request(:put, request_url).with(
      headers: {
        'Authorization' => 'Bearer shakenn0tst1rr3d'
      }
    ).
    to_return(status: 201, body: "{}", headers: {})
  }
end
