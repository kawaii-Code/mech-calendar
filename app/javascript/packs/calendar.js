import { Calendar } from 'vanilla-calendar-pro';
import 'vanilla-calendar-pro/styles/index.css';

document.addEventListener('DOMContentLoaded', () => {
  const calendarElement = document.getElementById('calendar');
  if (calendarElement) {
    const calendar = new Calendar('#calendar');
    calendar.init();
  } else {
    console.error('#calendar is not found');
  }
});
