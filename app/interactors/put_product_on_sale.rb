class PutProductOnSale
  include Interactor

  def perform
    return if failure?

    product.on_sale = true
    product.on_sale_at = Time.now

    product.expired = false
    product.expires_at = 3.hours.from_now

    product.save!

    context[:product] = product

    ExpireProductWorker.perform_at(product.expires_at, product.id)
  end

  def setup
    fail!(errors: ['Missing person.']) unless context[:person].present?
    fail!(errors: ['Missing pickup time.']) unless context[:pickup_at].present?
    fail!(errors: ['Missing product to sell.']) unless context[:product].present?
  end
end
