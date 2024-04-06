class Position
{
  Transition[] pre_sets, post_sets;
  PVector p;
  int marks, radius = 50;
  
  Position(float x, float y, int m)
  {
    this.p = new PVector(x, y);
    this.marks = m;
    this.pre_sets = new Transition[0];
    this.post_sets = new Transition[0];
  }
  
  public void display()
  {
    noStroke();
    fill(150, 0, 0);
    //ellipseMode(CENTER); -> default
    circle(p.x, p.y, radius);
  }
  
  public void set_marks(int m)
  {
    marks = m;
  }
  
  public void set_position(float x, float y)
  {
    p.x = x;
    p.y = y;
  }
  
  boolean mouseOn(float x, float y)
  {
    float r = sqrt(pow(p.x - x, 2) + pow(p.y - y, 2));  // distance between points
    if (r <= radius)
      return true;

    return false;
  }
}
