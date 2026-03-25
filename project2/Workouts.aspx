<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>WORKOUT PROGRAMS</h1>
    <table style="align-items:center">
        <tr>
            <td>
                <a href="Legs.aspx"><img src="https://source.unsplash.com/featured/?leg,workout" style="height:200px" /></a>
                <br />
                <a href="Legs.aspx">Leg Day Workout</a>
            </td>
            <td>
                <a href="Chest.aspx"><img src="https://source.unsplash.com/featured/?chest,benchpress" style="height:200px" /></a>
                <br />
                <a href="Chest.aspx">Chest Strength Workout</a>
            </td>
            <td>
                <a href="Shoulders.aspx"><img src="https://source.unsplash.com/featured/?shoulder,press" style="height:200px" /></a>
                <br />
                <a href="Shoulders.aspx">Shoulder Power Workout</a>
            </td>
            <td>
                <a href="Arms.aspx"><img src="https://source.unsplash.com/featured/?biceps,dumbbell" style="height:200px" /></a>
                <br />
                <a href="Arms.aspx">Arms Workout</a>
            </td>
            <td>
                <a href="FullBody.aspx"><img src="https://source.unsplash.com/featured/?fullbody,workout" style="height:200px" /></a>
                <br />
                <a href="FullBody.aspx">Full Body Workout</a>
            </td>
        </tr>
    </table>
</asp:Content>
