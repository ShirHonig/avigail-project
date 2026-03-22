using System;
using System.Text;
using System.Web;
using System.Web.UI;

namespace project2
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Generate anti-forgery token
                var token = Guid.NewGuid().ToString();
                Session["AntiForgeryToken"] = token;
                hfAntiForgery.Value = token;

                // Redirect if already logged in
                if (Session["Login"] != null && (bool)Session["Login"])
                {
                    Response.Redirect("Main.aspx");
                }

                // Debug: Check if Application state is initialized
                if (Application["DebugInit"] == null)
                {
                    message.Text = "Error: Application state not initialized. Attempting to initialize...";
                    InitializeApplicationState();
                }
            }
        }

        private void InitializeApplicationState()
        {
            // Fallback initialization if Application_Start didn't run
            Application.Lock();
            if (Application["DebugInit"] == null)
            {
                Application["uName1"] = "Shelly12";
                Application["uPass1"] = "Shelly28!";
                Application["uAdmin1"] = true;

                Application["uName2"] = "Alex12";
                Application["uPass2"] = "Alex1975!";
                Application["uAdmin2"] = true;

                Application["uName3"] = "Moshe12";
                Application["uPass3"] = "Moshe2100!";
                Application["uAdmin3"] = false;

                Application["uName4"] = "Baruch12";
                Application["uPass4"] = "David11!";
                Application["uAdmin4"] = false;

                Application["uName5"] = "Miriam";
                Application["uPass5"] = "Bhb!1456";
                Application["uAdmin5"] = false;

                Application["SessionsNum"] = 0;
                Application["currentSession"] = 0;
                Application["ActiveUsers"] = 0;
                Application["LoginSessions"] = 0;
                Application["DebugInit"] = "Fallback initialization at " + DateTime.Now.ToString();
            }
            Application.UnLock();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Verify anti-forgery token
            if (hfAntiForgery.Value != Session["AntiForgeryToken"]?.ToString())
            {
                message.Text = "Invalid form submission.";
                return;
            }

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Debug: Log input
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                message.Text = $"Debug: Username='{username}', Password='{password}'";
                return;
            }

            // Server-side validation
            if (username.Length < 2)
            {
                message.Text = "Username must be at least 2 characters.";
                return;
            }
            if (!System.Text.RegularExpressions.Regex.IsMatch(username, @"^[a-zA-Z][a-zA-Z0-9@_.-]*$"))
            {
                message.Text = "Username must start with a letter and contain only letters, numbers, @, _, ., or -.";
                return;
            }
            if (password.Length < 6 || password.Length > 12)
            {
                message.Text = "Password must be 6-12 characters.";
                return;
            }
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':""/|,.<>/?]*$"))
            {
                message.Text = "Password can only contain English letters, numbers, or common special characters.";
                return;
            }
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"[A-Z]"))
            {
                message.Text = "Password must have at least one uppercase letter.";
                return;
            }
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"[0-9]"))
            {
                message.Text = "Password must have at least one number.";
                return;
            }
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"[!@#$%^&*()_+\-=\[\]{};':""/|,.<>/?]"))
            {
                message.Text = "Password must have at least one special character.";
                return;
            }
            if (System.Text.RegularExpressions.Regex.IsMatch(password, @"(.)\1{2,}"))
            {
                message.Text = "Password cannot contain 3 or more consecutive repeating characters.";
                return;
            }

            // Authenticate using stored credentials
            bool isValidUser = MockAuthenticate(username, password, out string debugMessage);

            if (isValidUser)
            {
                Session["Login"] = true;
                Session["userName"] = username;

                // Update login counters
                Application.Lock();
                Application["ActiveUsers"] = (int)Application["ActiveUsers"] + 1;
                Application["LoginSessions"] = (int)Application["LoginSessions"] + 1;
                Application.UnLock();

                Response.Redirect("Main.aspx");
            }
            else
            {
                message.Text = $"Invalid username or password. Debug: Input username='{username}', password='{password}'. {debugMessage}";
            }
        }

        private bool MockAuthenticate(string username, string password, out string debugMessage)
        {
            StringBuilder debug = new StringBuilder();
            bool found = false;

            if (Application["DebugInit"] == null)
            {
                debug.Append($"Application state not initialized. DebugInit: {Application["DebugInit"] ?? "null"}<br/>");
            }
            else
            {
                debug.Append($"Application state initialized: {Application["DebugInit"]}<br/>");
            }

            for (int i = 1; i <= 5; i++)
            {
                string storedUser = Application[$"uName{i}"]?.ToString();
                string storedPass = Application[$"uPass{i}"]?.ToString();
                bool? isAdmin = Application[$"uAdmin{i}"] as bool?;

                debug.Append($"Checking uName{i}: {storedUser ?? "null"}, uPass{i}: {storedPass ?? "null"}, uAdmin{i}: {isAdmin?.ToString() ?? "null"}<br />");

                if (!string.IsNullOrEmpty(storedUser) && storedUser.Equals(username, StringComparison.InvariantCultureIgnoreCase) && storedPass == password)
                {
                    Session["Admin"] = isAdmin ?? false;
                    found = true;
                    break;
                }
            }

            debugMessage = found ? "Match found!" : debug.ToString();
            return found;
        }
    }
}