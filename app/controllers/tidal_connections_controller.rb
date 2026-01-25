class TidalConnectionsController < ApplicationController
  before_action :authenticate_user!

  def connect
    state = SecureRandom.hex(16)
    session[:tidal_oauth_state] = state
    redirect_to tidal_service.authorization_url(
      redirect_uri: callback_url,
      state: state
    ), allow_other_host: true
  end

  def callback
    unless params[:state].present? && params[:state] == session.delete(:tidal_oauth_state)
      redirect_to dashboard_path, alert: "TIDAL connection failed. Please try again."
      return
    end

    if params[:error].present?
      redirect_to dashboard_path, alert: "TIDAL connection failed: #{params[:error_description] || params[:error]}"
      return
    end

    token_data = tidal_service.exchange_code_for_token(
      code: params[:code],
      redirect_uri: callback_url
    )

    if token_data.blank? || token_data["access_token"].blank?
      redirect_to dashboard_path, alert: "TIDAL connection failed. Please try again."
      return
    end

    current_user.tidal_account&.destroy
    current_user.create_tidal_account!(
      access_token: token_data["access_token"],
      refresh_token: token_data["refresh_token"],
      expires_at: token_data["expires_in"] ? Time.current + token_data["expires_in"].to_i.seconds : nil
    )

    redirect_to dashboard_path, notice: "TIDAL connected successfully."
  end

  private

  def tidal_service
    TidalService.new
  end

  def callback_url
    tidal_callback_url
  end
end
