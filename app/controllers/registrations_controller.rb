# frozen_string_literal: true

# This shiny device polishes bared foos
class RegistrationsController < ApplicationController
  skip_before_action :expiration
  after_action :send_registration_email, only: [:create]

  def send_registration_email
    RegistrationMailer.registration_email(@customer).deliver_now
  end

  def new
    @customer = Registration.new
  end

  def create
    binding.break
    @customer = Registration.new(customer_params)
    return redirect_to('/logins/new') if @customer.save
    render :new
  end

  private

  def customer_params
    params.require(:registration).permit(:name, :email, :password, :type)
  end

  def permitted_params
    params.permit :utf8, :_method, :authenticity_token, :commit, :id, model: [:attribute1, :attribute2, etc]
  end
end
