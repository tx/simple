import std.stdio;
import std.ascii;
import std.string;

public class Obj {
  public string toString(){
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

  public const pure Number reduce(){
    return new Number(value);
  }

  public string toString(){
    return format("%d", this.value);
  }
  public const pure bool isReducible(){
    return false;
  }

}

/********************* Operations *********************/

public class Add : Obj {
  const Obj left;
  const Obj right;

  this(const Obj left, const Obj right){
    this.left = left;
    this.right = right;
  }

  public const pure Obj reduce(){
    if(left.isReducible()){
      return new Add(left.reduce(), right);
    } else if(right.isReducible()){
      return new Add(left, right.reduce);
    } else {
      return new Number((cast(Number) left).value + (cast(Number) right).value);
    }
  }

  public string toString(){
    return format("%s + %s", left, right);
  }

  public const pure bool isReducible(){
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

  public const pure Obj reduce(){
    if(left.isReducible()){
      return new Subtract(left.reduce(), right);
    } else if(right.isReducible()){
      return new Subtract(left, right.reduce);
    } else {
      return new Number((cast(Number) left).value - (cast(Number) right).value);
    }
  }

  public string toString(){
    return format("%s + %s", left, right);
  }

  public const pure bool isReducible(){
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

 public const pure Obj reduce(){
    if(left.isReducible()){
      return new Multiply(left.reduce(), right);
    } else if(right.isReducible()){
      return new Multiply(left, right.reduce);
    } else {
      return new Number((cast(Number) left).value * (cast(Number) right).value);
    }
  }

  public string toString(){
    return format("%s * %s", left, right);
  }

  public const pure bool isReducible(){
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

  public const pure Obj reduce(){
    if(left.isReducible()){
      return new Divide(left.reduce(), right);
    } else if(right.isReducible()){
      return new Divide(left, right.reduce);
    } else {
      return new Number((cast(Number) left).value / (cast(Number) right).value);
    }
  }

  public string toString(){
    return format("%s + %s", left, right);
  }

  public const pure bool isReducible(){
    return true;
  }
}
