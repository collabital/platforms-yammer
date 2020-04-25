# Platforms::Yammer

This is an easy-to-use Ruby library which takes all the hard work out of writing a Yammer App.

Platforms::Yammer supports all documented API endpoints, and has the flexibility of being able to call new, updated, or undocumented API endpoints too.

## Usage

This gem consists of two main parts. You need to have already [created an App](https://developer.yammer.com/docs/getting-started) in Yammer before using this gem.

### 1. Authentication

Assuming the "Redirect URI" for your App is `https://www.myapp.com/auth/yammer/callback`, in your routes file set that route to a controller of your choice. `SessionsController` is used in the examples below..

```ruby
# config/routes.rb

Rails.application.routes.draw do
  # ...
  match '/auth/:provider/callback', to: 'sessions#callback', via: [:get, :post]
  # ...
end
```

In the Sessions controller, include the `Platforms::Yammer::Authentication` module and call `save_identity` in the `callback` method:

```ruby
# app/controllers/sessions_controller

class SessionsController < ApplicationController
  include Platforms::Yammer::Authentication

  before_action :set_token

  def callback
    # ...
    save_identity
    # ...
  end

end
```

This will give you instance variables `@platforms_user`, `@platforms_network`, `@token`, and `@switch_network_ids`, giving you details of the Yammer user.
Some of this information will be useful to store in a [session](https://guides.rubyonrails.org/security.html#session-storage).
See {Platforms::Yammer::Authentication#save_identity} for more details.

This callback method also has access to more detailed information about the logged-in user through `request.env[omniauth.auth']`. More information about the data that is stored in that variable can be found in the OmniAuth [Auth Hash Schema](https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema) description.

Switching between Yammer Networks is achieved through {Platforms::Yammer::Authentication#switch_identity}, which is treated as a regular API request.

### 2. API Requests

Use the `@token`, found during [Authentication](#authentication), to create a new {Platforms::Yammer::Client}. That client can then be used to make API requests.

```ruby
client = Platforms::Yammer::Client.new(@token)
messages = client.messages.get
```

More detail on the configuration options for the {Platforms::Yammer::Client} can be found in the class documentation, including how to change the handling of HTTP errors.

Extra request parameters and headers can generally be passed in the subsequent parameters to a method:

```ruby
messages = client.messages.get { :older_than => 123 }, { :custom => :header }
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'platforms-yammer'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install platforms-yammer
```

Once the gem is installed, from your Rails directory you can run the following generator to complete the installation:

```bash
$ rails generate platforms:yammer:install
```

This will:

* Complete the installation of the [Platforms::Core](https://github.com/collabital/platforms-core) gem; and
* Add a basic initializer to `config/initializers/platforms_yammer.rb`.

## Configuration

REST-based APIs require authentication to get started. Please refer to the Yammer documentation for how to configure an integration.

### Configuring the Keys

Edit the initializer to add the credentials of your Yammer integration:

```ruby
# config/initializers/platforms_yammer.rb

```

### Starting a New App

Your application needs to have at least `Network` and `User` models. These can be created by calling the generator:

```bash
$ rails generate platforms:core:network foo some_info:string
$ rails generate platforms:core:user bar user more_info:string
$ rake db:migrate
```

Typically these would actually be called "Network" and "User", but here we have called them "Foo" and "Bar".

For more detailed instructions, refer to the documentation for configuring [Platforms::Core](https://github.com/collabital/platforms-core#configuration).

### Adding to an Existing App

If you already have `Network` and `User` models (which let's assume are called "Foo" and "Bar" respectively), you can configure them for Platforms::Core by using the generator with the `--existing-model` flag:

```bash
$ rails generate platforms:core:network foo --existing-model
$ rails generate platforms:core:user bar --existing-model
$ rake db:migrate
```

For more detailed instructions, refer to the documentation for configuring [Platforms::Core](https://github.com/collabital/platforms-core#configuration).

## Documentation

You can generate the documentation by running

```bash
$ rake yard
```

If not everything is documented, check this with:
```bash
$ yard stats --list-undoc
```

## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md).

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
