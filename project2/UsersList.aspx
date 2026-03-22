<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsersList.aspx.cs" Inherits="YourProjectName.UsersList" %>
<!DOCTYPE html>
<html>
<head>
    <title>Users List</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Users List (Admin Only)</h2>
        <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
        <div>
            <!-- Filtering Controls -->
            Username: <asp:TextBox ID="txtUsernameFilter" runat="server"></asp:TextBox>
            First Name: <asp:TextBox ID="txtFirstNameFilter" runat="server"></asp:TextBox>
            Last Name: <asp:TextBox ID="txtLastNameFilter" runat="server"></asp:TextBox>
            <asp:Button ID="btnFilter" runat="server" Text="Filter" OnClick="btnFilter_Click" />
        </div>
        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" AllowSorting="True" OnSorting="gvUsers_Sorting">
            <Columns>
                <asp:BoundField DataField="UserId" HeaderText="User ID" SortExpression="UserId" />
                <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="BirthDate" HeaderText="Birth Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="City" HeaderText="City" />
                <asp:TemplateField HeaderText="Gender" SortExpression="Gender">
                    <ItemTemplate>
                        <%# Eval("Gender") == "Male" ? "Male" : "Female" %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Admin" SortExpression="Admin">
                    <ItemTemplate>
                        <%# Convert.ToBoolean(Eval("Admin")) ? "Admin" : "User" %>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
