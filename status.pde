void status() {
  fill(0);
  noStroke();
  rectMode(CENTER);
  rect(width/2, 50, width, 100);
  textSize(30);
  textAlign(CENTER);
  fill(255);
  text("point : " + pacpac.point, width/2, 30);
  text("stage : " + stageNum, width/2, 70);
}

