# BaseN

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'base_n'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install base_n

## Usage

```ruby
require 'base_n'

# From base 60 to an base 10 (default to #to_i)
a = BaseN::Number.new 'deadbeef', 60
a.to_i #=> 111069787178441

# From base 20 to an base 10 (default to #to_i)
b = BaseN::Number.new 'deadbeef', 20
b.to_i #=> 17570173895

# From base 23 to base 5
c = BaseN::Number.new 'deadbeef', 23
c.rebase(5).to_s #=> '1230013231014300'

# If you're doing a lot of encoding or decoding you might want an encoder.
# I hardly even need to do this, preferring to work with BaseN::Number.
base3 = BaseN::Encoder.new 3
i = base3.encode(100000) #=> #<BaseN::Number representation="12002011201", base=3>
i.to_i #=> 100000        # (to_i -> base 10)
i.to_s #=> "12002011201" # 100000 in base 3
```

## Contributing

1. Fork it ( http://github.com/barkingiguana/base_n/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
