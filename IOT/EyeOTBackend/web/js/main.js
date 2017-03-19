//**********************************
//Misc Stuff
//**********************************

//Datepicker
$('.datepicker').datepicker({
    autoclose: true,
    todayHighlight: true,
    maxViewMode: 2,
    endDate: "today",
    orientation: "bottom left"
});

$(document).ready(function () {
    var d = new Date();
    $(".datepicker").val(returnCorrectDate(d));

    setInterval(function () {
        var today = new Date();
        $("#currentTime").text(returnCorrectDate(today) + " " + returnCorrectTime(today))
    }, 1000);

    activeDutyTable(d);

})

$("#notify-send-sms").click(function () {
    progressBarNotification();
    setTimeout(function () {
        sendSMSSuccessfully();
    }, 4000);
});

function sendSMSSuccessfully() {
    $.notify({
        icon: 'glyphicon glyphicon-phone',
        title: "<strong>Successful Message Notification</strong><br>:",
        message: "You have successfully sent the message to X."
    }, {
        showProgressbar: false,
        placement: {
            from: "top",
            align: "center"
        },
        type: 'success'
    });
}

function progressBarNotification() {
    $.notify({
        icon: 'glyphicon glyphicon-hourglass',
        title: "Loading",
        message: ""
    }, {
        showProgressbar: true,
        placement: {
            from: "top",
            align: "center"
        },
        type: 'info',
        delay: 2000,
        timer: 1000,
    });
}

function activeDutyTable(date) {
    var hour = date.getHours();
    var list = [];
    for (var i = hour; i <= 23; i++) {
        list.push(i);
    }
    for (var i = 0; i < hour; i++) {
        list.push(i);
    }

    for (x in list) {
        if (list[x] < 8 | list[x] == 23) {
            $("#duty-table").append("<tr class=\"duty-table-closed\">" +
                "<td style=\"text-align:center;\">" + convertSingleValueTime(list[x]) +
                "</td><td style=\"padding-left:20px;\">" +
                "<span>Closed</span></td></tr>");
        } else {
            rand = Math.random()
            switch (true) {
            case (rand < 0.1):
                $("#duty-table").append("<tr><td class=\"duty-table-centered\" style=\"text-align:center;\">" +
                    convertSingleValueTime(list[x]) + "</td><td style=\"padding-left:20px;\">" +
                    "<img src=\"img/wj.png\" class=\"image-responsive duty-img\">" +
                    "</td></tr>");
                break;
            case (rand < 0.2):
                $("#duty-table").append("<tr><td class=\"duty-table-centered\" style=\"text-align:center;\">" +
                    convertSingleValueTime(list[x]) + "</td><td style=\"padding-left:20px;\">" +
                    "<img src=\"img/mh.png\" class=\"image-responsive duty-img\">" +
                    "</td></tr>");
                break;
            case (rand < 0.3):
                $("#duty-table").append("<tr><td class=\"duty-table-centered\" style=\"text-align:center;\">" +
                    convertSingleValueTime(list[x]) + "</td><td style=\"padding-left:20px;\">" +
                    "<img src=\"img/merv.png\" class=\"image-responsive duty-img\">" +
                    "</td></tr>");
                break;
            case (rand < 0.4):
                $("#duty-table").append("<tr><td class=\"duty-table-centered\" style=\"text-align:center;\">" +
                    convertSingleValueTime(list[x]) + "</td><td style=\"padding-left:20px;\">" +
                    "<img src=\"img/wj.png\" class=\"image-responsive duty-img\">" +
                    "<img src=\"img/mh.png\" class=\"image-responsive duty-img\">" +
                    "</td></tr>");
                break;
            case (rand < 0.5):
                $("#duty-table").append("<tr><td class=\"duty-table-centered\" style=\"text-align:center;\">" +
                    convertSingleValueTime(list[x]) + "</td><td style=\"padding-left:20px;\">" +
                    "<img src=\"img/wj.png\" class=\"image-responsive duty-img\">" +
                    "<img src=\"img/merv.png\" class=\"image-responsive duty-img\">" +
                    "</td></tr>");
                break;
            case (rand < 0.6):
                $("#duty-table").append("<tr><td class=\"duty-table-centered\" style=\"text-align:center;\">" +
                    convertSingleValueTime(list[x]) + "</td><td style=\"padding-left:20px;\">" +
                    "<img src=\"img/mh.png\" class=\"image-responsive duty-img\">" +
                    "<img src=\"img/merv.png\" class=\"image-responsive duty-img\">" +
                    "</td></tr>");
                break;
            default:
                $("#duty-table").append("<tr><td class=\"duty-table-centered\" style=\"text-align:center;\">" +
                    convertSingleValueTime(list[x]) + "</td><td style=\"padding-left:20px;\">" +
                    "<img src=\"img/wj.png\" class=\"image-responsive duty-img\">" +
                    "<img src=\"img/mh.png\" class=\"image-responsive duty-img\">" +
                    "<img src=\"img/merv.png\" class=\"image-responsive duty-img\">" +
                    "</td></tr>");
                break;
            }

        }

    }

}

