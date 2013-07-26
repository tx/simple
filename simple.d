import std.stdio;
import std.ascii;
import std.string;
import objects;
class Machine {
  Obj expression;

  this(Obj expression){
    this.expression = expression;
  }

  public void step() {
    expression = expression.reduce();
  }

  public void run() {
    while(expression.isReducible()){
      writefln("%s", expression);
      step();
    }
    writefln("%s", expression);
  }
}

int main(char[][] args){
  Obj expr = new Add(
		       new Multiply(new Number(1), 
				      new Number(2)),
		       new Multiply(new Number(3), 
				      new Number(4))
		     );
  Machine vm = new Machine(expr);
  vm.run();
  return 0;
}
