class Transition
{
  ArrayList<Position> pre_sets, post_sets;
  ArrayList<Arch> arches;
  PVector p;
  boolean trig;
  float w, h;

  Transition(float x, float y)
  {
    this.pre_sets = new ArrayList<Position>();
    this.post_sets = new ArrayList<Position>();
    this.arches = new ArrayList<Arch>();
    this.p = new PVector(x, y);
    this.trig = false;
    w = 10;
    h = 50;
  }

  public void display(boolean contour)
  {
    if (contour) stroke(0, 255, 0);
    else noStroke();
    fill(255);
    rectMode(CENTER);
    rect(p.x, p.y, w, h);
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
  
  boolean mouseOn(float x, float y)
  {
    if ((x <= p.x + w/2) && (x >= p.x - w/2) && (y <= p.y + h/2) && (y >= p.y - h/2))
      return true;

    return false;
  }
}
