class Position
{
  Transition[] pre_sets, post_sets;
  PVector p;
  int marks;
  
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
    circle(p.x, p.y, 50);
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
}
