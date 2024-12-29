 class DaysController < ApplicationController
    def create
      @day = Day.new(user: User.current, date: Date.today, rating: rating_params)

      if @day.save
        flash[:notice] = "Ваш день был успешно оценен!"
      else
        flash[:alert] = "Произошла ошибка при сохранении оценки дня."
      end

      expires_now
      redirect_to root_path
    end

    private

    def rating_params
      params.require(:rating)
    end
 end
