<%@ Page Title="Users Table" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminUsers.aspx.cs" Inherits="project2.AdminUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Users Table</h1>
    <asp:Label ID="message" runat="server" ForeColor="Red" aria-live="polite"></asp:Label>
    <div>
        Username: <asp:TextBox ID="txtUsernameFilter" runat="server"></asp:TextBox>
        First Name: <asp:TextBox ID="txtFirstNameFilter" runat="server"></asp:TextBox>
        Last Name: <asp:TextBox ID="txtLastNameFilter" runat="server"></asp:TextBox>
        <asp:Button ID="btnFilter" runat="server" Text="Filter" OnClick="btnFilter_Click" />
    </div>
    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" AllowSorting="True" OnSorting="gvUsers_Sorting" DataKeyNames="UserId">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="chkDelete" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
            <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:BoundField DataField="BirthDate" HeaderText="Birth Date" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="City" HeaderText="City" />
            <asp:TemplateField HeaderText="Gender" SortExpression="Gender">
                <ItemTemplate>
                    <%# Eval("Gender") %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Admin" SortExpression="Admin">
                <ItemTemplate>
                    <%# Convert.ToBoolean(Eval("Admin")) ? "Admin" : "User" %>
                </ItemTemplate>
            </asp:TemplateField>
<asp:TemplateField HeaderText="Edit">
    <ItemTemplate>
        <asp:HyperLink ID="lnkEdit" runat="server" Text="Edit" NavigateUrl='<%# "~/UpdateUser.aspx?UserId=" + Eval("UserId") %>' />
    </ItemTemplate>
</asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Button ID="btnDeleteSelected" runat="server" Text="Delete Selected Users" OnClick="btnDeleteSelected_Click" />
</asp:Content>