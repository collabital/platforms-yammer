require 'support/contexts/save_identity/networks'
require 'support/contexts/save_identity/users'

RSpec.shared_context "#save_identity" do
  let(:group_params) { {} }
  subject { get :save_identity_spec, params: group_params }
end
