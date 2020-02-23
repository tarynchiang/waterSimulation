//create a Particle class to represent each particle 
//in the particle class we need 
//import processing.opengl.*;

PImage photo;
PImage texture;
ArrayList<Droplet> droplets;

void setup() {
  size(700, 670,P3D);
  photo = loadImage("background.jpg");
  droplets = new ArrayList<Droplet>();
}

void draw() {
  image(photo, 0, 0);
  
  //emitter
  for(int j=0;j<100;j++){
     droplets.add(new Droplet());
  }
 
  
  //render all droplets in the list 
  for (int i = droplets.size()-1; i >= 0; i--) {
    Droplet p = (Droplet) droplets.get(i);
    p.Run();
    
    if (p.isDead()) {
      droplets.remove(i);
    }
  }
}




class Droplet{
  float xPos,yPos,zPos;
  float xVel,yVel,zVel;
  int rC,gC,bC;
  float lifespan;
  
  //Constructor
  Droplet(){
    //set thr droplet from some fixed point(x,y,z)
    xPos = width/2-15;
    yPos = height/2+10;
    zPos = 0;
    
    //set initial velocity 
    yVel = random(-80,-20);
    xVel = random(-30,30);
    zVel = random(-30,30);
    
    //set initial color
    rC = 166;
    gC = 250;
    bC = 255;
    
    lifespan = 255;
  }


  void Run(){
    Update();
    Display();
  }
  
  // updating position, velocity and color for each droplet
  void Update(){
    // if droplet bounce the floor, bounce back to the opposite direction
    if( yPos > 650){
      yVel *= -0.7;
    }
    
    // update the position using Eulerian integration with delta t = 0.1
    xPos = xPos + xVel * 0.1;
    zPos = zPos + zVel * 0.1;
    yPos = yPos + yVel * 0.1;
    
    // update the velocity by minusing gravity(going down is positive)
    yVel = yVel + 9.8*0.1;
    
    //update the color to become white
    rC += 1;
    gC += 1;

    lifespan -= 1.5;
  }
  
  // void Display() method 
  // draw a particle with stroke(), fill(), and ellipse()
  void Display(){
    noStroke();
    //lights();
    fill(rC,gC,255,lifespan);
    //pushMatrix();
    //translate(xPos,yPos,zPos);
    //sphere(1);
    //popMatrix();
    ellipse(xPos,yPos,2,2);
  }
  
  // boolean isDead() method 
  // determine when the particle is dead
  boolean isDead(){
    if(lifespan < 0){
      return true;
    }else{
      return false;
    }
  }
}
