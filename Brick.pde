class Brick {
 
 int bSize = 30;
 int bX;
 int bY;
 boolean dis = false;

 Brick(int x,int y) {
  bX = x;
  bY = y;
 }
 
 void display() {
   fill(255,255,255);
   rectMode(CENTER);
   rect(bX,bY,bSize,bSize);   
 }
 
 
}
