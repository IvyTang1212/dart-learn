// // Instance variables
// class Point {
//   num x;
//   num y;
// }
// void main() {
//   var point = Point();
//   point.x = 4; // Use the setter method for x.
//   // assert(point.x == 4); // Use the getter method for x.
//   // assert(point.y == null); // Values default to null.
//   print(point); // Instance of 'Point'
// }




// Constructors
class Point {
  num x, y;

  // Point(num x, num y) {
  //   // There's a better way to do this, stay tuned.
  //   this.x = x;
  //   this.y = y;
  // }

  // Syntactic sugar for setting x and y
  // before the constructor body runs.
  Point(this.x, this.y);
}

void main(){
  var point = new Point(2,3);
  print(point); // Instance of 'Point'
  point.x = 4;
  print(point.x); // 4
}





