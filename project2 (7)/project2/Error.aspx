<%@ Page Title="Error" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="project2.Error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .error-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            text-align: center;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .error-icon {
            font-size: 48px;
            color: #dc3545;
            margin-bottom: 20px;
        }
        .error-message {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }
        .error-details {
            color: #666;
            margin-bottom: 20px;
        }
        .home-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 3px;
        }
        .home-link:hover {
            background-color: #45a049;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="error-container">
        <div class="error-icon">⚠</div>
        <div class="error-message">
            <asp:Label ID="lblErrorMessage" runat="server" Text="An error has occurred"></asp:Label>
        </div>
        <div class="error-details">
            <asp:Label ID="lblErrorDetails" runat="server" Text="We apologize for the inconvenience. Please try again later."></asp:Label>
        </div>
        <a href="Default.aspx" class="home-link">Return to Home Page</a>
    </div>
</asp:Content> 