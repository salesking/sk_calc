require 'bigdecimal'
require 'active_support/core_ext/enumerable'
module SK
  # calculation module
  # == Usage
  #
  #   class LineItem
  #     calculates :item
  #   end
  #
  #   class Invoice
  #     calculates :items
  #   end
  module Calc

    def self.included(base)
      autoload :Helper, 'sk_calc/helper'
      autoload :Item, 'sk_calc/item'
      autoload :Items, 'sk_calc/items'
      base.extend(ClassMethods)
  #    base.send(:include, InstanceMethods)
    end

    module ClassMethods

      def calculates(kind, opts={})
        include Item if kind == :item
        include Items if kind == :items
      end
    end

    module InstanceMethods; end

  end
end