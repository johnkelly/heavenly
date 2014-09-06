class CalculateTotal
  include Interactor

  def perform
    apply_any_discount  unless failure?
    calculate_sales_tax unless failure?
    calculate_sub_total unless failure?
    calculate_shipping  unless failure?
    calculate_total     unless failure?
  end

  def setup
    fail!(errors: ['Missing person.']) unless context[:person].present?
    fail!(errors: ['Missing delivery time.']) unless context[:deliver_at].present?
    fail!(errors: ['Missing product to buy.']) unless context[:product].present?
  end

  private

  def apply_any_discount
    # TODO: Handle discounts
    context[:discount] = 0
    context[:discount_reason] = nil
    context[:discount_id] = nil
  end

  def calculate_sales_tax
    origin_address = product.seller.address
    origin = TaxCloud::Address.new(
      address1: origin_address.street1,
      address2: origin_address.street2,
      city:     origin_address.city,
      state:    origin_address.region,
      zip5:     origin_address.postal_code
    )

    destination_address = person.address
    destination = TaxCloud::Address.new(
      address1: destination_address.street1,
      address2: destination_address.street2,
      city:     destination_address.city,
      state:    destination_address.region,
      zip5:     destination_address.postal_code
    )

    transaction = TaxCloud::Transaction.new(
      customer_id:  user.id,
      cart_id:      product.id,
      origin:       origin,
      destination:  destination
    )
    transaction.cart_items << TaxCloud::CartItem.new(
      index:    0,
      item_id:  product.id,
      tic:      TaxCloud::TaxCodes::GENERAL,
      price:    10.00,
      quantity: 1
    )

    lookup = transaction.lookup
    lookup.tax_amount # total tax amount
    lookup.cart_items.each do |cart_item|
      cart_item.tax_amount # tax for a single item
    end

    context[:sales_tax] = lookup.tax_amount
    context[:sales_taxability_code] = nil
    context[:sales_tax_rate]  = nil
    context[:sales_tax_total] = lookup.tax_amount
  end

  def calculate_sub_total
    context[:sub_total] = product.price - discount + sales_tax
  end

  def calculate_shipping
    # We need to get shipping from product/sales transaction
    # TODO: Handle Shipping
    context[:shipping_cost] = 0
  end

  def calculate_total
    context[:total] = sub_total + shipping_cost
  end
end
