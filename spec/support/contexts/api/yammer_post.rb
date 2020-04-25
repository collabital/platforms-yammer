RSpec.shared_context "yammer POST" do |endpoint|
  let(:request_url) { "https://www.yammer.com/api/v1/#{endpoint}" }
  let!(:mock) {
    stub_request(:post, request_url).with(
      headers: {
        'Authorization' => 'Bearer shakenn0tst1rr3d'
      }
    ).
    to_return(
      status: 201,
      body: {status: "ok"}.to_json,
      headers: {
        "Content-type": "application/json"
      }
    )
  }
end
