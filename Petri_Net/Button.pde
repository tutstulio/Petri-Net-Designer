public class Button
{
  PVector p;
  float L;
  color bg = color(0, 140, 0);
  color bgPress = color(0, 180, 0);
  color arrow = color(250);
  boolean mouseOn = false;

  Button(float x, float y, float l)
  {
    p = new PVector(x, y);
    L = l;
  }

  boolean mouseOn(float x, float y)
  {
    if ((x >= p.x) && (x <= p.x + L) && (y >= p.y) && (y <= p.y + L))
      return true;

    return false;
  }

  void display()
  {
    if (mouseOn(mouseX, mouseY))
      fill(bgPress);
    else
      fill(bg);

    noStroke();
    rect(p.x, p.y, L, L);
  }
}

/*class UpArrow extends Button
{

  UpArrow(float x, float y, float l)
  {
    super(x, y, l);
  }

  void display()
  {
    noStroke();

    if (mouseOn(mouseX, mouseY))
      fill(bgPress);
    else
      fill(bg);

    rect(p.x, p.y, L, L);

    fill(arrow);
    beginShape();
    vertex(p.x-L/9, p.y+L/3);
    vertex(p.x+L/9, p.y+L/3);
    vertex(p.x+L/9, p.y-L/9);
    vertex(p.x+L/5, p.y-L/9);
    vertex(p.x, p.y-L/3);
    vertex(p.x-L/5, p.y-L/9);
    vertex(p.x-L/9, p.y-L/9);
    endShape();
  }
}*/
