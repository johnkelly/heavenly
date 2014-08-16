class ReindexPersonProductsWorker
  include Sidekiq::Worker
  sidekiq_options queue: :elasticsearch

  def perform(person_id)
    person = Person.find person_id

    person.sold_products.each do |product|
      product.reindex
    end

    person.purchased_products.each do |product|
      product.reindex
    end
  end
end
