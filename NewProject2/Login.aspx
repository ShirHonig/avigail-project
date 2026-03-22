<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="project2.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 3px;
            box-sizing: border-box;
        }
        .error-message {
            color: red;
            margin-bottom: 10px;
        }
        .login-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .login-button:hover {
            background-color: #45a049;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-container">
        <h2>Login to System</h2>
        
        <asp:Panel ID="pnlLogin" runat="server" DefaultButton="btnLogin">
            <div class="error-message">
                <asp:Label ID="lblError" runat="server" Visible="false"></asp:Label>
            </div>
            
            <div class="form-group">
                <label for="txtUsername">Username:</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                    ControlToValidate="txtUsername" 
                    ErrorMessage="Please enter username" 
                    Display="Dynamic" 
                    ForeColor="Red">
                </asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtPassword">Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="txtPassword" 
                    ErrorMessage="Please enter password" 
                    Display="Dynamic" 
                    ForeColor="Red">
                </asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="login-button" />
            </div>
            
            <div>
                Don't have an account? <asp:HyperLink ID="hlRegister" runat="server" NavigateUrl="~/Register.aspx">Register here</asp:HyperLink>
            </div>
        </asp:Panel>
    </div>
</asp:Content> 