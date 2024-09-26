class Position
{
  //Transition[] pre_sets, post_sets;
  PVector p;
  int marks, radius;
  
  Position(float x, float y, int m)
  {
    this.p = new PVector(x, y);
    this.marks = m;
    this.radius = 25;
    //this.pre_sets = new Transition[0];
    //this.post_sets = new Transition[0];
  }
  
  public void display(boolean contour)
  {
    if (contour) stroke(0, 255, 0);
    else noStroke();
    fill(150, 0, 0);
    ellipseMode(CENTER); // default
    circle(p.x, p.y, 2*radius);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(40);
    text(str(marks), p.x, p.y);
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
    float r = sqrt(sq(p.x - x) + sq(p.y - y));  // distance between points
    if (r <= radius)
      return true;

    return false;
  }
}
