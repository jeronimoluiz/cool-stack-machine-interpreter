(*
 *  The List class has 4 operations defined on List objects. If 'l' is
 *  a list, then the methods dispatched on 'l' have the following effects:
 *
 *    isNil() : Bool		Returns true if 'l' is empty, false otherwise.
 *    head()  : String		Returns the string at the head of 'l'.
 *				If 'l' is empty, execution aborts.
 *    tail()  : List		Returns the remainder of the 'l',
 *				i.e. without the first element.
 *    cons(i : String) : List	Return a new list containing i as the
 *				first element, followed by the
 *				elements in 'l'.
 *
 *  There are 2 kinds of lists, the empty list and a non-empty
 *  list. We can think of the non-empty list as a specialization of
 *  the empty list.
 *  The class List defines the operations on empty list. The class
 *  Cons inherits from List and redefines things to handle non-empty
 *  lists.
 *)

class List {
   -- Define operations on empty lists.

   isNil() : Bool { true };

   -- Since abort() has return type Object and head() has return type
   -- String, we need to have an String as the result of the method
   -- body, even though abort() never returns.

   head()  : String { { abort(); ""; } };

   -- As for head(), the self is just to make sure the return type of
   -- tail() is correct.

   tail()  : List { { abort(); self; } };

   -- When we cons and element onto the empty list we get a non-empty
   -- list. The (new Cons) expression creates a new list cell of class
   -- Cons, which is initialized by a dispatch to init().
   -- The result of init() is an element of class Cons, but it
   -- conforms to the return type List, because Cons is a subclass of
   -- List.

   cons(i : String) : List {
      (new Cons).init(i, self)
   };

};

(*
 *  Cons inherits all operations from List. We can reuse only the cons
 *  method though, because adding an element to the front of an emtpy
 *  list is the same as adding it to the front of a non empty
 *  list. All other methods have to be redefined, since the behaviour
 *  for them is different from the empty list.
 *
 *  Cons needs two attributes to hold the string of this list
 *  cell and to hold the rest of the list.
 *
 *  The init() method is used by the cons() method to initialize the
 *  cell.
 *)

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

(*
 *  StackComm inherits from IO and is the parent of all other
 *  sub-commands. The init() method is used to create a type
 *  of the sub-command typed or add a new element to the stack.
 *)
class StackComm inherits IO {
    init(s : String, l : List) : List {       
        if s = "e" then new ExecuteComm.ex(l) else
        if s = "d" then { new DisplayComm.print_list(l); l; }
        else l.cons(s)
        fi fi
    };
};

(*  DisplayComm inherits from StackComm which inherits from IO. This
 *  makes possible for DisplayComm to use IO methods. The print_list()
 *  methods prints all elements of a list each followed by a \n.
 *)
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

(*  ExecuteComm inherits from StackComm. The ex() method executes
 *  one of the sub-commands that are stacked. If the head of the
 *  stack is a number, ex() does nothing and return the stack.
 *)
class ExecuteComm inherits StackComm {
    ex(l : List) : List {
        if l.isNil() then l else
        if l.head() = "+" then new SumComm.sum(l.tail()) else
        if l.head() = "s" then new SwitchComm.sw(l.tail()) else
        l
        fi fi fi
    };
};

(*  SumComm inherits from StackComm. The sum() method adds
 *  the first and second elements in the stack and returns a
 *  new stack with the result of its operation in the head. 
 *)
class SumComm inherits StackComm {
    first : Int;
    second : Int;

    sum(l : List) : List { {
        first <- new A2I.a2i_aux(l.head());
        second <- new A2I.a2i_aux(l.tail().head());
        new Cons.init(new A2I.i2a_aux(first + second), l.tail().tail());
    }
    };
};

(*  SwitchComm inherits from StackComm. The sw() method switches
 *  the position of the first and second elements in the stack 
 *  return a new list with the inversion.
 *)
class SwitchComm inherits StackComm {
    first: String;
    second: String;

    sw(l: List) : List { {
        first <- l.head();
        second <- l.tail().head();
        new Cons.init(second, new Cons.init(first, l.tail().tail()));
    }
    };
};


(*  The Main class inherits from IO and prints a prompt '>' waiting
 *  for the user's input.
 *  - x  : exit the program;
 *  - d  : display the elements of the stack one by one if not empty;
 *  - e  : execute the command in the head of the stack (if it's the case);
 *  - s  : adds the switch command to the head of the stack;
 *  - +  : adds the sum command to the head of the stack;
 *  - any number (0-9) : add the typed number to the head of the stack.
 *)
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
