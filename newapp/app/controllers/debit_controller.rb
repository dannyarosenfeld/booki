require 'stripe'

class DebitController < ApplicationController
  Stripe.api_key = "sk_test_LaGOwlDvqeTDlyYRBnWN1y4W"

  def create
    if request.xhr?
      token = params[:token]
      stripe_account_id = current_user.managed_account.account_id

      account = Stripe::Account.retrieve(stripe_account_id)

      account.external_accounts.create(external_account: token)

      p "*" * 50
      p "success"
      redirect_to root_path
    else
      p "*" * 50
      p "failure"
    end
  end

end
