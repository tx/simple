import std.stdio;
import std.ascii;
import std.string;
import objects;
class Machine {
  Obj expression;
  long steps = 0;
  this(Obj expression){
    this.expression = expression;
  }

  public void step() {
    expression = expression.reduce();
    steps++;
  }

  public void run() {
    while(expression.isReducible()){
      writefln("Step %d: %s", steps, expression);
      step();
    }
      writefln("Step %d: %s", steps, expression);
  }
}

int main(char[][] args){
  auto expr1 = new Add(
		       new Multiply(new Number(1), 
				      new Number(2)),
		       new Multiply(new Number(3), 
				      new Number(4))
		     );
  Machine vm = new Machine(expr1);
  vm.run();

  auto expr2 = new LessThan(new Number(5), new Add(new Number(2), new Number(2)));
  Machine vm2 = new Machine(expr2);
  vm2.run();
  
  auto expr3 = new Equals(
			  new Multiply(new Number(3), new Number(5)),
			  new Multiply(new Number(5), new Number(3)));
  Machine vm3 = new Machine(expr3);
  vm3.run();

  return 0;
}
