<%@ Page Title="Statistics" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Statistics.aspx.cs" Inherits="project2.Admin.Statistics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .stats-container {
            margin: 20px;
            padding: 20px;
            background-color: #f5f5f5;
            border-radius: 5px;
        }
        .stat-item {
            margin: 10px 0;
            padding: 10px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="stats-container">
        <h2>סטטיסטיקת משתמשים</h2>
        
        <div class="stat-item">
            <strong>סה"כ כניסות לאתר:</strong>
            <asp:Label ID="lblTotalVisits" runat="server"></asp:Label>
        </div>
        
        <div class="stat-item">
            <strong>כניסות משתמשים רשומים:</strong>
            <asp:Label ID="lblRegisteredVisits" runat="server"></asp:Label>
        </div>
        
        <div class="stat-item">
            <strong>משתמשים מחוברים כרגע:</strong>
            <ul>
                <li>אורחים: <asp:Label ID="lblOnlineGuests" runat="server"></asp:Label></li>
                <li>משתמשים רשומים: <asp:Label ID="lblOnlineRegistered" runat="server"></asp:Label></li>
                <li>סה"כ: <asp:Label ID="lblTotalOnline" runat="server"></asp:Label></li>
            </ul>
        </div>
    </div>
</asp:Content> 
