public class Brain {
  int curr;
  PVector[] directions;
  
  Brain(int numDirections) {
    directions = new PVector[numDirections];
    randInit();
  }
  
  Brain(PVector[] direcs) {
    directions = direcs;
  }
  
  //*****************************************************************
  
  public void randInit() {
    for (int i = 0; i < directions.length; i++) {
      directions[i] = PVector.fromAngle(random(2*PI));
    }
  }
}
