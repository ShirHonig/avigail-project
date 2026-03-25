<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" %>

<script runat="server">
    protected void btnSaveFavorite_Click(object sender, EventArgs e)
    {
        SaveWorkout("FavoriteWorkouts", "Arms Workout", "Saved to favorites.");
    }

    protected void btnSaveMyWorkout_Click(object sender, EventArgs e)
    {
        SaveWorkout("MyWorkouts", "Arms Workout", "Saved to My Workouts.");
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
    <h1>Arms Workout</h1>
    <img src="https://images.unsplash.com/photo-1584863231364-2edc166de576?auto=format&fit=crop&w=900&q=80" style="float:right;height:500px" />
    <img src="https://images.unsplash.com/photo-1517963879433-6ad2b056d712?auto=format&fit=crop&w=700&q=80" style="float:right;height:240px;margin-right:12px" />

    <asp:Button ID="btnSaveFavorite" runat="server" Text="Save to Favorites" OnClick="btnSaveFavorite_Click" />
    <asp:Button ID="btnSaveMyWorkout" runat="server" Text="Save to My Workouts" OnClick="btnSaveMyWorkout_Click" />
    <br />
    <asp:Label ID="lblSaveMessage" runat="server" ForeColor="Lime" />

    <h2>Warm-up:</h2>
    <h3>
        - 5 minutes jump rope or treadmill walk
        <br />
        - Light band curls and triceps pressdowns
    </h3>
    <h2>Workout Plan:</h2>
    <h3>
        1. Barbell Curls - 4 sets x 8-10 reps
        <br />
        2. Hammer Curls - 3 sets x 10-12 reps
        <br />
        3. Concentration Curls - 3 sets x 12 reps each arm
        <br />
        4. Close-Grip Bench Press - 4 sets x 8 reps
        <br />
        5. Rope Triceps Pushdown - 3 sets x 12 reps
        <br />
        6. Overhead Dumbbell Extension - 3 sets x 10 reps
        <br />
        7. Superset finisher: 2 rounds of curls + dips to failure
    </h3>

    <h2>Cool Down:</h2>
    <h3>
        - Stretch biceps, triceps, and forearms for 5 minutes.
    </h3>

</asp:Content>
