<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" %>

<script runat="server">
    protected void btnSaveFavorite_Click(object sender, EventArgs e)
    {
        SaveWorkout("FavoriteWorkouts", "Full Body Workout", "Saved to favorites.");
    }

    protected void btnSaveMyWorkout_Click(object sender, EventArgs e)
    {
        SaveWorkout("MyWorkouts", "Full Body Workout", "Saved to My Workouts.");
    }

    private void SaveWorkout(string sessionKey, string workoutName, string successMessage)
    {
        if (Session["Login"] == null || !(bool)Session["Login"])
        {
            lblSaveMessage.Text = "Please log in first.";
            return;
        }

        var list = Session[sessionKey] as System.Collections.Generic.List<string> ?? new System.Collections.Generic.List<string>();
        if (!list.Contains(workoutName))
        {
            list.Add(workoutName);
            Session[sessionKey] = list;
            lblSaveMessage.Text = successMessage;
        }
        else
        {
            lblSaveMessage.Text = "Already saved.";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Full Body Workout</h1>
    <img src="https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=900&q=80" style="float:right;height:500px" />
    <img src="https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&w=700&q=80" style="float:right;height:240px;margin-right:12px" />

    <asp:Button ID="btnSaveFavorite" runat="server" Text="Save to Favorites" OnClick="btnSaveFavorite_Click" />
    <asp:Button ID="btnSaveMyWorkout" runat="server" Text="Save to My Workouts" OnClick="btnSaveMyWorkout_Click" />
    <br />
    <asp:Label ID="lblSaveMessage" runat="server" ForeColor="Lime" />

    <h2>Warm-up:</h2>
    <h3>
        - 6 minutes rowing machine
        <br />
        - Dynamic mobility: hips, shoulders, ankles
    </h3>
    <h2>Workout Plan:</h2>
    <h3>
        1. Deadlift - 4 sets x 5 reps
        <br />
        2. Pull-Ups or Lat Pulldown - 4 sets x 8-10 reps
        <br />
        3. Incline Dumbbell Press - 4 sets x 8 reps
        <br />
        4. Goblet Squat - 3 sets x 12 reps
        <br />
        5. Dumbbell Row - 3 sets x 10 reps each side
        <br />
        6. Plank - 3 sets x 60 seconds
        <br />
        7. Farmer's Carry - 3 rounds x 30 meters
    </h3>

    <h2>Conditioning Finisher:</h2>
    <h3>
        - 5 rounds: 10 burpees + 15 kettlebell swings + 20 mountain climbers.
    </h3>
</asp:Content>
