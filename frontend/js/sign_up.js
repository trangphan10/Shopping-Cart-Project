var form = document.getElementById('form');
var password2 = document.getElementById('password2');
var email = document.getElementById("email");
var password = document.getElementById("password");
var add = document.getElementById("addr");
var firstname = document.getElementById("fname");
var lastname = document.getElementById("lname");



$(document).ready(function () {
    $("#submit").click(function () {
        

        // Tạo một đối tượng JSON từ các giá trị
        var data = {
            email: email.value,
            password: password.value,
            lastname: lastname.value,
            firstname: firstname.value,
            address: add.value
        };
        // e.preventDefault();
        const url = "/"
        if (isFormValid()) {
            // Proceed with form submission or any other action
            console.log('Form is valid. Submitting...');
            $.ajax({
                url: "/register",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(data),
                crossDomain: true,
                success: function (response) {
                    // Handle JSON data from the response

                    if (response.Check === "ok") {
                        
                        window.location.href = "../sub-pages/sign-in.html";
                    } else {
                        
                        setError(email, 'Email already registered');
                    }
                },
                error: function (xhr, status, error) {
                    // Display an error message if there's an issue with the request
                    console.log("Fail registered: " + error.message)
        
                }
            });
        } else {
            console.log('Form is not valid. Please check your inputs.');
        }
        
        


        

    });
});


const setError = (element, message) => {
    const inputControl = element.parentElement;
    const errorDisplay = inputControl.querySelector('.error');

    errorDisplay.innerText = message;
    inputControl.classList.add('error');
    inputControl.classList.remove('success')
}

const setSuccess = element => {
    const inputControl = element.parentElement;
    const errorDisplay = inputControl.querySelector('.error');

    errorDisplay.innerText = '';
    inputControl.classList.add('success');
    inputControl.classList.remove('error');
};

const isValidEmail = email => {
    const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}
const isFormValid = () => {
    const emailValue = email.value.trim();
    const passwordValue = password.value.trim();
    const password2Value = password2.value.trim();

    if (emailValue === '' || !isValidEmail(emailValue)) {
        setError(email, 'Provide a valid email address');
        return false;
    } else {
        setSuccess(email);
    }

    if (passwordValue === '' || passwordValue.length < 8) {
        setError(password, 'Password must be at least 8 characters.');
        return false;
    } else {
        setSuccess(password);
    }

    if (password2Value === '' || password2Value !== passwordValue) {
        setError(password2, "Passwords don't match");
        return false;
    } else {
        setSuccess(password2);
    }

    // If all validations pass, return true
    return true;
};