class GenerateOrder
  include Interactor

  def perform
    return if failure?

    buyer = person
    buy_receipt = buy_receipt

    seller = product.seller
    sell_receipt = product.sell_receipts.order('created_at desc').first

    order = Order.create!(
      product_id:       product.id,
      buyer_id:         buyer.id,
      seller_id:        seller.id,
      buy_receipt_id:   buy_receipt.id,
      sell_receipt_id:  sell_receipt.id,
      total:            total,
      picked_up:        false,
      delivered:        false,
      seller_verified:  false,
      buyer_verified:   false,
      charged_buyer:    false,
      paid_seller:      false,
      complete:         false,
      status:           'BLAH'
    )

    context[:order] = order
  end

  def setup
    fail!(errors: ['Missing person.']) unless context[:person].present?
    fail!(errors: ['Missing product.']) unless context[:product].present?
    fail!(errors: ['Missing buy receipt.']) unless context[:buy_receipt].present?
    fail!(errors: ['Missing total.']) unless context[:total].present?
  end
end
