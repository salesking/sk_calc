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
      autoload :Item, 'sk_calc/item'
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