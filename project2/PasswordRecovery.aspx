<%@ Page Title="Password Recovery" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PasswordRecovery.aspx.cs" Inherits="project2.PasswordRecovery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function checkEnglish(input) {
            return /^[a-zA-Z]$/.test(input);
        }

        function checkNumbers(input) {
            return /^[0-9]$/.test(input);
        }

        function checkSpecial(input) {
            return /^[\W_]+$/.test(input);
        }

        function checkForm() {
            var email = document.getElementById('<%= txtEmail.ClientID %>').value;
            var password1 = document.getElementById('<%= txtNewPassword.ClientID %>').value;
            var confirmPass1 = document.getElementById('<%= txtConfirmPassword.ClientID %>').value;

            if (email == "") {
                alert("Fill in email");
                return false;
            }
            if (email.indexOf("@") == -1 || email.indexOf(".") == -1) {
                alert("Email must include @ and a period. Enter a valid email");
                return false;
            }
            if (!checkEnglish(email[0])) {
                alert("Email must start with an English character.");
                return false;
            }
            for (let i = 0; i < email.length; i++) {
                if (!checkEnglish(email[i]) && !checkNumbers(email[i]) && !['-', '_', '.', '@'].includes(email[i])) {
                    alert("Email must only contain English letters, numbers, and @, -, ., _.");
                    return false;
                }
            }

            if (password1 == "") {
                alert("Fill in new password");
                return false;
            }
            if (password1.length < 6 || password1.length > 12) {
                alert("Password must be between 6-12 characters.");
                return false;
            }
            for (let i = 0; i < password1.length; i++) {
                if (!checkEnglish(password1[i]) && !checkNumbers(password1[i]) && !checkSpecial(password1[i])) {
                    alert("Password must only contain English letters, numbers, and special characters.");
                    return false;
                }
            }
            let countUpper = 0;
            let countSpecial = 0;
            let countNum = 0;
            for (let i = 0; i < password1.length; i++) {
                if (password1[i] >= 'A' && password1[i] <= 'Z') countUpper++;
                if (checkSpecial(password1[i])) countSpecial++;
                if (checkNumbers(password1[i])) countNum++;
            }
            if (countUpper == 0) {
                alert("Password must have at least one uppercase letter.");
                return false;
            }
            if (countSpecial == 0) {
                alert("Password must have at least one special character.");
                return false;
            }
            if (countNum == 0) {
                alert("Password must have at least one number.");
                return false;
            }
            let count = 1;
            for (let i = 1; i < password1.length; i++) {
                if (password1[i] === password1[i - 1]) {
                    count++;
                    if (count >= 3) {
                        alert("Password contains 3 or more consecutive repeating characters.");
                        return false;
                    }
                } else {
                    count = 1;
                }
            }

            if (confirmPass1 == "") {
                alert("Confirm password");
                return false;
            }
            if (confirmPass1 != password1) {
                alert("Passwords do not match.");
                return false;
            }

            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>PASSWORD RECOVERY</h1>
    <asp:Panel ID="pnlPasswordRecovery" runat="server" DefaultButton="btnSubmit">
        <asp:Label AssociatedControlID="txtEmail" runat="server" Text="Email:" />
        <asp:TextBox ID="txtEmail" runat="server" aria-describedby="emailHelp" />
        <small id="emailHelp" class="form-text">Enter your email to reset your password.</small>
        <br /><br />

        <asp:Label AssociatedControlID="txtNewPassword" runat="server" Text="New Password:" />
        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" aria-describedby="passwordHelp" />
        <small id="passwordHelp" class="form-text">Password must be 6-12 characters, with at least one uppercase letter, number, and special character.</small>
        <br /><br />

        <asp:Label AssociatedControlID="txtConfirmPassword" runat="server" Text="Confirm New Password:" />
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" />
        <br /><br />

        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" OnClientClick="return checkForm();" />
        <br /><br />

        <asp:Label ID="message" runat="server" ForeColor="Red" aria-live="polite" />
    </asp:Panel>
</asp:Content>