Population pop;
Target target;

void setup() {
  size(1000, 800);
  
  pop = new Population(500, 200);
  target = new Target(15);
}

void draw() {
  background(0);
  target.show();
  
  pop.show();
}
