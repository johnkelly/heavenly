class AuthorizeCreditCard
  include Interactor

  def perform
    return if failure?
    charge_id = Stripe::Charge.create(amount: total,
                                      currency: 'usd',
                                      customer: customer,
                                      description: product.title,
                                      metadata: { email: person.email, person_id: person.id },
                                      capture: false,
                                      statement_description: product.title,
                                      receipt_email: person.email
                                     )
    context[:charge_id] = charge_id
    context[:charged_at] = Time.now
  rescue Stripe::CardError, Stripe::APIConnectionError, Stripe::StripeError => e
    handle_payment_provider_error(e)
  end

  def setup
    fail!(errors: ['Missing person.']) unless context[:person].present?
    fail!(errors: ['Missing product to buy.']) unless context[:product].present?
    fail!(errors: ['Missing total.']) unless context[:total].present?
    fail!(errors: ['Charge must be greater than 0.50.']) if context[:total].to_i < 50
  end
end

private

def customer
  @customer ||= Stripe::Customer.retrieve(person.buyer.provider_id)
end

def handle_payment_provider_error(e)
  Rails.logger.error e.message
  Rails.logger.error e.backtrace.join('\n')
  fail!(errors: ['There was an error authorizing your credit card.'\
                 'Please check that your card is valid and if the problem persits contact support.'
                ])
end
