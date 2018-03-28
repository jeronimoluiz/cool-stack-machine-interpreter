class List {
   -- Define operations on empty lists.

   isNil() : Bool { true };

   head()  : String { { abort(); ""; } };

   tail()  : List { { abort(); self; } };

   cons(i : String) : List {
      (new Cons).init(i, self)
   };

};

class Cons inherits List {

   car : String; -- The element in this list cell

   cdr : List; -- The rest of the list

   isNil() : Bool { false };

   head()  : String { car };

   tail()  : List { cdr };

   init(i : String, rest : List) : List {
      {
	 car <- i;
	 cdr <- rest;
	 self;
      }
   };

};

class StackComm inherits IO {
    init(s : String, l : List) : List {       
        if s = "e" then new ExecuteComm.ex(l) else
        if s = "d" then { new DisplayComm.print_list(l); l; }
        else l.cons(s)
        fi fi
    };
};

class DisplayComm inherits StackComm {
    print_list(l : List) : Object {
      if l.isNil() then out_string("")
      else {
			out_string(l.head());
			out_string("\n");
			print_list(l.tail());
		}
      fi
   };
};

class ExecuteComm inherits StackComm {
    ex(l : List) : List {
        if l.isNil() then l else
        if l.head() = "+" then new SumComm.sum(l.tail()) else
        if l.head() = "s" then new SwitchComm.sw(l.tail()) else
        l
        fi fi fi
    };
};

class PushComm inherits StackComm {

};

class SumComm inherits StackComm {
    first : Int;
    second : Int;

    sum(l : List) : List { {
        first <- new A2I.c2i(l.head());
        second <- 2;
        new Cons.init(new A2I.i2c(first + second), l.tail());
    }
    };
};

class SwitchComm inherits StackComm {
    sw(l: List) : List {
        l
    };
};

class Main inherits IO {

   l : List;
   comm : String;

   main() : Object { {
    l <- new List;
    out_string(">");
    comm <- in_string();
    while ( not comm = "x" ) loop {
        l <- (new StackComm).init(comm, l);
        out_string(">");
        comm <- in_string();
        }
    pool;
   }
   };
};
