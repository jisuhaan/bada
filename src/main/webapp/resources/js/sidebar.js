/* EXPANDER MENU */
const showMenu = (toggleId, navbarId, bodyId) => {
    const toggle = document.getElementById(toggleId),
        navbar = document.getElementById(navbarId),
        bodypadding = document.getElementById(bodyId);

    if (toggle && navbar) {
        toggle.addEventListener('click', () => {
            navbar.classList.toggle('fixed'); // Sidebar stays fixed when toggled
            bodypadding.classList.toggle('body-pd');
        });
    }
}

showMenu('nav-toggle', 'navbar', 'body-pd');

/* COLLAPSE MENU */
const collapseToggles = document.querySelectorAll('.collapse__link');
const collapseMenus = document.querySelectorAll('.collapse__menu');

// Toggle collapse menu on button click
collapseToggles.forEach(collapseToggle => {
    collapseToggle.addEventListener('click', function(event) {
        event.preventDefault(); // Prevent default action for the collapse button

        const currentMenu = this.parentNode.querySelector('.collapse__menu');
        if (currentMenu) {
            collapseMenus.forEach(menu => {
                if (menu !== currentMenu) {
                    menu.classList.remove('showCollapse');
                    menu.parentElement.classList.remove('fixed');
                }
            });
            currentMenu.classList.toggle('showCollapse');
            this.parentElement.classList.toggle('fixed');
        }
    });
});

/* HOVER TO SHOW COLLAPSE MENU */
const parentLinks = document.querySelectorAll('.nav__link.collapse');

parentLinks.forEach(parentLink => {
    parentLink.addEventListener('mouseenter', function() {
        const currentMenu = this.querySelector('.collapse__menu');
        if (currentMenu) {
            collapseMenus.forEach(menu => {
                if (menu !== currentMenu) {
                    menu.classList.remove('showCollapse');
                    menu.parentElement.classList.remove('fixed');
                }
            });
            currentMenu.classList.add('showCollapse');
            this.classList.add('fixed');
        }
    });

    parentLink.addEventListener('mouseleave', function() {
        const currentMenu = this.querySelector('.collapse__menu');
        if (currentMenu && !this.classList.contains('fixed')) {
            currentMenu.classList.remove('showCollapse');
            this.classList.remove('fixed');
        }
    });
});


/* HOVER TO EXPAND */
const navbar = document.getElementById('navbar');
navbar.addEventListener('mouseenter', () => {
    if (!navbar.classList.contains('fixed')) {
        navbar.classList.add('expander');
        document.getElementById('body-pd').classList.add('body-pd');
        document.getElementById('nav-toggle').classList.add('toggle-move');
    }
});
navbar.addEventListener('mouseleave', () => {
    if (!navbar.classList.contains('fixed')) {
        navbar.classList.remove('expander');
        document.getElementById('body-pd').classList.remove('body-pd');
        document.getElementById('nav-toggle').classList.remove('toggle-move');
    }
});
