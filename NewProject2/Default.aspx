<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="project2.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .welcome-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            text-align: center;
        }
        .welcome-message {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .content-section {
            background-color: #f5f5f5;
            padding: 20px;
            margin: 20px 0;
            border-radius: 5px;
            text-align: right;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="welcome-container">
        <div class="welcome-message">
            <asp:Label ID="lblWelcome" runat="server"></asp:Label>
        </div>
        
        <div class="content-section">
            <h2>Welcome to our Recipe Website!</h2>
            <p>Here you can find a wide variety of delicious and special recipes.</p>
            <p>Registered users can:</p>
            <ul>
                <li>View special recipes</li>
                <li>Save favorite recipes</li>
                <li>Comment and rate recipes</li>
                <li>Share their own recipes</li>
            </ul>
        </div>
        
        <asp:Panel ID="pnlGuest" runat="server" Visible="false">
            <div class="content-section">
                <h3>Want access to more recipes?</h3>
                <p>Register now and get access to hundreds of additional recipes!</p>
                <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="register-button" />
            </div>
        </asp:Panel>
    </div>
</asp:Content> 