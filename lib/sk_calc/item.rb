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

  ############################################
  ### BASE VALUES
  ############################################
  ### These values are used for calculations.
  ### Use values under DISPLAY VALUES section
  ### for displaying values to the end user!

  # Total unrounded net basis incl discount
  # Use this internally to do calculations! Differs from net_total_base which is
  # used to output the rounded & formatted values
  # @return [Rational]
  def net_total_base
    (100 - conv_discount) * total / 100
  end

  # @return [Rational] total amount of tax
  def tax_total_base
    (net_total_base * conv_tax) / 100
  end

  # Single net price with discount applied
  # DO NOT use this method to calculate(eg. totals for a document) use net_total
  # or gross_total instead
  # @return [Rational] rounded 2 decimals
  def net_single_base
    conv_price_single * ( 1 - (conv_discount / 100 ) )
  end

  def gross_single_base
    net_single_base * ( 1 + conv_tax / 100)
  end

  # Total gross price incl. discount
  # @return [Rational] total gross base
  def gross_total_base
    net_total_base + tax_total_base
  end

  # The discount amount unrounded
  # @return [Rational] rounded
  def discount_total_base
    total * (conv_discount / 100)
  end

  # Unrounded item total price * quantity, excl discount
  # Use it to do calculations!
  # @return [Rational]
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
  # @return [Rational] rounded 2 decimals
  def gross_total
    gross_total_base.round(2)
  end

  # Total net price(2 decimals) incl. discount
  # @return [Rational] rounded 2 decimals
  def net_total
    net_total_base.round(2)
  end

  # @return [Rational] rounded 2 decimals
  def tax_total
    tax_total_base.round(2)
  end

  # The discount amount
  # @return [Rational] rounded 2 decimals
  def discount_total
    discount_total_base.round(2)
  end

  # Single net price with discount applied rounded 2.
  # DO NOT use this method to calculate(eg. totals for a document) use net_total
  # or gross_total instead
  # @return [Rational] rounded 2 decimals
  def net_single
    net_single_base.round(2)
  end

  # Single gross price rounded 2.
  # DONT use this method to calculate(eg. totals for a document) use net_total
  # or gross_total instead
  # @return [Rational] rounded 2 decimals
  def gross_single
    gross_single_base.round(2)
  end


  private

  # Init price single with 0 if nil
  # @return [Rational]
  def conv_price_single
    (price_single || 0).to_r.round(SK::Calc.precision)
  end

  # Init discount with 0 gracefully ignores if it is not defined.
  # @return [Rational]
  def conv_discount
    ((self.respond_to?(:discount) && discount) || 0).to_r
  end

  # Init tax with 0 if nil
  # @return [Rational]
  def conv_tax
    ((self.respond_to?(:tax) && tax) || 0).to_r
  end

end
