document.addEventListener('DOMContentLoaded', function () {
    var nav = document.getElementById("navbar");

    function isLoggedIn() {
        // Lấy giá trị từ localStorage
        console.log("OK");
        var storedID = localStorage.getItem('ID');
        console.log(storedID == null);
        // Kiểm tra xem giá trị có tồn tại và không phải là undefined hay không
        return (storedID == null );
    }


    var isIndexPage = window.location.pathname.endsWith('index.html');

    if (!isLoggedIn()) {
        nav.innerHTML += '<li id="lg-user"><a href=""><i class="far fa-user"></i></a></li>';
        nav.innerHTML += '<li id="logout"><a href="">Logout</a></li>';
        console.log("login: ", localStorage.getItem('ID'))
    
        var logoutButton = document.getElementById("logout");
        
        if (logoutButton) {
            logoutButton.addEventListener('click', function () {
                // Xóa trường ID từ localStorage khi người dùng logout
                localStorage.removeItem('ID');
                localStorage.removeItem("ID-Carts");
                
                console.log("User logged out.");

                // Thực hiện các bước khác cần thiết sau khi đăng xuất, nếu có
                // ...

                // Chuyển hướng về trang index.html hoặc trang chính của bạn
                
            });
        }
     
    } else {
        if(isIndexPage){
            nav.innerHTML += '<li id="sign-in"><a href="./sub-pages/sign-in.html">Sign in</a></li>';
            nav.innerHTML += '<li id="sign-up"><a href="./sub-pages/sign-up.html">Sign up</a></li>';
        }
        else{
            nav.innerHTML += '<li id="sign-in"><a href="../sub-pages/sign-in.html">Sign in</a></li>';
            nav.innerHTML += '<li id="sign-up"><a href="../sub-pages/sign-up.html">Sign up</a></li>';
        }
        console.log("unlogin:", localStorage.getItem('ID'))
    }
});


