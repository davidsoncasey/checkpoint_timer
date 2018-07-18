# CheckpointTimer

Checkpoint Timer is a gem to provide a very lightweight Ruby stopwatch timer.

The impetus for this was some performance diagnostic work that I was doing. I wanted to see how long different method calls were taking, but wanted something more lightweight than Ruby's Benchmark library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'checkpoint_timer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install checkpoint_timer

## Usage

To use the timer, create an instance of the timer class.
```Ruby
timer = CheckpointTimer::Timer.new
timer.start
# ... execute code here
timer.checkpoint(logging: true, message: 'First checkpoint')
# ... execute some more code
timer.checkpoint(logging: true, message: 'Second checkpoint')
```

The timer can also be used without logging, if you wish to use the data differently
```ruby
timer = CheckpointTimer::Timer.new
timer.start
# ... execute code here
elapsed_time = timer.checkpoint
```
The `CheckpointTimer::Timer#checkpoint` method returns the elapsed time in seconds since the previous checkpoint.

Logging can also be enabled at the instance level.
```ruby
timer = CheckpointTimer::Timer.new(log_all: true)
timer.start
# ... execute code here
elapsed_time = timer.checkpoint(message: 'Global logging is enabled')
```

## Development

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/checkpoint_timer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
