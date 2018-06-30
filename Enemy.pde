class Enemy {
  int posX;
  int posY;
  int dia;
  int moveDir;
  int speed;
  int nextDir;
  int life;
  int moveCount;
  color enemyColor;
  Enemy(int x, int y) {
    posX = x;
    posY = y;
    dia = stage.wallSize*5/6;
    moveDir = 0;
    speed = 2;
    nextDir = 0;
    life = 1;
    moveCount = 0;
    enemyColor = color(random(255), random(255), random(255));
  }
  void display() {
    noStroke();
    fill(enemyColor);
    ellipse(posX, posY, dia, dia);
    pushMatrix();
    translate(posX, posY);
    noStroke();
    fill(255);
    arc(-dia/5, 0, dia/4, dia/4, 0, PI+QUARTER_PI, CHORD);
    arc(dia/5, 0, dia/4, dia/4, -QUARTER_PI, PI, CHORD);
    fill(0);
    arc(-dia/5, 0, dia/6, dia/6, 0, PI+QUARTER_PI, CHORD);
    arc(dia/5, 0, dia/6, dia/6, -QUARTER_PI, PI, CHORD);
    popMatrix();
  }
  void move() {

    if (posX%(stage.wallSize*2)==stage.wallSize&&posY%(stage.wallSize*2)==stage.wallSize) {
      nextDir = int(random(0, 4));
      moveDir = nextDir;
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
    hit();
    moveCount++;
  }
  boolean hitWall(int d) {
    if (d==0) {
      for (int i=0; i<stage.addWallNum; i++) {
        if (posX==stage.addWallX[i]*stage.wallSize&&posY==(stage.addWallY[i]+1)*stage.wallSize) {
          moveDir = 1;
          return true;
        }
      }
    } else if (d==1) {
      for (int i=0; i<stage.addWallNum; i++) {
        if (posX==stage.addWallX[i]*stage.wallSize&&posY==(stage.addWallY[i]-1)*stage.wallSize) {
          moveDir = 0;
          return true;
        }
      }
    } else if (d==2) {
      for (int i=0; i<stage.addWallNum; i++) {
        if (posX==(stage.addWallX[i]+1)*stage.wallSize&&posY==stage.addWallY[i]*stage.wallSize) {
          moveDir = 3;
          return true;
        }
      }
    } else if (d==3) {
      for (int i=0; i<stage.addWallNum; i++) {
        if (posX==(stage.addWallX[i]-1)*stage.wallSize&&posY==stage.addWallY[i]*stage.wallSize) {
          moveDir = 2;
          return true;
        }
      }
    }
    return false;
  }
  void hit() {
    if (dist(posX, posY, pacpac.posX, pacpac.posY)<dia/2+pacpac.dia/2) {
      pacpac.life = 0;
    }
  }
}

