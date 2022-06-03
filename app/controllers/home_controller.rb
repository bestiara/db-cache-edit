class HomeController < ApplicationController
  def index
  end

  def reset
    Rails.application.load_seed
    render json: {}, status: :ok
  end
end
