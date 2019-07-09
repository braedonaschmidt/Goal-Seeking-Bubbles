public class Bubble {
  PVector loc = new PVector(width / 2, height - 10);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  
  Brain brain;
  
  float fitness = 0;
  boolean dead = false;
  boolean reachedGoal = false;
  
  Bubble(int numDirections) {
    brain = new Brain(numDirections);
  }
  
  Bubble(PVector[] directions) {
    brain = new Brain(directions);
  }
  
  //*****************************************************************
  
  public void show() {
    fill(255);
    circle(loc.x, loc.y, 12);
  }
  
  public void move() {
    if (shouldStop()) {
      vel.set(0, 0);
      acc.set(0, 0);
    }
    else if (brain.curr < brain.directions.length) {
      acc = brain.directions[brain.curr];
      
      brain.curr++;
    }
    else {
      dead = true;
    }
    vel.add(acc);
    vel.limit(10);
    loc.add(vel);
  }
  
  public boolean shouldStop() {
    if (loc.x <= 5 || // hit a wall
          loc.x >= width - 5 ||
          loc.y <= 5 ||
          loc.y >= height - 5) {
      dead = true;
      return true;
    }
    else if (dist(loc.x, loc.y, target.loc.x, target.loc.y) < 5) { // reached target
      reachedGoal = true;
      return true;
    }
    return false;
  }
  
  public float calcFitness() {
    float distanceToGoal = dist(loc.x, loc.y, target.loc.x, target.loc.y);
    fitness = 1.0 / (distanceToGoal * distanceToGoal);
    return fitness;
  }
  
  public void mutate() {
    final float MUTATION_RATE = 0.01;
    
    for (int i = 0; i < brain.directions.length; i++) {
      float rand = random(1);
      
      if (rand < MUTATION_RATE) {
        brain.directions[i] = PVector.fromAngle(random(2*PI));
      }
    }
  }
}
