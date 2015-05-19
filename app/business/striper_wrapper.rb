require 'stripe'


module StripeWrapper

#---------------------------------------------------------------------------------------------------

  class Card
    attr_reader :errors, :charge, :balanced_transaction
    class << self
      def fetch_credit_card(customer_token, card_token)
        customer = Stripe::Customer.retrieve(customer_token)
        customer.sources.retrieve(card_token)
      rescue => e
        @errors << e.message
      end
      def fetch_credit_card_by_fingerprint(customer_token, fingerprint)
        customer = Stripe::Customer.retrieve(customer_token)
        customer.sources.map { |card| card if card['fingerprint'] == fingerprint }.first
      rescue => e
        @errors << e.message
      end
    end
    def initialize
      @errors = []
      @customer = nil
      @credit_card = nil
      @charge = nil
    end

    def create_or_update_customer_by_transaction_token(token, description, customer_params={})
      transcation = Stripe::Token.retrieve(token)
      customer_email = transcation['email']
      card = OpenStruct.new(transcation['card'].to_hash)
      app_customer = Customer.where(email: customer_email.to_s.downcase).first
      unless app_customer
        customer =  Stripe::Customer.create(
                                            description: description,
                                            email: customer_email,
                                            source: token
                                            )
        app_customer = Customer.create(
                                       email: customer_email,
                                       stripe_id: customer.id
                                       )
        @credit_card = Card.fetch_credit_card(app_customer.stripe_id, card.id)
      else
        customer = Stripe::Customer.retrieve(app_customer.stripe_id)
        if is_card_a_duplicate?(customer, card.fingerprint)
          @credit_card = Card.fetch_credit_card_by_fingerprint(app_customer.stripe_id, card.fingerprint)
        else
          app_customer = Customer.create(
                                         email: customer_email,
                                         stripe_id: customer.id
                                         )
          @credit_card = Card.fetch_credit_card(app_customer.stripe_id, card.id)
        end
      end

      update_credit_card_information(@credit_card, customer_params)
      @customer = customer

      self
    rescue => e
      @errors << e.message
      self
    end
    def is_card_a_duplicate?(customer, fingerprint)
      customer.sources.data.map { |card| card['fingerprint'] }.include?(fingerprint)
    end
    def update_credit_card_information(card, customer_params={})
      card.address_city = customer_params['city']
      card.address_country = customer_params['country'] || 'US'
      card.address_line1 = customer_params['address_one']
      card.address_line2 = (customer_params['address_two'].empty? ? nil : customer_params['address_two'].empty?)
      card.address_state = customer_params['state']
      card.address_zip = customer_params['zipcode']
      card.name = "#{customer_params['first_name']} #{customer_params['last_name']}"
      card.save
    rescue => e
      @errors << e.message
      self
    end



    def set_transaction(amount, currency="USD", description=nil, statement_descriptor=nil)
      @amount, @currency, @description, @statement_descriptor = amount, currency, description, statement_descriptor
      self
    rescue => e
      @errors << e.message
      self
    end

    def perform_transaction!
      @charge = Stripe::Charge.create(
                                      amount: @amount,
                                      currency: @currency,
                                      customer: @customer.id,
                                      source: @credit_card.id,
                                      description: @description,
                                      statement_descriptor: @statement_descriptor
                                      # receipt_email: @customer.
                                      )
      @balanced_transaction = Stripe::BalanceTransaction.retrieve(@charge.balance_transaction)
      true
    rescue => e
      @errors << e.message
      false
    end
  end
end
