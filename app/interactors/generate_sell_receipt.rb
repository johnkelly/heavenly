class GenerateSellReceipt
  include Interactor

  def perform
    return if failure?

    sell_receipt = SellReceipt.create!(
      product_id: product.id,
      person_id: person.id,
      product_title: product.title,
      product_video_url: product.video_url,
      product_description: product.description,
      price: product.price,
      on_sale_at: product.on_sale_at,
      expires_at: product.expires_at,
      provider_id: person.seller.provider_id,
      provider: person.seller.provider,
      card_brand: person.seller.card_brand,
      card_funding: person.seller.card_funding,
      card_last_four: person.seller.card_last_four,
      card_expiration_month: person.seller.card_expiration_month,
      card_expiration_year: person.seller.card_expiration_year,
      pickup_at: pickup_at,
      pick_up_address: person.address.formatted,
      pick_up_latitude: person.address.latitude,
      pick_up_longitude: person.address.longitude
    )

    context[:sell_receipt] = sell_receipt
  end

  def setup
    fail!(errors: ['Missing person.']) unless context[:person].present?
    fail!(errors: ['Missing pickup time.']) unless context[:pickup_at].present?
    fail!(errors: ['Missing product to sell.']) unless context[:product].present?
  end
end
