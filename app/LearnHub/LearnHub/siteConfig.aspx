<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.Master" AutoEventWireup="true" CodeBehind="siteConfig.aspx.cs" Inherits="LearnHub.siteConfig" %>

<%@ Import Namespace="LearnHub.AppCode.entity" %>
<%@ Import Namespace="LearnHub.AppCode.dao" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <ul class="breadcrumb">
  <li><a href="home.aspx">Home</a></li>
  <li class="active">Configuration Settings</li>
  </ul>

    <div class="container">
        <h1>Configuration Settings</h1>
        <div class="verticalLine"></div>
    </div>
    <div class="container">
        <div class="row">
            <h3><span class="glyphicon glyphicon-chevron-right"></span>&emsp;Training Request Forms (Not In Use)</h3>
            <a href="#formModal" data-toggle="modal">
                <div class="col-md-3 btn-default">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-briefcase"></span>
                        <br />
                        <h3>Apply for Courses</h3>
                        <br />
                    </div>
                </div>
            </a>
            <a href="trfApplicationStatus.aspx">
                <div class="col-md-3 btn-default">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-file"></span>
                        <br />
                        <h3>Application Status</h3>
                        <br />
                    </div>
                </div>
            </a>
            <a href="pendingApproval.aspx">
                <div class="col-md-3 btn-default">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-option-horizontal"></span>
                        <br />
                        <h3>TRF Pending Approval</h3>
                        <br />
                    </div>
                </div>
            </a>
            <a href="approvedTRF.aspx">
                <div class="col-md-3 btn-default">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-inbox"></span>
                        <br />
                        <h3>TRF Approval History</h3>
                        <br />
                    </div>
                </div>
            </a>
        </div>
    </div>
    <br />
    <div class="container">
        <div class="row">
            <h3><span class="glyphicon glyphicon-chevron-right"></span>&emsp;Module Configuration</h3>
            <a href="createModules.aspx">
                <div class="col-md-3 btn-primary">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-apple"></span>
                        <h3>Create Module</h3>
                        <br />
                    </div>
                </div>
            </a>
            <a href="manageCategories.aspx">
                <div class="col-md-3 btn-primary">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-menu-hamburger"></span>
                        <h3>Module Categories</h3>
                        <br />
                    </div>
                </div>
            </a>
            <a href="viewCreatedModules.aspx">
                <div class="col-md-3 btn-primary">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-education"></span>
                        <h3>Manage Modules</h3>
                        <br />
                    </div>
                </div>
            </a>
        </div>
    </div>
    <br />
    <div class="container">
        <div class="row">
            <h3><span class="glyphicon glyphicon-chevron-right"></span>&emsp;Emma Configuration</h3>
            <a href="askEmmaAddAns.aspx">
                <div class="col-md-3 btn-success">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-send"></span>
                        <br />
                        <h3>Answers</h3>
                        <br />
                    </div>
                </div>
            </a>
            <a href="askEmmaAddIntent.aspx">
                <div class="col-md-3 btn-success">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-asterisk"></span>
                        <br />
                        <h3>Categories</h3>
                        <br />
                    </div>
                </div>
            </a>
            <a href="askEmmaInitializeMsg.aspx">
                <div class="col-md-3 btn-success">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-off"></span>
                        <br />
                        <h3>Initialization Message</h3>
                        <br />
                    </div>
                </div>
            </a>
            <a href="askEmmaHelpQn.aspx">
                <div class="col-md-3 btn-success">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-question-sign"></span>
                        <br />
                        <h3>Help Questions</h3>
                        <br />
                    </div>
                </div>
            </a>
        </div>
        <div class="row">
            <a href="askEmmaFeedback.aspx">
                <div class="col-md-3 btn-success">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-thumbs-up"></span>
                        <br />
                        <h3>Emma's Feedback</h3>
                        <br />
                    </div>
                </div>
            </a>
            <a href="askEmmaInstruction.aspx">
                <div class="col-md-3 btn-success">
                    <br />
                    <br />
                    <div class="wrapper">
                        <span style="font-size: 75px;" class="glyphicon glyphicon-book"></span>
                        <br />
                        <h3>Instructions</h3>
                        <br />
                    </div>
                </div>
            </a>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <%--TRF Modal--%>
    <div id="formModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Choose Type of Training Request Form</h4>
                </div>
                <div class="modal-body">
                    <div class="wrapper">
                        <a href="applyCourse.aspx" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-file"></span>
                            <br />
                            <strong>Individual Training</strong></a><br />
                        <br />
                        <a href="errorPage.aspx" class="btn btn-success btn-lg"><span class="glyphicon glyphicon-duplicate"></span>
                            <br />
                            <strong>&emsp;Group Training&nbsp;&nbsp;&nbsp;</strong></a>
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
</asp:Content>
