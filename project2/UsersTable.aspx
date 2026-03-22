<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UsersTable.aspx.cs" Inherits="project2.UsersTable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <br />
   <div class="container">

    <br />
     <br />

    Enter Text to search name:
    <input type="text" name="filter" id="filter" /> <asp:Button Text="Filter"  ID="Button1" runat="server" OnClick="Click_Filter" />
    <%--<asp:TextBox ID="txtFilter" runat="server"></asp:TextBox> <asp:Button Text="Filter" ID="Button4" runat="server" OnClick="Click_Filter" />--%>

    <br /> <br />

     <asp:Button Text="Delete"  ID="Button2" runat="server" OnClick="Delete" />
     <asp:Button Text="Edit"  ID="Button3" runat="server" OnClick="Edit" />


    <br /> <br />

            <br />
            <label for="Columns">Sort by Column:</label> &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="Columns" runat="server">
                <asp:ListItem Value="fName">firstName</asp:ListItem>
                <asp:ListItem Value="lName">lastName</asp:ListItem>
                <asp:ListItem Value="userN">userName</asp:ListItem>
                <asp:ListItem Value="city">city</asp:ListItem>
            </asp:DropDownList>
             <input id="ContentPlaceHolder1_ASC" type="radio" name="order" value="ASC" checked="checked" />
             <label for="ContentPlaceHolder1_ASC">ASC</label>

                &nbsp;&nbsp;&nbsp;&nbsp;

            <input id="ContentPlaceHolder1_DESC" type="radio" name="order" value="DESC" />
            <label for="ContentPlaceHolder1_DESC">DESC</label>

            <asp:Button ID="btnSort" runat="server" Text="Sort" OnClick="Click_Sort" />
            <br />
            <br />
        </div>
   <br />

    <div runat="server" id="tableDiv" class="container">

    </div>
    <div runat="server" id="message" class="container">

    </div>
</asp:Content>
