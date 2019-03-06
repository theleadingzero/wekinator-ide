/**
 * Adapted by Becky Stewart from oscP5message by andreas schlegel
 * example shows how to create osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

PFont f;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(500, 400);

  f = createFont("Courier", 16);
  textFont(f);
  textAlign(CENTER, CENTER);

  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
}


void draw() {
  background(0);

  fill(255);

  text("Click in this window to send an OSC message.", width/2, height/2);
}

void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/my-message");

  myMessage.add("some text"); /* add a string to the osc message */
  myMessage.add(123); /* add an int to the osc message */
  myMessage.add(12.34); /* add a float to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  if (theOscMessage.checkTypetag("sif")) {
    /* parse theOscMessage and extract the values from the osc message arguments. */
    String oscValue = theOscMessage.get(0).stringValue();  
    println(" value: "+oscValue);
  }
}
