// class Point {
//       num x;
//       num y;
//       num z;
//     }

// void main(){

//   var point = new Point();
//   print(point.hasCode); // Error 未定义父类的时候，默认继承自Object
// }

// // 2、构造函数
// // 如果只是简单的参数传递，可以在构造函数的参数前加this关键字定义
// // 或者参数后加 : 再赋值
// class Point {
//   num x;
//   num y;
//   num z;

//   Point(this.x, this.y, z) {
//     //第一个值传递给this.x，第二个值传递给this.y
//     this.z = z;
//   }

//   Point.fromeList(var list)
//       : //命名构造函数，格式为Class.name(var param)
//         x = list[0],
//         y = list[1],
//         z = list[2] {
//     //使用冒号初始化变量
//   }

//   //当然，上面句你也可以简写为：
//   //Point.fromeList(var list):this(list[0], list[1], list[2]);

//   String toString() => 'x:$x  y:$y  z:$z';
// }

// void main() {
//   var p1 = new Point(1, 2, 3);
//   var p2 = new Point.fromeList([1, 2, 3]);
//   print(p1); //默认调用toString()函数  // x:1  y:2  z:3
// }


// // // 3、Getters And Setters
// // Getter和Setter是用来读写一个对象属性的方法
// // 每个字段都对应一个隐式的Getter和Setter
// // 但是调用的时候是obj.x，而不是obj.x()

// // 你可以使用get和set关键字扩展功能
// // 如果字段为final或者const的话，那么它只有一个getter方法

// class Rectangle {
//   num left;
//   num top;
//   num width;
//   num height;

// Rectangle(this.left, this.top, this.width, this.height);

// // 两种计算方法
// num get right => left + width;
// set right(num value) => left = value - width;

// num get bottom => top + height;
// set bottom(num value) => top = value - height;

// }

// void main(){
//   var rect = new Rectangle(3,4,20,15);
//   print(rect.left); // 3
//   rect.right =12;
//   print(rect.left); // -8
// }


// // 4、抽象类
// // 使用abstract关键字来定义抽象类，并且抽象类不能被实例化
// // 抽象方法不需要关键字，直接以分号 ; 结束即可

// abstract class Shape {
//     num perimeter();
// }

// // Rectangle 实现了 Shape 接口
// class Rectangle implements Shape{
//   final num height, width;
//   Rectangle(num this.height, num this.width);
//   num perimeter() => 2*height + 2*width;
// }

// class Square extends Rectangle {
//   Square(num size): super(size, size);
// }

// void main(){
//   var rect = new Rectangle(3,4);
//   print (rect.perimeter()); // 14

// }

// 5、工厂构造函数
// Factory单独拿出来讲，因为这不仅仅是构造函数，更是一种模式
// 有时候为了返回一个之前已经创建的缓存对象，原始的构造方法已经不能满足要求
// 那么可以使用工厂模式来定义构造函数
// 并且用关键字new来获取之前已经创建的缓存对象

// class Logger {
//   final String name;
//   bool mute = false;
  
//   // 变量前加下划线表示私有属性
//   static final Map<String, Logger> _cache = <String, Logger>{};
  
//   factory Logger(String name){
//     if(_cache.containsKey(name)){
//       return _cache[name];
//     }else{
//       final logger  = new Logger._internal(name);
//       _cache[name] = logger;
//       return logger;
//     }
//   }

//   Logger._internal(this.name);

//   void log(String msg){
//     if(!mute){
//       print(msg);
//     }
//   }

// }

// void main(List<String> args) {
//   var logger = new Logger('UI');
//  logger.log('12345'); //12345
// }



// // 6、 实现和继承

// //此时abstract关键字可加可不加，如果加上的话Person不能被实例化 
// abstract class Person {
//   String greet(who); //函数可以没有实现语句，名曰隐式接口，前面不用加 abstract 关键字 
// }

// class Student implements Person {
//   String name;
//   Student(this.name);
//   String greet(who) => 'Student: i am $name!';
// }

// class Teacher implements Person{
//   String name;
//   Teacher(this.name);
//   String greet(who) => 'Student: i am $name!';
// }

// void main(List<String> args) {
//   Person student = new Student('a');
//   Person teacher = new Teacher('b');

//   print(student.greet('chen'));
//   print(teacher.greet('chen'));
// }


// 当重写某个函数的时候
// 不用考虑abstract或者接口或者函数实现
// 直接重写，比如greet()函数
// 而且仍然保持多态性

class Person { 
  String name; 
   
  Person(this.name); 
  String greet(who) => 'I am $name!'; 
} 

class Student extends Person {   
  Student(String name):super(name); 
  String greet(who) => 'Student: I am $name!'; 
} 

class Teacher extends Person { 
  Teacher(String name):super(name); 
     String greet(who) => 'Teacher: I am $name!'; 
} 

void main() { 
   Person p1 = new Student('Wang'); 
   Person p2 = new Teacher('Lee'); 
    
   print(p1.greet('Chen')); 
   print(p2.greet('Chen')); 
}