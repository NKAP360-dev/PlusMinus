<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="askLearnyInstruction.aspx.cs" Inherits="LearnHub.askLearnyInstruction" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="//cdn.ckeditor.com/4.7.3/full/ckeditor.js"></script>
    <script>

        function displayText() {
            var preview = CKEDITOR.instances.CKEDITOR1.getData();
            document.getElementById('myField').innerHTML = preview;
            $('#previewModal').modal('show');
            return false;
        }


    </script>
    <style>
        .breadcrumb {
            padding-top: 15px;
            margin-bottom: 10px;
            list-style: none;
            background-color: white;
            border-radius: 0px;
        }

        .form-horizontal .control-label-left {
            text-align: left;
            margin-bottom: 0;
            padding-top: 11px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="breadcrumb">
        <li><a href="home.aspx">Home</a></li>
        <li><a href="siteConfig.aspx">Configuration Settings</a></li>
        <li class="active">Learny's Instruction</li>
    </ul>
    <div class="container">
        <h1>Learny's Instructions
        </h1>
        <div class="verticalLine"></div>
        <br />
        <form runat="server" class="form-horizontal">
            
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Enter Title *"></asp:TextBox>
            <br />
            
            <CKEditor:CKEditorControl ID="CKEditor1" runat="server">
            </CKEditor:CKEditorControl>
            <br />
            <asp:Button ID="btnSave" CssClass="btn btn-primary pull-right" runat="server" Text="Save" OnClick="btnSave_Click" />

            

        </form>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
