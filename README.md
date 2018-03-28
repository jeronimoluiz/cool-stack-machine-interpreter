# Stack Machine with Cool

Cool means _Classrom Object-Oriented Language_ and it is a language used in many Computer Science Compilers' courses to teach how to build a compiler from scratch. The language was designed by Alexander Aiken from Stanford University. In his [own page](http://theory.stanford.edu/~aiken/software/cool/cool.html) he talks about Cool:

> Cool is a small language designed for use in an undergraduate compiler course project. While small enough for a one term project, Cool still has many of the features of modern programming languages, including objects, automatic memory management, and strong static typing. Cool is built entirely on public domain tools; it generates code for a MIPS simulator, spim . Thus, the project should port easily to other platforms. The project has been used for teaching compilers at many institutions and the software is stable. 

This program was the first assignment for my Compilers' course at [UFMG](https://ufmg.br/): to build a simples stack machine using Cool. The operations are the following:


| Command | Outcome                   |
|:-------:|---------------------------|
| _int_   | Push the number typed     |
| +       | Push the '+' signal       |
| s       | Push the 's' command      |
| e       | Evaluate the stack's head |
| d       | Prints the stack          |
| x       | Finishes the program      |

* The command __e__ will evaluate the top of the stack. That means:
    * If the top is '+', it will adds the two subsequent elements, pop them, and push the result into the stack;
    * If the top is 's', it will remove the 's' itself and switch the two following elements;
    * If the top is a number or the stack is empty, nothings happens.

This program has some assumptions:

* Only valid commands are entered by the user
* The numbers are all positive