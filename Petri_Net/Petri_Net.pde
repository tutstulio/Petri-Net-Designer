/*
 *
 * PRÓXIMOS PASSOS:
 * - 
 * - 
 *
 */

// ======================================================================== MAIN DATA

UserInterface ui;
Net petri;

boolean running, paused, editing, dragging;
boolean posSelecting, transSelecting, archSelecting;
boolean posSelected[], transSelected[], archSelected[];
boolean transTrigger[], trigFlag;
boolean archStarted, archEnded, isPos;

int posID, transID, archID;

// ======================================================================== SETUP

void setup()
{
  size(800, 600);
  running = false;
  editing = false;
  paused = false;
  posSelecting = false;
  transSelecting = false;
  archSelecting = false;
  trigFlag = false;
  ui = new UserInterface();
  petri = new Net();
}

// ======================================================================== LOOP

void draw()
{
  // -------------------- TOP SLOT --------------------

  posSelected = new boolean[petri.P.size()];
  transSelected = new boolean[petri.T.size()];
  transTrigger = new boolean[petri.T.size()];
  archSelected = new boolean[petri.A.size()];

  // ------------------ STATE MACHINE ------------------

  // Simulation mode
  if (running)
  {
    // Simulation paused
    if (paused)
    {
      background(200);
      ui.display();
      petri.display(posSelected, transSelected, archSelected);
      fill(0);
      text("Press P to continue", width/2, height/2);
    }
    // Running simulation
    else
    {
      background(200);
      if (petri.T.size() > 0 && trigFlag)
      {
        transTrigger[transID] = true;
        petri.run(transTrigger);
        trigFlag = false;
      }
      ui.display();
      petri.display(posSelected, transSelected, archSelected);
    }
  }

  // Editing mode
  else if (editing)
  {
    // Selecting position
    if (posSelecting)
    {
      if (dragging)
      {
        petri.P.set(petri.P.size()-1, new Position(mouseX, mouseY, 0));
        posSelected[petri.P.size()-1] = true;
      } else
      {
        posSelected[posID] = true;
      }
    }
    // Selecting transition
    else if (transSelecting)
    {
      if (dragging)
      {
        petri.T.set(petri.T.size()-1, new Transition(mouseX, mouseY));
        transSelected[petri.T.size()-1] = true;
      } else
      {
        transSelected[transID] = true;
      }
    }
    // Selecting arch
    else if (archSelecting)
    {
      if (dragging)
      {
        if (!archStarted && !archEnded)
          petri.A.set(petri.A.size()-1, new Arch(mouseX, mouseY, mouseX+1, mouseY+1, 1));
        else if (!archEnded)
        {
          Arch a = petri.A.get(petri.A.size()-1);
          petri.A.set(petri.A.size()-1, new Arch(a.start.x, a.start.y, mouseX, mouseY, 1));
        }
      } else
      {
        archSelected[archID] = true;
      }
    }
    // Selecting none
    else
    {
      ;
    }

    background(25);
    ui.display();
    petri.display(posSelected, transSelected, archSelected);
  }

  // Idle mode (default)
  else
  {
    background(25);
    ui.display();
    petri.display(posSelected, transSelected, archSelected);
  }
}

// ======================================================================== EVENTS

void mousePressed()
{
  // Get mouse coordinates
  PVector mouse = new PVector(mouseX, mouseY);
  if (!uiEvent(mouse))
    if (!screenEvent())
      netEvent(mouse);
}

void keyPressed()
{
  char k = key;
  if ((k == 'p' || k == 'P') && running)
    paused = !paused;
}

// -------------------- UI INPUTS --------------------
boolean uiEvent (PVector mouse)
{
  boolean flag = true;

  if (ui.run.mouseOn(mouse.x, mouse.y))
    runPressed();
  else if (ui.stop.mouseOn(mouse.x, mouse.y))
    stopPressed();
  else if (ui.add_pos.mouseOn(mouse.x, mouse.y))
    addPosPressed(mouse);
  else if (ui.add_trans.mouseOn(mouse.x, mouse.y))
    addTransPressed(mouse);
  else if (ui.add_arch.mouseOn(mouse.x, mouse.y))
    addArchPressed(mouse);
  else if (ui.add_mark.mouseOn(mouse.x, mouse.y))
    addMarkPressed();
  else if (ui.sub_mark.mouseOn(mouse.x, mouse.y))
    subMarkPressed();
  else
    flag = false;

  return flag;
}

