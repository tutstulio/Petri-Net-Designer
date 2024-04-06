class Transition
{
  Position[] pre_sets, post_sets;
  PVector p;
  boolean trig;

  Transition(float x, float y)
  {
    this.p = new PVector(x, y);
    this.trig = false;
    this.pre_sets = new Position[0];
    this.post_sets = new Position[0];
  }

  public void display()
  {
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(p.x, p.y, 10, 50);
  }

  public void trigger()
  {
    trig = true;
  }

  public void set_position(float x, float y)
  {
    p.x = x;
    p.y = y;
  }
}
