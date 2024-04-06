class Arch
{
  PVector start, end;
  int weight;
  
  Arch(float x0, float y0, float x1, float y1, int w)
  {
    this.start = new PVector(x0, y0);
    this.end = new PVector(x1, y1);
    this.weight = w;
  }
  
  public void display()
  {
    stroke(0, 255, 0);
    strokeWeight(2);
    line(start.x, start.y, end.x, end.y);
    //arrow();
    //show_weight();
  }
}
