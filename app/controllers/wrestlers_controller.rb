class WrestlersController < ApplicationController
  before_action :set_wrestler, only: %i[show]

  def index
    @wrestlers = Wrestler.all
  end

  def show; end

  private

  # def wrestler_params
  #   params.require(:wrestler).permit(:name, :image, :youtube_url)
  # end

  def set_wrestler
    @wrestler = Wrestler.find(params[:id])
  end
end
