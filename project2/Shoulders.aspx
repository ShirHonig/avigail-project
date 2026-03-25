<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" %>

<script runat="server">
    protected void btnSaveFavorite_Click(object sender, EventArgs e)
    {
        SaveWorkout("FavoriteWorkouts", "Shoulder Power Workout", "Saved to favorites.");
    }

    protected void btnSaveMyWorkout_Click(object sender, EventArgs e)
    {
        SaveWorkout("MyWorkouts", "Shoulder Power Workout", "Saved to My Workouts.");
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
    <h1>Shoulder Power Workout</h1>
    <img src="https://source.unsplash.com/featured/?shoulder,workout" style="float:right;height:500px" />

    <asp:Button ID="btnSaveFavorite" runat="server" Text="Save to Favorites" OnClick="btnSaveFavorite_Click" />
    <asp:Button ID="btnSaveMyWorkout" runat="server" Text="Save to My Workouts" OnClick="btnSaveMyWorkout_Click" />
    <br />
    <asp:Label ID="lblSaveMessage" runat="server" ForeColor="Lime" />

    <h2>Warm-up:</h2>
    <h3>
        - 5 minutes light cardio
        <br />
        - Shoulder circles, band dislocates, and wall slides
    </h3>

    <h2>Workout Plan:</h2>
    <h3>
        1. Seated Dumbbell Shoulder Press - 4 sets x 8 reps
        <br />
        2. Arnold Press - 3 sets x 10 reps
        <br />
        3. Lateral Raises - 4 sets x 12 reps
        <br />
        4. Front Raises - 3 sets x 12 reps
        <br />
        5. Rear Delt Flyes - 4 sets x 12-15 reps
        <br />
        6. Upright Rows - 3 sets x 10 reps
        <br />
        7. Dumbbell Shrugs - 4 sets x 12 reps
    </h3>

    <h2>Rest & Recovery:</h2>
    <h3>
        - Rest 60 seconds between isolation sets and 90 seconds after press movements.
    </h3>
</asp:Content>
