//sound
import ddf.minim.*;
Minim minim;
AudioSnippet sound;

Stage stage;
Pacpac pacpac;
ArrayList <Daifuku> daifuku = new ArrayList <Daifuku> ();
ArrayList <Enemy> enemy = new ArrayList <Enemy> ();

int phase;
int phaseCount;

int stageWidth;
int stageHeight;

int stageNum;

void setup() {

  minim = new Minim(this);
  size(1200, 900);

  sound = minim.loadSnippet("eat.mp3");

  stageWidth = width;
  stageHeight = height-100;
  stageNum = 1;
  stage = new Stage();
  pacpac = new Pacpac();
  stage.addEnemy();
  println("ver_0_1_0");
  phase = 0;
  phaseCount = 0;

  frameRate(60);
}

void draw() {
  if (phase==0) {
    pushMatrix();
    translate(0, 100);
    stage.display();
    pacpac.display();
    for (int i=0; i<enemy.size (); i++) {
      enemy.get(i).display();
    }
    popMatrix();
    status();

    fill(255);
    strokeWeight(5);
    stroke(255, 0, 0);
    rectMode(CENTER);
    rect(width/2, height/2, width/3, height/8);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(30);
    text("go right or down", width/2, height/2);
  } else if (phase==1) {
    pushMatrix();
    translate(0, 100);
    stage.display();
    pacpac.display();
    for (int i=0; i<enemy.size (); i++) {
      enemy.get(i).display();
    }
    if (phaseCount<200) {
      pacpac.move();
      for (int i=0; i<enemy.size (); i++) {
        enemy.get(i).move();
      }
    }
    popMatrix();
    status();

    if (pacpac.life<1) {
      phaseCount++;
    }
    if (phaseCount>200) {

      fill(255);
      strokeWeight(5);
      stroke(255, 0, 0);
      rectMode(CENTER);
      rect(width/2, height/2, width/3, height/8);
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(30);
      text("push any key and restart", width/2, height/2);
    }
  } else if (phase==2) {
    pushMatrix();
    translate(0, 100);
    stage.display();
    pacpac.display();
    for (int i=0; i<enemy.size (); i++) {
      enemy.get(i).display();
    }
    popMatrix();
    status();

    fill(255);
    strokeWeight(5);
    stroke(255, 0, 0);
    rectMode(CENTER);
    rect(width/2, height/2, width/2, height/8);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("stage clear! go to next stage", width/2, height/2);
  }
}

void reset() {
  phase = 0;
  pacpac.reset();
  stage.reset();
}

void stop() {
  sound.close();
  minim.stop();
  super.stop();
}

