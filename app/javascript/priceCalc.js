function priceCalc (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit")
    addTaxPrice.innerHTML = commissionCalk(itemPrice.value);
    profit.innerHTML = (itemPrice.value - commissionCalk(itemPrice.value));
  });
  
};

window.addEventListener('load', priceCalc)

function commissionCalk(price){
  const commission = parseInt(price / 10, 10);
  return commission;
};