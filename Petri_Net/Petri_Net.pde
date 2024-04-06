// ======================================================================== MAIN DATA

UserInterface ui;
Net petri;

boolean running, paused, editing;

// ======================================================================== SETUP

void setup()
{
  size(800, 600);
  running = false;
  editing = false;
  ui = new UserInterface();
  petri = new Net();
}

// ======================================================================== LOOP

void draw()
{
  if (running)  // simulation mode
  {
    if (paused)
    {
      while (key != 'p' && key != 'P')
        text("Press P to continue", width/2, height/2);
      delay(250);
    } else
    {
      background(200);
      ui.display();
      //petri.run();
      //petri.display();
    }
  } else  // editing mode
  {
    background(25);
    ui.display();
    //petri.display();
  }
}

// ======================================================================== EVENTS

void mousePressed()
{
  PVector mouse = new PVector(mouseX, mouseY);
  
  if (ui.simulate.mouseOn(mouse.x, mouse.y) && !editing)
    running = true;
  else if (ui.stop.mouseOn(mouse.x, mouse.y))
    running = false;
  else if (ui.add_pos.mouseOn(mouse.x, mouse.y) && !running)
  {
    // drag state until click somewhere to add position to net or press ESC
    editing = true;
    //petri.add(new Position(mouse.x, mouse.y, 0));
  }
  else
  {
    editing = false;
  }

  /*for (TextBox i : tb) {
   if (i.mouseOn(mouseX, mouseY))
   i.selected = true;
   else
   i.selected = false;
   }*/
}

void keyPressed()
{
  /*for (TextBox i : tb)
   i.write(key, (int)keyCode);*/
}
