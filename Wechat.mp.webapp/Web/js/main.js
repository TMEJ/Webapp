function myfunction() {
    $.ajax({
        //要用post方式     
        type: "Post",
        //方法所在页面和方法名     
        url: "Main.aspx/getXXX",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            //返回的数据用data.d获取内容     
            alert(data.d);
        },
        error: function (err) {
            alert(err);
        }
    });
}