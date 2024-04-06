// ======================================================================== MAIN DATA

UserInterface ui;
Net petri;
/*Position p1, p2;
Transition t1;
Arch a1;*/

boolean running, pause;

// ======================================================================== SETUP

void setup()
{
  size(800, 600);
  running = false;
  petri = new Net();
  /*p1 = new Position(100, 100, 0);
  p2 = new Position(200, 200, 0);
  t1 = new Transition(300, 300);
  a1 = new Arch(200, 200, 300, 300, 1);*/
}

// ======================================================================== LOOP

void draw()
{
  if (running)  // simulation mode
  {
    if (pause)
    {
      while(key != 'p' && key != 'P')
        text("Press P to continue", width/2, height/2);
      delay(250);
    } else
    {
      background(25);
      petri.run();
      petri.display();
    }
  } else  // editing mode
  {
    background(25);
    ui.display();
    petri.display();
    /*a1.display();
    p1.display();
    p2.display();
    t1.display();*/
  }
}

// ======================================================================== EVENTS

void mousePressed()
{
  /*if (up.mouseOn(mouseX, mouseY))
   res += 0.1;
   else if (down.mouseOn(mouseX, mouseY))
   res -= 0.1;
   
   for (TextBox i : tb) {
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
