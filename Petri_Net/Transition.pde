class Transition
{
  Position[] pre_sets, post_sets;
  PVector p;
  boolean trig;

  Transition(int x, int y)
  {
    this.p = new PVector(x, y);
    this.trig = false;
    this.pre_sets = new Position[0];
    this.post_sets = new Position[0];
  }

  public void display()
  {
    fill(255);
    rectMode(CENTER);
    rect(p.x, p.y, 10, 50);
  }

  public void trigger()
  {
    trig = true;
  }

  public void set_position(int x, int y)
  {
    p.x = x;
    p.y = y;
  }
}
