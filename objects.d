import std.stdio;
import std.ascii;
import std.string;

public class Obj {
  override public const string toString(){
    return "#{Obj}";
  }
  
  public const pure bool isReducible(){
    return false;
  }
  
  public const pure Obj reduce(){
    return new Obj();
  }
}

/********************* Values *********************/
class Atom(T) : Obj {
  T value;
  this(){}
  this(T t){
    this.value = t;
  }

  override public const pure Atom reduce(){
    return new Atom(value);
  }
  
  override public const string toString(){
    return format("%s", this.value);
  }
  
  override public const pure bool isReducible(){
    return false;
  }

}

alias Atom!(long) Number;
alias Atom!(bool) Boolean;

/********************* Operations *********************/

// Maths

public class Add : Obj {
  const Obj left;
  const Obj right;
  
  this(const Obj left, const Obj right){
    this.left = left;
    this.right = right;
  }
  
  override public const pure Obj reduce(){
    if(left.isReducible()){
      return new Add(left.reduce(), right);
    } else if(right.isReducible()){
      return new Add(left, right.reduce());
    } else {
      return new Number((cast(Number) left).value + (cast(Number) right).value);
    } 
  }
  
  override public const string toString(){
    return format("%s + %s", left, right);
  }
  
  override public const pure bool isReducible(){
    return true;
  }
}

public class Subtract : Obj {
  const Obj left;
  const Obj right;
  
  this(const Obj left, const Obj right){
    this.left = left;
    this.right = right;
  }
  
  override public const pure Obj reduce(){
    if(left.isReducible()){
      return new Subtract(left.reduce(), right);
    } else if(right.isReducible()){
      return new Subtract(left, right.reduce());
    } else {
      return new Number((cast(Number) left).value - (cast(Number) right).value);
    } 
  }
  
  override public const string toString(){
    return format("%s + %s", left, right);
  }
  
  override public const pure bool isReducible(){
    return true;
  }
}

public class Multiply : Obj {
  const Obj left;
  const Obj right;
  
  this(const Obj left, const Obj right){
    this.left = left;
    this.right = right;
  }
  
  override public const pure Obj reduce(){
    if(left.isReducible()){
      return new Multiply(left.reduce(), right);
    } else if(right.isReducible()){
      return new Multiply(left, right.reduce());
    } else {
      return new Number((cast(Number) left).value * (cast(Number) right).value);
    } 
  }
  
  override public const string toString(){
    return format("%s * %s", left, right);
  }
  
  override public const pure bool isReducible(){
    return true;
  }
}

public class Divide : Obj {
  const Obj left;
  const Obj right;
  
  this(const Obj left, const Obj right){
    this.left = left;
    this.right = right;
  }
  
  override public const pure Obj reduce(){
    if(left.isReducible()){
      return new Divide(left.reduce(), right);
    } else if(right.isReducible()){
      return new Divide(left, right.reduce());
    } else {
      return new Number((cast(Number) left).value / (cast(Number) right).value);
    } 
  }
  
  override public const string toString(){
    return format("%s / %s", left, right);
  }
  
  override public const pure bool isReducible(){
    return true;
  }
}

public class Equals : Obj {
  const Obj left;
  const Obj right;
  
  this(const Obj left, const Obj right){
    this.left = left;
    this.right = right;
  }
  
  override public const pure Obj reduce(){
    if(left.isReducible()){
      return new Equals(left.reduce(), right);
    } else if(right.isReducible()){
      return new Equals(left, right.reduce());
    } else if(cast(Number) left && cast(Number) right){
      return new Boolean((cast(Number) left).value == (cast(Number) right).value);
    } else if(cast(Boolean) left && cast(Boolean) right){
      return new Boolean((cast(Boolean) left).value == (cast(Boolean) right).value);
    } else {
      return new Boolean(false);
    }
  }
  
  override public const string toString(){
    return format("%s = %s", left, right);
  }
  
  override public const pure bool isReducible(){
    return true;
  }
}

public class LessThan : Obj {
  const Obj left;
  const Obj right;
  
  this(const Obj left, const Obj right){
    this.left = left;
    this.right = right;
  }
  
  override public const pure Obj reduce(){
    if(left.isReducible()){
      return new LessThan(left.reduce(), right);
    } else if(right.isReducible()){
      return new LessThan(left, right.reduce());
    } else {
      return new Boolean((cast(Number) left).value < (cast(Number) right).value);
    } 
  }
  
  override public const string toString(){
    return format("%s < %s", left, right);
  }
  
  override public const pure bool isReducible(){
    return true;
  }
}

public class GreaterThan : Obj {
  const Obj left;
  const Obj right;
  
  this(const Obj left, const Obj right){
    this.left = left;
    this.right = right;
  }
  
  override public const pure Obj reduce(){
    if(left.isReducible()){
      return new GreaterThan(left.reduce(), right);
    } else if(right.isReducible()){
      return new GreaterThan(left, right.reduce());
    } else {
      return new Boolean((cast(Number) left).value > (cast(Number) right).value);
    } 
  }
  
  override public const string toString(){
    return format("%s > %s", left, right);
  }
  
  override public const pure bool isReducible(){
    return true;
  }
}

public class And : Obj {
  const Obj left;
  const Obj right;
  
  this(const Obj left, const Obj right){
    this.left = left;
    this.right = right;
  }
  
  override public const pure Obj reduce(){
    if(left.isReducible()){
      return new And(left.reduce(), right);
    } else if(right.isReducible()){
      return new And(left, right.reduce());
    } else {
      return new Boolean((cast(Boolean) left).value && (cast(Boolean) right).value);
    } 
  }
  
  override public const string toString(){
    return format("%s && %s", left, right);
  }
  
  override public const pure bool isReducible(){
    return true;
  }
}

public class Or : Obj {
  const Obj left;
  const Obj right;
  
  this(const Obj left, const Obj right){
    this.left = left;
    this.right = right;
  }
  
  override public const pure Obj reduce(){
    if(left.isReducible()){
      return new Or(left.reduce(), right);
    } else if(right.isReducible()){
      return new Or(left, right.reduce());
    } else {
      return new Boolean((cast(Boolean) left).value || (cast(Boolean) right).value);
    } 
  }
  
  override public const string toString(){
    return format("%s || %s", left, right);
  }
  
  override public const pure bool isReducible(){
    return true;
  }
}

public class Not : Obj {
  const Obj cond;
  
  this(const Obj cond){
    this.cond = cond;
  }
  
  override public const pure Obj reduce(){
    if(cond.isReducible()){
      return new Not(cond.reduce());
    } else {
      return new Boolean(!(cast(Boolean) cond).value);
    } 
  }
  
  override public const string toString(){
    return format("!%s", cond);
  }
  
  override public const pure bool isReducible(){
    return true;
  }
}

