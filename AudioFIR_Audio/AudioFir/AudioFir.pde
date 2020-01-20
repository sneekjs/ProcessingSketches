import ddf.minim.*;
import processing.sound.*;

//sound
SoundFile sound;
Amplitude amp;
FFT fft;
AudioIn audioIn;
float freq;

int bands = 512;

int fileNumb = 0;

void setup() {
  sound = new SoundFile(this, "elvis.mp3");
  //sound = new SoundFile(this, "popularmonster.mp3");
  //sound = new SoundFile(this, "wiitheme.mp3");
  fullScreen();
  background(100);
  stroke(250, 0, 0);

  //create an amplitude object
  sound.play();
  sound.loop();
  amp = new Amplitude(this);
  amp.input(sound);
  
  fft = new FFT(this, bands);
  audioIn = new AudioIn(this, 0);
  audioIn.start();
  fft.input(sound);  
}

void draw() {
  background(0);
  float vol = amp.analyze();

  strokeCap(ROUND);
  strokeWeight(vol*500);
  point(width/2, height/2);

  float[] spectrum = fft.analyze();
  float fillerSpace= width / bands * 2 * 1.75;      //screen width / amount of bands * the opening on both sides * the part of all bands you want to see
  strokeCap(PROJECT);
  for ( int x = 0; x < bands; x++)
  {
    strokeWeight(fillerSpace);
    line(x * (fillerSpace), height, x * (fillerSpace), height - spectrum[x] * height * 5);
  }
}

void keyPressed()
{
  if(key == 'a') {
    fileNumb--;
  }else if (key == 'd') {
    fileNumb++;
  }else
  {
    return;
  }
  if(fileNumb > 4){
    fileNumb = 4;
  }else if (fileNumb < 0) {
    fileNumb = 0;
  }
  sound.stop();
  
  
  if(fileNumb==0)
  {
    sound = new SoundFile(this, "elvis.mp3");
  }else if(fileNumb == 1)
  {
    sound = new SoundFile(this, "demo.wav");
  }else if(fileNumb == 2)
  {
    sound = new SoundFile(this, "popularmonster.mp3");
  }else if(fileNumb == 3)
  {
    sound = new SoundFile(this, "wiitheme.mp3");
  }else if(fileNumb == 4)
  {
    sound = new SoundFile(this, "Pizza.mp3");
  }
  
  sound.play();
  sound.loop();
  amp = new Amplitude(this);
  amp.input(sound);
  fft = new FFT(this, bands);
  audioIn = new AudioIn(this, 0);
  audioIn.start();
  fft.input(sound);  
}
