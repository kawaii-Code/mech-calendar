function updateDate() {
    const date = new Date();
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    document.getElementById('current-date').innerText = date.toLocaleDateString(undefined, options);
}

window.onload = updateDate;
