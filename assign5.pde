Ball ball;
Bar board;
Brick[] bList;

//Game Status
final int GAME_START   = 0;
final int GAME_PLAYING = 1;
final int GAME_WIN     = 2;
final int GAME_LOSE    = 3;
int status;              //Game Status
int brickNum;

void setup() {
  
  status = GAME_START;
  
  bList = new Brick[50];
  
  size(680,480);
    
  ball = new Ball(10,5,3);
  board = new Bar(100);
  ball.life = 3;
  reset();
}

void draw() {
  
  background(50, 50, 50);
  noStroke();
  
  
  switch(status) {
   
   case GAME_START:
     printText("PONG", "Press ENTER to Start", 60, 20, 240);
     reset();
     break;
     
   case GAME_PLAYING:
     background(50, 50, 50);
     
     
     board.display();
     drawBrick();
     drawBall();
     board.move();
     drawLife();
     checkBrickHit();
     checkBallDrop();
     
     break;
     
   case GAME_WIN:
     printText("WINNER", "Press ENTER to Continue", 40, 20, 240);
     break;
     
   case GAME_LOSE:
     printText("YOU LOSE", "Pressd ENTER to Restart", 40, 20, 240);
     break;
  }
}

void keyPressed() {
  statusCtrl();
}

void mousePressed() {
 if(mouseButton == RIGHT && ball.toss == false) {
  ball.toss = true;
  ball.move();
 } 
}

void mouseMoved() {
  if(ball.toss == false) {
   ball.x = board.x;
   ball.y = board.y - ball.size; 
  }
}

void brickMaker(int ox, int oy, int colSpacing, int rowSpacing, int num, int numInRow) {
  for (int i=0; i<num; i++) {
    int row = i / numInRow;
    int col = i % numInRow;
    
    int x = ox + (colSpacing*col);
    int y = oy + (rowSpacing*row);
    bList[i] = new Brick(x,y);
  }
}

void drawBrick() {
 for(int i=0; i<bList.length; i++) {
  Brick brick = bList[i];
  if(brick!=null && !brick.dis) {
    brick.display();
  }
 }
}

void drawBall() {
  if(ball.toss == true) {
   ball.move(); 
  }
  ball.display();
}

void drawLife() {
 fill(230,74,96);
 text("LIFE:",36,460);
 
 int space = 0;
 
 for(int i=0; i<ball.life; i++){
  space +=25;
  ellipse(50+space,455,15,15); 
 }
}


void checkWinLose() {
 if(status == GAME_PLAYING) {
   if(ball.life == 0) {
   status = GAME_LOSE; 
  }else if(brickNum == 0) {
    status = GAME_WIN;
  }
 }
}



void printText(String s1 , String s2 , float sizeMain , float sizeSub , float y) {
   textSize(sizeMain);
   textAlign(CENTER);
   fill(95, 194, 226);
   text(s1, width/2, y);
   textSize(sizeSub);
   text(s2, width/2, y+40);
}

void checkBrickHit() {
  for(int i=0; i<bList.length;i++) {
    Brick brick = bList[i];
    if(brick!=null && !brick.dis) {
      if(bList[i].bX - bList[i].bSize <= ball.x + ball.size && bList[i].bX + bList[i].bSize >= ball.x - ball.size && bList[i].bY - bList[i].bSize <= ball.y + ball.size && bList[i].bY + bList[i].bSize >= ball.y - ball.size) {
       ball.xSpeed *= -1;
       
       if(bList[i].bX - bList[i].bSize <= ball.x + ball.size && bList[i].bX + bList[i].bSize >= ball.x - ball.size && bList[i].bY - bList[i].bSize <= ball.y + ball.size && bList[i].bY + bList[i].bSize >= ball.y - ball.size) {
       ball.ySpeed *= -1;
       removeBrick(bList[i]);
       brickNum--;
       checkWinLose();
       brick.dis = true; 
       }
      }
    }
  }
}

void checkBallDrop() {
  if(ball.y > height - ball.size) {
   ball.life--;
   ball.toss = false;
   ball.x = board.x;
   ball.y = board.y - ball.size; 
   checkWinLose();
  }
}


void removeBrick(Brick obj) {
  obj.dis = true;
  obj.bX = 1000;
  obj.bY = 1000;  
}

void reset() {
 for(int i=0; i<bList.length-1; i++) {
  bList[i] = null;
 }
 
 ball.life = 3;
 brickNum = 50;
 ball.x = board.x;
 ball.y = board.y - ball.size;
 ball.toss =false;
 
 brickMaker(113, 50, 50, 50, 50, 10);
 
}


void statusCtrl() {
 if (key == ENTER) {
  switch(status) {
    
    case GAME_START:
      status = GAME_PLAYING;
      break;
      
    case GAME_WIN:
      status = GAME_START;
      break;
    
    case GAME_LOSE:
      status = GAME_START;
      break;
  }
 } 
}
