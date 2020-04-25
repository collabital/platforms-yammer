OmniAuth.config.test_mode = true
OmniAuth.config.logger = Rails.logger

# Syntax of Yammer's auth response is correct as at March 2020.

OmniAuth.config.mock_auth[:yammer] = OmniAuth::AuthHash.new({
  credentials: OmniAuth::AuthHash.new({
    expires: false,
    token: "shakenn0tst1rr3d"
  }),
  extra: OmniAuth::AuthHash.new({
    raw_info:OmniAuth::AuthHash.new({
      aad_guest:false,
      activated_at: "2010/01/01 08:00:00 +0000",
      admin:"true",
      age_bucket: "notRequired",
      auto_activated: false,
      can_broadcast: "true",
      can_browse_external_networks:true,
      can_create_new_network:true,
      contact: OmniAuth::AuthHash.new({
        email_addresses: Hashie::Array.new([
          OmniAuth::AuthHash.new({
            address: "james@bond.com",
            type: "primary"
          })
        ]),
        has_fake_email: false,
        im: OmniAuth::AuthHash.new({
          provider: "aim"
        }),
        phone_numbers: Hashie::Array.new([
          OmniAuth::AuthHash.new({
            number:"+44 999",
            type:"mobile"
          })
        ]),
        email: "james@bond.com",
        first_name:"James",
        follow_general_messages:false,
        full_name: "James Bond",
        guest:false,
        id: 123007,
        job_title:"00 Agent",
        last_name:"Bond",
        location:"London",
        mugshot_url:"https://mug0.assets-yammer.com/mugshot/images/48x48/mi6jamesbond",
        mugshot_url_template:"https://mug0.assets-yammer.com/mugshot/images/{width}x{height}/mi6mugshots",
        name: "jbond",
        network_domains: Hashie::Array.new([
          "bond.com",
          "007.org"
        ])
      }),
      network_id: 44007,
      network_name:"MI6",
      o365_tenant_admin:"true",
      show_ask_for_photo: false,
      show_invite_lightbox: false,
      state: "active",
      stats: OmniAuth::AuthHash.new({
        followers: 42,
        following: 57,
        updates: 0
      }),
      supervisor_admin: "false",
      timezone: "GMT",
      type: "user",
      url: "https://www.yammer.com/api/v1/users/123007",
      verified_admin: "true",
      web_preferences: OmniAuth::AuthHash.new({
        absolute_timestamps:false,
        dismissed_apps_tooltip:true,
        dismissed_feed_tooltip:false,
        dismissed_group_tooltip:false,
        dismissed_invite_tooltip:true,
        dismissed_invite_tooltip_at: "2010/02/01 08:00:00 +0000",
        dismissed_profile_prompt:false,
        enable_chat:"true",
        enter_does_not_submit_message:"true",
        has_mobile_client:true,
        has_yammer_now:false,
        locale:"en-US",
        make_yammer_homepage:true,
        network_settings: OmniAuth::AuthHash.new({
          admin_can_delete_messages:"true",
          allow_attachments:"true",
          allow_external_sharing:true,
          allow_inline_document_view:true,
          allow_yammer_apps:true,
          attachment_types_allowed:"ALL",
          enable_chat:true,
          enable_groups:true,
          enable_private_messages:true,
          message_prompt:"What are you working on?",
          show_communities_directory:true
        }),
        prefer_modern_client:false,
        preferred_my_feed:"algo",
        prescribed_my_feed:"algo",
        sticky_my_feed:false
      }),
      web_url:"https://www.yammer.com/bond.com/users/123007"
    })
  }),
  info: OmniAuth::AuthHash::InfoHash.new({
    description: "00 Agent",
    email: "james@bond.com",
    image: "https://mug0.assets-yammer.com/mugshot/images/48x48/mi6jamesbond",
    location: "London",
    name: "James Bond",
    nickname: "jbond",
    urls: OmniAuth::AuthHash.new({
      yammer:"https://www.yammer.com/bond.com/users/123007"
    })
  }),
  provider:"yammer",
  uid: 123007
})
