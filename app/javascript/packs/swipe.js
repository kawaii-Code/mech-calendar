document.addEventListener('DOMContentLoaded', () => {
    const widget = document.getElementById('swipe-widget');

    let startX;

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

        widget.style.transition = 'none';
        widget.style.cursor = 'grabbing';
        
        const mouseMoveHandler = (e) => {
            const currentX = e.clientX;
            const diffX = currentX - startX;
            moveWidget(widget, diffX);
        };

        const mouseUpHandler = () => {
            widget.style.transform = 'translate(0, 0)';
            widget.style.backgroundColor = 'white';
            widget.style.transition = 'background-color 0.3s ease, transform 0.3s ease';
            widget.style.cursor = 'grab'; // Reset cursor

            document.removeEventListener('mousemove', mouseMoveHandler);
            document.removeEventListener('mouseup', mouseUpHandler);
        };

        document.addEventListener('mousemove', mouseMoveHandler);
        document.addEventListener('mouseup', mouseUpHandler);
    });
});

function moveWidget(widget, diffX) {
    widget.style.transform = `translateX(${diffX}px)`;

    if (diffX > 0) {
        const greenValue = Math.min(255, Math.floor((diffX / 200) * 255));
        widget.style.backgroundColor = `rgb(${255 - greenValue}, 255, ${255 - greenValue})`;
    } else {
        const redValue = Math.min(255, Math.floor((-diffX / 200) * 255));
        widget.style.backgroundColor = `rgb(255, ${255 - redValue}, ${255 - redValue})`;
    }
}
