class ReignsController < ApplicationController
  before_action :set_reign, only: %i[show]

  def show; end

  private

  def set_reign
    @reign = Reign.find(params[:id])
  end

  # def reign_params
  #   params.require(:reign).permit(:name,:duration, :title_id, :wrestler_id, :start_date, :end_date)
  # end
end
