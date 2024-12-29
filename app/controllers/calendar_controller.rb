class CalendarController < ApplicationController
  def data
    # Извлечение данных из базы данных
    days = Day.select(:date, :rating).as_json
    render json: days
  end
end
