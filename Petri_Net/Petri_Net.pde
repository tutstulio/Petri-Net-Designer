/*
 *
 * PRÓXIMOS PASSOS:
 * - adicionar e remover as marcações
 * - editar pesos
 * - fazer as posições e transições reconhecerem seus pre e pos-sets
 * - partir para a simulação
 *
 */

// ======================================================================== MAIN DATA

UserInterface ui;
Net petri;

boolean running, paused, editing, dragging;
boolean posSelecting, transSelecting, archSelecting;
boolean posSelected[], transSelected[], archSelected[];
boolean archStarted, archEnded, isPos;

int posID, transID, archID;

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
  // -------------------- TOP SLOT --------------------

  posSelected = new boolean[petri.P.size()];
  transSelected = new boolean[petri.T.size()];
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
      //petri.run();
      background(200);
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
        //else
        //{
        //Arch a = petri.A.get(petri.A.size()-1);
        //petri.A.set(petri.A.size()-1, new Arch(a.start.x, a.start.y, a.end.x, a.end.y, 1));
        //}
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
  uiEvent(mouse);
  netEvent(mouse);
}

void keyPressed()
{
  char k = key;

  if ((k == 'p' || k == 'P') && running)
    paused = !paused;

  /*for (TextBox i : tb)
   i.write(key, (int)keyCode);*/
}

// -------------------- UI INPUTS --------------------
void uiEvent (PVector mouse)
{
  // Simulate button
  if (ui.simulate.mouseOn(mouse.x, mouse.y) && !editing)
  {
    running = true;
  }
  // Stop button
  else if (ui.stop.mouseOn(mouse.x, mouse.y))
  {
    running = false;
    paused = false;
  }
  // Add position button
  else if (ui.add_pos.mouseOn(mouse.x, mouse.y) && !dragging && !running)
  {
    editing = true;
    posSelecting = true;
    transSelecting = false;
    archSelecting = false;
    dragging = true;
    petri.add(new Position(mouse.x, mouse.y, 0));
  }
  // Add transition button
  else if (ui.add_trans.mouseOn(mouse.x, mouse.y) && !dragging && !running)
  {
    editing = true;
    posSelecting = false;
    transSelecting = true;
    archSelecting = false;
    dragging = true;
    petri.add(new Transition(mouse.x, mouse.y));
  }
  // Add arch button
  else if (ui.add_arch.mouseOn(mouse.x, mouse.y) && !dragging && !running)
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
  // Anywhere on the screen
  else
  {
    if (!archSelecting)
    {
      editing = false;
      posSelecting = false;
      transSelecting = false;
      dragging = false;
      print("Djonga da Mironga\t");
      println(petri.A.size());
    }
    else if (archSelecting && archEnded)
    {
      editing = false;
      posSelecting = false;
      transSelecting = false;
      archSelecting = false;
      dragging = false;
      print("Djonga da Mironga\t");
      println(petri.A.size());
    }
    // The arch start and end points case
    else
    {
      // Scans positions on the screen
      for (Position p : petri.P)
      {
        if (p.mouseOn(mouse.x, mouse.y) && !running)
        {
          Arch a = petri.A.get(petri.A.size()-1);
          if (!archStarted)
          {
            petri.A.set(petri.A.size()-1, new Arch(p.p.x, p.p.y, p.p.x+1, p.p.y+1, 1));
            archStarted = true;
            isPos = true;
            print("TchumP\t");
            println(petri.A.size());
          } else if (!isPos && !archEnded)
          {
            petri.A.set(petri.A.size()-1, new Arch(a.start.x, a.start.y, p.p.x, p.p.y, 1));
            archEnded = true;
            editing = false;
            archSelecting = false;
            dragging = false;
          }
          // Drop an arch point anywhere on the screen
          else
          {
            editing = false;
            archSelecting = false;
            dragging = false;
            archStarted = false;
            archEnded = false;
            if (isPos) petri.A.remove(petri.A.size()-1);
            print("Nem tchum\t");
            println(petri.A.size());
          }
        }
      }

      // Scans transitions on the screen
      for (Transition t : petri.T)
      {
        if (t.mouseOn(mouse.x, mouse.y) && !running)
        {
          Arch a = petri.A.get(petri.A.size()-1);
          if (!archStarted)
          {
            petri.A.set(petri.A.size()-1, new Arch(t.p.x, t.p.y, t.p.x+1, t.p.y+1, 1));
            archStarted = true;
            isPos = false;
            print("TchumT\t");
            println(petri.A.size());
          } else if (isPos && !archEnded)
          {
            petri.A.set(petri.A.size()-1, new Arch(a.start.x, a.start.y, t.p.x, t.p.y, 1));
            archEnded = true;
            editing = false;
            archSelecting = false;
            dragging = false;
          }
          // Drop an arch point anywhere on the screen
          else
          {
            editing = false;
            archSelecting = false;
            dragging = false;
            archStarted = false;
            archEnded = false;
            if (!isPos) petri.A.remove(petri.A.size()-1);
            print("Nem tchum\t");
            println(petri.A.size());
          }
        }
      }
    }
  }
}

// -------------------- NET INPUTS --------------------
void netEvent (PVector mouse)
{
  // Selects positions added on the screen
  for (Position p : petri.P)
    if (p.mouseOn(mouse.x, mouse.y) && !dragging && !running)
    {
      editing = true;
      posSelecting = true;
      transSelecting = false;
      archSelecting = false;
      posID = petri.P.indexOf(p);
      //println(posID);
    }

  // Selects transitions added on the screen
  for (Transition t : petri.T)
    if (t.mouseOn(mouse.x, mouse.y) && !dragging && !running)
    {
      editing = true;
      posSelecting = false;
      transSelecting = true;
      archSelecting = false;
      transID = petri.T.indexOf(t);
      //println(transID);
    }

  // Selects arches added on the screen
  for (Arch a : petri.A)
    if (a.mouseOn(mouse.x, mouse.y) && !dragging && !running)
    {
      editing = true;
      archSelecting = true;
      archID = petri.A.indexOf(a);
      println(archID);
    }

  /*for (TextBox i : tb) {
   if (i.mouseOn(mouseX, mouseY))
   i.selected = true;
   else
   i.selected = false;
   }*/
}
