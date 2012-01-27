import processing.serial.*;

import com.neophob.lpd6803.misc.*;
import com.neophob.lpd6803.*;

private static final int NR_OF_PIXELS = 20;

Lpd6803 lpd6803;
boolean initialized;
int buffer[];

void setup() {
  try {
    lpd6803 = new Lpd6803(this, NR_OF_PIXELS);          
    this.initialized = lpd6803.ping();
    println("ping result: "+ this.initialized);
  } 
  catch (NoSerialPortFoundException e) {
    println("failed to initialize serial port!");
  }

  if (!initialized) {
    throw new IllegalStateException("no serial device found");
  }  

  buffer = new int[NR_OF_PIXELS];
  println("init done");

  framerate(10);
}


public void draw() { 

  //fill buffer with random garbage
  for (int i=0; i<NR_OF_PIXELS; i++) {
    buffer[i] = r.nextInt(0xffffff)|0x7F7F7F;
  }
  
  
  lpd6803.sendRgbFrame((byte)0, buffer, ColorFormat.RBG);

  frames++;
}

