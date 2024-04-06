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
  
  void display()
  {
    for (Arch a : A)
    {
      a.display();
    }
    
    for (Position p : P)
    {
      p.display();
    }
    
    for (Transition t : T)
    {
      t.display();
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
