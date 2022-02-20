const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    // カード情報の取得
    const card = {
      number: formData.get("order_info[number]"),
      cvc: formData.get("order_info[cvc]"),
      exp_month: formData.get("order_info[exp_month]"),
      exp_year: `20${formData.get("order_info[exp_year]")}`
    };
    // トークンの取得・セット
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden" >`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // カード情報の削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      // 送信
      document.getElementById("charge-form").submit();
    });
  });
};



window.addEventListener("load", pay);