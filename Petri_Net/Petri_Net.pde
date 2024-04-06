// ======================================================================== MAIN DATA

UserInterface ui;
Net petri;

boolean running, paused, editing, dragging;
boolean posSelected, transSelected, archSelected;

// ======================================================================== SETUP

void setup()
{
  size(800, 600);
  running = false;
  editing = false;
  paused = false;
  ui = new UserInterface();
  petri = new Net();
}

// ======================================================================== LOOP

void draw()
{
  if (running)  // simulation mode
  {
    if (paused)  // simulation paused
    {
      while (key != 'p' && key != 'P')
        text("Press P to continue", width/2, height/2);
      delay(250);
    } else      // simulation running
    {
      //petri.run();
      background(200);
      ui.display();
      petri.display();
    }
  } else if (editing)  // editing mode on add buttons pressed or net itens pressed
  {
    if (posSelected)
    {
      if (dragging)
        petri.P.set(petri.P.size()-1, new Position(mouseX, mouseY, 0));
      else
        print("cocozauro");
    } else if (transSelected)
    {
      if (dragging)
        petri.T.set(petri.T.size()-1, new Transition(mouseX, mouseY));
      else
        print("pirocossauro");
    } else if (archSelected)
    {
      if (dragging)
        petri.A.set(petri.A.size()-1, new Arch(mouseX, mouseY, mouseX+30, mouseY+30, 1));
      else
        print("babacazãossauro");
    }

    background(25);
    ui.display();
    petri.display();
  } else  // idle mode (default)
  {
    background(25);
    ui.display();
    petri.display();
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
    posSelected = true;
    transSelected = false;
    archSelected = false;
    dragging = true;
    petri.add(new Position(mouse.x, mouse.y, 0));
  } else if (ui.add_trans.mouseOn(mouse.x, mouse.y) && !running)
  {
    // drag state until click somewhere to add position to net or press ESC
    editing = true;
    posSelected = false;
    transSelected = true;
    archSelected = false;
    dragging = true;
    petri.add(new Transition(mouse.x, mouse.y));
  } else if (ui.add_arch.mouseOn(mouse.x, mouse.y) && !running)
  {
    editing = true;
    posSelected = false;
    transSelected = false;
    archSelected = true;
    dragging = true;
    petri.add(new Arch(mouse.x, mouse.y, mouse.x+30, mouse.y+30, 1));
  } else  // click anywhere
  {
    editing = false;
    posSelected = false;
    transSelected = false;
    archSelected = false;
    dragging = false;
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
