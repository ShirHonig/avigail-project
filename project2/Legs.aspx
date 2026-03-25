<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" %>

<script runat="server">
    protected void btnSaveFavorite_Click(object sender, EventArgs e)
    {
        SaveWorkout("FavoriteWorkouts", "Leg Day Workout", "Saved to favorites.");
    }

    protected void btnSaveMyWorkout_Click(object sender, EventArgs e)
    {
        SaveWorkout("MyWorkouts", "Leg Day Workout", "Saved to My Workouts.");
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
    <h1>Leg Day Workout</h1>
    <img src="https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?auto=format&fit=crop&w=900&q=80" style="float:right;height:500px" />
    <img src="https://images.unsplash.com/photo-1434682881908-b43d0467b798?auto=format&fit=crop&w=700&q=80" style="float:right;height:240px;margin-right:12px" />

    <asp:Button ID="btnSaveFavorite" runat="server" Text="Save to Favorites" OnClick="btnSaveFavorite_Click" />
    <asp:Button ID="btnSaveMyWorkout" runat="server" Text="Save to My Workouts" OnClick="btnSaveMyWorkout_Click" />
    <br />
    <asp:Label ID="lblSaveMessage" runat="server" ForeColor="Lime" />

    <h2>Warm-up:</h2>
    <h3>
        - 5 minutes brisk walk or light bike
        <br />
        - Dynamic stretches: hip circles, leg swings, bodyweight squats
    </h3>

    <h2>Workout Plan:</h2>
    <h3>
        1. Barbell Back Squat - 4 sets x 6-8 reps
        <br />
        2. Romanian Deadlift - 4 sets x 8-10 reps
        <br />
        3. Walking Lunges - 3 sets x 12 reps each leg
        <br />
        4. Leg Press - 3 sets x 10-12 reps
        <br />
        5. Leg Curl - 3 sets x 12 reps
        <br />
        6. Standing Calf Raises - 4 sets x 15 reps
        <br />
        7. Rest 60-90 seconds between sets
    </h3>

    <h2>Finisher:</h2>
    <h3>
        - 3 rounds: 20 jump squats + 30 seconds wall sit
    </h3>
</asp:Content>
