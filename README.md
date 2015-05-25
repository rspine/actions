# Spine::Actions

[![Gem Version](https://badge.fury.io/rb/spine-actions.svg)](http://badge.fury.io/rb/spine-actions)
[![Dependency Status](https://gemnasium.com/rspine/actions.svg)](https://gemnasium.com/rspine/actions)
[![Code Climate](https://codeclimate.com/github/rspine/actions/badges/gpa.svg)](https://codeclimate.com/github/rspine/actions)

HTTP endpoint action with before and after callbacks, response builder.

## Installation

To install it, add the gem to your Gemfile:

```ruby
gem 'spine-actions'
```

Then run `bundle`. If you're not using Bundler, just `gem install spine-actions`.

## Usage

Each action can access Rack `env`, `request` and `response`.

Action provides following methods to respond: `respond(content, options)`,
`redirect(url, options)` and `send_data(binary, options)`. Options include
`:status`, `:content_type`, `:data` and `:filename`.

Response headers can be set using `response['header-name'] = 'value'`
before running response.

```ruby
class Status < Spine::Actions::Action
  before :authenticate
  after :close_connections

  # It will be used as response type. Default is Spine::ContentTypes::Html
  def format
    Spine::ContentTypes::Json
  end

  def action
    # ...
    respond({ status: 'OK' }, status: 200)
  end

  def authenticate
    # ...
  end

  def close_connections
    # ...
  end
end


Status.call(env)
```

### Using with default Rack routing

```ruby
# config.ru

map 'status' do
  run Status
end
```

### Using with Spine::Routing

```ruby
# config.ru

router = Spine::Routing::Router.new
router.configure do
  get :status, to: Status
end

run router
```
