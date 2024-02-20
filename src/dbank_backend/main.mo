import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank{
  //var is used to create variables
  stable var currentValue:Float = 300;
  // currentValue := 500;
  var name = "Gagan"; 

  //let is used to create a constant
  let id = 2133245241234;

  // showing time in motoko (time elapsed in ns since 1-1-1970)
  stable var startTime = Time.now();
  // startTime := Time.now();
  Debug.print(debug_show(startTime));

  Debug.print(name);
  Debug.print(debug_show(currentValue));
  Debug.print(debug_show(id));

  func topUp() {
    currentValue += 1;
    Debug.print(debug_show(currentValue));
  };
  //this is private function

  topUp();
 
  public func topUp2(value: Float) {
    currentValue += value;
    Debug.print(debug_show(currentValue));
  };
  //this is a public function and can be accessed even while deploying

  public func withdraw(value: Float) {
    let tempValue: Float = currentValue - value;
    if (tempValue >= 0){
      currentValue -= value;
      Debug.print(debug_show(currentValue));
    }else{
      Debug.print("Insufficient Funds!!");
    }
  };

  public query func SeeCurrentValue(): async Float {
    return currentValue;
  };


  public func compound() {
    let currentTime = Time.now();
    let timeElapsed_ns = currentTime - startTime;
    let timeElapsed_s = timeElapsed_ns / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsed_s));
    startTime := currentTime;
  }
}