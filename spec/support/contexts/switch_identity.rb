require 'support/contexts/switch_identity/tokens'
require 'support/contexts/switch_identity/users'

RSpec.shared_context "#switch_identity" do
  let(:group_params) { {} }
  subject { get :switch_identity_spec, params: group_params }
end
