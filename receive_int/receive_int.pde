/**
* REALLY simple processing sketch that displays value received from wekinator
*
* By Becky Stewart 2019.
**/

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

float oscValue = -1;

PFont f;

void setup() {
  f = createFont("Courier", 64);
  textFont(f);
  textAlign(CENTER, CENTER);

  size(400, 400, P2D);
  noStroke();
  smooth();
  
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);
  
}

void draw() {
  background(0, 50, 50);
  fill(255);
  
  text(oscValue, width/2, height/2);
}

void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  
  if(theOscMessage.checkAddrPattern("/wek/outputs")==true) {
    /* check if the typetag is the right one. */
    if(theOscMessage.checkTypetag("f")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      oscValue = theOscMessage.get(0).floatValue();  
      print("### received an osc message /test with typetag f.");
      println(" value: "+oscValue);
      return;
    }  
  } 
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}
