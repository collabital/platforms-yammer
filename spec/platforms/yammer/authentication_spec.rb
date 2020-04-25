require 'rails_helper'
require 'platforms/yammer/authentication'
require 'support/examples/identity'
require 'support/contexts/omniauth_env'
require 'support/contexts/save_identity'
require 'support/contexts/switch_identity'

module Platforms
  module Yammer

    class AnonymousController < ApplicationController; end

    # Test this in the context of a controller, with env
    RSpec.describe AnonymousController, type: :controller do
      subject { response.body }

      controller do
        include Platforms::Yammer::Authentication

        def set_token_spec
          set_token
          render :plain => @token
        end

        def client_spec
          set_token
          client
          render :plain => "#{@client.inspect}"
        end

        # Need to turn of group_memberships by params
        def save_identity_spec
          skip_groups = params[:groups] == "0"
          set_token
          if skip_groups
            save_identity false
          else
            save_identity
          end
          render :plain => "#{@platforms_user.inspect}"
        end

        # Need to turn of group_memberships by params
        def switch_identity_spec
          skip_groups = params[:groups] == "0"
          client = Platforms::Yammer::Client.new("shakenn0tst1rr3d")
          if skip_groups
            switch_identity client, "spyagency", false
          else
            switch_identity client, "spyagency"
          end
          render :plain => "#{@platforms_user.inspect}"
        end
      end

      describe "#set_token" do
        include_context "omniauth env"

        it "sets @token" do
          routes.draw { get "set_token_spec" => "platforms/yammer/anonymous#set_token_spec" }
          get :set_token_spec
          expect(response.body).to eq "shakenn0tst1rr3d"
        end
      end

      describe "#client" do
        include_context "omniauth env"

        it "sets @client" do
          client = "#<Platforms::Yammer::Client> Stub"
          routes.draw { get "client_spec" => "platforms/yammer/anonymous#client_spec" }
          allow(Client).to receive(:new).with("shakenn0tst1rr3d").and_return(client)

          get :client_spec
          expect(response.body).to eq client.inspect
        end
      end

      describe "#save_identity" do
        include_context "omniauth env"
        include_context "#save_identity"

        before :each do
          routes.draw do
            get "save_identity_spec" => "platforms/yammer/anonymous"
          end
        end

        describe "API responding" do
          include_context "#save_identity networks/current.json"

          describe "no existing User, Network" do

            describe "with group creation" do
              include_context "#save_identity users/current.json"

              describe "model counts" do
                it { expect { subject }.to change { Platforms::User.count        }.from(0).to(1) }
                it { expect { subject }.to change { Platforms::Network.count     }.from(0).to(2) }
                it { expect { subject }.to change { Platforms::Group.count       }.from(0).to(2) }
                it { expect { subject }.to change { Platforms::GroupMember.count }.from(0).to(2) }
              end
              it_behaves_like "#save_identity User and Network"
              it_behaves_like "#save_identity Groups"
            end

            describe "without group creation" do
              let(:group_params) { { groups: '0' } }

              describe "model counts" do
                it { expect { subject }.to change { Platforms::User.count            }.from(0).to(1) }
                it { expect { subject }.to change { Platforms::Network.count         }.from(0).to(2) }
                it { expect { subject }.not_to change { Platforms::Group.count       }               }
                it { expect { subject }.not_to change { Platforms::GroupMember.count }               }
              end
              it_behaves_like "#save_identity User and Network"
            end
          end

          describe "one existing User, Network" do
            # User also creates Network
            let(:user) { FactoryBot.create(:user) }

            describe "one existing Group, GroupMember" do

              before :each do
                group = FactoryBot.build(:group, platforms_network: user.platforms_network)
                group.save!
                member = FactoryBot.build(:group_member, platforms_group: group, platforms_user: user)
                member.save!
              end
              describe "with group creation" do
                include_context "#save_identity users/current.json"

                describe "model counts" do
                  it { expect { subject }.not_to change { Platforms::User.count        }               }
                  it { expect { subject }.to change     { Platforms::Network.count     }.from(1).to(2) }
                  it { expect { subject }.to change     { Platforms::Group.count       }.from(1).to(2) }
                  it { expect { subject }.to change     { Platforms::GroupMember.count }.from(1).to(2) }
                end

                it_behaves_like "#save_identity User and Network"
                it_behaves_like "#save_identity updates User and Network"
                it_behaves_like "#save_identity Groups"
              end

              describe "without group creation" do
                let(:group_params) { { groups: '0' } }

                describe "model counts" do
                  it { expect { subject }.not_to change { Platforms::User.count        }               }
                  it { expect { subject }.to change     { Platforms::Network.count     }.from(1).to(2) }
                  it { expect { subject }.not_to change { Platforms::Group.count       }               }
                  it { expect { subject }.not_to change { Platforms::GroupMember.count }               }
                end
                it_behaves_like "#save_identity User and Network"
                it_behaves_like "#save_identity updates User and Network"
              end

              describe "delete one GroupMember" do
                include_context "#save_identity users/current.json"

                let(:group_del) do
                  group = FactoryBot.build(:group, :missing, platforms_network: user.platforms_network)
                  group.save!
                  group
                end

                before :each do
                  member_del = FactoryBot.build(:group_member, platforms_group: group_del, platforms_user: user)
                  member_del.save!
                end

                describe "model counts" do
                  it { expect { subject }.not_to change { Platforms::User.count        }               }
                  it { expect { subject }.to change     { Platforms::Network.count     }.from(1).to(2) }
                  it { expect { subject }.to change     { Platforms::Group.count       }.from(2).to(3) }
                  # Group Memberships should stay the same (1 new, 1 deleted)
                  it { expect { subject }.not_to change { Platforms::GroupMember.count }               }
                end

                it_behaves_like "#save_identity User and Network"
                it_behaves_like "#save_identity updates User and Network"
                it_behaves_like "#save_identity Groups"
              end
            end
          end
        end

        describe "API errors" do

          describe "networks/current.json" do
            include_context "#save_identity networks/current.json failure"
            it { expect { subject }.to raise_error Faraday::UnauthorizedError }
          end

          describe "users/current.json" do
            include_context "#save_identity networks/current.json"
            include_context "#save_identity users/current.json failure"
            it { expect { subject }.to raise_error Faraday::UnauthorizedError }
          end

          describe "request to include group memberships ignored" do
            include_context "#save_identity networks/current.json"
            include_context "#save_identity users/current.json undoc"

            describe "no existing Groups" do
              describe "model counts" do
                it { expect { subject }.to change     { Platforms::User.count        }.from(0).to(1) }
                it { expect { subject }.to change     { Platforms::Network.count     }.from(0).to(2) }
                it { expect { subject }.not_to change { Platforms::Group.count       }               }
                it { expect { subject }.not_to change { Platforms::GroupMember.count }               }
              end
            end

            describe "one existing Group" do

              before(:each) do
                user = FactoryBot.create(:user)
                group = FactoryBot.build(:group, platforms_network: user.platforms_network)
                group.save!
                member = FactoryBot.build(:group_member, platforms_group: group, platforms_user: user)
                member.save!
              end

              describe "model counts" do
                it { expect { subject }.not_to change { Platforms::User.count        }               }
                it { expect { subject }.to change     { Platforms::Network.count     }.from(1).to(2) }
                it { expect { subject }.not_to change { Platforms::Group.count       }               }
                it { expect { subject }.not_to change { Platforms::GroupMember.count }               }
              end

            end
          end
        end
      end

      describe "#switch_identity" do
        include_context "omniauth env"
        include_context "#switch_identity"

        before(:each) do
          routes.draw do
            get "switch_identity_spec" => "platforms/yammer/anonymous"
          end
        end

        describe "API responding" do
          include_context "#switch_identity oauth/tokens.json"

          let!(:spyagency) { FactoryBot.create(:network, :alternate) }

          before :each do
            # Create both Networks, as would be expected
            network = FactoryBot.create(:network)
            user = FactoryBot.build(:user, platforms_network: network)
            user.save!
          end

          describe "no existing switch User" do

            describe "with group creation" do
              include_context "#switch_identity users/current.json"

              describe "model counts" do
                it { expect { subject }.to change     { Platforms::User.count        }.from(1).to(2) }
                it { expect { subject }.not_to change { Platforms::Network.count     }               }
                it { expect { subject }.to change     { Platforms::Group.count       }.from(0).to(2) }
                it { expect { subject }.to change     { Platforms::GroupMember.count }.from(0).to(2) }
              end
              it_behaves_like "#switch_identity User and Network"
              it_behaves_like "#switch_identity Groups"
            end

            describe "without group creation" do
              include_context "#switch_identity users/current.json nogroup"
              let(:group_params) { { groups: '0' } }

              describe "model counts" do
                it { expect { subject }.to change { Platforms::User.count            }.from(1).to(2) }
                it { expect { subject }.not_to change { Platforms::Network.count     }               }
                it { expect { subject }.not_to change { Platforms::Group.count       }               }
                it { expect { subject }.not_to change { Platforms::GroupMember.count }               }
              end
              it_behaves_like "#switch_identity User and Network"
            end
          end

          describe "existing switch User" do
            # User also creates Network
            let(:user) do
              user = FactoryBot.build(:user, platforms_network: spyagency, platform_id: 234007)
              user.save!
              user
            end

            describe "one existing Group, GroupMember" do

              before :each do
                group = FactoryBot.build(:group, :mi5, platforms_network: user.platforms_network)
                group.save!
                member = FactoryBot.build(:group_member, platforms_group: group, platforms_user: user)
                member.save!
              end


              describe "with group creation" do
                include_context "#switch_identity users/current.json"

                describe "model counts" do
                  it { expect { subject }.not_to change { Platforms::User.count        }               }
                  it { expect { subject }.not_to change { Platforms::Network.count     }               }
                  it { expect { subject }.to change     { Platforms::Group.count       }.from(1).to(2) }
                  it { expect { subject }.to change     { Platforms::GroupMember.count }.from(1).to(2) }
                end

                it_behaves_like "#switch_identity User and Network"
                it_behaves_like "#switch_identity updates User"
                it_behaves_like "#switch_identity Groups"
              end

              describe "without group creation" do
                include_context "#switch_identity users/current.json nogroup"
                let(:group_params) { { groups: '0' } }

                describe "model counts" do
                  it { expect { subject }.not_to change { Platforms::User.count        }               }
                  it { expect { subject }.not_to change { Platforms::Network.count     }               }
                  it { expect { subject }.not_to change { Platforms::Group.count       }               }
                  it { expect { subject }.not_to change { Platforms::GroupMember.count }               }
                end
                it_behaves_like "#switch_identity User and Network"
                it_behaves_like "#switch_identity updates User"
              end

              describe "delete one GroupMember" do
                include_context "#switch_identity users/current.json"

                let(:group_del) do
                  group = FactoryBot.build(:group, :mi5, :missing, platforms_network: user.platforms_network)
                  group.save!
                  group
                end

                before :each do
                  member_del = FactoryBot.build(:group_member, platforms_group: group_del, platforms_user: user)
                  member_del.save!
                end

                describe "model counts" do
                  it { expect { subject }.not_to change { Platforms::User.count        }               }
                  it { expect { subject }.not_to change { Platforms::Network.count     }               }
                  it { expect { subject }.to change     { Platforms::Group.count       }.from(2).to(3) }
                  # Group Memberships should stay the same (1 new, 1 deleted)
                  it { expect { subject }.not_to change { Platforms::GroupMember.count }               }
                end

                it_behaves_like "#switch_identity User and Network"
                it_behaves_like "#switch_identity updates User"
                it_behaves_like "#switch_identity Groups"
              end
            end
          end
        end

        describe "non-existent permalink request" do
          include_context "#switch_identity oauth/tokens.json missing"
          it { expect { subject }.to raise_error ::ActiveRecord::RecordNotFound }
        end

        describe "API errors" do

          describe "oauth/tokens.json" do
            include_context "#switch_identity oauth/tokens.json failure"
            it { expect { subject }.to raise_error Faraday::UnauthorizedError }
          end

          describe "users/current.json" do
            include_context "#switch_identity oauth/tokens.json"
            include_context "#switch_identity users/current.json failure"

            describe "without models" do
              it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
            end

            describe "with models" do
              let!(:spyagency) { FactoryBot.create(:network, :alternate) }
              it { expect { subject }.to raise_error Faraday::UnauthorizedError }
            end
          end

          describe "request to include group memberships ignored" do
            include_context "#switch_identity oauth/tokens.json"
            include_context "#switch_identity users/current.json undoc"

            let!(:mi6_user)  { FactoryBot.create(:user) }
            let!(:spyagency) { FactoryBot.create(:network, :alternate) }

            it "logs a Warning" do
              expect(Rails.logger).to receive(:warn).
                with("No Group membership data from users/current.json").
                once
              subject
            end

            describe "no existing Groups" do
              describe "model counts" do
                it { expect { subject }.to change     { Platforms::User.count        }.from(1).to(2) }
                it { expect { subject }.not_to change { Platforms::Network.count     }               }
                it { expect { subject }.not_to change { Platforms::Group.count       }               }
                it { expect { subject }.not_to change { Platforms::GroupMember.count }               }
              end
            end

            describe "one existing Group, GroupMember" do

              let(:user) do
                user = FactoryBot.build(:user, platforms_network: spyagency, platform_id: 234007)
                user.save!
                user
              end

              before(:each) do
                group = FactoryBot.build(:group, :mi5, platforms_network: user.platforms_network)
                group.save!
                member = FactoryBot.build(:group_member, platforms_group: group, platforms_user: user)
                member.save!
              end

              describe "model counts" do
                # No new Users are created
                it { expect { subject }.not_to change { Platforms::User.count        } }
                # No new Networks are created
                it { expect { subject }.not_to change { Platforms::Network.count     } }
                # Groups are left alone
                it { expect { subject }.not_to change { Platforms::Group.count       } }
                # GroupMembers are left alone
                it { expect { subject }.not_to change { Platforms::GroupMember.count } }
              end
            end

          end
        end
      end
    end
  end
end
