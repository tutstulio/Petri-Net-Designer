class Net
{
  ArrayList<Position> P;    // positions
  ArrayList<Transition> T;  // transitions
  ArrayList<Arch> A;        // arches
  int[] W, m0;              // weights and initial marks
  int posID, transID;

  Net()
  {
    this.P = new ArrayList<Position>();
    this.T = new ArrayList<Transition>();
    this.A = new ArrayList<Arch>();
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
      transID = T.indexOf(t);
      if (transTrigged[transID])
      {
        boolean flag = true;
        for (Position pre : t.pre_set)
        {
          posID = P.indexOf(pre);
          for (Arch a : A)
            if (a.posID == posID && a.transID == transID && pre.marks < a.weight)
              flag = false;
        }

        if (flag)
        {
          for (Position pre : t.pre_set)
          {
            posID = P.indexOf(pre);
            println("x1:", pre.o.x, "y1:", pre.o.y);
            for (Arch a : A)
              if (a.posID == posID && a.transID == transID)
                P.get(posID).marks -= a.weight;
          }
          for (Position post : t.post_set)
          {
            posID = P.indexOf(post);
            println("x2:", post.o.x, "y2:", post.o.y);
            for (Arch a : A)
              if (a.posID == posID && a.transID == transID)
                P.get(posID).marks += a.weight;
          }
        }
        else
        {
          println("YOU GAY???");
        }
      }
    }
  }
}
