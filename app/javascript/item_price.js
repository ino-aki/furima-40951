window.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value; // 入力された価格を数値に変換

    // 数値でない場合や空の場合にNaNが返されるため、その場合は計算を行わない
    if (!isNaN(inputValue)) {
      // 手数料率の設定（手数料率は10%とします）
      const commissionRate = 0.10;  // 手数料率 10%

      // 販売手数料の計算（小数点以下を切り捨てて整数にする）
      const commission = Math.floor(inputValue * commissionRate);

      // 販売利益の計算（小数点以下を切り捨てて整数にする）
      const profit = Math.floor(inputValue - commission );

      // 販売手数料と販売利益を表示
      addTaxDom.innerHTML = `${commission.toLocaleString()}`; // 手数料をカンマ区切りの整数に変換して表示
      profitDom.innerHTML = `${profit.toLocaleString()}`;     // 利益をカンマ区切りの整数に変換して表示
    } else {
      // 数値でない場合は空欄またはエラーメッセージを表示する処理を追加
      addTaxDom.innerHTML = "0";
      profitDom.innerHTML = "0";
    }
  });
});
