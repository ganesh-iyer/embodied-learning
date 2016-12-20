// THIS IS IT!

Arduino arduino;

int[] drawInputsForPractice(){
  int[] inputs = {1 ,0, 0, 0, 0, 0, 0, 0, 0};
  for (int i = 1; i < 9; i++){
    if (arduino.digitalRead(i+4) == Arduino.HIGH){
      inputs[i] = 1;
    }
    else {
      inputs[i] = 0;
    }
  }
  return inputs;
}
int[] drawInputsForPlay(){
  int[] inputs = {0, 0, 0, 0, 0, 0, 0, 0, 0}; // 9 element array
  for (int i = 0; i < 8; i++){
    if (arduino.digitalRead(i+5) == Arduino.HIGH){
      inputs[i] = 1;
    }
    else {
      inputs[i] = 0;
    }
  }
  return inputs;
}