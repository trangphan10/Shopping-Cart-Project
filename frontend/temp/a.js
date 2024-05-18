$(document).ready(function () {
    user_infor = {
        id: "",
        firstname: ""
    }


    $("#submit").click(function () {
        var email = document.getElementById("email").value;
        var pass = document.getElementById("pass").value;
        var add = document.getElementById("add").value;
        var firstname = document.getElementById("fname").value;
        var lastname = document.getElementById("lname").value;

        // Tạo một đối tượng JSON từ các giá trị
        var data = {
            email: email,
            password: pass,
            lastname: lastname,
            firstname: firstname,
            address: add
        };

        document.getElementById("test").innerHTML = data["email"];
        const url = "http://127.0.0.1:9000/"


        $.ajax({
            url: "/register",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            crossDomain: true,
            success: function (response) {
                // Handle JSON data from the response
                $("#regis").text("Result: " + JSON.stringify(response));
            },
            error: function (xhr, status, error) {
                // Display an error message if there's an issue with the request
                $("#regis").text("Fail: " + error.message);
            }
        });

        var check = false;
        $.ajax({
            url: "/login",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function (response) {
                // Handle JSON data from the response
                user_infor["id"] = response["ID"]
                $("#login").text("Result: " + JSON.stringify(response));
                document.getElementById("data-user").innerHTML = JSON.stringify(user_infor);
                document.getElementById("id_user").value = user_infor["id"]
                document.getElementById("button").submit();
                check = true
            },
            error: function (xhr, status, error) {
                // Display an error message if there's an issue with the request
                check = true
                $("#login").text("Fail: " + error.message);
            }
        });



        $.ajax({
            url: "/users/" + user_infor["id"],
            type: "GET",
            contentType: "application/json",
            // data: JSON.stringify(data),
            // crossDomain: true,
            success: function (response) {
                // Handle JSON data from the response
                $("#get-data-user").text("Result: " + JSON.stringify(response));
            },
            error: function (xhr, status, error) {
                // Display an error message if there's an issue with the request
                $("#get-data-user").text("Fail: " + error.message);
            }
        });


    });
});