// -------------------- NET INPUTS --------------------
void netEvent (PVector mouse)
{
  //boolean flag = true;

  // Selects positions added on the screen
  for (Position p : petri.P)
    if (p.mouseOn(mouse.x, mouse.y) && !running)
    {
      posID = petri.P.indexOf(p);
      if (dragging && !posSelecting)
      {
        if (!archStarted)
        {
          petri.A.set(petri.A.size()-1, new Arch(p.o.x, p.o.y, mouse.x, mouse.y, 1));
          archStarted = true;
          isPos = true;
        } else if (!archEnded && !isPos)
        {
          Arch a = petri.A.get(petri.A.size()-1);
          petri.A.set(petri.A.size()-1, new Arch(a.start.x, a.start.y, p.o.x, p.o.y, 1));
          petri.A.get(petri.A.size()-1).posID = posID;
          petri.A.get(petri.A.size()-1).transID = transID;
          petri.T.get(transID).post_set.add(petri.P.get(posID));
          archEnded = true;
          dragging = false;
          archSelecting = false;
          editing = false;
        } else
        {
          archStarted = false;
          archEnded = false;
          dragging = false;
          archSelecting = false;
          editing = false;
          if (isPos) petri.A.remove(petri.A.size()-1);
          println("Nem tchum\t");
        }
      } else
      {
        editing = true;
        posSelecting = true;
        transSelecting = false;
        archSelecting = false;
      }
    }

  // Selects transitions added on the screen
  for (Transition t : petri.T)
    if (t.mouseOn(mouse.x, mouse.y))
    {
      transID = petri.T.indexOf(t);
      if (dragging && !transSelecting)
      {
        if (!archStarted)
        {
          petri.A.set(petri.A.size()-1, new Arch(t.o.x, t.o.y, mouse.x, mouse.y, 1));
          archStarted = true;
          isPos = false;
        } else if (!archEnded && isPos)
        {
          Arch a = petri.A.get(petri.A.size()-1);
          petri.A.set(petri.A.size()-1, new Arch(a.start.x, a.start.y, t.o.x, t.o.y, 1));
          petri.A.get(petri.A.size()-1).posID = posID;
          petri.A.get(petri.A.size()-1).transID = transID;
          petri.T.get(transID).pre_set.add(petri.P.get(posID));
          archEnded = true;
          dragging = false;
          archSelecting = false;
          editing = false;
        } else
        {
          archStarted = false;
          archEnded = false;
          dragging = false;
          archSelecting = false;
          editing = false;
          if (!isPos) petri.A.remove(petri.A.size()-1);
          println("Nem tchum\t");
        }
      } else if (running)
      {
        trigFlag = true;
        println("trigged " + transID);
      } else
      {
        editing = true;
        posSelecting = false;
        transSelecting = true;
        archSelecting = false;
      }
    }

  // Selects arches added on the screen
  for (Arch a : petri.A)
  {
    if (a.mouseOn(mouse.x, mouse.y) && !dragging && !running)
    {
      editing = true;
      archSelecting = true;
      archID = petri.A.indexOf(a);
    }
  }

  //return flag;
}

// -------------------- ANYWHERE --------------------
boolean screenEvent ()
{
  boolean flag = false;
  
  if (archSelecting)
  {
    // Arch start and end case
    if (!archStarted)
    {
      ;
    } else if (!archEnded)
    {
      ;
    }
    // Arch completly drawn
    else
    {
      dragging = false;
      posSelecting = false;
      transSelecting = false;
      archSelecting = false;
      editing = false;
      flag = true;
    }
  }
  // Default
  else
  {
    dragging = false;
    posSelecting = false;
    transSelecting = false;
    editing = false;
  }
  
  return flag;
}

// Run button
void runPressed ()
{
  if (!editing)
  {
    running = true;
  }
}

// Stop button
void stopPressed ()
{
  running = false;
  paused = false;
}

// Add position button
void addPosPressed (PVector mouse)
{
  if (!dragging && !running)
  {
    editing = true;
    posSelecting = true;
    transSelecting = false;
    archSelecting = false;
    dragging = true;
    petri.add(new Position(mouse.x, mouse.y, 0));
  }
}

// Add transition button
void addTransPressed (PVector mouse)
{
  if (!dragging && !running)
  {
    editing = true;
    posSelecting = false;
    transSelecting = true;
    archSelecting = false;
    dragging = true;
    petri.add(new Transition(mouse.x, mouse.y));
  }
}

// Add arch button
void addArchPressed (PVector mouse)
{
  if (!dragging && !running)
  {
    editing = true;
    posSelecting = false;
    transSelecting = false;
    archSelecting = true;
    dragging = true;
    archStarted = false;
    archEnded = false;
    petri.add(new Arch(mouse.x, mouse.y, mouse.x+1, mouse.y+1, 1));
  }
}

// Add mark button
void addMarkPressed ()
{
  if (!running && editing && !dragging && (archSelecting || posSelecting))
  {
    if (archSelecting)
      petri.A.get(archID).weight++;
    else if (posSelecting)
      petri.P.get(posID).marks++;
  }
}

// Subtract mark button
void subMarkPressed ()
{
  if (!running && editing && !dragging && (archSelecting || posSelecting))
  {
    int weight = petri.A.get(archID).weight;
    int marks = petri.P.get(posID).marks;
    if (archSelecting && weight > 1)
      petri.A.get(archID).weight--;
    else if (posSelecting && marks > 0)
      petri.P.get(posID).marks--;
  }
}
