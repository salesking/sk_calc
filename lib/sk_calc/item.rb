# Calculate totals for a single item
# Including class MUST respond to:
# 
# - discount
# - price_single
# - quantity
# - tax
# 
# == Information
# 
# base data
#   price_single
#   quantity
#   discount %
#   tax %     
# 
# unrounded calculations
#   total               price_single * quantity
#   net_total_base      total * discount 
#   tax_total_base      net_total_base * tax
# 
# rounded calculations
#   net_total
#   tax_total
#   gross_total
# 
# informative: should not be used in totals calc
#   net_single
#   gross_single
#   discount_total
#
module SK::Calc::Item
  include SK::Calc::Helper
  
  def self.round_mode
    @rmd || BigDecimal::ROUND_HALF_UP
  end
  def self.round_mode=(mode)
    @rmd = mode
  end
  
  # Total gross price incl. discount
  # ==== Returns
  # <BigDecimal>:: rounded 2 decimals
  def gross_total
    val = net_total_base + tax_total_base
    val.round(2)
  end

  # Total net price(2 decimals) incl. discount
  # ==== Returns
  # <BigDecimal>:: rounded 2 decimals
  def net_total
    net_total_base.round(2)
  end

  # Total unrounded net basis incl discount
  # 
  # ==== Returns
  # <BigDecimal>::
  def net_total_base
    (100 - discount) * total / 100
  end

  # Unrounded item total price * quantity, excl discount
  # Use it to do calculations!
  # ==== Returns
  # <BigDecimal>::
  def total
    conv_price_single * ( quantity || 0)    
  end

  # ==== Returns
  # <BigDecimal>:: rounded 2 decimals
  def tax_total
    tax_total_base.round(2)
  end
  
  # Unrounded tax
  # ==== Returns
  # <BigDecimal>:: unrounded
  def tax_total_base
    (net_total_base * conv_tax) / 100
  end
  
  # Rounded discount amount
  # ==== Returns
  # <BigDecimal>:: rounded 2 decimals
  def discount_total
    discount_total_base.round(2)
  end
  
  # The discount amount unrounded
  # ==== Returns
  # <BigDecimal>:: rounded 
  def discount_total_base
    total * (discount / 100)
  end

  # Single net price with discount applied rounded 2.
  # DONT use this method to calculate(eg. totals for a document) use net_total
  # or gross_total instead
  # ==== Returns
  # <BigDecimal>:: rounded 2 decimals
  def net_single
    val = conv_price_single *  ( 1 - (discount / 100 ) )
    val.round(2)
  end

  # Single gross price rounded 2.
  # DONT use this method to calculate(eg. totals for a document) use net_total
  # or gross_total instead
  # ==== Returns
  # <BigDecimal>:: rounded 2 decimals
  def gross_single
    val = net_single * ( 1 + conv_tax / 100)
    val.round(2)
  end


  private

  # Init price single with 0 if nil and cast to BigDecimal
  # == Return
  # <BigDecimal>
  def conv_price_single
    to_bd(price_single || 0)
  end

end