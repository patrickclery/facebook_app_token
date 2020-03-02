# FacebookAppToken

FacebookAppToken is a fork of [tinder_auth_fetcher gem](https://github.com/shuheiktgw/tinder_auth_fetcher) that can retrieve an authentication token for any facebook app (not just Tinder).

## Dependencies
- [Mechanize](https://github.com/sparklemotion/mechanize)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'facebook_app_token'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install facebook_app_token

## Usage
First thing is first. Make sure that you've required facebook_app_token.
$ gem install facebook_app_token


```ruby
require 'facebook_app_token'
```

Now all you need to do is just call #FacebookAppToken.fetch_token with target facebook email address and password. Then it will return the token.

```ruby
token = FacebookAppToken.fetch_token(facebook_email, facebook_password, facebook_app_id)
```

**Notice**: FacebookAppToken raises `FacebookAppToken::FacebookAuthenticationError` with the message "Facebook Authentication failed. Check if you passed correct email and password" if it failed to log in, so you might want to deal with it.

## Test
I wrote only two test cases, one that asserts it raises `FacebookAppToken::FacebookAuthenticationError` when it fails to fetch the token and the one which asserts it fetches the token correctly.

First you have to provide valid Facebook email and password through environment variables.

    $ export FACEBOOK_AUTH_EMAIL="your_facebook_email@gmail.com"
    $ export FACEBOOK_AUTH_PASSWORD="your_facebook_password"
    $ export FACEBOOK_AUTH_APP_ID="your_facebook_app_id"   (use 464891386855067 for tinder)

Then all you need to do is just runing the RSpec.

    $ rspec

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/patrickclery/facebook_app_token. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
