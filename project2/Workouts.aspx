<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>WORKOUT PROGRAMS</h1>
    <table style="align-items:center">
        <tr>
            <td>
                <a href="Legs.aspx"><img src="https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?auto=format&fit=crop&w=500&q=80" style="height:200px" /></a>
                <br />
                <a href="Legs.aspx">Leg Day Workout</a>
            </td>
            <td>
                <a href="Chest.aspx"><img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=500&q=80" style="height:200px" /></a>
                <br />
                <a href="Chest.aspx">Chest Strength Workout</a>
            </td>
            <td>
                <a href="Shoulders.aspx"><img src="https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?auto=format&fit=crop&w=500&q=80" style="height:200px" /></a>
                <br />
                <a href="Shoulders.aspx">Shoulder Power Workout</a>
            </td>
            <td>
                <a href="Arms.aspx"><img src="https://images.unsplash.com/photo-1584863231364-2edc166de576?auto=format&fit=crop&w=500&q=80" style="height:200px" /></a>
                <br />
                <a href="Arms.aspx">Arms Workout</a>
            </td>
            <td>
                <a href="FullBody.aspx"><img src="https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=500&q=80" style="height:200px" /></a>
                <br />
                <a href="FullBody.aspx">Full Body Workout</a>
            </td>
        </tr>
    </table>
</asp:Content>
