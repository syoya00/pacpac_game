class Pacpac {
  int posX;
  int posY;
  int dia;
  int moveDir;
  int speed;
  int nextDir;
  int point;
  int life;
  int type;
  int moveCount;
  Pacpac() {
    posX = stage.wallSize;
    posY = stage.wallSize;
    dia = stage.wallSize*4/6;
    moveDir = 0;
    speed = 5;
    nextDir = 0;
    point = 0;
    life = 1;
    type = 0;
    moveCount = 0;
  }
  void display() {
    noStroke();
    if (life>0) {
      fill(255, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    ellipse(posX, posY, dia, dia);
    pushMatrix();
    translate(posX, posY);
    rectMode(CORNER);
    if (moveDir==0) {
      rotate(radians(-90));
    } else if (moveDir==1) {
      rotate(radians(90));
    } else if (moveDir==2) {
      rotate(radians(180));
    } else if (moveDir==3) {
    }
    pushMatrix();
    rotate(radians(sin(radians(moveCount*8))*30));
    rect(0, 0, dia*7/10, dia/8);
    popMatrix();
    pushMatrix();
    rotate(radians(-sin(radians(moveCount*8))*30));
    rect(0, 0, dia*7/10, dia/8);
    popMatrix();
    popMatrix();
  }
  void move() {
    if (life>0) {
      if (type==0) {
        if (posX%(stage.wallSize*2)==stage.wallSize&&posY%(stage.wallSize*2)==stage.wallSize) {
          moveDir = nextDir;
        }
        if ((moveDir==0&&nextDir==1)||(moveDir==1&&nextDir==0)||(moveDir==2&&nextDir==3)||(moveDir==3&&nextDir==2)) {
          moveDir = nextDir;
        }
      }

      if (moveDir==0) {
        if (posY>stage.wallSize&&!hitWall(0)) {
          posY-=speed;
        }
      } else if (moveDir==1) {
        if (posY<stageHeight-stage.wallSize&&!hitWall(1)) {
          posY+=speed;
        }
      } else if (moveDir==2) {
        if (posX>stage.wallSize&&!hitWall(2)) {
          posX-=speed;
        }
      } else if (moveDir==3) {
        if (posX<stageWidth-stage.wallSize&&!hitWall(3)) {
          posX+=speed;
        }
      }
      eat();
      moveCount++;
    }
  }
  boolean hitWall(int d) {
    if (d==0) {
      for (int i=0; i<stage.addWallNum; i++) {
        if (posX==stage.addWallX[i]*stage.wallSize&&posY==(stage.addWallY[i]+1)*stage.wallSize) {
          return true;
        }
      }
    } else if (d==1) {
      for (int i=0; i<stage.addWallNum; i++) {
        if (posX==stage.addWallX[i]*stage.wallSize&&posY==(stage.addWallY[i]-1)*stage.wallSize) {
          return true;
        }
      }
    } else if (d==2) {
      for (int i=0; i<stage.addWallNum; i++) {
        if (posX==(stage.addWallX[i]+1)*stage.wallSize&&posY==stage.addWallY[i]*stage.wallSize) {
          return true;
        }
      }
    } else if (d==3) {
      for (int i=0; i<stage.addWallNum; i++) {
        if (posX==(stage.addWallX[i]-1)*stage.wallSize&&posY==stage.addWallY[i]*stage.wallSize) {
          return true;
        }
      }
    }
    return false;
  }
  void eat() {
    int ate = -1;
    for (int i=0; i<daifuku.size (); i++) {
      if (dist(posX, posY, daifuku.get(i).posX, daifuku.get(i).posY)<stage.wallSize*3/8) {
        point+=100;
        ate = i;
      }
    }
    if (ate!=-1) {
      sound.play();
      sound.rewind();
      daifuku.remove(ate);
    }
    if (point/(stage.maxDaifukuNum*100)==stageNum&&phase==1) {
      phase++;
    }
  }
  void reset() {
    posX = stage.wallSize;
    posY = stage.wallSize;
    moveDir = 0;
    nextDir = 0;
    point = 0;
    life = 1;
    point = (stageNum-1)*stage.maxDaifukuNum*100;
    moveCount = 0;
  }
  void newStage() {
    posX = stage.wallSize;
    posY = stage.wallSize;
    moveDir = 0;
    nextDir = 0;
    life = 1;
    moveCount = 0;
  }
}

