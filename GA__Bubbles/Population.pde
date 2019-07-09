public class Population {
  Bubble[] pop;
  float totalFit;
  int genNum = 0;
  int countReachedGoal = 0;
  
  Population(int size, int numDirections) {
    pop = new Bubble[size];
    
    for (int i = 0; i < size; i++) {
      pop[i] = new Bubble(numDirections);
    }
  }
  
  //***********************************************************
  
  public void show() {
    for (int i = 0; i < pop.length; i++) {
      pop[i].show();
      pop[i].move();
    }
    
    if (allDead()) {
      println("Generation: " + genNum + "\n\tavg fit: " + (totalFit / pop.length) + "\n\tnumber reaching goal: " + countReachedGoal() + "\n");
      nextGen();
    }
  }
  
  public void calcAllFit() {
    totalFit = 0;
    
    for (int i = 0; i < pop.length; i++) {
      totalFit += pop[i].calcFitness(); // updates value of fitness variable too
    }
  }
  
  public int selectParent() {
    float rand = random(totalFit);
    float runningSum = 0;
    
    for (int i = 0; i < pop.length; i++) {
      runningSum += pop[i].fitness;
      
      if (runningSum > rand) {
        return i;
      }
    }
    
    println(runningSum);
    return pop.length - 1; // SHOULD NOT EVER BE REACHED
  }
  
  public PVector[] reproduce(int parentA, int parentB) {
    int direcsSize = pop[parentA].brain.directions.length;
    PVector[] directions = new PVector[direcsSize];
    for (int i = 0; i < direcsSize; i++) {
      directions[i] = pop[(i > direcsSize / 2)? parentA: parentB].brain.directions[i].copy();
    }
    
    return directions;
  }
  
  public void nextGen() {
    calcAllFit();
    Bubble[] nextPop = new Bubble[pop.length];
    
    for (int i = 0; i < pop.length; i++) {
      nextPop[i] = new Bubble(reproduce(selectParent(), selectParent()));
    }
    
    pop = nextPop;
    mutateAll();
    
    genNum++;
  }
  
  public void mutateAll() {
    for (int i = 0; i < pop.length; i++) {
      pop[i].mutate();
    }
  }
  
  public boolean allDead() {
    for (int i = 0; i < pop.length; i++) {
      if (!pop[i].dead && !pop[i].reachedGoal)
        return false;
    }
    
    return true;
  }
  
  public int countReachedGoal() {
    countReachedGoal = 0;
    
    for (int i = 0; i < pop.length; i++) {
      if (pop[i].reachedGoal) {
        countReachedGoal++;
      }
    }
    
    return countReachedGoal;
  }
}
