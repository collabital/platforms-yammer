
RSpec.shared_context "#save_identity users/current.json" do
  let(:http_user_response_groups) {
    {
      group_memberships: [
        {
          "id": 207007,
          "full_name": "HR",
          "web_url": "https://www.yammer.com/bond.com/#/threads/ingroup?type=in_group&feedid=207007",
          "admin": true,
        },
        {
          "id": 208007,
          "full_name": "Finance",
          "web_url": "https://www.yammer.com/bond.com/#/threads/ingroup?type=in_group&feedid=208007",
          "admin": false,
        }
      ]
    }
  }

  let(:http_user_response) do
    {
      status: 200,
      body: {
        full_name: "James Bond",
        mugshot_url: "https://mug0.assets-yammer.com/mugshot/images/48x48/mi6jamesbond",
        admin: false,
        web_url: "https://www.yammer.com/bond.com/users/123007",
        email: "james@bond.com"
      }.merge(http_user_response_groups).to_json,
      headers: {
        "Content-type": "application/json"
      }
    }
  end

  before :each do
    stub_request(:get, "https://www.yammer.com/api/v1/users/current.json").
      with(
        {
          headers: { 'Authorization' => 'Bearer shakenn0tst1rr3d' },
          query: hash_including( { include_group_memberships: "true" } )
        }
    ).
    to_return(http_user_response)
  end
end

# Include query parameter, but don't include http_user_response_groups
RSpec.shared_context "#save_identity users/current.json undoc" do
  include_context "#save_identity users/current.json" do
    let(:http_user_response_groups) { {} }
  end
end

RSpec.shared_context "#save_identity users/current.json failure" do
  include_context "#save_identity users/current.json" do
    let(:http_user_response) do
      {
        status: 401,
        body: "Not Authorized"
      }
    end
  end
end
