# Calculate totals for a multiple items .. in a document
# Including class MUST respond to:
# - price_total
# - precision
# - price_tax
# - line_items
module SK::Calc::Items
  include SK::Calc::Helper
  # Gross total always rounded to 2 decimals
  def gross_total
    val = (net_total || 0) + conv_tax
    val.round(2)
  end

  # Net total rounded to 2 decimals, the taxation base
  def net_total
    net_total_base.round(2)
  end

  # Rounded net total to document presicion. Defaults to 2 decimals
  # Should only be used when decimal settings are set > 2, so one can see the base
  # sum of the line items before rounded net total is taxed
  def net_total_base
   conv_price_total.round( precision || 2 )
  end

  # Rounded price_tax to 2 decimals
  def tax_total
    conv_tax.round(2)
  end
  
  # Save items sums of net total and summed taxes into the price_total,
  # tax_total
  def sum_items(items=nil)
    items ||= line_items
    # Sum up all the total prices of the items. 
    # .to_a to get out of activerecord collection into enum
    self.price_total = items.to_a.sum(&:net_total_base_raw)
    # Sum up the tax, but use the tax_grouped to prevent rounding errors
    self.price_tax = tax_grouped(items).sum { |tax_group| tax_group[1] }
  end
  
  # Sums up the tax price of the line items, grouped by tax
  # Results a sorted hash (=array) like [ [ 7, 3.50 ], [ 19, 47.50 ] ]
  #==Example
  # a sorted array like [ [ 7, 3.50 ], [ 19, 47.50 ] ] for each price/tax combination
  # So if you are using two kinds of tax (7%/19%) in an document:
  #
  # [0] =>
  #       [0] => 7      # the tax percentage
  #       [1] => 14.00  # tax sum of all line item with this tax (items summ is 200.00)
  # [1] =>
  #       [0] => 19   # the tax percentage
  #       [1] => 57   # tax sum of all line item with this tax(items sum = 300)
  #       
  #       
  # Sum up the price_total and calculate the tax -
  # don't sum price_tax because of rounding errors!
  #
  def tax_grouped(items=nil)
    items ||= line_items
    result = {}
    items.group_by(&:tax).each do |tax, item_group|
      net_total_sum = item_group.to_a.sum(&:net_total)
      result[tax] = (net_total_sum * tax / 100.0) unless tax.zero?
    end
    result.sort
  end

  private

  # Init price single with 0 if nil and cast to BigDecimal
  # == Return
  # <BigDecimal>
  def conv_price_total
    to_bd(price_total || 0)
  end

  # Init tax with 0 if nil and cast to BigDecimal .. same in helper
  # == Return
  # <BigDecimal>
  def conv_tax
    to_bd(price_tax || 0)
  end
end