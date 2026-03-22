<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="project2.login" ValidateRequest="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function checkEnglish(input) {
            return /^[a-zA-Z]/.test(input);
        }

        function checkValidUsernameChar(input) {
            return /^[a-zA-Z0-9@_.-]$/.test(input);
        }

        function checkValidPasswordChar(input) {
            return /^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]$/.test(input);
        }

        function checkSpecial(input) {
            return /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(input);
        }

        function checkNumbers(input) {
            return /[0-9]/.test(input);
        }

        function validateForm() {
            var username = document.getElementById('<%= txtUsername.ClientID %>').value;
            var password = document.getElementById('<%= txtPassword.ClientID %>').value;
            var messageLabel = document.getElementById('<%= message.ClientID %>');

            // Clear previous error message
            messageLabel.innerText = "";

            // Username validation
            if (username === "") {
                messageLabel.innerText = "Please fill in username.";
                return false;
            }
            if (username.length < 2) {
                messageLabel.innerText = "Username must be at least 2 characters.";
                return false;
            }
            if (!checkEnglish(username[0])) {
                messageLabel.innerText = "Username must start with an English letter.";
                return false;
            }
            for (var i = 0; i < username.length; i++) {
                if (!checkValidUsernameChar(username[i])) {
                    messageLabel.innerText = "Username can only contain English letters, numbers, @, _, ., or -.";
                    return false;
                }
            }

            // Password validation
            if (password === "") {
                messageLabel.innerText = "Please fill in password.";
                return false;
            }
            if (password.length < 6 || password.length > 12) {
                messageLabel.innerText = "Password must be 6-12 characters.";
                return false;
            }
            for (var i = 0; i < password.length; i++) {
                if (!checkValidPasswordChar(password[i])) {
                    messageLabel.innerText = "Password can only contain English letters, numbers, or common special characters.";
                    return false;
                }
            }

            var countUpper = (password.match(/[A-Z]/g) || []).length;
            var countSpecial = (password.match(/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/g) || []).length;
            var countNum = (password.match(/[0-9]/g) || []).length;

            if (countUpper === 0) {
                messageLabel.innerText = "Password must have at least one uppercase letter.";
                return false;
            }
            if (countSpecial === 0) {
                messageLabel.innerText = "Password must have at least one special character.";
                return false;
            }
            if (countNum === 0) {
                messageLabel.innerText = "Password must have at least one number.";
                return false;
            }

            var count = 1;
            for (var i = 1; i < password.length; i++) {
                if (password[i] === password[i - 1]) {
                    count++;
                    if (count >= 3) {
                        messageLabel.innerText = "Password cannot contain 3 or more consecutive repeating characters.";
                        return false;
                    }
                } else {
                    count = 1;
                }
            }

            return true; // Form is valid
        }

        function resetForm() {
            document.getElementById('<%= txtUsername.ClientID %>').value = '';
            document.getElementById('<%= txtPassword.ClientID %>').value = '';
            document.getElementById('<%= message.ClientID %>').innerText = '';
            return false;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Log In</h1>
    
    <asp:Panel ID="pnlLogin" runat="server" DefaultButton="btnSubmit">
        <asp:HiddenField ID="hfAntiForgery" runat="server" />
        <asp:Label AssociatedControlID="txtUsername" runat="server" Text="Enter Username:" />
        <asp:TextBox ID="txtUsername" runat="server" aria-describedby="usernameHelp" />
        <small id="usernameHelp" class="form-text">Username must start with a letter and contain only letters, numbers, @, _, ., or -.</small>
        <br /><br />

        <asp:Label AssociatedControlID="txtPassword" runat="server" Text="Enter Password:" />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" aria-describedby="passwordHelp" />
        <small id="passwordHelp" class="form-text">Password must be 6-12 characters, with at least one uppercase letter, number, and special character.</small>
        <br /><br />

        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClientClick="return resetForm();" />
        <br /><br />

        <asp:Label ID="message" runat="server" ForeColor="Red" aria-live="polite" />
    </asp:Panel>
</asp:Content>