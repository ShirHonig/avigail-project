<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="project2.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .register-container {
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
        .success-message {
            color: green;
            margin-bottom: 10px;
        }
        .register-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .register-button:hover {
            background-color: #45a049;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="register-container">
        <h2>Register New Account</h2>
        
        <asp:Panel ID="pnlRegister" runat="server" DefaultButton="btnRegister">
            <div class="error-message">
                <asp:Label ID="lblError" runat="server" Visible="false"></asp:Label>
            </div>
            
            <div class="success-message">
                <asp:Label ID="lblSuccess" runat="server" Visible="false"></asp:Label>
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
                <label for="txtConfirmPassword">Confirm Password:</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                    ControlToValidate="txtConfirmPassword" 
                    ErrorMessage="Please confirm password" 
                    Display="Dynamic" 
                    ForeColor="Red">
                </asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvPassword" runat="server" 
                    ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtPassword"
                    ErrorMessage="Passwords do not match"
                    Display="Dynamic"
                    ForeColor="Red">
                </asp:CompareValidator>
            </div>
            
            <div class="form-group">
                <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="register-button" />
            </div>
            
            <div>
                Already have an account? <asp:HyperLink ID="hlLogin" runat="server" NavigateUrl="~/Login.aspx">Login here</asp:HyperLink>
            </div>
        </asp:Panel>
    </div>
</asp:Content> 