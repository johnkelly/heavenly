class MarkProductAsSold
  include Interactor

  def perform
    return if failure?
    product.update!(sold: true, expired: true, on_sale: false, sold_at: Time.now, buyer_id: person.id)
    context[:product] = product
  end

  def setup
    fail!(errors: ['Missing person.']) unless context[:person].present?
    fail!(errors: ['Missing product.']) unless context[:product].present?
  end
end
