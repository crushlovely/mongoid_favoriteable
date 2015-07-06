# Favoriting for Mongoid Documents

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid_favoriteable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid_favoriteable

## Usage

Make sure you require the library and include the module within any mongoid models you wish to use the functionality.

```ruby
require 'mongoid_favoriteable'

class Person
  include MongoidFavoriteable
  include Mongoid::Document
end
```

Add the `favoriteable` declaration and include the designated model to be favorited

```ruby
class Food
  include Mongoid::Document
  field :name, :type => String
end

class Person
  include MongoidFavoriteable
  include Mongoid::Document

  favoriteable :food
end
```

You may also supply an optional `class_name` value to compensate for namespaced models

```ruby
favoriteable :city, :class_name => Location::City
```

## Module Methods

By declaring the `favoriteable` functionality, a few methods are provided to handle favoriting. Let's say we've designated the `Food` class as favoriteable

```ruby
favoriteable :food
```

The following convenience methods become available:
* `favorite_food!`
* `unfavorite_food!`
* `favorite_foods`
* `favorite_food_ids`

The bang methods require a model instance to be supplied:

```ruby
person = Person.create(:name => 'john')
pizza = Food.create(:name => 'pizza')

person.favorite_food!(pizza)

=> true

person.unfavorite_food!(pizza)

=> true
```

`favorite_foods` will return a ```Mongoid::Criteria``` query object of all favorited food records

```ruby
person.favorite_foods

=> #<Mongoid::Criteria
  selector: {"_id"=>{"$in"=>[BSON::ObjectId('54fe002469702d5011c60100')]}}
  options:  {}
  class:    Food
  embedded: false>

person.favorite_foods.entries

=> [#<Food _id: 54fe002469702d5011c60100, name: 'pizza' >]
```

`favorite_food_ids` will return an array of bson identifiers

```ruby
person.favorite_food_ids

=> [BSON::ObjectId('54fe002469702d5011c60100')]
```

## Contributing

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so we don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so we can cherry-pick around it.


## Copyright

Copyright (c) 2015 Greg Morrison (Crush & Lovely). See LICENSE for further details.