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

$("#datepicker").change(function () {
    var d = $("#datepicker").val();
    var month = "";
    switch (d.split("-")[1]) {
        case "Jan":
            month = "01";
            break;
        case "Feb":
            month = "02";
            break;
        case "Mar":
            month = "03";
            break;
        case "Apr":
            month = "04";
            break;
        case "May":
            month = "05";
            break;
        case "Jun":
            month = "06";
            break;
        case "Jul":
            month = "07";
            break;
        case "Aug":
            month = "08";
            break;
        case "Sep":
            month = "09";
            break;
        case "Oct":
            month = "10";
            break;
        case "Nov":
            month = "11";
            break;
        case "Dec":
            month = "12";
            break;

    }

    retrieveDaily("20" + d.split("-")[2] + "-" + month + "-" + d.split("-")[0] + " 12:00:00");
});

function returnCorrectDate(date) {
    var day = date.getDate();
    var month = date.getMonth();
    var year = date.getFullYear() - 2000;

    switch (month) {
        case 0:
            month = "Jan";
            break;
        case 1:
            month = "Feb";
            break;
        case 2:
            month = "Mar";
            break;
        case 3:
            month = "Apr";
            break;
        case 4:
            month = "May";
            break;
        case 5:
            month = "Jun";
            break;
        case 6:
            month = "Jul";
            break;
        case 7:
            month = "Aug";
            break;
        case 8:
            month = "Sep";
            break;
        case 9:
            month = "Oct";
            break;
        case 10:
            month = "Nov";
            break;
        case 11:
            month = "Dec";
            break;
    }
    day = convertSingleValueTime(day);
    return (day + "-" + month + "-" + year);
}

function returnCorrectTime(date) {
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var sec = date.getSeconds();

    hours = convertSingleValueTime(hours);
    minutes = convertSingleValueTime(minutes);
    sec = convertSingleValueTime(sec);

    return (hours + ":" + minutes + ":" + sec);
}

function convertSingleValueTime(int) {
    if (int < 10) {
        int = "0" + int;
    }
    return int;
}

$(document).ready(function () {
    var d = new Date();
    $(".datepicker").val(returnCorrectDate(d));

    setInterval(function () {
        var today = new Date();
        $("#currentTime").text(returnCorrectTime(today));
        actionableFunction($("#overview-missing").text()/$("#overview-total").text()*100);
    }, 1000);

    activeDutyTable(d);

    timeSeriesMonth();
    setTimeout(function () {
        $('[data-toggle="tooltip"]').tooltip();

        $("#actionable-overview").click(function () {
            console.log("overview");
            $("#sms-textArea").text("Hi, NTUC Fairprice now has more than 20% of lost trolleys. Please go around the estate to retrieve these unreturned trolleys. Thank you.");
        });

        $("#actionable-battery").click(function () {
            console.log("battery");
            $("#sms-textArea").text("Hi, The battery for shopping Cart [Cart] at [Location] is running low. Please proceed to that location to change the batteries now. Thank you.");
        });


        $(".replacing-battery").click(function () {
            console.log("replacing battery");
            var cID = $(this).parent().parent().text().substring(0, 1);
            console.log(cID);
            $.ajax({
                url: 'SendTrolleyDataAlarm',
                data: {
                    trolleyID: cID
                },
                success: function (responseText) {
                    $("#battery-table").html("");
                    retrieveBattery();
                }
            });
        });

    }, 2000);

    retrieveMonth();
    retrieveWeekly();
    retrieveOverview();
    //final date is "2017-04-03 17:36:02"
    var date = d.getFullYear() + "-" + convertSingleValueTime(d.getMonth() + 1) + "-" + convertSingleValueTime(d.getDate()) + " " + returnCorrectTime(d);
    console.log(date);
    retrieveDaily(date);
    retrieveBattery();

    // To generate enforcer schedule dynamically in MODAL
    getEnforcementOfficerSchedule(date, function (responseText) {
        response = JSON.parse(responseText);
        for (var x = 0; x < response.length; x++)
        {
            var single = response[x];
            var officerName = single.officer.name;
            var phoneNum = single.officer.phoneNum;

            $('#enforcement-select').append($('<option>', {
                value: phoneNum,
                text: officerName
            }));
        }

    })

});