function returnCorrectDate(date) {
    var day = date.getDate();
    var month = date.getMonth();
    var year = date.getFullYear() - 2000;

    switch (month) {
    case 0:
        month = "Jan"
        break;
    case 1:
        month = "Feb"
        break;
    case 2:
        month = "Mar"
        break;
    case 3:
        month = "Apr"
        break;
    case 4:
        month = "May"
        break;
    case 5:
        month = "Jun"
        break;
    case 6:
        month = "Jul"
        break;
    case 7:
        month = "Aug"
        break;
    case 8:
        month = "Sep"
        break;
    case 9:
        month = "Oct"
        break;
    case 10:
        month = "Nov"
        break;
    case 11:
        month = "Dec"
        break;
    }

    day = convertSingleValueTime(day)

    return (day + "-" + month + "-" + year)
}

function returnCorrectTime(date) {
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var sec = date.getSeconds();

    hours = convertSingleValueTime(hours)
    minutes = convertSingleValueTime(minutes)
    sec = convertSingleValueTime(sec)

    return (hours + ":" + minutes + ":" + sec)
}

function convertSingleValueTime(int) {
    if (int < 10) {
        int = "0" + int;
    }
    return int
}

//**********************************
//JS - Current Time
//**********************************



//**********************************
//D3 - HeatMap
//**********************************
var margin = {
        top: 20,
        right: 30,
        bottom: 0,
        left: 50
    },
    width = 1080 - margin.left - margin.right,
    height = 300 - margin.top - margin.bottom,
    gridSize = Math.floor(width / 24),
    legendElementWidth = (width / 6) - 90,
    buckets = 9,
    colors = ['#eff3ff', '#c6dbef', '#9ecae1', '#6baed6', '#4292c6', '#2171b5', '#084594'],
    oppcolors = ['#000000', '#000000', '#000000', '#000000', '#ffffff', '#ffffff', '#ffffff'],
    days = ["Exit 1", "Exit 2", "Exit 3", "Exit 4", "Exit 5", "Exit 6"],
    times = ["08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"];

var svg = d3.select("#heatMap").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var tip = d3.tip()
    .attr('class', 'd3-tip')
    .offset([-10, 0])
    .html(function (d) {
        return "<strong>No. of Alarms Triggered: </strong> <span style='color:#6baed6'>" + d.value + "</span><br>At time: <span style='color:#6baed6'>" + (d.hour - 1) + ":00 - " + (d.hour - 1) + ":59</span><br>At Exit: <span style='color:#6baed6'>" + d.exit + "</span>";
    })

svg.call(tip);

var dayLabels = svg.selectAll(".dayLabel")
    .data(days)
    .enter().append("text")
    .text(function (d) {
        return d;
    })
    .attr("x", 0)
    .attr("y", function (d, i) {
        return i * gridSize;
    })
    .style("text-anchor", "end")
    .attr("transform", "translate(-6," + gridSize / 1.5 + ")")
    .attr("class", "dayLabel mono axis");

