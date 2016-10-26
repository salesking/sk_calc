# Calculate totals for a multiple items eg in an invoice
# Including class MUST respond to:
# - price_total: the sum of all items net totals, you must call #sum_items yourself to fill this and price tax
# - price_tax: the tax total for all items
# - line_items
module SK::Calc::Items
  # Unrounded net total which is the sum of all items net_total, the taxation base
  # @return [Rational]
  def net_total_base
    conv_price_total
  end

  # Gross total unrounded
  # @return [Rational]
  def gross_total_base
    (net_total_base || 0) + tax_total_base
  end

  # Net total rounded to 2 decimals
  def net_total
    net_total_base.round(2)
  end

  # Gross total rounded to 2 decimals
  # @return [Rational]
  def gross_total
    gross_total_base.round(2)
  end

  # Tax total rounded price_tax to 2 decimals
  # @return [Rational]
  def tax_total_base
    conv_tax
  end

  # Tax total rounded price_tax to 2 decimals
  # @return [Rational]
  def tax_total
    conv_tax.round(2)
  end

  # Save items sums of net total and summed taxes into the price_total,
  # tax_total
  def sum_items(items=nil)
    items ||= line_items
    # Sum up all the total prices of the items.
    # .to_a to get out of activerecord collection into enum
    self.price_total = items.to_a.sum(&:net_total_base)
    # Sum up the tax, but use the tax_grouped to prevent rounding errors
    self.price_tax = tax_grouped(items).sum { |tax_group| tax_group[1] }
  end

  # Sums up the tax price of the line items, grouped by tax
  #
  # @example
  # Sums up the price_total and calculate the tax -does not sum price_tax
  # because of rounding errors!
  # Returns a sorted sorted hash
  #   { [ 7, 3.50 ], [ 19, 47.50 ] } for each price/tax combination
  # So if you are using two kinds of tax (7%/19%) in an document:
  #
  # [0] =>
  #       [0] => 7      # the tax percentage
  #       [1] => 14.00  # tax sum of all line item with this tax (items summ is 200.00)
  # [1] =>
  #       [0] => 19
  #       [1] => 57   #(items sum = 300)
  #
  #
  # @return [Hash]
  def tax_grouped(items=nil)
    items ||= line_items
    result = {}
    items.group_by(&:tax).each do |tax, item_group|
      net_total_sum = item_group.to_a.sum(&:net_total_base)
      result[tax] = (net_total_sum * tax.to_r / 100.0).round(SK::Calc.precision) if tax && !tax.zero?
    end
    result.sort
  end

  private

  # Init total with 0 if nil and cast to Rational
  # @return [Rational]
  def conv_price_total
    (price_total || 0).to_r.round(SK::Calc.precision)
  end

  # Init tax with 0 if nil and cast to Rational
  # @return [Rational]
  def conv_tax
    (price_tax || 0).to_r
  end
end
