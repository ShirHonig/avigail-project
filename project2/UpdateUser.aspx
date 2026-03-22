<%@ Page Title="Update User" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UpdateUser.aspx.cs" Inherits="project2.UpdateUser" %>
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

        function checkHebrew(input) {
            const hebrew = /[\u0590-\u05FF]/;
            return hebrew.test(input);
        }

        function checkForm() {
            var email = document.getElementById('<%= txtEmail.ClientID %>').value;
            var username = document.getElementById('<%= txtUsername.ClientID %>').value;
            var password1 = document.getElementById('<%= txtPassword.ClientID %>').value;
            var confirmPass1 = document.getElementById('<%= txtConfirmPassword.ClientID %>').value;
            var fName1 = document.getElementById('<%= txtFirstName.ClientID %>').value;
            var lName1 = document.getElementById('<%= txtLastName.ClientID %>').value;
            var bDay1 = document.getElementById('<%= txtBirthDate.ClientID %>').value;
            var gender = document.querySelector('input[name="<%= rblGender.UniqueID %>"]:checked');

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
                alert("Fill in password");
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

            if (username == "") {
                alert("Fill in username");
                return false;
            }
            if (!checkEnglish(username[0])) {
                alert("Username must start with an English character.");
                return false;
            }
            if (username.length < 2) {
                alert("Username must be more than 2 characters.");
                return false;
            }

            if (confirmPass1 == "") {
                alert("Confirm password");
                return false;
            }
            if (confirmPass1 != password1) {
                alert("Passwords do not match.");
                return false;
            }

            if (fName1 == "") {
                alert("Fill in first name");
                return false;
            }
            if (fName1.length < 2) {
                alert("First name must be at least 2 characters.");
                return false;
            }
            for (let i = 0; i < fName1.length; i++) {
                if (!checkEnglish(fName1[i]) && fName1[i] != ' ' && !checkHebrew(fName1[i])) {
                    alert("First name must only contain English letters, Hebrew letters, and spaces.");
                    return false;
                }
            }

            if (lName1 == "") {
                alert("Fill in last name");
                return false;
            }
            if (lName1.length < 2) {
                alert("Last name must be at least 2 characters.");
                return false;
            }
            for (let i = 0; i < lName1.length; i++) {
                if (!checkEnglish(lName1[i]) && lName1[i] != ' ' && !checkHebrew(lName1[i])) {
                    alert("Last name must only contain English letters, Hebrew letters, and spaces.");
                    return false;
                }
            }

            if (bDay1 == "") {
                alert("Fill in birthday");
                return false;
            }

            if (!gender) {
                alert("Please select a gender.");
                return false;
            }

            return true;
        }

        function resetForm() {
            document.getElementById('<%= txtEmail.ClientID %>').value = '';
            document.getElementById('<%= txtUsername.ClientID %>').value = '';
            document.getElementById('<%= txtPassword.ClientID %>').value = '';
            document.getElementById('<%= txtConfirmPassword.ClientID %>').value = '';
            document.getElementById('<%= txtFirstName.ClientID %>').value = '';
            document.getElementById('<%= txtLastName.ClientID %>').value = '';
            document.getElementById('<%= txtBirthDate.ClientID %>').value = '';
            document.getElementById('<%= txtCity.ClientID %>').value = '';
            document.querySelector('input[name="<%= rblGender.UniqueID %>"]:checked').checked = false;
            document.getElementById('<%= message.ClientID %>').innerText = '';
            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>UPDATE USER</h1>
    <asp:Panel ID="pnlUpdateUser" runat="server" DefaultButton="btnSubmit">
       

        <asp:Label AssociatedControlID="txtFirstName" runat="server" Text="First Name:" />
        <asp:TextBox ID="txtFirstName" runat="server" aria-describedby="firstNameHelp" />
        <small id="firstNameHelp" class="form-text">First name must be at least 2 characters, English or Hebrew letters, and spaces.</small>
        <br /><br />

        <asp:Label AssociatedControlID="txtLastName" runat="server" Text="Last Name:" />
        <asp:TextBox ID="txtLastName" runat="server" aria-describedby="lastNameHelp" />
        <small id="lastNameHelp" class="form-text">Last name must be at least 2 characters, English or Hebrew letters, and spaces.</small>
        <br /><br />

        <asp:Label AssociatedControlID="txtBirthDate" runat="server" Text="Birthday:" />
        <asp:TextBox ID="txtBirthDate" runat="server" TextMode="Date" aria-describedby="birthDateHelp" />
        <small id="birthDateHelp" class="form-text">Enter your birth date.</small>
        <br /><br />

        <asp:Label AssociatedControlID="rblGender" runat="server" Text="Gender:" />
        <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Value="Male">Male</asp:ListItem>
            <asp:ListItem Value="Female">Female</asp:ListItem>
        </asp:RadioButtonList>
        <small id="genderHelp" class="form-text">Select your gender.</small>
        <br /><br />

        <asp:Label AssociatedControlID="txtCity" runat="server" Text="City:" />
        <asp:TextBox ID="txtCity" runat="server" aria-describedby="cityHelp" />
        <small id="cityHelp" class="form-text">City is optional.</small>
        <br /><br />

        <asp:Label AssociatedControlID="txtEmail" runat="server" Text="Email:" />
        <asp:TextBox ID="txtEmail" runat="server" aria-describedby="emailHelp" />
        <small id="emailHelp" class="form-text">Email must include @ and a period, start with a letter.</small>
        <br /><br />

        <asp:Label AssociatedControlID="txtUsername" runat="server" Text="Username:" />
        <asp:TextBox ID="txtUsername" runat="server" aria-describedby="usernameHelp" />
        <small id="usernameHelp" class="form-text">Username must start with a letter and contain only letters, numbers, @, _, ., or -.</small>
        <br /><br />

        <asp:Label AssociatedControlID="txtPassword" runat="server" Text="Password:" />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" aria-describedby="passwordHelp" />
        <small id="passwordHelp" class="form-text">Password must be 6-12 characters, with at least one uppercase letter, number, and special character.</small>
        <br /><br />

        <asp:Label AssociatedControlID="txtConfirmPassword" runat="server" Text="Confirm Password:" />
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" />
        <br /><br />

        <asp:Label AssociatedControlID="chkAdmin" runat="server" Text="Admin:" Visible="false" />
        <asp:CheckBox ID="chkAdmin" runat="server" Visible="false" />
        <br /><br />

        <asp:Button ID="btnSubmit" runat="server" Text="Update" OnClick="btnSubmit_Click" OnClientClick="return checkForm();" />
        <asp:Button ID="btnReset" runat="server" Text="Reset" OnClientClick="return resetForm();" />
        <br /><br />

        <asp:Label ID="message" runat="server" ForeColor="Red" aria-live="polite" />
    </asp:Panel>
</asp:Content>