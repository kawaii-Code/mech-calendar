const threshold = 20;
let leftGradient;
let startX;
let rightGradient;

document.addEventListener('DOMContentLoaded', () => {
    const widget = document.getElementById('swipe-widget');
    leftGradient = document.getElementById('left-gradient');
    rightGradient = document.getElementById('right-gradient');

    widget.addEventListener('touchstart', (e) => {
        startX = e.touches[0].clientX;
        widget.style.transition = 'none';
    });

    widget.addEventListener('touchmove', (e) => {
        const currentX = e.touches[0].clientX;
        const diffX = currentX - startX;
        moveWidget(widget, diffX);
    });

    widget.addEventListener('touchend', () => {
        widget.style.transform = 'translateX(0)';
        widget.style.backgroundColor = 'white';
        widget.style.transition = 'background-color 0.3s ease, transform 0.3s ease';
    });

    widget.addEventListener('mousedown', (e) => {
        startX = e.clientX;
        leftGradient.style.display = 'block';
        rightGradient.style.display = 'block';

        widget.style.transition = 'none';
        widget.style.cursor = 'grabbing';
        
        const mouseMoveHandler = (e) => {
            const currentX = e.clientX;
            const diffX = currentX - startX;
            moveWidget(widget, diffX);
        };

        const mouseUpHandler = (e) => {
            leftGradient.style.display = 'none';
            rightGradient.style.display = 'none';

            const mouseX = e.clientX;
            if (isMouseAtLeftBorder(mouseX)) {
                const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

                fetch('/day/new?rating=bad', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-Token': csrfToken
                    },
                }).then(response => {
                    if (!response.ok) {
                        console.error('error on post to /bad_day!');
                    }
                }).catch(error => {
                    console.error('Error during POST: ', error);
                });

                return;
            }

            if (isMouseAtRightBorder(mouseX))  {
                const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

                fetch('/day/new?rating=good', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-Token': csrfToken
                    }
                }).then(response => {
                    if (!response.ok) {
                        console.error('error on post to /good_day!');
                    }
                }).catch(error => {
                    console.error('Error during POST: ', error);
                });

                return;
            }

            widget.style.transform = 'translate(0, 0)';
            widget.style.backgroundColor = 'white';
            widget.style.transition = 'background-color 0.3s ease, transform 0.3s ease';
            widget.style.cursor = 'grab';

            document.removeEventListener('mousemove', mouseMoveHandler);
            document.removeEventListener('mouseup', mouseUpHandler);
        };

        document.addEventListener('mousemove', mouseMoveHandler);
        document.addEventListener('mouseup', mouseUpHandler);
    });
});

function isMouseAtLeftBorder(mouseX) {
    return mouseX < threshold;
}

function isMouseAtRightBorder(mouseX) {
    const windowWidth = window.innerWidth;
    return mouseX > windowWidth - threshold;
}

function moveWidget(widget, diffX) {
    const windowWidth = window.innerWidth;
    widget.style.transform = `translateX(${diffX}px)`;

    if (diffX > 0) {
        const t = diffX / (windowWidth - startX)
        const greenValue = 255 * t;
        widget.style.backgroundColor = `rgb(${255 - greenValue}, 255, ${255 - greenValue})`;

        leftGradient.style.opacity = 0;
        rightGradient.style.opacity = t;
    } else {
        const t = (-diffX / startX)
        const redValue = 255 * t;
        widget.style.backgroundColor = `rgb(255, ${255 - redValue}, ${255 - redValue})`;

        leftGradient.style.opacity = t;
        rightGradient.style.opacity = 0;
    }
}
