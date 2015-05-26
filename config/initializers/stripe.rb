Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'] || 'pk_test_5qnfgJ0WGx33aCtjcLu32urT' ,
  :secret_key      => ENV['SECRET_KEY'] || 'sk_test_17UeaQ4zPhxawkrC7sagatbl'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
