<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="project2.master2" %>

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
            var email = document.getElementById("email").value;
            var username = document.getElementById("userN").value;
            var password1 = document.getElementById("password1").value;
            var confirmPass1 = document.getElementById("confirmPass").value;
            var fName1 = document.getElementById("fName").value;
            var lName1 = document.getElementById("lName").value;
            var bDay1 = document.getElementById("bDay").value;
            var pNum1 = document.getElementById("phoneNum").value;
            var gender = document.querySelector('input[name="gender"]:checked');

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
            if (pNum1 == "") {
                alert("Fill in phone number");
                return false;
            }
            if (pNum1.length != 9 && pNum1.length != 10) {
                alert("Phone number must be 9-10 digits.");
                return false;
            }
            if (!pNum1.includes("-")) {
                alert("Phone number must include a '-' symbol.");
                return false;
            }
            if (pNum1[0] != '0') {
                alert("Phone number must start with 0.");
                return false;
            }

            if (pNum1.indexOf("-") == 3 && (pNum1[1] != '5' && pNum1[1] != '7')) {
                alert("Phone numbers starting with 0 must have 5 or 7 as the second digit.");
                return false;
            }

            alert("The form was successfully filled");
            return true;
        }
    </script>

    

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>SIGN UP</h1>
        <form id="form1" runat="server" onsubmit="return checkForm()">

    First name: <input type="text" id="fName" />
    <br />
    Last name: <input type="text" id="lName" />
    <br />
    Birthday: <input type="date" id="bDay" />
    <br />
    Gender: <br />
    male <input type="radio" name="gender" id="male" />
    female <input type="radio" name="gender" id="female" />
    <br />
    City: <input type="text" id="city" />
    <br />
    Email: <input type="text" id="email" />
    <br />
    Username: <input type="text" id="userN" />
    <br />
    Phone number: <input type="text" id="phoneNum" />
    <br />
    Password: <input type="password" id="password1" />
    <br />
    Confirm Password: <input type="password" id="confirmPass" />
    <br />
    <input type="submit" value="Submit" />
    RESET <input type="reset" />
    <div style="text-align:center" name="div" id="div" runat="server"></div>
               

    <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
            </form>
</asp:Content>
