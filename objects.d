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

public class Number : Obj {
  const long value;
  
  this(long value){
    this.value = value;
  }
  
  override public const pure Number reduce(){
    return this;
  }
  
  override public const string toString(){
    return format("%d", this.value);
  }
  
  override public const pure bool isReducible(){
    return false;
  }
  
}

public class Boolean : Obj {
  const bool value;
  
  this(bool value){
    this.value = value;
  }
  
  override public const pure bool isReducible(){
    return false;
  }
  
  override public const pure Boolean reduce(){
    return this;
  }
  
  override public const string toString(){
    return format("%s", value);
  }
}

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
      return new Add(left, right.reduce);
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
      return new Subtract(left, right.reduce);
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
      return new Multiply(left, right.reduce);
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
      return new Divide(left, right.reduce);
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
