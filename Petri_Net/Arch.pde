class Arch
{
  PVector start, end;
  int weight, posID, transID;
  float archLength, archAngle;

  Arch(float x0, float y0, float x1, float y1, int w)
  {
    this.start = new PVector(x0, y0);
    this.end = new PVector(x1, y1);
    this.weight = w;
    this.archLength = sqrt(sq(this.end.x - this.start.x) + sq(this.end.y - this.start.y));
    this.archAngle = atan((this.end.y - this.start.y) / (this.end.x - this.start.x));
  }

  public void display (boolean contour)
  {
    if (contour)
    {
      stroke(0, 255, 0);
      fill(0, 255, 0);
    } else
    {
      stroke(255);
      fill(0, 175, 255);
    }
    strokeWeight(2);
    line(start.x, start.y, end.x, end.y);
    showArrow();
    showWeight();
  }
  
  private void showWeight ()
  {
    float weightOffset = 0.4 * archLength;
    textAlign(CENTER, BOTTOM);
    textSize(22);
    if (end.x - start.x >= 0)
      text(str(weight), start.x + weightOffset*cos(archAngle), start.y + weightOffset*sin(archAngle));
    else
      text(str(weight), start.x - weightOffset*cos(archAngle), start.y - weightOffset*sin(archAngle));
  }
  
  private void showArrow ()
  {
    float arrowLength, arrowAngle, arrowOffset, theta;
    if (archLength <= 150) arrowOffset = 0.5 * archLength;
    else arrowOffset = 0.625 * archLength;
    arrowLength = 18;
    arrowAngle = radians(15);
    theta = atan((arrowLength*tan(arrowAngle)) / arrowOffset);
    strokeWeight(1);
    if (end.x - start.x >= 0)
    {
      beginShape(TRIANGLES);
      vertex(start.x + arrowOffset*cos(archAngle+theta), start.y + arrowOffset*sin(archAngle+theta));
      vertex(start.x + arrowOffset*cos(archAngle-theta), start.y + arrowOffset*sin(archAngle-theta));
      vertex(start.x + (arrowOffset+arrowLength)*cos(archAngle), start.y + (arrowOffset+arrowLength)*sin(archAngle));
      endShape();
    } else
    {
      beginShape(TRIANGLES);
      vertex(start.x - arrowOffset*cos(archAngle+theta), start.y - arrowOffset*sin(archAngle+theta));
      vertex(start.x - arrowOffset*cos(archAngle-theta), start.y - arrowOffset*sin(archAngle-theta));
      vertex(start.x - (arrowOffset+arrowLength)*cos(archAngle), start.y - (arrowOffset+arrowLength)*sin(archAngle));
      endShape();
    }
  }

  /*public void set_position(float x, float y, int m)
  {
    p = new Position(x, y, m);
  }
  
  public void set_transition(float x, float y)
  {
    t = new Transition(x, y);
  }*/

  public void set_weight(int w)
  {
    weight = w;
  }

  boolean mouseOn(float x, float y)
  {
    float y_dot = (end.y - start.y) / (end.x - start.x);
    float y0 = end.y - end.x * y_dot;
    float d = abs(y_dot * x - y + y0) / sqrt(sq(y_dot) + 1);  // distance between mouse and line

    //float archLength = sqrt(sq(end.x - start.x) + sq(end.y - start.y));
    float startRadius = sqrt(sq(start.x - x) + sq(start.y - y));
    float endRadius = sqrt(sq(end.x - x) + sq(end.y - y));

    if (d <= 5 && startRadius < archLength && endRadius < archLength)
      return true;

    return false;
  }
}
