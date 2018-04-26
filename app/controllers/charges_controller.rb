class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: 1500
    }
  end

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      :source => params[:stripeToken],
      :email => current_user.email
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 1500,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

   current_user.update_attribute(:role, "premium")

   redirect_to edit_user_registration_path, flash: { notice: "Upgraded #{current_user.email} to Premium Membership!"}

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def cancel
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
    }

    customer = Stripe::Customer.retrieve(
      :source => params[:stripeToken],
    )

    customer.subscriptions.retrieve("Premium Membership").delete(:at_period_end => true)

  end
end
