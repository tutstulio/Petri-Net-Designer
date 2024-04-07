// ======================================================================== MAIN DATA

UserInterface ui;
Net petri;

boolean running, paused, editing, dragging;
boolean posSelecting, transSelecting, archSelecting;
boolean posSelected[], transSelected[], archSelected[];

int posID, transID;

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
  posSelected = new boolean[petri.P.size()];
  transSelected = new boolean[petri.T.size()];
  archSelected = new boolean[petri.A.size()];

  // BOTA NA CABECA QUE ESTILO NAO EH MARRA
  if (running)  // simulation mode
  {
    if (paused)  // simulation paused
    {
      background(200);
      ui.display();
      petri.display(posSelected, transSelected);
      fill(0);
      text("Press P to continue", width/2, height/2);
    } else      // simulation running
    {
      //petri.run();
      background(200);
      ui.display();
      petri.display(posSelected, transSelected);
    }
  }

  // BOTA NA CABECA QUE ESTILO NAO EH MARRA
  else if (editing)  // editing mode on add buttons pressed or net itens pressed
  {
    if (posSelecting)
    {
      if (dragging)
      {
        posSelected[petri.P.size()-1] = true;
        petri.P.set(petri.P.size()-1, new Position(mouseX, mouseY, 0));
      } else
      {
        posSelected[posID] = true;
      }
    } else if (transSelecting)
    {
      if (dragging)
      {
        transSelected[petri.T.size()-1] = true;
        petri.T.set(petri.T.size()-1, new Transition(mouseX, mouseY));
      } else
      {
        transSelected[transID] = true;
      }
    } else if (archSelecting)
    {
      if (dragging)
        petri.A.set(petri.A.size()-1, new Arch(mouseX, mouseY, mouseX+1, mouseY+1, 1));
    } else
    {
      ;
    }

    background(25);
    ui.display();
    petri.display(posSelected, transSelected);
  }

  // BOTA NA CABECA QUE ESTILO NAO EH MARRA
  else  // idle mode (default)
  {
    background(25);
    ui.display();
    petri.display(posSelected, transSelected);
  }
}

// ======================================================================== EVENTS

void mousePressed()
{
  PVector mouse = new PVector(mouseX, mouseY);

  if (ui.simulate.mouseOn(mouse.x, mouse.y) && !editing)  // simulate button pressed
  {
    running = true;
  } else if (ui.stop.mouseOn(mouse.x, mouse.y))  // stop button pressed
  {
    running = false;
    paused = false;
  } else if (ui.add_pos.mouseOn(mouse.x, mouse.y) && !running)  // add position button pressed
  {
    // drag state until click somewhere to add position to net or press another shit
    editing = true;
    posSelecting = true;
    transSelecting = false;
    archSelecting = false;
    dragging = true;
    petri.add(new Position(mouse.x, mouse.y, 0));
  } else if (ui.add_trans.mouseOn(mouse.x, mouse.y) && !running)  // add transition button pressed
  {
    editing = true;
    posSelecting = false;
    transSelecting = true;
    archSelecting = false;
    dragging = true;
    petri.add(new Transition(mouse.x, mouse.y));
  } else if (ui.add_arch.mouseOn(mouse.x, mouse.y) && !running)  // add arch button pressed
  {
    editing = true;
    posSelecting = false;
    transSelecting = false;
    archSelecting = true;
    dragging = true;
    petri.add(new Arch(mouse.x, mouse.y, mouse.x+1, mouse.y+1, 1));
  } else  // click anywhere on the screen
  {
    posSelecting = false;
    transSelecting = false;
    editing = false;
    archSelecting = false;
    dragging = false;
  }

  for (Position p : petri.P)
    if (p.mouseOn(mouse.x, mouse.y) && !dragging && !running)
    {
      editing = true;
      posSelecting = true;
      transSelecting = false;
      archSelecting = false;
      //dragging = false;
      posID = petri.P.indexOf(p);
      println(posID);
    }

  for (Transition t : petri.T)
    if (t.mouseOn(mouse.x, mouse.y) && !dragging && !running)
    {
      editing = true;
      posSelecting = false;
      transSelecting = true;
      archSelecting = false;
      //dragging = false;
      transID = petri.T.indexOf(t);
      println(transID);
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
  char k = key;

  if ((k == 'p' || k == 'P') && running)
    paused = !paused;

  /*for (TextBox i : tb)
   i.write(key, (int)keyCode);*/
}
