class Stage {
  int wallSize;
  int wallNumX;
  int wallNumY;
  int wall[][];
  int addWallNum;
  int addWallX[];
  int addWallY[];
  int putEnemyNum;
  int maxDaifukuNum;
  boolean [][]checker;
  int checkNum;
  int result;
  int reCheckNum;
  Stage() {
    wallSize = 100;
    wallNumX = stageWidth/wallSize;
    wallNumY = stageHeight/wallSize;
    wall = new int [wallNumX][wallNumY];
    addWallNum = 10;
    addWallX = new int [addWallNum];
    addWallY = new int [addWallNum];
    for (int i=0; i<addWallNum; i++) {
      addWallX[i] = -1;
      addWallY[i] = -1;
    }
    putEnemyNum = 0;
    checker = new boolean [wallNumX][wallNumY];
    for (int i=0; i<wallNumX; i++) {
      for (int j=0; j<wallNumY; j++) {
        checker[i][j] = false;
      }
    }
    checkNum = (wallNumX-1)*(wallNumY-1)-(wallNumX-2)*(wallNumY-2)/4-addWallNum;
    reCheckNum = 0;
    addDaifuku();
    createWall();
    maxDaifukuNum = daifuku.size()-addWallNum*2;
    //println(maxDaifukuNum*100);
  }
  void display() {

    background(0);
    for (int i=0; i<daifuku.size (); i++) {
      daifuku.get(i).display();
    }

    rectMode(CENTER);
    for (int i=0; i<wallNumX; i++) {
      for (int j=0; j<wallNumY; j++) {
        stroke(155+100*sin(radians(pacpac.moveCount*2)));
        strokeWeight(1);
        if (wall[i][j]==1) {

          for (int k=0; k<10; k++) {
            fill(255*(k+1)/10);
            rect(i*wallSize, j*wallSize, wallSize*(10-k)/10, wallSize*(10-k)/10);
          }
        }
      }
    }

    for (int i=0; i<wallNumX+1; i++) {
      for (int k=0; k<10; k++) {
        fill(255*(k+1)/10);
        rect(i*wallSize, 0, wallSize*(10-k)/10, wallSize*(10-k)/10);
        rect(i*wallSize, wallSize*wallNumY, wallSize*(10-k)/10, wallSize*(10-k)/10);
      }
    }
    for (int i=0; i<wallNumY+1; i++) {
      for (int k=0; k<10; k++) {
        fill(255*(k+1)/10);
        rect(0, i*wallSize, wallSize*(10-k)/10, wallSize*(10-k)/10);
        rect(wallSize*wallNumX, i*wallSize, wallSize*(10-k)/10, wallSize*(10-k)/10);
      }
    }
  }
  void addDaifuku() {
    for (int i=1; i<wallNumX; i++) {
      for (int j=1; j<wallNumY; j++) {
        if (i%2==1&&j%2==1&&!(i==1&&j==1)) {
          daifuku.add(new Daifuku(i*wallSize, j*wallSize));
          if (i<wallNumX-1) {
            daifuku.add(new Daifuku(i*wallSize+wallSize*2/3, j*wallSize));
            daifuku.add(new Daifuku(i*wallSize+wallSize*4/3, j*wallSize));
          }
          if (j<wallNumY-1) {
            daifuku.add(new Daifuku(i*wallSize, j*wallSize+wallSize*2/3));
            daifuku.add(new Daifuku(i*wallSize, j*wallSize+wallSize*4/3));
          }
        }
      }
    }
  }
  void createWall() {

    for (int i=1; i<wallNumX; i++) {
      for (int j=1; j<wallNumY; j++) {
        if (i%2==0&&j%2==0) {
          wall[i][j] = 1;
        }
      }
    }

    for (int i=0; i<addWallNum; i++) {
      boolean overlap = true;
      boolean outPoint = true;
      while (overlap||outPoint) {
        addWallX[i] = int(random(2, wallNumX-1));
        addWallY[i] = int(random(2, wallNumY-1));
        if (wall[addWallX[i]][addWallY[i]]==0) {
          overlap = false;
        } else {
          overlap = true;
        }
        if ((addWallX[i]+addWallY[i])%2==0) {
          outPoint = true;
        } else {
          outPoint = false;
        }
      }
      wall[addWallX[i]][addWallY[i]] = 1;
    }

    result = 0;
    wallCheck(1, 1);
    if (result!=checkNum) {
      reCheckNum++;
      //println(reCheckNum);
      resetWall();
      createWall();
    }
  }

  void wallCheck(int x, int y) {
    //閉所避け

    checker[x][y]=true;
    result++;

    if (x<wallNumX-1) {
      if (!checker[x+1][y]&&wall[x+1][y]==0) {
        wallCheck(x+1, y);
      }
    }
    if (x>1) {
      if (!checker[x-1][y]&&wall[x-1][y]==0) {
        wallCheck(x-1, y);
      }
    }
    if (y<wallNumY-1) {
      if (!checker[x][y+1]&&wall[x][y+1]==0) {
        wallCheck(x, y+1);
      }
    }
    if (y>1) {
      if (!checker[x][y-1]&&wall[x][y-1]==0) {
        wallCheck(x, y-1);
      }
    }
  }
  void resetWall() {
    for (int i=0; i<wallNumX; i++) {
      for (int j=0; j<wallNumY; j++) {
        wall[i][j] = 0;
        checker[i][j] = false;
      }
    }
  }
  void addEnemy() {
    putEnemyNum = stageNum;
    for (int i=0; i<putEnemyNum; i++) {
      boolean canSet = false;
      int putX = 0;
      int putY = 0;
      while (!canSet) {
        putX = int(random(1, wallNumX/2))*2-1;
        putY = int(random(1, wallNumY/2))*2-1;
        if (wall[putX][putY]==0&&!(putX<4&&putY<4)) {
          canSet = true;
        }
      }
      enemy.add(new Enemy(putX*wallSize, putY*wallSize));
    }
  }
  void reset() {
    int daifukuNum = daifuku.size();
    for (int i=0; i<daifukuNum; i++) {
      daifuku.remove(0);
    }
    addDaifuku();
    resetWall();
    createWall();
    int enemyNum = enemy.size();
    for (int i=0; i<enemyNum; i++) {
      enemy.remove(0);
    }
    addEnemy();
  }
  void nextStage() {
    this.reset();
    pacpac.newStage();
  }
}

