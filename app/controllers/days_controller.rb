class DaysController < ApplicationController

  class DaysController < ApplicationController
    before_action :authenticate_user!

    def create
      @day = current_user.days.find_or_initialize_by(date: Date.today)
      @day.rating = params[:rating]

      if @day.save
        flash[:notice] = "Ваш день был успешно оценен!"
      else
        flash[:alert] = "Произошла ошибка при сохранении оценки дня."
      end

      redirect_to root_path
    end
  end

end
