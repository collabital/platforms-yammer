RSpec.shared_context "#save_identity networks/current.json" do
  let(:http_network_response) do
    {
      status: 200,
      body: [
        {
          id: 44007,
          is_freemium: false,
          name: "MI6",
          permalink: "bond.com"
        },
        {
          id: 44009,
          is_freemium: false,
          name: "MI5",
          permalink: "spyagency"
        }
      ].to_json,
      headers: {
        "Content-type": "application/json"
      }
    }
  end

  before :each do
    stub_request(:get, "https://www.yammer.com/api/v1/networks/current.json").
      with(
        {
          headers: { 'Authorization' => 'Bearer shakenn0tst1rr3d' }
        }
    ).
    to_return(http_network_response)
  end
end

RSpec.shared_context "#save_identity networks/current.json failure" do
  include_context "#save_identity networks/current.json" do
    let(:http_network_response) do
      {
        status: 401,
        body: "Not Authorized"
      }
    end
  end
end
