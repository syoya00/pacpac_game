class Daifuku {
  int posX;
  int posY;
  Daifuku(int x, int y) {
    posX = x;
    posY = y;
  }
  void display() {
    noStroke();
    fill(255);
    ellipse(posX, posY, stage.wallSize/5, stage.wallSize/5);
  }
}

