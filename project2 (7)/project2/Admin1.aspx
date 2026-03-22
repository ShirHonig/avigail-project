<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Admin1.aspx.cs" Inherits="project2.Admin1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Admin</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
        <div class="container" style="text-align:center;">
                        
            <table border="1" cellpadding="5" cellspacing="0">
                <tr>
                    <td>Username:</td>
                    <td>Password:</td>
                    <td>Admin:</td>
                </tr>
                <tr>
                    <td><div runat="server" id="User1">

                </div></td>
                    <td><div runat="server" id="Pass1">

                </div></td>
                    <td><div runat="server" id="Admin1Div">

                </div></td>
                </tr>

                <tr>
                    <td><div runat="server" id="User2">

                </div></td>
                    <td><div runat="server" id="Pass2">

                </div></td>
                    <td><div runat="server" id="Admin2">

                </div></td>
                </tr>

                <tr>
                    <td><div runat="server" id="User3">

                </div></td>
                    <td><div runat="server" id="Pass3">

                </div></td>
                     <td><div runat="server" id="Admin3">

                </div></td>
                </tr>

                <tr>
                     <td><div runat="server" id="User4">

                </div></td>
                     <td><div runat="server" id="Pass4">

                </div></td>
                     <td><div runat="server" id="Admin4">

                </div></td>
                </tr>

                <tr>
                     <td><div runat="server" id="User5">

                </div></td>
                     <td><div runat="server" id="Pass5">

                </div></td>
                     <td><div runat="server" id="Admin5">

                </div></td>
                </tr>
                
            </table>
        </div>
</asp:Content>
