<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="Wechat.mp.webapp.Web.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="black" name="apple-mobile-web-app-status-bar-style" />
    <meta content="telephone=no" name="format-detection" />
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/bootstrap-theme.min.css" rel="stylesheet" />
    <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="js/main.js" type="text/javascript"></script>
    <title></title>
</head>
<body>
    <form id="index" runat="server" class="container">
        <header class="page-header">
            <img src="img/logo_90X20.gif" style="position: absolute; left: 5px; top: 5px" />
            <h4 class="text-center">内部车辆管理系统</h4>
            <div class="dropdown" style="position: absolute; right: 5px; top: 5px">
                <button type="button" class="btn dropdown-toggle" id="dropdownMenu1"
                    data-toggle="dropdown">
                    管理
      <span class="caret"></span>
                </button>
                <ul class="dropdown-menu pull-right" role="menu" aria-labelledby="dropdownMenu1">
                    <li role="presentation">
                        <a role="menuitem" tabindex="-1" onclick="$('#modalResvHistory').modal('show');" href="#">我的预约</a>
                    </li>
                    <li role="presentation">
                        <a role="menuitem" tabindex="-1" onclick="$('#modalApproval').modal('show');" href="#">主管审批</a>
                    </li>
                    <li role="presentation">
                        <a role="menuitem" tabindex="-1" href="#" onclick="btnAddCarInfoClick();">车辆追加
                        </a>
                    </li>
                    <li role="presentation" class="divider"></li>
                    <li role="presentation">
                        <a role="menuitem" tabindex="-1" href="#">计划管理</a>
                    </li>
                </ul>
            </div>
        </header>
        <div class="panel-group" id="accordion">
            <asp:GridView ID="gvCarinfo" runat="server" BorderStyle="None" AutoGenerateColumns="false" Width="100%" ShowHeader="false" >
                <Columns>
                    <asp:TemplateField ShowHeader="false" HeaderStyle-BorderStyle="None" HeaderStyle-Height="0">
                        <ItemTemplate>
                            <div class="panel panel-default" style="position: relative">
                                <a data-toggle="collapse" data-parent="#accordion"
                                    href="#collapse<%# Eval("CAR_ID") %>">
                                    <div class="panel-heading">
                                        <img src="img/kmr.png" />
                                        <h4><%# Eval("CAR_NAME") %>　<%# Eval("LICENSE_PLATE") %></h4>
                                    </div>
                                </a>
                                <button class="btn btn-primary" onclick="$('#modalReservation').modal('show');" style="position: absolute; right: 10px; top: 10px" contenteditable="true" type="button">预约</button>
                                <div id="collapse<%# Eval("CAR_ID") %>" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <table class="table table-condensed" contenteditable="true">
                                            <tr>
                                                <th>车型</th>
                                                <td><%# Eval("CAR_NAME") %></td>
                                                <th>座位</th>
                                                <td><%# Eval("PERSON_CNT") %>座</td>
                                            </tr>
                                            <tr>
                                                <th>司机</th>
                                                <td colspan="3"><%# Eval("USER_NAME") %></td>
                                            </tr>
                                            <tr>
                                                <th>联系方式</th>
                                                <td colspan="3"><%# Eval("TEL") %></td>
                                            </tr>
                                            <tr>
                                                <th>状态</th>
                                                <td colspan="3"><%# Eval("NUM") %></td>
                                            </tr>   
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle Wrap="True" />
            </asp:GridView>
           <%-- <div class="panel panel-default" style="position: relative">
                <a data-toggle="collapse" data-parent="#accordion"
                    href="#collapseOne">
                    <div class="panel-heading">
                        <img src="img/kmr.png" />
                        <h4>凯美瑞 粤A88888</h4>
                    </div>
                </a>
                <button class="btn btn-primary" onclick="$('#modalReservation').modal('show');" style="position: absolute; right: 10px; top: 10px" contenteditable="true" type="button">预约</button>
                <div id="collapseOne" class="panel-collapse collapse">
                    <div class="panel-body">
                        <table class="table table-condensed" contenteditable="true">
                            <tr>
                                <th>车型</th>
                                <td>丰田凯美瑞</td>
                                <th>座位</th>
                                <td>5座</td>
                            </tr>
                            <tr>
                                <th>司机</th>
                                <td colspan="3">李师傅</td>
                            </tr>
                            <tr>
                                <th>联系方式</th>
                                <td colspan="3">13888888888</td>
                            </tr>
                            <tr>
                                <th>状态</th>
                                <td colspan="3">空闲</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="panel panel-default" style="position: relative">
                <a data-toggle="collapse" data-parent="#accordion"
                    href="#collapseTwo">
                    <div class="panel-heading">
                        <img src="img/gl82011.png" />
                        <h4>GL8 粤A12345</h4>
                    </div>
                </a>
                <button class="btn btn-primary" onclick="$('#modalReservation').modal('show');" style="position: absolute; right: 10px; top: 10px" contenteditable="true" type="button">预约</button>
                <div id="collapseTwo" class="panel-collapse collapse">
                    <div class="panel-body">
                        <table class="table table-condensed" contenteditable="true">
                            <tr>
                                <th>车型</th>
                                <td>别克GL8</td>
                                <th>座位</th>
                                <td>7座</td>
                            </tr>
                            <tr>
                                <th>司机</th>
                                <td colspan="3">李师傅</td>
                            </tr>
                            <tr>
                                <th>联系方式</th>
                                <td colspan="3">13888888888</td>
                            </tr>
                            <tr>
                                <th>状态</th>
                                <td colspan="3">使用中</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="panel panel-default" style="position: relative">
                <a data-toggle="collapse" data-parent="#accordion"
                    href="#collapseThree">
                    <div class="panel-heading">
                        <img src="img/kmr.png" />
                        <h4>CITY 粤A55388</h4>
                    </div>
                </a>
                <button class="btn btn-primary" onclick="$('#modalReservation').modal('show');" style="position: absolute; right: 10px; top: 10px" contenteditable="true" type="button">预约</button>
                <div id="collapseThree" class="panel-collapse collapse">
                    <div class="panel-body">
                        <table class="table table-condensed" contenteditable="true">
                            <tr>
                                <th>车型</th>
                                <td>本田CITY</td>
                                <th>座位</th>
                                <td>5座</td>
                            </tr>
                            <tr>
                                <th>司机</th>
                                <td colspan="3">李师傅</td>
                            </tr>
                            <tr>
                                <th>联系方式</th>
                                <td colspan="3">13888888888</td>
                            </tr>
                            <tr>
                                <th>状态</th>
                                <td colspan="3">空闲,有预约</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>--%>
        </div>

        <%--预约页面--%>
        <div class="modal fade" id="modalReservation" tabindex="-1" role="dialog"
            aria-labelledby="modalReservationLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;</button>
                        <h4 class="modal-title" id="modalReservationLabel">用车预约
                        </h4>
                    </div>
                    <div class="modal-body">

                        <div class="control-group">
                            <label class="control-label" contenteditable="true" for="selecteCar">车辆</label>

                            <div class="controls">
                                <select class="form-control" id="selecteCar">
                                    <option>CITY 粤A55388</option>
                                    <option>GL8 粤A12345</option>
                                    <option>凯美瑞 粤A88888</option>
                                </select>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" contenteditable="true" for="addressFrom">上车地点</label>

                            <div class="controls">
                                <input id="addressFrom" class="form-control" placeholder="填入上车地点" type="text" />
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" contenteditable="true" for="addressTo">到达地点</label>

                            <div class="controls">
                                <input id="addressTo" class="form-control" placeholder="填入到达地点" type="text" />
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" contenteditable="true" for="datetime">约定时间</label>

                            <div class="controls">
                                <input id="datetime" class="form-control" type="datetime-local" />
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" contenteditable="true" for="pesvTime">预计用时</label>

                            <div class="controls">
                                <input id="pesvTime" class="form-control" type="time" />
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" contenteditable="true" for="remark">用途</label>

                            <div class="controls">
                                <textarea id="remark" class="form-control" placeholder="简单填写用途" ></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                            data-dismiss="modal">
                            关闭
                        </button>
                        <button type="button" class="btn btn-primary">
                            提交更改
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <%--预约一览--%>
        <div class="modal fade" id="modalResvHistory" tabindex="-1" role="dialog"
            aria-labelledby="resvHistoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="resvHistoryModalLabel">我的预约
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">No.1 2015/11/11 12:00
                                </h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-condensed" style="margin-bottom:0">
                                    <tr>
                                        <th>车型</th><td>粤A88888 5座</td>
                                    </tr>
                                    <tr>
                                        <th>区间</th><td>彩频路11号 到 白云机场</td>
                                    </tr>
                                    <tr>
                                        <th>状态</th><td>未审批</td>
                                    </tr>
                                    <tr>
                                        <th>操作</th>
                                        <td>
                                            <button type="button" class="btn btn-primary btn-sm">更改</button>
                                            <button type="button" class="btn btn-danger btn-sm">删除</button></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">No.2 2015/11/11 12:00
                                </h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-condensed" style="margin-bottom:0">
                                    <tr>
                                        <th>车型</th><td>粤A88888 5座</td>
                                    </tr>
                                    <tr>
                                        <th>区间</th><td>彩频路11号 到 白云机场</td>
                                    </tr>
                                    <tr>
                                        <th>状态</th><td>未审批</td>
                                    </tr>
                                    <tr>
                                        <th>操作</th>
                                        <td>
                                            <button type="button" class="btn btn-primary btn-sm">更改</button>
                                            <button type="button" class="btn btn-danger btn-sm">删除</button></td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                    </div>
                    <%--<div class="modal-footer">
                        <button type="button" class="btn btn-default"
                            data-dismiss="modal">
                            关闭
                        </button>
                        <button type="button" class="btn btn-primary">
                            提交更改
                        </button>
                    </div>--%>
                </div>
            </div>
        </div>

        <%--审批管理页面--%>
        <div class="modal fade" id="modalApproval" tabindex="-1" role="dialog"
            aria-labelledby="modalApprovalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="modalApprovalLabel">待审核一览
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">No.1 2015/11/11 12:00
                                </h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-condensed" style="margin-bottom:0">
                                    <tr>
                                        <th>车型</th><td>粤A88888 5座</td>
                                    </tr>
                                    <tr>
                                        <th>区间</th><td>彩频路11号 到 白云机场</td>
                                    </tr>
                                    <tr>
                                        <th>用途</th><td>去机场接顾客</td>
                                    </tr>
                                    <tr>
                                        <th>操作</th>
                                        <td>
                                            <button type="button" class="btn btn-primary btn-sm">同意</button>
                                            <button type="button" class="btn btn-danger btn-sm">不同意</button></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">No.2 2015/11/11 12:00
                                </h3>
                            </div>
                            <div class="panel-body">
                                <table class="table table-condensed" style="margin-bottom:0">
                                    <tr>
                                        <th>车型</th><td>粤A88888 5座</td>
                                    </tr>
                                    <tr>
                                        <th>区间</th><td>彩频路11号 到 白云机场</td>
                                    </tr>
                                    <tr>
                                        <th>用途</th><td>去机场接顾客</td>
                                    </tr>
                                    <tr>
                                        <th>操作</th>
                                        <td>
                                            <button type="button" class="btn btn-primary btn-sm">同意</button>
                                            <button type="button" class="btn btn-danger btn-sm">不同意</button></td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                    </div>
                    <%--<div class="modal-footer">
                        <button type="button" class="btn btn-default"
                            data-dismiss="modal">
                            关闭
                        </button>
                        <button type="button" class="btn btn-primary">
                            提交更改
                        </button>
                    </div>--%>
                </div>
            </div>
        </div>

        <%--Add car info--%>
        <div class="modal fade" id="modalAddCarInfo" tabindex="-1" role="dialog"
            aria-labelledby="modalAddCarInfoLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;</button>
                        <h4 class="modal-title" id="modalAddCarInfoLabel">車両登録
                        </h4>
                    </div>
                    <div class="modal-body">

                        <div class="control-group">
                            <label class="control-label" contenteditable="true" for="carName">车型</label>

                            <div class="controls">
                                <input id="carName" class="form-control" placeholder="车型" type="text"/>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" contenteditable="true" for="personCnt">座位数</label>

                            <div class="controls">
                                <select class="form-control" id="personCnt">
                                    <option value="5">5座</option>
                                    <option value="7">7座</option>
                                    <option value="99">7座以上</option>
                                </select>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" contenteditable="true" for="licensePlate">车牌号</label>

                            <div class="controls">
                                <input id="licensePlate" class="form-control" placeholder="车牌号" type="text" />
                            </div>
                        </div>
                        
                        <div class="control-group">
                            <label class="control-label" contenteditable="true" for="selecteDriver">分配司机</label>

                            <div class="controls">
                                <select class="form-control" id="selecteDriver">
                                    <option></option>
                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                            data-dismiss="modal">
                            关闭
                        </button>
                        <button type="button" class="btn btn-primary" data-loading-text="正在加载..." onclick="submitCarInfoClick()">
                            提交更改
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 模态框（Modal） -->
        <div class="modal fade" id="identifier" tabindex="-1" role="dialog"
            aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="myModalLabel">模态框（Modal）标题
                        </h4>
                    </div>
                    <div class="modal-body">
                        在这里添加一些文本
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                            data-dismiss="modal">
                            关闭
                        </button>
                        <button type="button" class="btn btn-primary">
                            提交更改
                        </button>
                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
