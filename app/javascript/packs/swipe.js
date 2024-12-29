const threshold = 20;
let startX;
let leftGradient;
let rightGradient;
let neutralFace;
let sadFace;
let smilingFace;

document.addEventListener('DOMContentLoaded', () => {
    const widget = document.getElementById('swipe-widget');
    leftGradient = document.getElementById('left-gradient');
    rightGradient = document.getElementById('right-gradient');

    widget.style.borderRadius = '40px';

    neutralFace = document.getElementById('neutral-face');
    sadFace = document.getElementById('sad-face');
    smilingFace = document.getElementById('smiling-face');

    widget.addEventListener('touchstart', (e) => {
        startX = e.touches[0].clientX;
        widget.style.transition = 'none';

        showElement(leftGradient);
        showElement(rightGradient);
        showElement(smilingFace);
        showElement(sadFace);
    });

    let lastX;
    widget.addEventListener('touchmove', (e) => {
        const currentX = e.touches[0].clientX;
        const diffX = currentX - startX;
        moveWidget(widget, diffX);
        lastX = currentX;
    });

    widget.addEventListener('touchend', (e) => {
        const currentX = lastX;
        if (isMouseAtLeftBorder(currentX)) {
            sendDayReview('bad');
            return;
        }

        if (isMouseAtRightBorder(currentX))  {
            sendDayReview('good');
            return;
        }

        widget.style.transform = 'translateX(0)';
        widget.style.backgroundColor = 'white';
        widget.style.transition = 'background-color 0.3s ease, transform 0.3s ease';

        neutralFace.style.opacity = 1;
        hideElement(smilingFace);
        hideElement(sadFace);
        hideElement(leftGradient);
        hideElement(rightGradient);
    });

    widget.addEventListener('mousedown', (e) => {
        startX = e.clientX;

        showElement(leftGradient);
        showElement(rightGradient);
        showElement(smilingFace);
        showElement(sadFace);

        widget.style.transition = 'none';
        widget.style.cursor = 'grabbing';
        
        const mouseMoveHandler = (e) => {
            const currentX = e.clientX;
            const diffX = currentX - startX;
            moveWidget(widget, diffX);
        };

        const mouseUpHandler = (e) => {
            const mouseX = e.clientX;
            if (isMouseAtLeftBorder(mouseX)) {
                sendDayReview('bad');
                return;
            }

            if (isMouseAtRightBorder(mouseX))  {
                sendDayReview('good');
                return;
            }

            widget.style.transform = 'translate(0, 0)';
            widget.style.backgroundColor = 'white';
            widget.style.transition = 'background-color 0.3s ease, transform 0.3s ease';
            widget.style.cursor = 'grab';

            hideElement(smilingFace);
            hideElement(sadFace);
            hideElement(rightGradient);
            hideElement(leftGradient);

            document.removeEventListener('mousemove', mouseMoveHandler);
            document.removeEventListener('mouseup', mouseUpHandler);
        };

        document.addEventListener('mousemove', mouseMoveHandler);
        document.addEventListener('mouseup', mouseUpHandler);
    });
});

function showElement(elem) {
    elem.classList.remove('hidden');
    elem.style.opacity = 0;
}

function hideElement(elem) {
    elem.classList.add('hidden');
}

function sendDayReview(rating) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    fetch('/day/new?rating=' + rating, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken
        },
    }).then(response => {
        if (!response.ok) {
            console.error('error on post to /bad_day!');
        }
        location.reload();
    }).catch(error => {
        console.error('Error during POST: ', error);
    });
}

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

    if (diffX <= 0) {
        const t = (-diffX / startX)
        const redValue = 255 * t;

        widget.style.backgroundColor = `rgb(255, ${255 - redValue}, ${255 - redValue})`;
        leftGradient.style.opacity = t;
        rightGradient.style.opacity = 0;

        sadFace.style.opacity = t;
    } else {
        const t = diffX / (windowWidth - startX)
        const greenValue = 255 * t;

        widget.style.backgroundColor = `rgb(${255 - greenValue}, 255, ${255 - greenValue})`;
        leftGradient.style.opacity = 0;
        rightGradient.style.opacity = t;

        smilingFace.style.opacity = t;
    }
}
