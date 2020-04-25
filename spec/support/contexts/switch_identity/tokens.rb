RSpec.shared_context "#switch_identity oauth/tokens.json" do
  let(:http_token_permalink) { "spyagency" }
  let(:http_token_response) do
    {
      status: 200,
      body: [
        {
          network_permalink: "bond.com",
          token: "shakenn0tst1rr3d",
          user_id: 123007
        },
        {
          network_permalink: http_token_permalink,
          token: "payAtt3nt10n",
          user_id: 234007
        }
      ].to_json,
      headers: {
        "Content-type": "application/json"
      }
    }
  end

  before :each do
    stub_request(:get, "https://www.yammer.com/api/v1/oauth/tokens.json").
      with({ headers: { 'Authorization' => 'Bearer shakenn0tst1rr3d' } }).
      to_return(http_token_response)
  end
end

RSpec.shared_context "#switch_identity oauth/tokens.json missing" do
  include_context "#switch_identity oauth/tokens.json" do
    let(:http_token_permalink) { "kgb" }
  end
end

RSpec.shared_context "#switch_identity oauth/tokens.json failure" do
  include_context "#switch_identity oauth/tokens.json" do
    let(:http_token_response) do
      {
        status: 401,
        body: "Not Authorized"
      }
    end
  end
end
