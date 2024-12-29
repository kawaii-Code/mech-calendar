import { Calendar } from 'vanilla-calendar-pro';
import 'vanilla-calendar-pro/styles/index.css';

async function fetchCalendarData() {
  const response = await fetch('/calendar_data');
  return response.json();
}

document.addEventListener('DOMContentLoaded', () => {
  const calendarElement = document.getElementById('calendar');
  if (calendarElement) {
    const calendarData = fetchCalendarData();
    const calendar = new Calendar('#calendar');
    calendar.init();
    // Раскраска😊
    calendarData.forEach(event => {
      const dayElement = document.querySelector(`[data-calendar-date="${event.date}"]`);
      if (dayElement) {
        if (event.rating === 'good') {
          dayElement.style.backgroundColor = 'green'; // Зелёный для 'good'
          dayElement.style.color = 'white'; // Цвет текста
        } else if (event.rating === 'bad') {
          dayElement.style.backgroundColor = 'red'; // Красный для 'bad'
          dayElement.style.color = 'white'; // Цвет текста
        }
      }
    });
  } else {
    console.error('#calendar is not found');
  }
});
