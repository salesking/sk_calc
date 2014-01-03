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

  ############################################
  ### BASE VALUES
  ############################################
  ### These values are used for calculations.
  ### Use values under DISPLAY VALUES section
  ### for displaying values to the end user!

  # Total unrounded net basis incl discount
  # Use this internally to do calculations! Differs from net_total_base which is
  # used to output the rounded & formatted values
  # @return [BigDecimal]
  def net_total_base
    (100 - (discount||0)) * total / 100
  end

  # @return [BigDecimal] total amount of tax
  def tax_total_base
    (net_total_base * conv_tax) / 100
  end

  # Single net price with discount applied
  # DO NOT use this method to calculate(eg. totals for a document) use net_total
  # or gross_total instead
  # @return [BigDecimal] rounded 2 decimals
  def net_single_base
    conv_price_single * ( 1 - ((discount||0) / 100 ) )
  end

  def gross_single_base
    net_single_base * ( 1 + conv_tax / 100)
  end

  # Total gross price incl. discount
  # @return [BigDecimal] total gross base
  def gross_total_base
    net_total_base + tax_total_base
  end

  # The discount amount unrounded
  # @return [BigDecimal] rounded
  def discount_total_base
    total * ((discount||0) / 100)
  end

  # Unrounded item total price * quantity, excl discount
  # Use it to do calculations!
  # @return [BigDecimal]
  def total
    conv_price_single * ( quantity || 0)
  end

  ############################################
  ### DISPLAY VALUES
  ############################################
  ### These values are used only to display to a user.
  ### Use values under BASE VALUES section
  ### for calculations!

  # Total gross price incl. discount
  # @return [BigDecimal] rounded 2 decimals
  def gross_total
    gross_total_base.round(2)
  end

  # Total net price(2 decimals) incl. discount
  # @return [BigDecimal] rounded 2 decimals
  def net_total
    net_total_base.round(2)
  end

  # @return [BigDecimal] rounded 2 decimals
  def tax_total
    tax_total_base.round(2)
  end

  # The discount amount
  # @return [BigDecimal] rounded 2 decimals
  def discount_total
    discount_total_base.round(2)
  end

  # Single net price with discount applied rounded 2.
  # DO NOT use this method to calculate(eg. totals for a document) use net_total
  # or gross_total instead
  # @return [BigDecimal] rounded 2 decimals
  def net_single
    net_single_base.round(2)
  end

  # Single gross price rounded 2.
  # DONT use this method to calculate(eg. totals for a document) use net_total
  # or gross_total instead
  # @return [BigDecimal] rounded 2 decimals
  def gross_single
    gross_single_base.round(2)
  end

  ############################################
  ### DISPLAY VALUES 4
  ############################################
  ### These values are used only to display to a user.
  ### Use values under BASE VALUES section
  ### for calculations!

  # Total gross price incl. discount
  # @return [BigDecimal] rounded 2 decimals
  def gross_total_4
    gross_total_base.round(4)
  end

  # Total net price
  # @return [BigDecimal] rounded 4 decimals
  def net_total_4
    net_total_base.round(4)
  end


  # @return [BigDecimal] rounded 4 decimals
  def tax_total_4
    tax_total_base.round(4)
  end

  # The discount amount
  # @return [BigDecimal] rounded 4 decimals
  def discount_total_4
    discount_total_base.round(4)
  end


  # Single net price with discount applied rounded 2.
  # DO NOT use this method to calculate(eg. totals for a document) use net_total
  # or gross_total instead
  # @return [BigDecimal] rounded 4 decimals
  def net_single_4
    net_single_base.round(4)
  end

  # Single gross price rounded 2.
  # DONT use this method to calculate(eg. totals for a document) use net_total
  # or gross_total instead
  # @return [BigDecimal] rounded 4 decimals
  def gross_single_4
    gross_single_base.round(4)
  end

  private

  # Init price single with 0 if nil and cast to BigDecimal
  # @return [BigDecimal]
  def conv_price_single
    to_bd(price_single || 0)
  end

end
