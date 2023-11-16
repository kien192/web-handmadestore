// add hovered class to selected list item
let list = document.querySelectorAll(".navigation li");
function  activeLink() {
    list.forEach(   (item) => {item.classList.remove("hovered");
    });
    this.classList.add("hovered");
}
list.forEach((item)=> {item.addEventListener("mouseover", activeLink);
});



// Điều hướng web:
var navItems = document.querySelectorAll('.nav-item');

navItems.forEach(function (item) {
    item.addEventListener('click', function () {


        var newPage = item.getAttribute('data-href');
        if(pageName) {
            window.location.href=pageName;
        }

    })

})







// Toggle dieu khien nav
let toggle = document.querySelector(".toggle");
let navigation = document.querySelector(".navigation");
let main = document.querySelector(".main");

toggle.onclick = function () {
    navigation.classList.toggle("active");
    main.classList.toggle("active");
};

// canvas vẽ biểu đồ



