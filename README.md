# MedicsPremierClient

API Client for the Medics Premier system used by (currently just 1) Kipu client. Implements API authentication via HMAC and that's about it folks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'medics_premier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install medics_premier

## Usage

Default usage...

```ruby
require 'medics_premier'

client = MedicsPremier.client # will use env vars for config
response = client.post { patient: { ...data... }}
response.body # response
```

Custom config...

```ruby
client = MedicsPremier.client endpoint: ENDPOINT, request_uri: REQUEST_URI, secret_key: SECRET_KEY
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
