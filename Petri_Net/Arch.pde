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

  public void display (boolean contour)
  {
    if (contour) stroke(0, 255, 0);
    else stroke(255);
    strokeWeight(2);
    line(start.x, start.y, end.x, end.y);
    //arrow();
    //show_weight();
  }
  
  boolean mouseOn(float x, float y)
  {
    float y_dot = (end.y - start.y) / (end.x - start.x);
    float y0 = end.y - end.x * y_dot;
    float d = abs(y_dot * x - y + y0) / sqrt(sq(y_dot) + 1);  // distance between mouse and line
    
    float archLength = sqrt(sq(end.x - start.x) + sq(end.y - start.y));
    float startRadius = sqrt(sq(start.x - x) + sq(start.y - y));
    float endRadius = sqrt(sq(end.x - x) + sq(end.y - y));
    
    if (d <= 5 && startRadius < archLength && endRadius < archLength)
      return true;

    return false;
  }
}
