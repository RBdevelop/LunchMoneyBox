class ChargesController < ApplicationController
  def create
    Charge.create(parent_id: current_parent.id)
    @customer=current_parent
    #### setting up the transaction with the module
    (@transaction = StripeWrapper::Card.new).create_or_update_customer_by_transaction_token(params['credit_card_token_id'], "#{@current_parent.first_name} #{@current_parent.last_name}")
    .set_transaction(10, currency="USD", "#{@current_parent.first_name} #{@current_parent.last_name}", "Charge")
    .perform_transaction!
    binding.pry
    respond_to do |format|
      format.html {
        flash[:alert]=@errors
        redirect_to request.referer
      }
      format.js {
        
      }
    end
  end
end
