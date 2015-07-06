require 'active_support'
require 'mongoid'
require 'mongoid_favoriteable/version'

module MongoidFavoriteable
  extend ActiveSupport::Concern

  included do
    extend ClassMethods
  end

  module ClassMethods
    # Public: Create a favoriteable attribute on the model.
    #
    # favoriteable - A symbol representing the singularized class name of the attribute to be favorited.
    #                An optional :class_name value may be explicitly provided for namespaced classes.
    # Examples:
    #
    #   class User
    #     favoriteable :product, :class_name => Product
    #   end
    #
    # The 'favoriteable' declaration will provide the following dynamically generated conveniences:

    # Examples:
    #
    #   class User
    #     favoriteable :product, :class_name => Product
    #   end
    #
    # =>  field :favorite_product_ids, :type => Array, :default => []
    # =>  index :favorite_product_ids => 1
    # =>  user#favorite_product!(product)
    #       - persists the provided product by performin an atomic #push to the
    #       - favorite_product_ids array
    #
    # =>  user#unfavorite_product!(product)
    #       - returns a boolean value contingent on whether the provided argument id
    #       - is present in the favorite_product_ids array
    #
    # =>  user#favorited_product?(product)
    #       - removes the provided product by performing an atomic #pull on the
    #       - favorite_product_ids array
    #
    # =>  user#favorite_products
    #       - executes a scoped query to return all favorited product instances
    #       - NOTE: scoped query class is inferred from the favoriteable attribute declaration
    #       - if the :class_name options is not explicitly provided
    #
    def favoriteable(klass, opts = {})
      pluralized_klass = klass.to_s.pluralize
      klass_constant = opts.fetch(:class_name, klass.to_s.classify).constantize

      field :"favorite_#{klass}_ids", :type => Array, :default => []
      index(:"favorite_#{klass}_ids" => 1)
      define_method :"favorite_#{klass}!" do |favoritee|
        return if send(:"favorited_#{klass}?", favoritee)
        push(:"favorite_#{klass}_ids" => favoritee.id)
      end
      define_method :"unfavorite_#{klass}!" do |favoritee|
        return unless send(:"favorited_#{klass}?", favoritee)
        pull(:"favorite_#{klass}_ids" => favoritee.id)
      end
      define_method :"favorited_#{klass}?" do |favoritee|
        send(:"favorite_#{klass}_ids").include? favoritee.id
      end
      define_method :"favorite_#{pluralized_klass}" do
        klass_constant.where(:_id.in => send(:"favorite_#{klass}_ids"))
      end
    end
  end
end
