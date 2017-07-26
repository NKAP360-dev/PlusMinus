<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="emmaConfiguration.aspx.cs" Inherits="LearnHub.emmaConfiguration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div class="container">
        <h1>Emma Configuration Settings</h1>
        <div class="verticalLine"></div><br/>
    </div>
    <div class="container">
        <div class="row">
            <a href="askEmmaAddAns.aspx">
                <div class="col-md-3 btn-primary">
                    <br /><br />
                    <div class="wrapper">
                        <span style="font-size:75px;" class="glyphicon glyphicon-plus-sign"></span>
                        <br />
                        <h3>Add Answers</h3>
                        <br />
                    </div>
                </div>
            </a>
             <a href="askEmmaEditAns.aspx">
                <div class="col-md-3 btn-success">
                    <br /><br />
                    <div class="wrapper">
                        <span style="font-size:75px;" class="glyphicon glyphicon-pencil"></span>
                        <br />
                        <h3>Edit Answers</h3>
                        <br />
                    </div>
                </div>
            </a>
            <a href="askEmmaAddIntent.aspx">
                <div class="col-md-3 btn-danger">
                    <br /><br />
                    <div class="wrapper">
                        <span style="font-size:75px;" class="glyphicon glyphicon-asterisk"></span>
                        <br />
                        <h3>Create New Intent</h3>
                        <br />
                    </div>
                </div>
            </a>
            <a href="askEmmaInitializeMsg.aspx">
                <div class="col-md-3 btn-info">
                    <br /><br />
                    <div class="wrapper">
                        <span style="font-size:75px;" class="glyphicon glyphicon-off"></span>
                        <br />
                        <h3>Initialization Message</h3>
                        <br />
                    </div>
                </div>
            </a>
        </div>
        <div class="row">
            <a href="askEmmaHelpQn.aspx">
                <div class="col-md-3 btn-warning">
                    <br /><br />
                    <div class="wrapper">
                        <span style="font-size:75px;" class="glyphicon glyphicon-question-sign"></span>
                        <br />
                        <h3>Help Questions</h3>
                        <br />
                    </div>
                </div>
            </a>
             <a href="askEmmaFeedback.aspx">
                <div class="col-md-3 btn-default">
                    <br /><br />
                    <div class="wrapper">
                        <span style="font-size:75px;" class="glyphicon glyphicon-thumbs-up"></span>
                        <br />
                        <h3>Emma's Feedback</h3>
                        <br />
                    </div>
                </div>
            </a>
             <a href="askEmmaFeedback.aspx">
                <div class="col-md-3 btn-primary">
                    <br /><br />
                    <div class="wrapper">
                        <span style="font-size:75px;" class="glyphicon glyphicon-book"></span>
                        <br />
                        <h3>Edit Instructions</h3>
                        <br />
                    </div>
                </div>
            </a>
        </div>
    </div>



   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
