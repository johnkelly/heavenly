class CreateSellerAccount
  include Interactor

  def perform
    return if failure?
    recipient = Stripe::Recipient.create(
      name:   name,
      type:   Account::RECIPIENT_TYPE,
      email:  person.email,
      card:   token
    )

    credit_card = recipient.cards.retrieve(recipient.default_card)

    seller_account = Seller.create!(
      person_id:              person.id,
      provider_id:            recipient.id,
      provider:               Account::PROVIDER,
      card_brand:             credit_card.brand,
      card_funding:           credit_card.funding,
      card_last_four:         credit_card.last4,
      card_expiration_month:  credit_card.exp_month,
      card_expiration_year:   credit_card.exp_year
    )
    context[:seller_account] = seller_account
  end

  def setup
    fail!(errors: ['Missing person.']) unless context[:person].present?
    fail!(errors: ['Missing Stripe card token.']) unless context[:token].present?
    fail!(errors: ['Missing credit card name.']) unless context[:name].present?
  end
end
