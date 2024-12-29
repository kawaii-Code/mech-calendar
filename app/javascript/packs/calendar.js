import { Calendar } from 'vanilla-calendar-pro';
import 'vanilla-calendar-pro/styles/index.css';

async function fetchCalendarData() {
  const response = await fetch('/calendar_data');
  return response.json();
}

document.addEventListener('DOMContentLoaded', async () =>  {
  const calendarElement = document.getElementById('calendar');
  if (calendarElement) {
    const calendarData = await fetchCalendarData();
    const calendar = new Calendar('#calendar');
    calendar.init();

    // Раскраска😊
    calendarData.forEach(day => {
      const dayElement = document.querySelector(`[data-vc-date="${day.date}"]`);
      if (dayElement) {
        if (day.rating === 'good') {
          dayElement.style.backgroundColor = 'green'; // Цвет фона зелёный для 'good' - красный для 'bad'
          dayElement.style.color = 'white'; // Цвет текста
        } else if (day.rating === 'bad') {
          dayElement.style.backgroundColor = 'red';
          dayElement.style.color = 'white';
        }
      }
    });
  } else {
    console.error('#calendar is not found');
  }
});
