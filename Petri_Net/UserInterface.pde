class UserInterface
{
  Button simulate, stop, pause, add_pos, add_trans, add_arch, add_mark, sbt_mark;

  UserInterface()
  {
    simulate = new Button(5, 5, 25);
    stop = new Button(40, 5, 25);
    add_pos = new Button(75, 5, 25);
    add_trans = new Button(110, 5, 25);
    add_arch = new Button(145, 5, 25);
  }

  void display()
  {
    rectMode(CORNER);
    simulate.display();
    stop.display();
    add_pos.display();
    add_trans.display();
    add_arch.display();
  }
}
