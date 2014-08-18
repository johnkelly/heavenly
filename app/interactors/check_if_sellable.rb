class CheckIfSellable
  include Interactor

  def perform
    assert_person_is_a_seller unless failure?
    assert_valid_pickup_at unless failure?
    assert_product_is_sellable unless failure?
  end

  def setup
    fail!(errors: ['Missing person.']) unless context[:person].present?
    fail!(errors: ['Missing pickup time.']) unless context[:pickup_at].present?
    fail!(errors: ['Missing product to sell.']) unless context[:product].present?
  end

  private

  def assert_person_is_a_seller
    return if person.seller.present?
    fail!(errors: ['You must first create a seller account with a debit card to be paid to.'])
  end

  def assert_valid_pickup_at
    context[:pickup_at] = DateTime.parse(pickup_at)
  rescue ArgumentError
    fail!(errors: ['Invalid Pick up date or time'])
  end

  def assert_product_is_sellable
    return unless product.on_sale? || product.sold?
    fail!(errors: ['The product is already listed for sale.'])
  end
end
