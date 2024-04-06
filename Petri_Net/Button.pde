public class Button
{
  PVector pos; 
  float L;
  color bg = color(0, 140, 0);
  color arrow = color(250);
  color bgPress = color(0, 180, 0);
  boolean mouseOn = false;

  Button(float x, float y, float l)
  {
    pos = new PVector(x, y);
    L = l;
  }

  boolean mouseOn(int x, int y)
  {
    if (x >= pos.x - L/2 && x <= pos.x + L/2)
      if (y <= pos.y + L/2 && y >= pos.y - L/2)
        return true;

    return false;
  }
}

class UpArrow extends Button
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

    rect(pos.x, pos.y, L, L);

    fill(arrow);
    beginShape();
    vertex(pos.x-L/9, pos.y+L/3);
    vertex(pos.x+L/9, pos.y+L/3);
    vertex(pos.x+L/9, pos.y-L/9);
    vertex(pos.x+L/5, pos.y-L/9);
    vertex(pos.x, pos.y-L/3);
    vertex(pos.x-L/5, pos.y-L/9);
    vertex(pos.x-L/9, pos.y-L/9);
    endShape();
  }
}

class DownArrow extends Button
{

  DownArrow(float x, float y, float l)
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

    rect(pos.x, pos.y, L, L);

    fill(arrow);
    beginShape();
    vertex(pos.x-L/9, pos.y-L/3);
    vertex(pos.x+L/9, pos.y-L/3);
    vertex(pos.x+L/9, pos.y+L/9);
    vertex(pos.x+L/5, pos.y+L/9);
    vertex(pos.x, pos.y+L/3);
    vertex(pos.x-L/5, pos.y+L/9);
    vertex(pos.x-L/9, pos.y+L/9);
    endShape();
  }
}
