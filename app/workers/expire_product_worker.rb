class ExpireProductWorker
  include Sidekiq::Worker
  sidekiq_options queue: :expire

  def perform(product_id)
    product = Product.find product_id
    return if product.expired?

    if product.expires_at <= Time.now
      product.update!(expired: true)
    else
      ExpireProductWorker.perform_at(product.expires_at, product.id)
    end
  end
end
