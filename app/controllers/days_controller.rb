 class DaysController < ApplicationController
   include Authentication

   def create
     @day = Day.new(user: User.current, date: Date.today, rating: rating_params)

     if @day.save
       flash[:notice] = "Ваш день был успешно оценен!"
     else
       flash[:alert] = "Произошла ошибка при сохранении оценки дня."
     end

     redirect_to root_path
   end

   def delete
     day = Day.find_by(user: User.current, date: Date.today)
     if day
       Day.delete(day)
     end

     redirect_to root_path
   end

   private

   def rating_params
     params.require(:rating)
   end
 end
