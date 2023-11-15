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

    const xValues = ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"];
    const yValues = [0.34, 1.24, 3.55, 6.4, 2.25, 4.0, 3.8, 2.3, 2.0, 5.7, 10.1];

    new Chart("myChart", {
    type: "line",
    data: {
    labels: xValues,
    datasets: [{
    fill: false,
    lineTension: 0,
    backgroundColor: "#ff0000",
    borderColor: "#1a73e8",
    data: yValues
}]
},
    options: {
    legend: {display: false},
    scales: {
    yAxes: [{ticks: {min: 0, max: 14}}],
}
}
});

