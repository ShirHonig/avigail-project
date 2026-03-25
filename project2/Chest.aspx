<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" %>

<script runat="server">
    protected void btnSaveFavorite_Click(object sender, EventArgs e)
    {
        SaveWorkout("FavoriteWorkouts", "Chest Strength Workout", "Saved to favorites.");
    }

    protected void btnSaveMyWorkout_Click(object sender, EventArgs e)
    {
        SaveWorkout("MyWorkouts", "Chest Strength Workout", "Saved to My Workouts.");
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
    <h1>Chest Strength Workout</h1>
    <img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=900&q=80" style="float:right;height:500px" />
    <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=700&q=80" style="float:right;height:240px;margin-right:12px" />

    <asp:Button ID="btnSaveFavorite" runat="server" Text="Save to Favorites" OnClick="btnSaveFavorite_Click" />
    <asp:Button ID="btnSaveMyWorkout" runat="server" Text="Save to My Workouts" OnClick="btnSaveMyWorkout_Click" />
    <br />
    <asp:Label ID="lblSaveMessage" runat="server" ForeColor="Lime" />

    <h2>Warm-up:</h2>
    <h3>
        - 5 minutes rowing machine
        <br />
        - Band pull-aparts and light push-ups
    </h3>
    <h2>Workout Plan:</h2>
    <h3>
        1. Barbell Bench Press - 4 sets x 5-8 reps
        <br />
        2. Incline Dumbbell Press - 4 sets x 8-10 reps
        <br />
        3. Dumbbell Flyes - 3 sets x 12 reps
        <br />
        4. Chest Dips - 3 sets to near failure
        <br />
        5. Cable Crossovers - 3 sets x 12-15 reps
        <br />
        6. Push-up Burnout - 2 sets to failure
        <br />
        7. Rest 60-90 seconds between sets
    </h3>

    <h2>Cool Down:</h2>
    <h3>
        - 5 minutes chest and shoulder stretching
    </h3>

</asp:Content>
