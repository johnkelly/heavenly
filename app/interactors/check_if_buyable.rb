class CheckIfBuyable
  include Interactor

  def perform
    assert_person_is_a_buyer unless failure?
    assert_valid_deliver_at unless failure?
    assert_product_is_buyable unless failure?
  end

  def setup
    fail!(errors: ['Missing person.']) unless context[:person].present?
    fail!(errors: ['Missing delivery time.']) unless context[:deliver_at].present?
    fail!(errors: ['Missing product to buy.']) unless context[:product].present?
  end

  private

  def assert_person_is_a_buyer
    return if person.buyer.present?
    fail!(errors: ['You must first create a buyer account with a credit card.'])
  end

  def assert_valid_deliver_at
    context[:deliver_at] = DateTime.parse(deliver_at)
  rescue ArgumentError
    fail!(errors: ['Invalid Delivery date or time'])
  end

  def assert_product_is_buyable
    return if product.on_sale? && product.not_sold?
    fail!(errors: ['The product is currently not for sale or has been sold.'])
  end
end