var timeLabels = svg.selectAll(".timeLabel")
    .data(times)
    .enter().append("text")
    .text(function (d) {
        return d;
    })
    .attr("x", function (d, i) {
        return i * gridSize;
    })
    .attr("y", 0)
    .style("text-anchor", "middle")
    .attr("transform", "translate(" + gridSize / 2 + ", -6)")
    .attr("class", "timeLabel mono axis");

var heatmapChart = function () {
    d3.csv("../data/fakelinedata.csv",
        function (d) {
            return {
                exit: +d.exit,
                hour: +d.hour,
                value: +d.value
            };
        },
        function (error, data) {
            var colorScale = d3.scale.quantile()
                .domain([0, buckets - 1, d3.max(data, function (d) {
                    return d.value;
                })])
                .range(colors);

            var cards = svg.selectAll(".hour")
                .data(data, function (d) {
                    return d.exit + ':' + d.hour;
                });

            cards.append("title");

            cards.enter().append("rect")
                .attr("x", function (d) {
                    return (d.hour - 1) * gridSize;
                })
                .attr("y", function (d) {
                    return (d.exit - 1) * gridSize;
                })
                .attr("rx", 4)
                .attr("ry", 4)
                .attr("class", "hour bordered")
                .attr("width", gridSize)
                .attr("height", gridSize)
                .style("fill", colors[0])
                .on('mouseover', tip.show)
                .on('mouseout', tip.hide);

            cards.transition().duration(1000)
                .style("fill", function (d) {
                    return colorScale(d.value);
                });

            cards.exit().remove();

            var legend = svg.selectAll(".legend")
                .data([0].concat(colorScale.quantiles()), function (d) {
                    return d;
                });

            legend.enter().append("g")
                .attr("class", "legend");

            legend.append("rect")
                .attr("x", function (d, i) {
                    return legendElementWidth * i;
                })
                .attr("y", height - 20)
                .attr("width", legendElementWidth)
                .attr("height", gridSize / 2)
                .style("fill", function (d, i) {
                    return colors[i];
                });

            legend.append("text")
                .attr("class", "mono")
                .text(function (d) {
                    return "≥ " + Math.round(d);
                })
                .attr("x", function (d, i) {
                    return legendElementWidth * i + 50;
                })
                .attr("y", height - 5)
                .style("fill", function (d, i) {
                    return oppcolors[i];
                });

            legend.exit().remove();


        });
};

heatmapChart();

//**********************************
//D3 - Line Graph
//**********************************
/*var margin = {
        top: 20,
        right: 30,
        bottom: 0,
        left: 50
    },
    width = 1080 - margin.left - margin.right,
    height = 300 - margin.top - margin.bottom

var lineGraph = function () {
    d3.csv("../data/faketimedata.csv",
        function (d) {
            return {
                date: +d.date,
                stolen: +d.stolen,
                triggered: +d.triggered
            };
        },
        function (error, data) {
            var colorScale = d3.scale.quantile()
                .domain([0, buckets - 1, d3.max(data, function (d) {
                    return d.value;
                })])
                .range(colors);

            var cards = svg.selectAll(".hour")
                .data(data, function (d) {
                    return d.exit + ':' + d.hour;
                });

            cards.append("title");

            cards.enter().append("rect")
                .attr("x", function (d) {
                    return (d.hour - 1) * gridSize;
                })
                .attr("y", function (d) {
                    return (d.exit - 1) * gridSize;
                })
                .attr("rx", 4)
                .attr("ry", 4)
                .attr("class", "hour bordered")
                .attr("width", gridSize)
                .attr("height", gridSize)
                .style("fill", colors[0])
                .on('mouseover', tip.show)
                .on('mouseout', tip.hide);

            cards.transition().duration(1000)
                .style("fill", function (d) {
                    return colorScale(d.value);
                });

            cards.exit().remove();
        });
}

lineGraph();*/