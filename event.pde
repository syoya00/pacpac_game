void keyTyped() {
  if (phase==0) {
    if (key=='s') {
      pacpac.nextDir = 1;
      phase++;
    } else if (key=='d') {
      pacpac.nextDir = 3;
      phase++;
    }
  } else if (phase==1) {
    if (key=='w') {
      if (pacpac.posY>stage.wallSize) {
        pacpac.nextDir = 0;
      }
    }
    if (key=='s') {
      if (pacpac.posY<stageHeight-stage.wallSize) {
        pacpac.nextDir = 1;
      }
    }
    if (key=='a') {
      if (pacpac.posX>stage.wallSize) {
        pacpac.nextDir = 2;
      }
    }
    if (key=='d') {
      if (pacpac.posX<stageWidth-stage.wallSize) {
        pacpac.nextDir = 3;
      }
    }
    if (key=='r') {
      stage.reCheckNum = 0;
      phaseCount = 0;
      stageNum = 1;
      pacpac.point = 0;
      reset();
    }
    if (phaseCount>200) {
      stage.reCheckNum = 0;
      phaseCount = 0;
      reset();
    }
  } else if (phase==2) {
    phase=0;
    stageNum++;
    stage.nextStage();
  }
}

