// void main() {
// // 1、取整
// // 取整~/操作符之前可能很少看到，代码如下：

// int a = 3;
// int b = 2;
// print(a~/b); //输出1

// }

//   // 2、级联
//   // 当你要对一个单一的对象进行一系列的操作的时候，可以使用级联操作符 ..
// class Person {
//     String name;
//     String country;
//     void setCountry(String country){
//       this.country = country;
//     }
//     String toString() => 'Name:$name\nCountry:$country';
// }

// void main() {

//   Person p = new Person();
//   p..name = 'Wang'
//   ..setCountry('China');
//   print(p);// Name:Wang
//            // Country:China
// }

// // 3、if语句
// void main() {
//   functioni(i) {
//     if (i < 0) {
//       print('i < 0');
//     } else if (i == 0) {
//       print('i = 0');
//     } else {
//       print('i > 0');
//     }
//   }

//   functioni(1); // i>0
// }

// // 4、循环
// void main() {
//   var collection = [0, 1, 2];

//   collection.forEach((x) => print(x)); // 0 1 2
//   for (var x in collection) {
//     print(x); // 0 1 2
//   }
// }
