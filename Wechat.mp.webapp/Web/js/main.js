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
    if ($("#carName").val()=="") {
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
                //$(".alert-success").alert("close");
            }

        },
        error: function (err) {
            alert(err);
        }
    });
}

function carListReload() {

}