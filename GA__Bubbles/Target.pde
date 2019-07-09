public class Target {
  int radius;
  PVector loc;
  
  Target(int rad) {
    radius = rad;
    loc = new PVector(width / 2, 25);
  }
  
  //*********************************************************
  
  public void show() {
    fill(0, 255, 0);
    circle(loc.x, loc.y, radius);
  }
}