$("#sync").click(function () {
    var today = new Date();
    retrieveMonth();
    retrieveWeekly();
    retrieveOverview();
    //final date is "2017-04-03 17:36:02"
    var date = today.getFullYear() + "-" + convertSingleValueTime(today.getMonth() + 1) + "-" + convertSingleValueTime(today.getDate()) + " " + returnCorrectTime(today);
    retrieveDaily(date);
    retrieveBattery();
});

//**********************************
//For OverView/ Duty Table/Battery
//**********************************
function retrieveBattery() {
    $.ajax({
        url: 'RetrieveTrolleyBattery',
        success: function (responseText) {
            response = JSON.parse(responseText);
            for (var i = 0; i < Object.keys(response).length; i++) {
                //calculate time
                var today = new Date();
                var trolleyID = Object.keys(response)[i];
                var lastBatt = new Date(response[Object.keys(response)[i]]);
                var seconds = (today - lastBatt) / 1000;
                console.log(seconds);
                //calculate battery, via linear regression
                var remainBatt = (67694 - seconds) / 67694 * 100;
                if (remainBatt < 0) {
                    remainBatt = 0;
                }
                batteryTable(trolleyID, remainBatt);
            }
        }
    });
}

function retrieveOverview() {
    $.ajax({
        url: 'RetrieveTrolleyOverview',
        success: function (responseText) {
            console.log(responseText);
            response = JSON.parse(responseText);
            var total = response.total_trolley;
            var missing = response.missing_trolley;
            var current = total - missing;
            var percent = (Math.floor(((total - missing) / total) * 100));

            $("#overview-current").text(current);
            $("#overview-missing").text(missing);
            $("#overview-total").text(total);

            if (percent >= 20) {
                $(".overview").css("background-color", "#e74c3c");
                $(".overview div span").css("color", "#fff");
            } else if (percent >= 10) {
                $(".overview").css("background-color", "#f1c40f");
                $(".overview div span").css("color", "#fff");
            } else {
                $(".overview").css("background-color", "#2ecc71");
                $(".overview div span").css("color", "#fff");
            }


        }
    });
}

var batteryTable = function (trolleyID, batt) {
    console.log(batt);
    var tableRow = "";

    if (batt < 20) {
        tableRow = "<tr class=\"danger danger-table\" id=\"danger-table\"><td>" + trolleyID + "</td><td>Point1</td><td>" + batt.toString().substring(0, 4) + "% </td><td>" +
                "<a title=\"Battery Replaced\" class=\"replacing-battery\" style=\"color:black;\">" +
                "<i class=\"fa fa-battery-1\" aria-hidden=\"true\" style=\"margin-left: 5px;\"></i></a></td></tr>";
    } else if (batt < 50) {
        tableRow = "<tr class=\"warning\"><td>" + trolleyID + "</td><td>Point1</td><td>" + batt.toString().substring(0, 4) + "% </td><td>" +
                "<a title=\"Battery Replaced\" class=\"replacing-battery\" style=\"color:black;\">" +
                "<i class=\"fa fa-battery-half\" aria-hidden=\"true\" style=\"margin-left: 5px;\"></i></a></td></tr>";
    } else {
        tableRow = "<tr class=\"success\"><td>" + trolleyID + "</td><td>Point1</td><td>" + batt.toString().substring(0, 4) + "% </td><td>" +
                "<a title=\"Battery Replaced\" class=\"replacing-battery\" style=\"color:black;\">" +
                "<i class=\"fa fa-battery-full\" aria-hidden=\"true\" style=\"margin-left: 5px;\"></i></a></td></tr>";
    }

    $("#battery-table").append(tableRow);
};

