$(document).ready(function () {
    // var productsContainer = $("#productsContainer");
    const url = "/";
    const container = $(".pro-container");
    // Gửi yêu cầu GET đến "/products" sử dụng jQuery AJAX
    $.ajax({
        url: url + "products",
        type: "GET",
        contentType: "application/json",
        success: function (data) {
            console.log("ok",data);
            
            data.forEach((product) => {
                const { ProductImages, Name, Price ,ID} = product;

                container.append(`
                    <div class="pro" onclick="redirectToSingleProductPage('${ID}')">
                        <img src="${"../../"}${ProductImages[0].Path}" alt="Product Image">
                        <div class="des">
                            <span>adidas</span>
                            <h5>${Name}</h5>
                            <div class="star">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                            </div>
                            <h4>${Price}</h4>
                        </div>
                        <a href="#" class="cart"><i class="fa-solid fa-cart-shopping"></i></a>
                    </div>
                `);
            });

            
            
        },
        error: function (xhr, status, error) {
            // Display an error message if there's an issue with the request
            console.log("fail");
        }
    });
    
});

function redirectToSingleProductPage(productId) {
    window.location.href = `sproduct.html`;
    localStorage.setItem("pro-id",productId);

}




// const container = document.querySelector(".pro-container");


// fetch("/products")
//     .then((response) => {
//         console.log(response);
//         return response.json();
//     })
//     .then((data) => {
//         console.log("DATA:",data);

//         data.forEach((product) => {
//         const { ProductImages, Name, Price } = product;

//                 container.innerHTML += `
//                 <div class="pro" onclick="window.location.href='sproduct.html'">
//                     <img src="${ProductImages[0].Path}" alt="Product Image">
//                     <div class="des">
//                         <span>adidas</span>
//                         <h5>${Name}</h5>
//                         <div class="star">
//                             <i class="fa-solid fa-star"></i>
//                             <i class="fa-solid fa-star"></i>
//                             <i class="fa-solid fa-star"></i>
//                             <i class="fa-solid fa-star"></i>
//                             <i class="fa-solid fa-star"></i>
//                         </div>
//                         <h4>${Price}</h4>
//                     </div>
//                     <a href="#" class="cart"><i class="fa-solid fa-cart-shopping"></i></a>
//                 </div>
//                 `;

                
//         });
// });

