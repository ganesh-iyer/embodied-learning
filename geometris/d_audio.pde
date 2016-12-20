Minim minim;
AudioPlayer raghu_vamsa;
AudioPlayer groove;
AudioPlayer danger;
AudioPlayer tada;

AudioPlayer leahYay;
AudioPlayer leahWellDone;

void leahExclaim(){
  float a = random(0,1);
  if (a < 0.5){
    leahWellDone.rewind();
    leahWellDone.play();
  }

  else {
    leahYay.rewind();
    leahYay.play();
  }
}