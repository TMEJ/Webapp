$(function () {
    carListReload();
});

function btnAddCarInfoClick() {
    $('#modalAddCarInfo').modal({ backdrop: 'static' });
    $('#modalAddCarInfo').modal('show');
    $.ajax({
        //要用post方式 
        type: "Post",
        //方法所在页面和方法名 
        url: "Main.aspx/GetDriverList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //返回的数据用data.d获取内容 
            $("#selecteDriver").html("");
            $(eval("(" + data.d + ")").arry).each(function () {
                $("#selecteDriver").append("<option value='" + this.USER_ID + "'>" + this.USER_NAME + "</option>");
            })
        },
        error: function (err) {
            alert(err);
        }
    });
}

function submitCarInfoClick(btnObj) {
    if ($("#carName").val() == "") {
        alert("车型是必须的。");
        $("#carName").focus();
        return false;
    }
    if ($("#personCnt").val() == "") {
        alert("座位数是必须的。");
        $("#personCnt").focus();
        return false;
    }
    if ($("#licensePlate").val() == "") {
        alert("车牌号是必须的。");
        $("#licensePlate").focus();
        return false;
    }
    if ($("#selecteDriver").val() == "") {
        alert("分配司机是必须的。");
        $("#selecteDriver").focus();
        return false;
    }

    var $btn = $(btnObj).button('loading');

    var info = "{carName:'" + $("#carName").val() +
    "',personCnt:'" + $("#personCnt").val() +
    "',licensePlate:'" + $("#licensePlate").val() +
    "',selecteDriver: '" + $("#selecteDriver").val() +
    "'}";

    $.ajax({
        //要用post方式 
        type: "Post",
        //方法所在页面和方法名 
        url: "Main.aspx/InsertCarInfo",
        data: info,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //返回的数据用data.d获取内容 
            if (data.d == "Success") {
                $btn.button('reset')
                $('#modalAddCarInfo').modal('hide');

                var msg = '<div class="alert alert-success alert-dismissable fade in">' +
                '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>' +
                '車両追加成功。' +
                '</div>';
                $("#messageBox").html(msg);

                setTimeout(function () {
                    $(".alert-success").alert("close");
                }, 2000);

                $("#carName").val("");
                $("#personCnt").val("");
                $("#licensePlate").val("");
                $("#selecteDriver").val("");

                carListReload();
            }

        },
        error: function (err) {
            alert(err);
        }
    });
}

function carListReload() {
    $.ajax({
        //要用post方式 
        type: "Post",
        //方法所在页面和方法名 
        url: "Main.aspx/LoadCarList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //返回的数据用data.d获取内容 
            $("#gvCarinfo>tbody").html("");
            $(eval("(" + data.d + ")").arry).each(function () {

                var tr = "<tr> " +
                            "<td style=\"border-style:none\">" +
                            "<div class=\"panel panel-default\" style=\"margin-bottom: 10px; position: relative;\"> " +
                            "<a class=\"collapsed\" aria-expanded=\"false\" href=\"#collapse" + this.CAR_ID + "\" data-toggle=\"collapse\" data-parent=\"#accordion\">" +
                            "<div class=\"panel-heading\">" +
                            "<img src=\"img/kmr.png\">" +
                            "<h4>" + this.CAR_NAME + "　" + this.LICENSE_PLATE + "</h4>" +
                            "</div> " +
                            "</a> " +
                            "<button class=\"btn btn-primary\"" +
                            "style=\"top: 10px; right: 10px; position: absolute;\"" +
                            "contenteditable=\"true\" " +
                            "onclick=\"btnReservationClick(" + this.CAR_ID + ");\"" +
                            "type=\"button\">预约</button>" +
                            "<div class=\"panel-collapse collapse\" id=\"collapse" + this.CAR_ID + "\" aria-expanded=\"false\" style=\"height: 0px;\">" +
                            "<div class=\"panel-body\"> " +
                            "<table class=\"table table-condensed\" contenteditable=\"true\"> " +
                            "<tbody><tr>" +
                            "<th>车型</th>" +
                            "<td>" + this.CAR_NAME + "</td> " +
                            "<th>座位</th>" +
                            "<td>" + this.PERSON_CNT + "座</td> " +
                            "</tr>" +
                            "<tr> " +
                            "<th>司机</th>" +
                            "<td colspan=\"3\">" + this.USER_NAME + "</td> " +
                            "</tr>" +
                            "<tr> " +
                            "<th>联系方式</th>" +
                            "<td colspan=\"3\">" + this.TEL + "</td>" +
                            "</tr>" +
                            "<tr> " +
                            "<th>状态</th>" +
                            "<td colspan=\"3\">" + this.NUM + "</td>" +
                            "</tr>" +
                            "</tbody></table> " +
                            "</div> " +
                            "</div> " +
                            "</div> " +
                            "</td>" +
                        "</tr>";

                $("#gvCarinfo>tbody").append(tr);
            })
        },
        error: function (err) {
            alert(err);
        }
    });
}

