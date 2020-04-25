RSpec.shared_context "yammer DELETE" do |endpoint|
  let(:request_url) { "https://www.yammer.com/api/v1/#{endpoint}" }
  let!(:mock) {
    stub_request(:delete, request_url).with(
      # See https://github.com/bblimke/webmock/issues/693
      query: hash_including({}),
      headers: {
        'Authorization' => 'Bearer shakenn0tst1rr3d'
      }
    ).
    to_return(status: 200, body: "", headers: {})
  }
end
