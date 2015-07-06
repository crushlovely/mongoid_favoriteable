require 'spec_helper'

describe MongoidFavoriteable do
  class Food
    include Mongoid::Document
    field :name, :type => String
  end

  class Person
    include Mongoid::Document
    include MongoidFavoriteable
    favoriteable :food
  end

  it 'has a version number' do
    expect(MongoidFavoriteable::VERSION).not_to be nil
  end

  context 'module methods' do
    let(:person) { Person.new }
    it 'responds to included module methods' do
      [:favorite_food!, :unfavorite_food!, :favorite_foods, :favorite_food_ids].each do |method|
        expect(person.respond_to? method).to eq(true)
      end
    end
  end

  context 'favoriting' do
    let(:food) { Food.create(:name => 'pizza') }
    let(:person) { Person.create }

    it 'favorites the instance' do
      person.favorite_food!(food)
      expect(person.favorite_food_ids).to include(food.id)
    end

    it 'unfavorites the instance' do
      person.unfavorite_food!(food)
      expect(person.favorite_food_ids).not_to include(food.id)
    end

    it 'returns favorited instances' do
      person.favorite_food!(food)
      expect(person.favorite_foods.present?).to eq(true)
    end
  end
end
