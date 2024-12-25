document.addEventListener('DOMContentLoaded', () => {
    const burger = document.getElementById('burger')
    const closeSidebarButton = document.getElementById('closeSidebar');
    const overlay = document.getElementById('overlay')
    const sidebar = document.getElementById('sidebar')

    burger.addEventListener('click', () => {
        sidebar.classList.toggle('-translate-x-full');
        overlay.classList.toggle('hidden');
    });

    closeSidebarButton.addEventListener('click', () => {
        sidebar.classList.add('-translate-x-full');
        overlay.classList.add('hidden');
    });

    overlay.addEventListener('click', () => {
        sidebar.classList.add('-translate-x-full');
        overlay.classList.add('hidden');
    });
});
