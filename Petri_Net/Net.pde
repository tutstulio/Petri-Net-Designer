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
  
  void run(boolean[] transTrigged)
  {
    for (Transition t : T)
    {
      boolean trigged = transTrigged[T.indexOf(t)];
      if (trigged)
      {
        for (Position pre : t.pre_sets)
        {
          int pre_weight = 100;
          for (Arch a : A)
            if (a.p == pre && a.t == t)
              pre_weight = a.weight;
          
          if (pre.marks >= pre_weight)
          {
            pre.marks -= pre_weight;
            for (Position post : t.post_sets)
            {
              int post_weight = 0;
              for (Arch a : A)
                if (a.p == post && a.t == t)
                  post_weight = a.weight;
                  
              post.marks += post_weight;
            }
          }
        }
      }
    }
  }
  
}
