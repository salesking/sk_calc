# Calculate totals for a single item
# Including class MUST respond to:
# - discount
# - price_single
# - quantity
# - tax
module SK::Calc::Item
  # Total gross price incl. discount
  # ==== Returns
  # <BigDecimal>:: rounded 2 decimals
  def gross_total
    val = net_total + tax_total
    val.round(2)
  end

  # Total net price(2 decimals) incl. discount
  # ==== Returns
  # <BigDecimal>:: rounded 2 decimals
  def net_total
    net_total_base_raw.round(2)
  end

  # Rounded net total useful for output in cases when the docs has a
  # precision > 2
  # If the default prec of 2 is used this method equals net_total
  # In here so naming & output aligns with class document
  # ==== Returns
  # <BigDecimal>:: rounded to precision from document
  def net_total_base
    net_total_base_raw.round(precision)
  end

  # Total unrounded net basis incl discount
  # Use this internally to do calculations! Differs from net_total_base which is
  # used to output the rounded & formatted values
  # ==== Returns
  # <BigDecimal>::
  def net_total_base_raw
    (100 - discount) * total / 100
  end

  # Unrounded item total price * quantity, excl discount
  # Use it to do calculations!
  # ==== Returns
  # <BigDecimal>::
  def total
    ( price_single || 0) * ( quantity || 0)
  end

  # ==== Returns
  # <BigDecimal>:: rounded 2 decimals
  def tax_total
    val = (net_total * (tax || 0)) / 100
    val.round(2)
  end

  # The discount amount
  # ==== Returns
  # <BigDecimal>:: rounded 2 decimals
  def discount_total
    val = total * (discount / 100)
    val.round(2)
  end

  # Single net price with discount applied rounded 2.
  # DONT use this method to calculate(eg. totals for a document) use net_total
  # or gross_total instead
  # ==== Returns
  # <BigDecimal>:: rounded 2 decimals
  def net_single
    val = (price_single || 0) *  ( 1 - (discount / 100 ) )
    val.round(2)
  end

  # Single gross price rounded 2.
  # DONT use this method to calculate(eg. totals for a document) use net_total
  # or gross_total instead
  # ==== Returns
  # <BigDecimal>:: rounded 2 decimals
  def gross_single
    val = net_single * ( 1 + (tax || 0) / 100)
    val.round(2)
  end
end