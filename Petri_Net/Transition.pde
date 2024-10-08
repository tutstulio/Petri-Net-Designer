class Transition
{
  ArrayList<Position> pre_set, post_set;
  int[] pre_weights, post_weights;
  PVector o;
  boolean trig;
  float w, h;

  Transition(float x, float y)
  {
    this.pre_set = new ArrayList<Position>();
    this.post_set = new ArrayList<Position>();
    this.o = new PVector(x, y);
    this.trig = false;
    w = 10;
    h = 50;
  }

  public void display(boolean contour)
  {
    if (contour) stroke(0, 255, 0);
    else noStroke();
    strokeWeight(2);
    fill(255);
    rectMode(CENTER);
    rect(o.x, o.y, w, h);
  }

  public void trigger()
  {
    trig = true;
  }
  
  boolean mouseOn(float x, float y)
  {
    if ((x <= o.x + w/2) && (x >= o.x - w/2) && (y <= o.y + h/2) && (y >= o.y - h/2))
      return true;

    return false;
  }
}
