<%@ Page Title="Favorites" Language="C#" MasterPageFile="~/Site1.Master" %>

<script runat="server">
    public class WorkoutLink
    {
        public string Name { get; set; }
        public string Url { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Login"] == null || !(bool)Session["Login"])
        {
            Response.Redirect("~/LogIn.aspx");
            return;
        }

        var favorites = Session["FavoriteWorkouts"] as System.Collections.Generic.List<string>;
        if (favorites == null || favorites.Count == 0)
        {
            lblEmpty.Visible = true;
            rptFavorites.Visible = false;
            return;
        }

        var links = new System.Collections.Generic.List<WorkoutLink>();
        foreach (var workout in favorites)
        {
            links.Add(new WorkoutLink
            {
                Name = workout,
                Url = GetWorkoutUrl(workout)
            });
        }

        rptFavorites.DataSource = links;
        rptFavorites.DataBind();
    }

    private string GetWorkoutUrl(string workout)
    {
        switch (workout)
        {
            case "Leg Day Workout": return "~/Legs.aspx";
            case "Chest Strength Workout": return "~/Chest.aspx";
            case "Shoulder Power Workout": return "~/Shoulders.aspx";
            case "Arms Workout": return "~/Arms.aspx";
            case "Full Body Workout": return "~/FullBody.aspx";
            default: return "~/Workouts.aspx";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server" />

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Favorite Workouts</h1>
    <asp:Label ID="lblEmpty" runat="server" Visible="false" Text="No favorites saved yet." />

    <asp:Repeater ID="rptFavorites" runat="server">
        <HeaderTemplate><ul></HeaderTemplate>
        <ItemTemplate>
            <li><a href='<%# ResolveUrl(((WorkoutLink)Container.DataItem).Url) %>'><%# ((WorkoutLink)Container.DataItem).Name %></a></li>
        </ItemTemplate>
        <FooterTemplate></ul></FooterTemplate>
    </asp:Repeater>
</asp:Content>
