const url = "/";
var pro_name;
$(document).ready(function () {
    // var productsContainer = $("#productsContainer");
    
    const pro_img = document.querySelector(".single-pro-img");
    const pro_detail = document.querySelector(".single-pro-details")
    const baseImagePath = "../../";
    const pro_id = localStorage.getItem("pro-id");
    console.log("ID pro: ",pro_id);
    // Gửi yêu cầu GET đến "/products" sử dụng jQuery AJAX
    $.ajax({
        url: url + "products/"+pro_id,
        type: "GET",
        contentType: "application/json",
        success: function (data) {
            console.log("ok",data);
            const { ProductImages, Name, Price ,CategoryID,Description} = data;
            console.log("Main src ",ProductImages[0].Path)
            pro_img.innerHTML += `
            <img src="${baseImagePath}${ProductImages[0].Path}" alt="${Name}" width="100%" height="60%" id="mainImg">
            <div class="small-img-group">
            `;
            const img_group = document.querySelector(".small-img-group");

            // Create small image elements and append them to the small-img-group
            for (let i = 0; i < ProductImages.length; i++) {
                img_group.innerHTML += `
                    <div class="small-img-col">
                        <img src="${baseImagePath}${ProductImages[i].Path}" width="100%" alt="${Name} ${i + 1}" class="small-img">
                    </div>
                `;
                console.log(`Image ${i + 1} path: ${ProductImages[i].Path}`);
            }
            var mainImg = document.getElementById("mainImg");
            var smallImg = document.getElementsByClassName("small-img");
            console.log(smallImg);
            
            for (let i = 0; i < smallImg.length; i++) {
                smallImg[i].addEventListener("click", () => {
                    mainImg.src = smallImg[i].src;
                });
                console.log("img",smallImg[i]);
            }
            pro_detail.innerHTML+=`
            <h5>Shop</h5>
            <h4>${CategoryID}</h4>
            <h2>${Price}$</h2>
            
            <input type="number" value="1" id="qty" min="1" max="99">
            <button class="normal" id="add-to-cart">Add to cart</button>
            
            <div class="input-control">
            <div class="error"></div>
            </div>

            <h4>Product Details</h4>
            <span>${Description}
            </span>
            `
            pro_name = Name;
            
        },
        error: function (xhr, status, error) {
            // Display an error message if there's an issue with the request
            console.log("fail");
        }
    });

    
         
});




$(document).ready(function () {
    // ... (your existing code)

    // Use event delegation for the "Add to cart" button
    $(document).on('click', '#add-to-cart', function () {
        // Your existing click event handler code here
        var productId = localStorage.getItem("pro-id");
        var quantity = $("#qty").val();
        var id_cart = localStorage.getItem("ID-Carts");

        // Check if productId, quantity, and id_cart have valid values
        if (productId && quantity && id_cart) {
            // Your existing AJAX request code here
            data = {
                "CartID": id_cart,
                "productId": productId,
                "Qty": parseInt(quantity)
            };

            $.ajax({
                url: url + "carts",
                type: "POST",
                data: JSON.stringify(data),
                success: function (response) {
        
                    console.log("Success:", response);
                    alert("Add success "+ quantity + " " +pro_name);
                    
                },
                error: function (error) {
                    console.error("Error:", error);
                }
            });
        } else {
            console.error("Invalid product ID or quantity.");
        }
    });
});

















    
    