function btnReservationClick(carId) {
    $('#modalReservation').modal({ backdrop: 'static' });
    $('#modalReservation').modal('show');
    $.ajax({
        //要用post方式 
        type: "Post",
        //方法所在页面和方法名 
        url: "Main.aspx/LoadCarList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //返回的数据用data.d获取内容 
            $("#selecteCar").html("");
            $(eval("(" + data.d + ")").arry).each(function () {
                $("#selecteCar").append("<option value='" + this.CAR_ID + "'>" + this.CAR_NAME + "　" + this.LICENSE_PLATE + "</option>");
            });
            $("#selecteCar").val(carId);
            $("#addressFrom").val("");
            $("#addressTo").val("");
            $("#datetime").val("");
            $("#pesvTime").val("");
            $("#remark").val("");
            $("#eq").val("");
        },
        error: function (err) {
            alert(err);
        }
    });
}

function submitReservationClick(btnObj) {
    if ($("#selecteCar").val() == "") {
        alert("车型是必须的。");
        $("#selecteCar").focus();
        return false;
    }
    if ($("#addressFrom").val() == "") {
        alert("上车地点是必须的。");
        $("#addressFrom").focus();
        return false;
    }
    if ($("#addressTo").val() == "") {
        alert("到达地点是必须的。");
        $("#addressTo").focus();
        return false;
    }
    if ($("#datetime").val() == "") {
        alert("约定时间是必须的。");
        $("#datetime").focus();
        return false;
    }
    if ($("#pesvTime").val() == "") {
        alert("预计用时是必须的。");
        $("#pesvTime").focus();
        return false;
    }

    var $btn = $(btnObj).button('loading');

    var info = "{selecteCar:'" + $("#selecteCar").val() +
    "',addressFrom:'" + $("#addressFrom").val() +
    "',addressTo:'" + $("#addressTo").val() +
    "',datetime: '" + $("#datetime").val() +
    "',pesvTime: '" + $("#pesvTime").val() +
    "',remark: '" + $("#remark").val() +
    "',eq: '" + $("#eq").val() +
    "'}";

    $.ajax({
        //要用post方式 
        type: "Post",
        //方法所在页面和方法名 
        url: "Main.aspx/InsertReservation",
        data: info,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //返回的数据用data.d获取内容 
            if (data.d == "Success") {
                $btn.button('reset')
                $('#modalReservation').modal('hide');

                var msg = '<div class="alert alert-success alert-dismissable fade in">' +
                '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>' +
                '車両追加成功。' +
                '</div>';
                $("#messageBox").html(msg);

                setTimeout(function () {
                    $(".alert-success").alert("close");
                }, 2000);

                //$("#carName").val("");
                //$("#personCnt").val("");
                //$("#licensePlate").val("");
                //$("#selecteDriver").val("");

                //carListReload();
            }

        },
        error: function (err) {
            alert(err);
        }
    });
}

function getResvHistory() {
    $('#modalResvHistory').modal({ backdrop: 'static' });
    $('#modalResvHistory').modal('show');
    $.ajax({
        //要用post方式 
        type: "Post",
        //方法所在页面和方法名 
        url: "Main.aspx/GetSchedule",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{eq:'',status:'R'}",
        success: function (data) {
            //返回的数据用data.d获取内容 
            $("#modalResvHistory .modal-body").html("");
            $(eval("(" + data.d + ")").arry).each(function () {
                var tr = "<div class=\"panel panel-default\"> "
                + "<div class=\"panel-heading\"> "
                + "<h3 class=\"panel-title\">No." + this.EQ + " " + this.FROM_TIME + " "
                + "</h3> "
                + "</div>"
                + "<div class=\"panel-body\">"
                + "<table class=\"table table-condensed\" style=\"margin-bottom:0\"> "
                + "<tr>"
                + "<th>车型</th><td>" + this.CAR_NAME + " " + this.LICENSE_PLATE + " " + this.PERSON_CNT + "座</td>"
                + "</tr> "
                + "<tr>"
                + "<th>区间</th><td>" + this.FROM_LOCATION + " 到 " + this.TO_LOCATION + "</td>"
                + "</tr> "
                + "<tr>"
                + "<th>状态</th><td>" + this.NUM + "</td>"
                + "</tr> "
                + "<tr>"
                + "<th>操作</th> "
                + "<td>"
                + "<button type=\"button\" class=\"btn btn-primary btn-sm\" onclick='updateReservationClick(" + this.EQ + ")'>更改</button> "
                + "<button type=\"button\" class=\"btn btn-danger btn-sm\" data-loading-text=\"loading...\" onclick='updateReservation(this,4," + this.EQ + ");'>删除</button></td>"
                + "</tr> "
                + "</table>"
                + "</div>"
                + "</div>";

                $("#modalResvHistory .modal-body").append(tr);

            });
        },
        error: function (err) {
            alert(err);
        }
    });
}

