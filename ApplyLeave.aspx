<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApplyLeave.aspx.cs" Inherits="AMS.Web.ApplyLeave" EnableSessionState="True" Culture="en-GB" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Custom/Custom.css" rel="stylesheet" />
    <link href="Custom/Site.css" rel="stylesheet" />
    <script src="scripts/Common.js"></script>
    <asp:ScriptManager runat="server" ID="sm1" EnablePageMethods="true"></asp:ScriptManager>
    <script type="text/javascript">
        function ShowPopup() {
            $("#btnShowPopup").click();
        }
        window.onload = function () {
            if (isPostBack) {
             <%--   document.getElementById("<%=tblApplyLeave.Rows[3].ClientID%>").style.display = 'none';--%>
            }
            if (!isPostBack) {
                if (document.getElementById("<%=ddlTypeOfLeave.ClientID%>").options[document.getElementById("<%=ddlTypeOfLeave.ClientID%>").selectedIndex].value == 'CO') {
                   <%-- document.getElementById("<%=tblApplyLeave.Rows[3].ClientID%>").setAttribute('style', 'visibility:visible');--%>
                }
                else {
                    <%--document.getElementById("<%=tblApplyLeave.Rows[3].ClientID%>").style.display = 'none';--%>
                }
            }
        }
        function handleResult(result) {
           <%-- document.getElementById("<%=lblddlTypeOfLeave.ClientID%>").style.display = 'block';--%>
            document.getElementById("<%=lblddlTypeOfLeave.ClientID%>").innerText = "Leave balance is " + result;
        }
        function compOffValidate(compOffValue) {
            if (document.getElementById("<%=ddlTypeOfLeave.ClientID%>").options[document.getElementById("<%=ddlTypeOfLeave.ClientID%>").selectedIndex].value != 'CO') {
              <%--  document.getElementById("<%=tblApplyLeave.Rows[3].ClientID%>").style.display = 'none';--%>
            }
            if (document.getElementById("<%=ddlTypeOfLeave.ClientID%>").options[document.getElementById("<%=ddlTypeOfLeave.ClientID%>").selectedIndex].value == 'CO') {
               <%-- document.getElementById("<%=tblApplyLeave.Rows[3].ClientID%>").setAttribute('style', 'visibility:visible');--%>
                document.getElementById("<%=rfvtxtRemarks.ClientID%>").enabled = true;
                document.getElementById("<%=lblddlTypeOfLeave.ClientID%>").style.display = 'block';
                document.getElementById("<%=lblddlTypeOfLeave.ClientID%>").innerText = "*Please enter the date against which compensatory off is taken.";
            }
            else {
                document.getElementById("<%=rfvtxtRemarks.ClientID%>").enabled = false;
                document.getElementById("<%=lblddlTypeOfLeave.ClientID%>").style.display = 'none';
            }
        }
        $(function () {
            $('[id*=txtFromDate]').datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true,
                yearRange: '1990:2025'
            });
        });
        $(function () {
            $('[id*=txtToDate]').datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true,
                yearRange: '1990:2025'
            });
        });
        $(function () {
            $('[id*=txtRemarks]').datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true,
                yearRange: '1990:2025'
            });
        });
    </script>
    <script type="text/javascript">
        function ClientSideClick(myButton) {
            if (typeof (Page_ClientValidate) == 'function') {
                if (Page_ClientValidate() == false) { return false; }
            }
            if (myButton.getAttribute('type') == 'button') {
                myButton.disabled = true;
                document.getElementById("graybackgrounddiv").style.display = "block";
                document.getElementById("spinnerdiv").style.display = "block";
            }
            return true;
        }
    </script>
     <div class="container">
        <div class="row">
            <div class="col-lg-6 col-lg-offset-2">
                <div class="messagealert" id="alert_container">
                </div>
            </div>
        </div>
    </div>
    <div id="graybackgrounddiv" style="opacity: 0.75">
        <div id="spinnerdiv" style="display: none; opacity: 1">
            <div class="loader">
            </div>
        </div>
    </div>
    <div class="container">
        <h3>APPLY LEAVE</h3>


        <div class="form-group">
            <div class="row">
                <div class="col-md-2">
                    <span style="color: red">*</span>
                    <label>From Date:</label>
                </div>
                <div class="col-md-3">
                    <asp:TextBox class="form-control" ID="txtFromDate" ValidationGroup="LeaveReq" runat="server" placeholder="dd/mm/yyyy"></asp:TextBox>
                    <asp:RequiredFieldValidator ValidationGroup="leaveReq" runat="server" ControlToValidate="txtFromDate" Display="None" ForeColor="Red" ErrorMessage="*Please select from date."></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2">
                    <span style="color: red">*</span>
                    <label>To Date :</label>
                </div>
                <div class="col-md-3">
                    <asp:TextBox class="form-control" ID="txtToDate" ValidationGroup="LeaveReq" runat="server" placeholder="dd/mm/yyyy"></asp:TextBox>
                    <asp:RequiredFieldValidator ValidationGroup="leaveReq" runat="server" ControlToValidate="txtToDate" ForeColor="Red" Display="None" ErrorMessage="*Please select To Date."></asp:RequiredFieldValidator>
                    <asp:CompareValidator ValidationGroup="leaveReq" runat="server" ControlToCompare="txtFromDate" ControlToValidate="txtToDate" Operator="GreaterThanEqual" Type="Date" Display="None" ForeColor="Red" ErrorMessage="*To Date should be greater or equal to From Date"></asp:CompareValidator>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2">
                    <span style="color: red">*</span>
                    <label>Type of Leave :</label>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList Class="form-control" runat="server" ID="ddlTypeOfLeave" DataTextField="LeaveDescription" DataValueField="LeaveTypeName" onChange="compOffValidate(this)">
                        <asp:ListItem>Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ValidationGroup="leaveReq" ID="rfvddlLeaveType" runat="server" ControlToValidate="ddlTypeOfLeave" InitialValue="Select" Display="None" ForeColor="Red" ErrorMessage="*Please select type of leave."></asp:RequiredFieldValidator>
                    <asp:Label runat="server" ID="lblddlTypeOfLeave" ForeColor="Blue" Text="*Please enter the date against which compensatory off is taken." Style="display: none"></asp:Label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2">
                    <span style="color: red"></span>
                    <label>CompOff against date :</label>
                </div>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="txtRemarks" Class="form-control" placeholder="dd/mm/yyyy"></asp:TextBox>
                    <asp:RequiredFieldValidator Display="None" ValidationGroup="leaveReq" runat="server" Enabled="false" ID="rfvtxtRemarks" ControlToValidate="txtRemarks" ForeColor="Red" ErrorMessage="*Please select CompOff against date."></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2">
                    <span style="color: red">*</span>
                    <label>Total Days :</label>
                </div>
                <div class="col-md-3">
                    <asp:TextBox ReadOnly="true" class="form-control" runat="server" ID="txtLeaveDays"></asp:TextBox>

                </div>
                <div class="col-md-2">
                    <asp:Button runat="server" ID="btnLeaveDays" Class="btn btn-primary" Text="Calculate Leave Days" OnClick="btnLeaveDays_Click" CausesValidation="false" />
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2">
                    <span style="color: red">*</span>
                    <label>Reason For Leave :</label>
                </div>
                <div class="col-md-3">
                    <asp:TextBox runat="server" TextMode="MultiLine" MaxLength="200" ID="txtReasonForLeave" Class="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ValidationGroup="leaveReq" runat="server" ID="rfvtxtReasonForLeave" ControlToValidate="txtReasonForLeave" Display="None" ForeColor="Red" ErrorMessage="*Please enter Reason."></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-2">
                    <span style="color: red">*</span>
                    <label>Contact Number :</label>
                </div>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="txtContactNo" Class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' MaxLength="10"></asp:TextBox>
                    <asp:RequiredFieldValidator ValidationGroup="leaveReq" runat="server" ID="rfvtxtContactNo" ControlToValidate="txtContactNo" ForeColor="Red" ErrorMessage="*Please enter contact number." Display="None"></asp:RequiredFieldValidator>
                </div>

            </div>
        </div>

        <div class="form-group">
            <div class="row">
                <div class="col-md-6 col-md-offset-2">
                    <asp:Button runat="server" ValidationGroup="leaveReq" Text="Apply Leave" ID="btnApplyLeave" Class="btn btn-primary" UseSubmitBehavior="false" OnClientClick="ClientSideClick(this)" OnClick="btnApplyLeave_Click" ClientIDMode="Static" />
                    <asp:ValidationSummary HeaderText="Please clear below errors..." runat="server" ForeColor="Red" ValidationGroup="leaveReq" Font-Bold="true" />
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-6">
                    <asp:Label ID="lblStatus" Text="" ForeColor="Blue" runat="server" Visible="false" Font-Bold="true"></asp:Label>
                    <asp:Label ID="lblError" Text="" ForeColor="Red" runat="server" Visible="false" Font-Bold="true"></asp:Label>
                </div>
            </div>
        </div>
       
    </div>




</asp:Content>
