class Net
{
  ArrayList<Position> P;    // positions
  ArrayList<Transition> T;  // transitions
  ArrayList<Arch> A;        // arches
  int[] W, m0;              // weights and initial marks
  int n, m;                 // position and transition numbers
  
  Net()
  {
    this.P = new ArrayList<Position>();
    this.T = new ArrayList<Transition>();
    this.A = new ArrayList<Arch>();
    n = 0;
    m = 0;
  }
  
  void display(boolean[] posSelection, boolean[] transSelection, boolean[] archSelection)
  {
    for (Arch a : A)
    {
      boolean selected = archSelection[A.indexOf(a)];
      if (selected) a.display(true);
      else a.display(false);
    }
    
    for (Position p : P)
    {
      boolean selected = posSelection[P.indexOf(p)];
      if (selected) p.display(true);
      else p.display(false);
    }
    
    for (Transition t : T)
    {
      boolean selected = transSelection[T.indexOf(t)];
      if (selected) t.display(true);
      else t.display(false);
    }
  }
  
  void run()
  {
    ;
  }
  
  void add(Position p)
  {
    P.add(p);
  }
  
  void add(Transition t)
  {
    T.add(t);
  }
  
  void add(Arch a)
  {
    A.add(a);
  }
}
