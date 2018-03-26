class StackCommand inherits IO {
    init(s : String, l : List) : List {       
        if s = "e" then { l; } else
        if s = "d" then { new DisplayCommand.print_list(l); l; }
        else l.cons(s)
        fi fi
    };
};

class DisplayCommand inherits StackCommand {
    print_list(l : List) : Object {
      if l.isNil() then out_string("\n")
      else {
			out_string(l.head());
			out_string("\n");
			print_list(l.tail());
		}
      fi
   };
};

class ExecuteCommand inherits StackCommand {

};

class PushCommand inherits StackCommand {

};

class SumCommand inherits StackCommand {

};

class SwitchCommand inherits StackCommand {

};

class Main inherits IO {

   l : List;
   comm : String;

   main() : Object { {
    l <- new List;
    out_string(">");
    comm <- in_string();
    while ( not comm = "x" ) loop {
        l <- (new StackCommand).init(comm, l);
        out_string(">");
        comm <- in_string();
        }
    pool;
   }
   };
};
