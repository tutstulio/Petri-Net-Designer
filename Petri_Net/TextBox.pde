public class TextBox
{
  public PVector pos, size;
  public color bg = color(0, 140, 140);
  public color bgPress = color(0, 180, 180);
  public color txtCor = color(250);
  public boolean mouseOn = false;
  private boolean selected = false;
  public String txt = "";
  public int textLength = 0;
  public float sizeOfText;

  TextBox(float x, float y, float w, float h)
  {
    pos = new PVector(x, y);
    size = new PVector(w, h*3/2);
    sizeOfText = h;
  }

  void display()
  {
    if (mouseOn(mouseX, mouseY) || selected)
      fill(bgPress);
    else
      fill(bg);

    rect(pos.x, pos.y, size.x, size.y);

    fill(txtCor);
    textSize(sizeOfText);
    text(txt, pos.x - size.x/2 + 6, pos.y + size.y/10);

    if (selected && (millis()/500) % 2 == 0)
    {
      float txtEnd = textWidth(txt);
      stroke(250);
      line(pos.x - size.x/2 + 6 + txtEnd, pos.y + size.y/10, pos.x - size.x/2 + 6 + txtEnd, pos.y - 3*size.y/7);
      noStroke();
    }
  }

  private boolean mouseOn(int x, int y)
  {
    if (x >= pos.x - size.x/2 && x <= pos.x + size.x/2)
      if (y <= pos.y + size.y/2 && y >= pos.y - size.y/2)
        return true;

    return false;
  }

  void write(char _key, int _keyCode)
  {
    if (selected)
    {
      if (_keyCode == (int)BACKSPACE)
        backspace();
      else if (_keyCode == ENTER)
        selected = false;
      else
      {
        boolean isUsualCharacter = (_key >= 32 && _key <= 126);
        if (isUsualCharacter)
          addText(_key);
      }
    }
  }

  private void addText(char _txt)
  {
    if (textWidth(txt + _txt) < size.x - 6)
    {
      txt += _txt;
      textLength++;
    }
  }

  private void backspace()
  {
    if (textLength - 1 >= 0)
    {
      txt = txt.substring(0, textLength - 1);
      textLength--;
    }
  }
}