function getApprovalList() {
    $('#modalApproval').modal({ backdrop: 'static' });
    $('#modalApproval').modal('show');
    $.ajax({
        //要用post方式 
        type: "Post",
        //方法所在页面和方法名 
        url: "Main.aspx/GetSchedule",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{eq:'',status:'A'}",
        success: function (data) {
            //返回的数据用data.d获取内容 
            $("#modalApproval .modal-body").html("");
            $(eval("(" + data.d + ")").arry).each(function () {
                var tr = "<div class=\"panel panel-default\"> "
                + "<div class=\"panel-heading\"> "
                + "<h3 class=\"panel-title\">No." + this.EQ + " " + this.FROM_TIME + " "
                + "</h3> "
                + "</div>"
                + "<div class=\"panel-body\">"
                + "<table class=\"table table-condensed\" style=\"margin-bottom:0\"> "
                + "<tr>"
                + "<th>车型</th><td>" + this.CAR_NAME + " " + this.LICENSE_PLATE + " " + this.PERSON_CNT + "座</td>"
                + "</tr> "
                + "<tr>"
                + "<th>区间</th><td>" + this.FROM_LOCATION + " 到 " + this.TO_LOCATION + "</td>"
                + "</tr> "
                + "<tr>"
                + "<th>用途</th><td>" + this.REMARK + "</td>"
                + "</tr> "
                + "<tr>"
                + "<th>操作</th> "
                + "<td>"
                + "<button type=\"button\" class=\"btn btn-primary btn-sm\" data-loading-text=\"loading...\" onclick='updateReservation(this,2," + this.EQ + ");'>同意</button> "
                + "<button type=\"button\" class=\"btn btn-default btn-sm\" data-loading-text=\"loading...\" onclick='updateReservation(this,3," + this.EQ + ");'>不同意</button></td>"
                + "</tr> "
                + "</table>"
                + "</div>"
                + "</div>";

                $("#modalApproval .modal-body").append(tr);

            });
        },
        error: function (err) {
            alert(err);
        }
    });
}

function updateReservationClick(id) {
    $('.modal').modal('hide');
    $('#modalReservation').modal({ backdrop: 'static' });
    $('#modalReservation').modal('show');
    $.ajax({
        //要用post方式 
        type: "Post",
        //方法所在页面和方法名 
        url: "Main.aspx/LoadCarList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //返回的数据用data.d获取内容 
            $("#selecteCar").html("");
            $(eval("(" + data.d + ")").arry).each(function () {
                $("#selecteCar").append("<option value='" + this.CAR_ID + "'>" + this.CAR_NAME + "　" + this.LICENSE_PLATE + "</option>");
            });
        },
        error: function (err) {
            alert(err);
        }
    });

    $.ajax({
        //要用post方式 
        type: "Post",
        //方法所在页面和方法名 
        url: "Main.aspx/GetSchedule",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: "{eq:'" + id + "',status:''}",
        success: function (data) {
            //返回的数据用data.d获取内容 
            $(eval("(" + data.d + ")").arry).each(function () {
                $("#selecteCar").val(this.PLAN_CAR);
                $("#addressFrom").val(this.FROM_LOCATION);
                $("#addressTo").val(this.TO_LOCATION);
                $("#datetime").val(this.FROM_TIME);
                $("#pesvTime").val(this.TO_TIME);
                $("#remark").val(this.REMARK);
                $("#eq").val(this.EQ);
            });
        },
        error: function (err) {
            alert(err);
        }
    });
}

function updateReservation(btnObj,status,eq) {

    var $btn = $(btnObj).button('loading');

    $.ajax({
        //要用post方式 
        type: "Post",
        //方法所在页面和方法名 
        url: "Main.aspx/UpdateReservation",
        data: "{eq:'" + eq + "',status:'" + status + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //返回的数据用data.d获取内容 
            if (data.d == "Success") {
                $btn.button('reset')
                $(btnObj).parent().parent().parent().parent().parent().parent().remove();
            }

        },
        error: function (err) {
            alert(err);
        }
    });
}