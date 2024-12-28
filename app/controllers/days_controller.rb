 class DaysController < ApplicationController
    def create
      current_user = User.find(Current.session.user_id)
      @day = Day.new(user: current_user, date: Date.today, rating: rating_params)

      if @day.save
        flash[:notice] = "Ваш день был успешно оценен!"
      else
        flash[:alert] = "Произошла ошибка при сохранении оценки дня."
      end

      redirect_to root_path
    end

    private

    def rating_params
      params.require(:rating)
    end
 end
