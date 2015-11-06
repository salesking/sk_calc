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

    # Global calculation precision setting. If you save values to db with 8
    # decimal places you should use a precision of 8
    def self.precision
      @precision || 6
    end

    def self.precision=(val)
      @precision = val
    end

    def self.included(base)
      autoload :Item, 'sk_calc/item'
      autoload :Items, 'sk_calc/items'
      base.extend(ClassMethods)
    end

    module ClassMethods

      def calculates(kind, opts={})
        include Item if kind == :item
        include Items if kind == :items
        if opts[:precision]
          SK::Calc.precision = opts[:precision]
        end
      end
    end

  end
end