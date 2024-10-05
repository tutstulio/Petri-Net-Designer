class Position
{
  PVector o;
  int marks, radius;
  
  Position(float x, float y, int m)
  {
    this.o = new PVector(x, y);
    this.marks = m;
    this.radius = 25;
  }
  
  public void display(boolean contour)
  {
    if (contour) stroke(0, 255, 0);
    else noStroke();
    fill(150, 0, 0);
    ellipseMode(CENTER); // default
    circle(o.x, o.y, 2*radius);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(40);
    text(str(marks), o.x, o.y);
  }
  
  public void set_marks(int m)
  {
    marks = m;
  }
  
  public void set_position(float x, float y)
  {
    o.x = x;
    o.y = y;
  }
  
  boolean mouseOn(float x, float y)
  {
    float r = sqrt(sq(o.x - x) + sq(o.y - y));  // distance between points
    if (r <= radius)
      return true;

    return false;
  }
  
  /*@Override
  public boolean equals (Object obj)
  {
    if (this == obj) return true;
    if (obj == null || getClass() != obj.getClass()) return false;
    Position that = (Position) obj;
    return o.x == that.o.x && o.y == that.o.y && marks == that.marks;
  }*/
}
