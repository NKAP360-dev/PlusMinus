<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="addNews.aspx.cs" Inherits="LearnHub.addNews" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>
<%@ Import Namespace="LearnHub.AppCode.entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
     <style>
        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 10px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }
         </style>
    <script>
        function checkTextAreaMaxLength(textBox, e, length) {

            var mLen = textBox["MaxLength"];
            if (null == mLen)
                mLen = length;

            var maxLength = parseInt(mLen);
            if (!checkSpecialKeys(e)) {
                if (textBox.value.length > maxLength - 1) {
                    if (window.event)//IE
                        e.returnValue = false;
                    else//Firefox
                        e.preventDefault();
                }
            }
        }
        function checkSpecialKeys(e) {
            if (e.keyCode != 8 && e.keyCode != 46 && e.keyCode != 37 && e.keyCode != 38 && e.keyCode != 39 && e.keyCode != 40)
                return false;
            else
                return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="manageNews.aspx"> Manage News</a></li>
        <li class="active">Add News</li>
    </ul>

    <form class="form-horizontal" runat="server">
        <div class="container">
             <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="News Type"></asp:Label></strong>
                    <div class="col-lg-9">
                        <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control">
                            <asp:ListItem Text="-- Select --" Selected="true" Value="none"></asp:ListItem>
                            <asp:ListItem>News</asp:ListItem>
                            <asp:ListItem>Update</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

            <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="News Title"></asp:Label></strong>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Banner Name"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group required">
                      <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Upload Banner Image"></asp:Label></strong>
                    <div class="col-lg-9">
                     <asp:FileUpload ID="FileUpload1" runat="server" />
                        </div>
                </div>

              <div class="form-group required">
                    <strong>
                        <asp:Label runat="server" CssClass="col-lg-2 control-label" Text="Short Description"></asp:Label></strong>
                    <div class="col-lg-9">
                        <asp:TextBox ID="txtDesc" TextMode="MultiLine" runat="server" CssClass="form-control" placeholder="Page that user will land upon clicking the banner" MaxLength='10' onkeyDown="checkTextAreaMaxLength(this,event,'10');"></asp:TextBox>
                    </div>
                </div>

        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
