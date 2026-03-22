<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminUsers.aspx.cs" Inherits="project2.Admin.AdminUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>User Management</h2>
    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
    <asp:GridView ID="gvUsers" runat="server" CssClass="users-grid" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="Username" HeaderText="Username" />
            <asp:BoundField DataField="Password" HeaderText="Password" />
            <asp:TemplateField HeaderText="System Admin">
                <ItemTemplate>
                    <%# Eval("IsAdmin") != null && (bool)Eval("IsAdmin") ? "Yes" : "No" %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>