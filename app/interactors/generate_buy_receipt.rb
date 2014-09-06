class GenerateBuyReceipt
  include Interactor

  def perform
    return if failure?

    buy_receipt = BuyReceipt.create!(
      product_id: product.id,
      person_id: person.id,
      product_title: product.title,
      product_video_url: product.video_url,
      product_description: product.description,
      price: product.price,
      provider_id: person.seller.provider_id,
      provider: person.seller.provider,
      card_brand: person.seller.card_brand,
      card_funding: person.seller.card_funding,
      card_last_four: person.seller.card_last_four,
      card_expiration_month: person.seller.card_expiration_month,
      card_expiration_year: person.seller.card_expiration_year,
      delivery_at: delivery_at,
      delivery_address: person.address.formatted,
      delivery_latitude: person.address.latitude,
      delivery_longitude: person.address.longitude,
      charge_id: charge_id,
      charged_at: charged_at,
      purchased_at: Time.now,
      sales_tax: sales_tax,
      sales_taxability_code: sales_taxability_code,
      sales_tax_rate: sales_tax_rate,
      sales_tax_total: sales_tax_total,
      sub_total: sub_total,
      shipping_cost: shipping_cost,
      total: total,
      discount: discount,
      discount_reason: discount_reason,
      discount_id: discount_id
    )

    context[:buy_receipt] = buy_receipt
  end

  def setup
    fail!(errors: ['Missing person.']) unless context[:person].present?
    fail!(errors: ['Missing delivery time.']) unless context[:deliver_at].present?
    fail!(errors: ['Missing product to sell.']) unless context[:product].present?
    fail!(errors: ['Missing sales tax.']) unless context[:sales_tax].present?
    fail!(errors: ['Missing sales taxability code.']) unless context[:sales_taxability_code].present?
    fail!(errors: ['Missing sales tax rate.']) unless context[:sales_tax_rate].present?
    fail!(errors: ['Missing sales tax total.']) unless context[:sales_tax_total].present?
    fail!(errors: ['Missing sub total.']) unless context[:sub_total].present?
    fail!(errors: ['Missing shipping cost.']) unless context[:shipping_cost].present?
    fail!(errors: ['Missing total.']) unless context[:total].present?
    fail!(errors: ['Missing discount.']) unless context[:discount].present?
    fail!(errors: ['Missing discount reason.']) unless context[:discount_reason].present?
    fail!(errors: ['Missing discount id.']) unless context[:discount_id].present?
    fail!(errors: ['Missing payment provider charge id.']) unless context[:charge_id].present?
    fail!(errors: ['Missing payment provider charge time.']) unless context[:charged_at].present?
  end
end
