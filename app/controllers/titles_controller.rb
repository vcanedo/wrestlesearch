class TitlesController < ApplicationController
  before_action :set_title, only: %i[show]

  def index
    @titles = Title.all
  end

  # def show; end

  private

  # def set_title
  #   @title = Title.find(params[:id])
  # end

  # def title_params
  #   params.require(:title).permit(:name, :image, :time_used)
  # end
end
