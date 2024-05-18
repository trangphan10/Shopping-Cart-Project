
// function getProductIdFromURL() {
//     const urlParams = new URLSearchParams(window.location.search);
//     return urlParams.get('id');
// }

// var mainImg = document.getElementById("mainImg");
// var smallImg = document.getElementsByClassName("small-img");



// console.log(smallImg);

// smallImg[0].addEventListener("click", () =>{
//     mainImg.src = smallImg[0].src;
// })
// smallImg[1].addEventListener("click", () =>{
//     mainImg.src = smallImg[1].src;
// })
// smallImg[2].addEventListener("click", () =>{
//     mainImg.src = smallImg[2].src;
// })
// smallImg[3].addEventListener("click", () =>{
//     mainImg.src = smallImg[3].src;
// })  


console.log("ok");
function getProductIdFromURL() {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get('id');
}

var mainImg = document.getElementById("mainImg");
var smallImg = document.getElementsByClassName("small-img");
console.log(smallImg);
console.log('ok2');
for (let i = 0; i < smallImg.length; i++) {
    smallImg[i].addEventListener("click", () => {
        mainImg.src = smallImg[i].src;
    });
    console.log("img",smallImg[i]);
}
console.log("ok3");


