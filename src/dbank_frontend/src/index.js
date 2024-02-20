import { dbank_backend } from "../../declarations/dbank_backend";


async function GetBalance() {
  const balance = await dbank_backend.SeeCurrentValue();
  document.getElementById("value").innerText = Math.round(balance * 100) / 100;
}

window.addEventListener("load",GetBalance);

document.querySelector("form").addEventListener("submit",async function(event) {
  event.preventDefault();
  // console.log("submitted");

  const button = event.target.querySelector("#submit-btn");


  const inputAmount = document.getElementById("input-amount").value;
  const outputAmount = document.getElementById("withdrawal-amount").value;

  button.setAttribute("disabled",true);

  if (inputAmount.length != 0){
    await dbank_backend.topUp2(parseFloat(inputAmount));
    document.getElementById("input-amount").value = "";
    GetBalance();
  }
  
  if(outputAmount.length != 0){
    await dbank_backend.withdraw(parseFloat(outputAmount));
    document.getElementById("withdrawal-amount").value = "";
    GetBalance();
  }

  await dbank_backend.compound();
  GetBalance();
  button.removeAttribute("disabled");
})