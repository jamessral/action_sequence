# ActionSequence
## A simple way to coordinate your actions

###### Lights, camera, ACTION!

### Why would I use this?

If you:
  * have a series of actions and transformations
  * you need to run them over a shared context
  * value minimal abstraction
  * value small, simple libraries

This may be the library for you. Or not, I don't know you.

### Examples

Let's say you have a Rails app with a controller that is getting out of hand

```ruby
class SomeSweetController < ActionController
  def create
    awesome_data = @awesome_data.do_one_thing

    if awesome_data.valid?
      awesome_data.do_something_dangerous!
    else
      somehow_handle_the_error
    end

    if awesome_data.still_valid?
      awesome_data.do_something_else
    end
    # ...
  end
end
```

Yikes. This is getting hard to read and getting out of hand, so you do the responsible thing and move it to a "Service Object". This is a start, but that's just taking the Patrick Star method. Let's take this complexity and "Push it somewhere else!" What if `awesome_data` now also depends on some other data somewhere else. This approach is going to get out of hand.

What if instead we could describe the operations that we want to run, capture any error, and deal with the success or failure at the end?

```ruby
class SomeServiceObject
  def self.call(awesome_data:)
    ActionSequence::Sequence.new(
      actions: my_actions,
      initial_context: { awesome_data: awesome_data }
    ).call
  end

  def self.my_actions
    [
      ensure_data_present,
      transform_awesome_data,
      ensure_data_present,
      ensure_awesome_data_is_valid
    ]
  end

  # These can live anywhere you want. They just need to respond to
  # `call` with a single argument of the shared context
  # Perhaps a lambda or even another service object like this one!
  def self.ensure_data_present
    lambda do |context|
      if context.fetch(:awesome_data, nil).nil?
        context.fail_context!("There must be data and it must be awesome")
      end
    end
  end

  def self.do_one_thing
    -> (context) { context.fetch(:awesome_data).do_one_thing }
  end

  def self.transform_param
    -> (context) { context.fetch(:awesome_data).do_some_thing_dangerous! }
  end

  def self.ensure_awesome_data_is_valid
    lambda do |context|
      if context.fetch(:awesome_data).valid?
        context.fail_context!("Awesome Data invalid")
      end
    end
  end
end
```

Now, back in our controller we can express this:

```ruby
class SomeSweetController < ActionController
  def create
    result = SomeServiceObject.call(@awesome_data)

    if result.failed?
      handle_failure(result.error_message)
    else
      have_a_party!(result.fetch(:awesome_data))
    end
  # ...
  end
end
```
