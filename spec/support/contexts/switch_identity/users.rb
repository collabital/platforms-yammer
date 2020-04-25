
RSpec.shared_context "#switch_identity users/current.json" do
  let(:http_user_response_groups) {
    {
      group_memberships: [
        {
          "id": 307007,
          "full_name": "HR",
          "web_url": "https://www.yammer.com/spyagency/#/threads/ingroup?type=in_group&feedid=307007",
          "admin": true,
        },
        {
          "id": 308007,
          "full_name": "Finance",
          "web_url": "https://www.yammer.com/spyagency/#/threads/ingroup?type=in_group&feedid=308007",
          "admin": false,
        }
      ]
    }
  }

  let(:http_user_response) do
    {
      status: 200,
      body: {
        full_name: "James Bond (MI5)",
        mugshot_url: "https://mug0.assets-yammer.com/mugshot/images/48x48/mi5jamesbond",
        admin: false,
        web_url: "https://www.yammer.com/spyagency/users/234007",
        email: "james@bond.com"
      }.merge(http_user_response_groups).to_json,
      headers: {
        "Content-type": "application/json"
      }
    }
  end

  let(:http_user_request_query) do
    {
      query: hash_including( { include_group_memberships: "true" } )
    }
  end

  before :each do
    stub_request(:get, "https://www.yammer.com/api/v1/users/current.json").
      with(
        { headers: { 'Authorization' => 'Bearer payAtt3nt10n' } }.
        merge(http_user_request_query)
    ).
    to_return(http_user_response)
  end
end

# Include http_user_request_query parameter, but don't include http_user_response_groups
RSpec.shared_context "#switch_identity users/current.json undoc" do
  include_context "#switch_identity users/current.json" do
    let(:http_user_response_groups) { {} }
  end
end

# Do not allow groups parameter
RSpec.shared_context "#switch_identity users/current.json nogroup" do
  include_context "#switch_identity users/current.json" do
    let(:http_user_response_groups) { {} }
    let(:http_user_request_query)   { {} }
  end
end

RSpec.shared_context "#switch_identity users/current.json failure" do
  include_context "#switch_identity users/current.json" do
    let(:http_user_response) do
      {
        status: 401,
        body: "Not Authorized"
      }
    end
  end
end
