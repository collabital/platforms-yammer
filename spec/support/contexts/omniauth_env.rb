RSpec.shared_context "omniauth env" do

  before :each do
    omni = OmniAuth.config.mock_auth[:yammer]

    allow(request.env).to receive(:[]).and_call_original
    allow(request.env).to receive(:[])
      .with("omniauth.auth")
      .and_return omni
  end

end