//KUNSHENG CHANGE HERE FOR THE DUTY TABLE
function activeDutyTable(date) {
    var hour = date.getHours();
    var list = [];
    for (var i = hour; i <= 23; i++) {
        list.push(i);
    }
    for (var i = 0; i < hour; i++) {
        list.push(i);
    }

//    for (x in list) {
//        if (list[x] < 8 | list[x] == 23) {
//            $("#duty-table").append("<tr class=\"duty-table-closed\">" +
//                    "<td style=\"text-align:center;\">" + convertSingleValueTime(list[x]) +
//                    "</td><td style=\"padding-left:20px;\">" +
//                    "<span>Closed</span></td></tr>");
//        } else {

    var d = new Date();
    var date = d.getFullYear() + "-" + convertSingleValueTime(d.getMonth() + 1) + "-" + convertSingleValueTime(d.getDate()) + " " + returnCorrectTime(d);

    getEnforcementOfficerSchedule(date, function (response) {

        var scheduleMap = mapOfficerToHour(response);
        for (var x = 0; x < 24; x++)
        {

            var list = scheduleMap[x];
            if (list !== undefined)
            {
                var append = "<tr><td class=\"duty-table-centered\" style=\"text-align:center;\">" +
                        x + "</td><td style=\"padding-left:20px;\">";

                for (var i = 0; i < list.length; i++) {
                    var single = list[i];

                    append += "<img src=\"" + single.officer.image + "\" class=\"image-responsive duty-img\" data-toggle=\"tooltip\" title=" + single.officer.phoneNum + ">";
//                        append +="<img src=\"img/mh.png\" class=\"image-responsive duty-img\" data-toggle=\"tooltip\" title="+single.officer.phoneNum+">";
                }
                append += "</td></tr>";
                $("#duty-table").append(append);

            } else
            {
                $("#duty-table").append("<tr class=\"duty-table-closed\">" +
                        "<td style=\"text-align:center;\">" + x +
                        "</td><td style=\"padding-left:20px;\">" +
                        "<span>Closed</span></td></tr>");
            }

        }

    });
//        }
//}
}


function mapOfficerToHour(data) {
    var response = JSON.parse(data);
    var scheduleMap = {};
    for (var x = 0; x < 24; x++)
    {
        for (var i = 0; i < response.length; i++)
        {
            var single = response[i];
            var officerName = single.officer.name;
            var phoneNum = single.officer.phoneNum;
            var startTime = single.startTime;
            var endTime = single.endTime;
            var image = single.officer.image;


            if (x > startTime && x < endTime)
            {
                var list = scheduleMap[x];
                if (list === undefined)
                {
                    list = [];
                }
                list.push(single);
                scheduleMap[x] = list;
            }

        }

    }
    return scheduleMap;


}





//**********************************
//For Actionables/Modal/SMS
//**********************************
var actionableFunction = function (percent) {
    var today = new Date();
    var battery = "";
    var customButton = "<tr><td colspan=\"3\"><center><button type=\"button\" class=\"btn btn-success\" style=\"font-size: 1em; margin-top: 10px; width: 100%;\"" +
            "data-toggle=\"modal\" data-target=\".send-sms-modal\" id=\"actionable-custom\">Send Custom SMS</button></center></td></tr>";

    if (percent >= 20) {
        var overview = "<tr><td>" + returnCorrectTime(today) + "</td><td> Number of missing trolleys is more than 20%.</td><td><button type=\"button\" id=\"actionable-overview\"\n\
            data-toggle=\"modal\" data-target=\".send-sms-modal\" class=\"btn btn-danger\">Send SMS</button></td></tr>";
    }

    var battArr = $(".danger-table").text().split(" ");

    for (var i = 0; i < battArr.length - 1; i++) {
        var trolleyID = battArr[i].substring(0, 1);
        var batteryLvl = battArr[i].substring(7, battArr[i].length - 1);

        if (batteryLvl < 20) {
            battery = battery + actionableBattery(trolleyID, 1);
        }
    }

    var actionTable = overview + battery + customButton;

    $("#actionable-table").html(actionTable);
};

var actionableBattery = function (trolleyID, location) {
    var today = new Date();
    return "<tr><td>" + returnCorrectTime(today) + "</td><td>Shopping Cart " + trolleyID + " at Location " + location +
            " needs to be recharged.</td><td><button type=\"button\"  id=\"actionable-battery\" class=\"btn btn-danger\" data-toggle=\"modal\" data-target=\".send-sms-modal\">" +
            "Send SMS</button></td></tr>";
};


$("#enforcement-select").change(function () {
    console.log($("#enforcement-select").val());
    if ($("#enforcement-select").val() !== "<Manual Input>") {
        $("#sms-textArea").text("Hi, " + $("#enforcement-select").val() + " NTUC Fairprice now has more than 20% of lost trolleys. Please go around the estate to retrieve these unreturned trolleys. Thank you.");
    } else {
        $("#sms-textArea").text("Hi, NTUC Fairprice now has more than 20% of lost trolleys. Please go around the estate to retrieve these unreturned trolleys. Thank you.");
    }
});

