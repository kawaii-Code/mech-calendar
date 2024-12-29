class CalendarController < ApplicationController
  def data
    # Извлечение данных из базы данных
    events = Day.select(:date, :rating).as_json
    render json: events
  end
end
