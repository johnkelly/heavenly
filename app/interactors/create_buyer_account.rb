class CreateBuyerAccount
  include Interactor

  def perform
    return if failure?
    customer = Stripe::Customer.create(
      email:  person.email,
      card:   token
    )

    credit_card = customer.cards.retrieve(customer.default_card)

    buyer_account = Buyer.create!(
      person_id:              person.id,
      provider_id:            customer.id,
      provider:               Account::PROVIDER,
      card_brand:             credit_card.brand,
      card_funding:           credit_card.funding,
      card_last_four:         credit_card.last4,
      card_expiration_month:  credit_card.exp_month,
      card_expiration_year:   credit_card.exp_year
    )
    context[:buyer_account] = buyer_account
  end

  def setup
    fail!(errors: ['Missing person.']) unless context[:person].present?
    fail!(errors: ['Missing Stripe card token.']) unless context[:token].present?
  end
end