// Called when document load to generate enforcer schedule dynamically in MODAL
function getEnforcementOfficerSchedule(date, response) {
    $.ajax({
        url: 'RetrieveEmployeeSchedule',
        data: {
            date: date
        },
        success: response
    });
}

function sendSMS(phone_no, msg) {
//    alert(phone_no);
    $.ajax({
        url: 'SendSMS',
        data: {phone_no: phone_no, msg: msg},
        success: function (responseText) {
            response = JSON.parse(responseText);
        }
    });
}
//==========================================================================================================================
$("#notify-send-sms").click(function () {
    var phone_no = $('#sms-mobile').val();
    var dropdown_num = $('#enforcement-select').val();
    var msg = $('#sms-textArea').val();

    if (phone_no == null || phone_no == undefined || phone_no.length < 1) {
        phone_no = dropdown_num;
    }

    progressBarNotification();
    setTimeout(function () {
        //alert("The value is : "+phone_no + ", " + msg);
        sendSMS(phone_no, msg);
        //sendSMSSuccessfully();
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
        timer: 1000
    });
}

//**********************************
//For Time Series Analysis/ HeatMap or Map
//**********************************

$("#time-series-select").change(function () {
    var timeFilter = $("#time-series-select").val();
    if (timeFilter === "By Week") {
        retrieveWeekly();
    } else {
        retrieveMonth();
    }
});

timeSeriesMonth = function (obj) {
    var alarmChart = new CanvasJS.Chart("chartContainer",
            {
                animationEnabled: true,
                axisX: {
                    lineDashType: "dot",
                    lineThickness: 2,
                    title: "Month"
                },
                axisY: {
                    gridThickness: 0,
                    title: "Alarms Triggered"
                },
                data: [{
                        type: "area",
                        color: "rgba(0,135,147,.5)",
                        toolTipContent: "<b><span style='\"'color: blue;'\"'>{label}</span></b><br/><strong>Total Alarms Triggered:</strong> {y}",
                        dataPoints: obj
                    }]
            });
    alarmChart.render();
}

timeSeriesWeek = function (obj) {
    var alarmChart = new CanvasJS.Chart("chartContainer",
            {
                animationEnabled: true,
                axisX: {
                    lineDashType: "dot",
                    lineThickness: 2,
                    title: "Alarms Triggered",
                    interval: 1,
                },
                axisY: {
                    gridThickness: 0,
                    title: "Month"

                },
                data: [{
                        type: "area",
                        color: "rgba(0,135,147,.5)",
                        dataPoints: obj
                    }]
            });
    alarmChart.render();
};

function retrieveDaily(today) {
    $.ajax({
        url: 'RetrieveDailyTriggeredAlarm',
        data: {
            date: today
        },
        success: function (responseText) {
            response = JSON.parse(responseText);
            var result = [];
//            console.log(responseText);
            var sum29 = 0;
            var sum28 = 0;
            var sumA = 0;
            var sumB = 0;
            for (var i = 8; i < 23; i++) {
//                console.log(Object.keys(response)[i]);
                arr = response[Object.keys(response)[i]][convertSingleValueTime(Object.keys(response)[i])];
                var e1 = arr[0]["At exit 28"][0]["occurence"];
                var e2 = arr[1]["At exit 29"][0]["occurence"];
                var e3 = arr[2]["At exit B"][0]["occurence"];
                var e4 = arr[3]["At exit A"][0]["occurence"];

                if (e1 == null) {
                    result.push({"exit": 3, "hour": parseInt(Object.keys(response)[i]) - 7, "value": 0});
                } else {
                    result.push({"exit": 3, "hour": parseInt(Object.keys(response)[i]) - 7, "value": e1});
                    sum28 += parseInt(e1);
                }

                if (e2 == null) {
                    result.push({"exit": 4, "hour": parseInt(Object.keys(response)[i]) - 7, "value": 0});
                } else {
                    result.push({"exit": 4, "hour": parseInt(Object.keys(response)[i]) - 7, "value": e2});
                    sum29 += parseInt(e2);
                }

                if (e3 == null) {
                    result.push({"exit": 2, "hour": parseInt(Object.keys(response)[i]) - 7, "value": 0});
                } else {
                    result.push({"exit": 2, "hour": parseInt(Object.keys(response)[i]) - 7, "value": e3});
                    sumB += parseInt(e3);
                }

                if (e4 == null) {
                    result.push({"exit": 1, "hour": parseInt(Object.keys(response)[i]) - 7, "value": 0});
                } else {
                    result.push({"exit": 1, "hour": parseInt(Object.keys(response)[i]) - 7, "value": e4});
                    sumA += parseInt(e4);
                }
            }
            $("#block1").text("Exit A: " + sumA);
            $("#block2").text("Exit B: " + sumB);
            $("#block3").text("Exit 28: " + sum28);
            $("#block4").text("Exit 29: " + +sum29);
            heatmapChart(result);
        }


    });
}

function retrieveMonth() {
    $.ajax({
        url: 'RetrieveMonthlyTriggeredAlarm',
        success: function (responseText) {
            response = JSON.parse(responseText);
            var result = [];
            for (var i = 0; i < Object.keys(response).length; i++) {
                var xVal = "";
                switch (Object.keys(response)[i]) {
                    case "1":
                        xVal = "Jan-2017";
                        break;
                    case "2":
                        xVal = "Feb-2017";
                        break;
                    case "3":
                        xVal = "Mar-2017";
                        break;
                    case "4":
                        xVal = "Apr-2017";
                        break;
                    case "5":
                        xVal = "May-2017";
                        break;
                    case "6":
                        xVal = "Jun-2017";
                        break;
                    case "7":
                        xVal = "Jul-2017";
                        break;
                    case "8":
                        xVal = "Aug-2017";
                        break;
                    case "9":
                        xVal = "Sep-2017";
                        break;
                    case "10":
                        xVal = "Oct-2017";
                        break;
                    case "11":
                        xVal = "Nov-2017";
                        break;
                    case "11":
                        xVal = "Dec-2017";
                        break;
                }
                var row = {label: xVal, y: parseInt(response[Object.keys(response)[i]])};
                result.push(row);
            }
            timeSeriesMonth(result);
        }
    });
}

function retrieveWeekly() {
    $.ajax({
        url: 'RetrieveWeeklyTriggeredAlarm',
        success: function (responseText) {
            response = JSON.parse(responseText);
            var result = [];
            for (var i = 0; i < Object.keys(response).length; i++) {
                var row = {x: parseInt(Object.keys(response)[i]), y: parseInt(response[Object.keys(response)[i]])};
                result.push(row);
            }
            timeSeriesWeek(result);
        }
    });
}


//function randomHeatMap() {
//    if (Math.random() < 0.25) {
//        heatmapChart("../data/fakelinedata.csv");
//    } else if (Math.random() < 0.5) {
//        heatmapChart("../data/fakelinedata1.csv");
//    } else if (Math.random() < 0.75) {
//        heatmapChart("../data/fakelinedata2.csv");
//    } else {
//        heatmapChart("../data/fakelinedata3.csv");
//    }
//}

//**********************************
//D3 - HeatMap
//**********************************
var margin = {
    top: 20,
    right: 30,
    bottom: 0,
    left: 40
},
        width = 1080 - margin.left - margin.right,
        height = 300 - margin.top - margin.bottom,
        gridSize = Math.floor(width / 22),
        legendElementWidth = (width / 6) - 90,
        buckets = 4,
        colors = ['#ffffff', '#9ecae1', '#4292c6', '#084594'],
        oppcolors = ['#000000', '#000000', '#ffffff', '#ffffff'],
        days = ["Exit A", "Exit B", "Exit 28", "Exit 29"],
        times = ["08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22"];

var svg = d3.select("#heatMap").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var tip = d3.tip()
        .attr('class', 'd3-tip')
        .offset([-10, 0])
        .html(function (d) {
            return "<strong>No. of Alarms Triggered: </strong> <span style='color:#6baed6'>" + d.value + "</span><br>At time: <span style='color:#6baed6'>" + (d.hour + 7) + ":00 - " + (d.hour + 7) + ":59</span><br>At Exit: <span style='color:#6baed6'>" + d.exit + "</span>";
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

var heatmapChart = function (data) {
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
            .attr("class", "hour bordered ")
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
            .attr("y", height - 80)
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
            .attr("y", height - 65)
            .style("fill", function (d, i) {
                return oppcolors[i];
            });

    legend.exit().remove();
};

