class ChargesController < ApplicationController
  def create
    @customer=current_parent
    #### setting up the transaction with the module
    (@transaction = StripeWrapper::Card.new).create_or_update_customer_by_transaction_token(params['credit_card_token_id'], "#{@current_parent.first_name} #{@current_parent.last_name}")
    .set_transaction(1000, currency="USD", "#{@current_parent.first_name} #{@current_parent.last_name}", "Charge")
    .perform_transaction!
    Charge.create(parent_id: current_parent.id, amount: 10)
    respond_to do |format|
      format.html {
        flash[:alert]=@errors
        redirect_to dashboard_overview_path
      }
      format.js {}
    end
  end
end
