const url = "/"
var email = document.getElementById("email");
var password = document.getElementById("password");
$(document).ready(function () {
    
    $("#submit").click(function () {


        var data = {
            email: email.value,
            password: password.value

        };
        const url = "/"
        
            // Proceed with form submission or any other action
            console.log('Form is valid. Submitting...');

            console.log(data);
            $.ajax({
                url: url + "login",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(data),
                success: function (response) {
                    if(Object.keys(response).length == 1){
                        alert("Login fail")
                    }
                    else{
                    var fieldValue = response.ID; 
                    console.log(fieldValue);
                    localStorage.setItem('ID', fieldValue);

                    var fieldValue = localStorage.getItem('ID');
                    console.log(fieldValue);
                    
                    
                    getCarts();
                    console.log("GET CARTS OK");
                    }
                    
                    
                },
                error: function (xhr, status, error) {
                    // Display an error message if there's an issue with the request
                    $("#login").text("Fail: " + error.message);
                }
        });
        
    });
    
});

function getCarts(){
    var id_user = localStorage.getItem("ID")
    $.ajax({
        
        url: url+ "carts/"+id_user,
        type: "GET",
        contentType: "application/json",
        crossDomain: true,
        success: function (response) {
            // Handle JSON data from the response
            console.log("Result carts: " + JSON.stringify(response));
            var idValue = response.ID;
            localStorage.setItem("ID-Carts",idValue)
            console.log("ID CART: ",localStorage.getItem("ID-Carts"));
            window.location.href = "../index.html";
            
        },
        error: function (xhr, status, error) {
            // Display an error message if there's an issue with the request
            
            console.log("Fail: " + error.message);
        }
    });
}




