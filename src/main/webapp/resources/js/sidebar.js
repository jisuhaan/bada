/* EXPANDER MENU */
const showMenu = (toggleId, navbarId, bodyId) => {
    const toggle = document.getElementById(toggleId),
        navbar = document.getElementById(navbarId),
        bodypadding = document.getElementById(bodyId);

    if (toggle && navbar) {
        toggle.addEventListener('click', () => {
            navbar.classList.toggle('expander');
            bodypadding.classList.toggle('body-pd');
        });
    }
}

showMenu('nav-toggle', 'navbar', 'body-pd');

/* LINK ACTIVE */
const linkColor = document.querySelectorAll('.nav__link');

function colorLink() {
    linkColor.forEach(l => l.classList.remove('active'));
    this.classList.add('active');
}

linkColor.forEach(l => l.addEventListener('click', colorLink));


/* COLLAPSE MENU */
const parentLinks = document.querySelectorAll('.nav__link');
const collapseMenus = document.querySelectorAll('.collapse__menu');

parentLinks.forEach((parentLink, index) => {
    parentLink.addEventListener('mouseenter', function() {
        const currentMenu = this.nextElementSibling;
        if (currentMenu.classList.contains('collapse__menu')) {
            collapseMenus.forEach(menu => {
                menu.classList.remove('showCollapse');
            });
            currentMenu.classList.add('showCollapse');
        } else {
            collapseMenus.forEach(menu => {
                menu.classList.remove('showCollapse');
            });
        }
    });

    parentLink.addEventListener('mouseleave', function() {
        collapseMenus.forEach(menu => {
            menu.classList.remove('showCollapse');
        });
    });
});

// 작은 방향 버튼에 대한 이벤트 처리
const collapseLinks = document.querySelectorAll('.collapse__link');

collapseLinks.forEach(collapseLink => {
    collapseLink.addEventListener('mouseenter', function() {
        const parentMenu = this.parentNode.querySelector('.collapse__menu');
        collapseMenus.forEach(menu => {
            if (menu !== parentMenu) {
                menu.classList.remove('showCollapse');
            }
        });
        parentMenu.classList.add('showCollapse');
    });

    collapseLink.addEventListener('mouseleave', function() {
        collapseMenus.forEach(menu => {
            menu.classList.remove('showCollapse');
        });
    });
});


/* HOVER TO EXPAND */
const navbar = document.getElementById('navbar');
navbar.addEventListener('mouseenter', () => {
    navbar.classList.add('expander');
    document.getElementById('body-pd').classList.add('body-pd');
});
navbar.addEventListener('mouseleave', () => {
    navbar.classList.remove('expander');
    document.getElementById('body-pd').classList.remove('body-pd');
});
