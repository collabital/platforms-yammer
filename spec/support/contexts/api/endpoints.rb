RSpec.shared_context "API endpoints" do
  let(:token)      { "shakenn0tst1rr3d" }
  let(:client)     { ::Platforms::Yammer::Client.new token }
  let(:connection) { client.connection }
  let(:options)    { {} }
  let(:headers)    { {} }
  let(:api) { described_class.new connection }
end
