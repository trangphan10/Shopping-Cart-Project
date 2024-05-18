 /* const product = [
    {image: '../data/images/balo/balo1/minibalo2.png', title: 'Mini Album', price: 120, Qty: 2},
    {image: '../data/images/chair/chair2/i1.jpg', title: 'Chair', price: 80, Qty: 1},
    {image: '../data/images/keyboard/keyboard1/keyboard_1_1.jpg', title: 'Keyboard', price: 100, Qty: 2},
    {image: '../data/images/handbag/handbag2/tui_xach_xanh.png', title: 'Handbag', price: 2000, Qty: 1},
];

const category = [...new Set(product.map((item) => ({...item})))]; */
const url = "http://" + document.getElementById("backend-host").textContent + ":9000/";
// const pro_id = localStorage.getItem("pro-id");
// const category = [];
// category.push(...pro_id);
// console.log("ID pro: ",pro_id);
// console.log("cartID:",'6cb33888-d3cb-4b28-9e03-0bf4e80364dc');
const baseImagePath = "../../";



// function quantityChanged(event) {
//     var input = event.target;
//     let index = input.getAttribute('data-index');
//     let newQty = parseInt(input.value);
//     if (isNaN(newQty) || newQty <= 0) {
//         input.value = 1;
//         newQty = 1;
//     }


//     $.ajax({
//         url: url + "carts/" + '1ae0725f-af6f-49f1-abe7-110be47adc4e', 
//         type: 'POST',
//         contentType: "application/json",
//         data: {
//             CartItems:[{
//                 Qty: newQty,
//         }],},
//         success: function () {
//             displaycart();
         
//         },
//         error: function (xhr, status, error) {
//             console.error('Error:', status, error);
//         }
//     });
// }

function displaycart(){
    const id = localStorage.getItem("ID");
    
    $.ajax({
        url: url + "carts/" + id,
        type: 'GET',
        contentType: "application/json",
        
        success: function(data) {
        const {ID, CartItems} = data;
        
        console.log("ok",data);
        let j = 0,
        total = 0;
        console.log("Oke",CartItems[0]);
    document.getElementById("CountA").innerHTML = CartItems.length + " Items";
    document.getElementById("CountB").innerHTML = CartItems.length + " Items";

    if (CartItems.length === 0) {
        document.getElementById("root").innerHTML = "Your cart is empty";
        document.getElementById("Subtotal").innerHTML = "$ 00.00";
        document.getElementById("TotalPrice").innerHTML = "$ 00.00";
    } else {
        let cartHTML = CartItems.map((item,index) => {
            const { ProductImages, Name, Price } = item.Product;

            localStorage.setItem('Item',item.ID);
            localStorage.setItem('CartID',item.CartID);
            console.log('Item:',localStorage.getItem('Item')); 
            console.log(localStorage.getItem('CartID'));
            localStorage.setItem('Item-cart',item.Product.ID);
            const item_in_cart =localStorage.getItem("Item-cart");
            console.log('Id-product-cart:',item_in_cart); 

            console.log("Main src ",ProductImages[0].Path)
            let subitem = Price * item.Qty;
            total = total + subitem;

            document.getElementById("Subtotal").innerHTML = "$" + total.toFixed(2);

            if (total > 3000 && total > 0) {
                document.getElementById("Ship").innerHTML = "Freeship";
                document.getElementById("TotalPrice").innerHTML = "$" + total.toFixed(2);
            } else {
                document.getElementById("Ship").innerHTML = '$' + 25 + ".00";
                document.getElementById("TotalPrice").innerHTML = "$" + (total + 25).toFixed(2);
            }

            return `<tr id = 'Item'>
                <td>
                    <i class="fa-regular fa-circle-xmark" data-id=${item.ID}></i>
                </td>
                <td>
                    <div class='img-box'> <img class="img" id="image"  src="${baseImagePath}${ProductImages[0].Path}" alt="${Name}" ></div>
                </td>
                <td><p style='font-size:15px;' id="Name">${Name}</p></td>
                <td><h2 id='price' style='font-size:15px; color:red;'>$ ${Price} </h2></td>
                <td id = 'Quantity-box'>
                    <div class='Quanty'>
                    <i class="fa-solid fa-minus" id= "minus-btn"  data-id=${item.ProductID}></i>
                    <input type="number" id="Qty" class="Qty-box" value="${item.Qty}" data-index="${index}" style=" text-align: center;" min="1" max="99" readonly>
                    <i class="fa-solid fa-plus" id = "plus-btn" data-id=${item.ProductID}></i>
                    </div>
                </td>
                <td><h2 style='font-size:15px; color:red;'> ${subitem.toFixed(2)} </h2></td>
            </tr>`;
        }).join('');
        
        document.getElementById('root').innerHTML = cartHTML;
        (function () {
            $('.fa-circle-xmark').click(function (e) {
                e.preventDefault(); 
                var $removeBtn = $(this);
                if (confirm("Are you sure you want to remove this product?")) {
                var id = $removeBtn.data('id'); 
        
                $.ajax({
                    type: 'DELETE',
                    url: url + 'carts/' + id,
                    success: function (data) {
                        $removeBtn.closest('.item').remove();
                        displaycart(); 
                    },
                    error: function (xhr, status, error) {
                        console.error('Error:', status, error);
                    }
                });
            }
            });
        })();
        (function(){
            $('.fa-minus').click(function(e){
                e.preventDefault();
                var $minusBtn = $(this);
                var id = $minusBtn.data('id');
                // var quantity = parseInt($(".Qty").val());
                // if (quantity === 1) {
                //     // Nếu Qty là 1, ẩn hiển thị fa-minus
                //     $minusBtn.hide();
                // }
                var data = {
                    "cartid": localStorage.getItem("CartID"),
                    "productID": id,
                    "Qty": -1,
                };
                // alert("Decrease quantity!");
                $.ajax({
                    type: "POST",
                    url: url + "carts",
                    data: JSON.stringify(data),
                    success: function(data2){
                       
                        displaycart();
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', status, error);
                    }
                });
                return false;
            });
        
            $('.fa-plus').click(function(e){
                e.preventDefault();
                var $plusBtn = $(this);
                var id = $plusBtn.data('id');
                var data = {
                    "cartid": localStorage.getItem("CartID"),
                    "productID": id,
                    "Qty": 1,
                };
        
                $.ajax({
                    type: "POST",
                    url: url + "carts",
                    data: JSON.stringify(data),
                    success: function(data1){
                        displaycart();
                        console.log(JSON.stringify(data1));
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', status, error);
                    }
                });
                return false;
            });
        })();
        
        
        
       
        
        
    }
},
error: function(xhr, status, error) {
    console.error('Error fetching cart data:', status, error);
}
});
}
displaycart();


