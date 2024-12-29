import { Calendar } from 'vanilla-calendar-pro';
import 'vanilla-calendar-pro/styles/index.css';

async function fetchCalendarData() {
  const response = await fetch('/calendar_data');
  return response.json();
}

async function colorify() {
  const calendarData = await fetchCalendarData();

  //unproper Раскраска😧
  document.querySelectorAll('.vc-date button').forEach(but =>{
    but.style.color = 'black'
  })

  // proper Раскраска😊
  calendarData.forEach(day => {
    const dayElement = document.querySelector(`[data-vc-date="${day.date}"]`);
    if (dayElement) {
      if (dayElement.children.length > 0) {
        if (day.rating === 'good') {
          // Цвет фона зелёный для 'good' - красный для 'bad'
          dayElement.children.item(0).style.background = '#46eb34'
          dayElement.children.item(0).style.color = 'white';
        } else if (day.rating === 'bad') {
          dayElement.children.item(0).style.background = '#eb4034'
          dayElement.children.item(0).style.color = 'white';
        }
      }
    }
  });
}

document.addEventListener('DOMContentLoaded', async () =>  {
  const calendarElement = document.getElementById('calendar');

  if (calendarElement) {

    const calendar = new Calendar('#calendar', {
      async onUpdate(self)  {colorify()},
      async onShow(self)  {colorify()},
      async onClickArrow(self)  {colorify()},
      async onClickMonth(self, event) {colorify()},
      async onClickYear(self, event) {colorify()},
      async onClickWeekDay(self, number, year, dateEls, event) {colorify()},
      async onClickWeekNumber(self, number, year, dateEls, event) {colorify()},
      async onInit() {colorify()},
      displayDatesOutside: false,
    } );
    calendar.init();
  } else {
    console.error('#calendar is not found');
  }
});

function myShow(calendar) {
      console.log('hello');
}
