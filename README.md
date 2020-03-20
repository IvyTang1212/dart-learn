# dart-learn

参考资料：[dart官网](https://dart.dev/codelabs/async-await)
[极客时间学习flutter](https://time.geekbang.org/column/article/106816)

## 1. Dart 的变量与类型

在 Dart 中，我们可以用 var 或者具体的类型来声明一个变量。当使用 var 定义变量时，表示类型是交由编译器推断决定的，当然你也可以用静态类型去定义变量，更清楚地跟编译器表达你的意图，这样编辑器和编译器就能使用这些静态类型，向你提供代码补全或编译警告的提示了。在默认情况下，未初始化的变量的值都是 null，因此我们不用担心无法判定一个传递过来的、未定义变量到底是 undefined，还是烫烫烫而写一堆冗长的判断语句了。Dart 是类型安全的语言，并且所有类型都是对象类型，都继承自顶层类型 Object，因此一切变量的值都是类的实例（即对象），甚至数字、布尔值、函数和 null 也都是继承自 Object 的对象。Dart 内置了一些基本类型，如 num、bool、String、List 和 Map，在不引入其他库的情况下可以使用它们去声明变量。

### 1.1. num、bool 与 String

1. Dart 的数值类型 num，只有两种子类：即 64 位 int 和符合 IEEE 754 标准的 64 位 double。前者代表整数类型，而后者则是浮点数的抽象。在正常情况下，它们的精度与取值范围就足够满足我们的诉求了。

```dart
int x = 1;
int hex = 0xEEADBEEF;
double y = 1.1;
double exponents = 1.13e5;
int roundY = y.round();
```
除了常见的基本运算符，比如 +、-、*、/，以及位运算符外，你还能使用继承自 num 的 abs()、round() 等方法，来实现求绝对值、取整的功能。
如果还有其他高级运算方法的需求 num 无法满足，你可以试用一下 dart:math 库。这个库提供了诸如三角函数、指数、对数、平方根等高级函数。

2. Dart 使用了一种名为 bool 的类型。在 Dart 里，只有两个对象具有 bool 类型：true 和 false，它们都是编译时常量。

- Dart 是类型安全的，因此我们不能使用 if(nonbooleanValue) 或 assert(nonbooleanValue) 之类的在 JavaScript 可以正常工作的代码，而应该显式地检查值。如下所示，检查变量是否为 0，在 Dart 中需要显示地与 0 做比较：

```dart

// 检查是否为0.
var number = 0;
assert(number == 0);
// assert(number); 错误
```

3. String 由 UTF-16 的字符串组成。和 JavaScript 一样，构造字符串字面量时既能使用单引号也能使用双引号，还能在字符串中嵌入变量或表达式：你可以使用 ${express} 把一个表达式的值放进字符串。而如果是一个标识符，你可以省略{}。

```dart
var s = 'cat';
var s1 = 'this is a uppercased string: ${s.toUpperCase()}';
```

### 1.2. List 与 Map

其他编程语言中常见的数组和字典类型，在 Dart 中的对应实现是 List 和 Map，统称为集合类型。它们的声明和使用很简单，和 JavaScript 中的用法类似。

```dart

var arr1 = ["Tom", "Andy", "Jack"];
var arr2 = List.of([1,2,3]);
arr2.add(499);
arr2.forEach((v) => print('${v}'));
  
var map1 = {"name": "Tom", 'sex': 'male'}; 
var map2 = new Map();
map2['name'] = 'Tom';
map2['sex'] = 'male';
map2.forEach((k,v) => print('${k}: ${v}')); 
```

容器里的元素也需要有类型，比如上述代码中 arr2 的类型是 List，map2 的类型则为 Map。Dart 会自动根据上下文进行类型推断，所以你后续往容器内添加的元素也必须遵照这一类型。如果编译器自动推断的类型不符合预期，我们当然可以在声明时显式地把类型标记出来，不仅可以让代码提示更友好一些，更重要的是可以让静态分析器帮忙检查字面量中的错误，解除类型不匹配带来的安全隐患或是 Bug。以上述代码为例，如果往 arr2 集合中添加一个浮点数 arr2.add(1.1)，尽管语义上合法，但编译器会提示类型不匹配，从而导致编译失败。和 Java 语言类似，在初始化集合实例对象时，你可以为它的类型添加约束，也可以用于后续判断集合类型。


```dart
// 增加了类型约束后
var arr1 = <String>['Tom', 'Andy', 'Jack'];
var arr2 = new List<int>.of([1,2,3]);
arr2.add(499);
arr2.forEach((v) => print('${v}'));
print(arr2 is List<int>); // true

var map1 = <String, String>{'name': 'Tom','sex': 'male',};
var map2 = new Map<String, String>();
map2['name'] = 'Tom';
map2['sex'] = 'male';
map2.forEach((k,v) => print('${k}: ${v}')); 
print(map2 is Map<String, String>); // true
```

### 1.3. 常量定义

如果你想定义不可变的变量，则需要在定义变量前加上 final 或 const 关键字：const，表示变量在编译期间即能确定的值；final 则不太一样，用它定义的变量可以在运行时确定值，而一旦确定后就不可再变。声明 const 常量与 final 常量的典型例子，如下所示：

```dart

final name = 'Andy';
const count = 3;

var x = 70;  
var y = 30;
final z = x / y;
```

可以看到，const 适用于定义编译常量（字面量固定值）的场景，而 final 适用于定义运行时常量的场景。


## 2. 函数

在 Dart 中，所有类型都是对象类型，函数也是对象，它的类型叫作 Function。这意味着函数也可以被定义为变量，甚至可以被定义为参数传递给另一个函数。

```dart

bool isZero(int number) { //判断整数是否为0
  return number == 0; 
}

void printInfo(int number,Function check) { //用check函数来判断整数是否为0
  print("$number is Zero: ${check(number)}");
}

Function f = isZero;
int x = 10;
int y = 0;
printInfo(x,f);  // 输出 10 is Zero: false
printInfo(y,f);  // 输出 0 is Zero: true
```

还可以像 JavaScript 语言那样用箭头函数来简化这个函数：

```dart

bool isZero(int number) => number == 0;

void printInfo(int number,Function check) => print("$number is Zero: ${check(number)}");
```

在声明函数时：给参数增加{}，以 paramName: value 的方式指定调用参数，也就是可选命名参数；给参数增加 []，则意味着这些参数是可以忽略的，也就是可选参数。

在使用这两种方式定义函数时，我们还可以在参数未传递时设置默认值。我以一个只有两个参数的简单函数为例，来和你说明这两种方式的具体用法

```dart

//要达到可选命名参数的用法，那就在定义函数的时候给参数加上 {}
void enable1Flags({bool bold, bool hidden}) => print("$bold , $hidden");

//定义可选命名参数时增加默认值
void enable2Flags({bool bold = true, bool hidden = false}) => print("$bold ,$hidden");

//可忽略的参数在函数定义时用[]符号指定
void enable3Flags(bool bold, [bool hidden]) => print("$bold ,$hidden");

//定义可忽略参数时增加默认值
void enable4Flags(bool bold, [bool hidden = false]) => print("$bold ,$hidden");

//可选命名参数函数调用
enable1Flags(bold: true, hidden: false); //true, false
enable1Flags(bold: true); //true, null
enable2Flags(bold: false); //false, false

//可忽略参数函数调用
enable3Flags(true, false); //true, false
enable3Flags(true,); //true, null
enable4Flags(true); //true, false
enable4Flags(true,true); // true, true
```

## 3. 类

类是特定类型的数据和方法的集合，也是创建对象的模板。与其他语言一样，Dart 为类概念提供了内置支持。类的定义及初始化

### 3.1. 类的定义及初始化

Dart 是面向对象的语言，每个对象都是一个类的实例，都继承自顶层类型 Object。在 Dart 中，实例变量与实例方法、类变量与类方法的声明与 Java 类似，我就不再过多展开了。值得一提的是，Dart 中并没有 public、protected、private 这些关键字，我们只要在声明变量与方法时，在前面加上“_”即可作为 private 方法使用。如果不加“_”，则默认为 public。不过，“_”的限制范围并不是类访问级别的，而是库访问级别。

```dart

class Point {
  num x, y;
  static num factor = 0;
  //语法糖，等同于在函数体内：this.x = x;this.y = y;
  Point(this.x,this.y);
  void printInfo() => print('($x, $y)');
  static void printZValue() => print('$factor');
}

var p = new Point(100,200); // new 关键字可以省略
p.printInfo();  // 输出(100, 200);
Point.factor = 10;
Point.printZValue(); // 输出10
```

有时候类的实例化需要根据参数提供多种初始化方式。除了可选命名参数和可选参数之外，Dart 还提供了命名构造函数的方式，使得类的实例化过程语义更清晰。此外，与 C++ 类似，Dart 支持初始化列表。在构造函数的函数体真正执行之前，你还有机会给实例变量赋值，甚至重定向至另一个构造函数。如下面实例所示，Point 类中有两个构造函数 Point.bottom 与 Point，其中：Point.bottom 将其成员变量的初始化重定向到了 Point 中，而 Point 则在初始化列表中为 z 赋上了默认值 0。

```dart

class Point {
  num x, y, z;
  Point(this.x, this.y) : z = 0; // 初始化变量z
  Point.bottom(num x) : this(x, 0); // 重定向构造函数
  void printInfo() => print('($x,$y,$z)');
}

var p = Point.bottom(100);
p.printInfo(); // 输出(100,0,0)
```

### 3.2. 复用

继承父类意味着，子类由父类派生，会自动获取父类的成员变量和方法实现，子类可以根据需要覆写构造函数及父类方法；接口实现则意味着，子类获取到的仅仅是接口的成员变量符号和方法符号，需要重新实现成员变量，以及方法的声明和初始化，否则编译器会报错。

```dart
// Vector 通过继承 Point 的方式增加了成员变量，并覆写了 printInfo 的实现；而 Coordinate，则通过接口实现的方式，覆写了 Point 的变量定义及函数实现：
// 子类 Coordinate 采用接口实现的方式，仅仅是获取到了父类 Point 的一个“空壳子”，只能从语义层面当成接口 Point 来用，但并不能复用 Point 的原有实现。

class Point {
  num x = 0, y = 0;
  void printInfo() => print('($x,$y)');
}

//Vector继承自Point
class Vector extends Point{
  num z = 0;
  @override
  void printInfo() => print('($x,$y,$z)'); //覆写了printInfo实现
}

//Coordinate是对Point的接口实现
class Coordinate implements Point {
  num x = 0, y = 0; //成员变量需要重新声明
  void printInfo() => print('($x,$y)'); //成员函数需要重新声明实现
}

var xxx = Vector(); 
xxx
  ..x = 1
  ..y = 2
  ..z = 3; //级联运算符，等同于xxx.x=1; xxx.y=2;xxx.z=3;
xxx.printInfo(); //输出(1,2,3)

var yyy = Coordinate();
yyy
  ..x = 1
  ..y = 2; //级联运算符，等同于yyy.x=1; yyy.y=2;
yyy.printInfo(); //输出(1,2)
print (yyy is Point); //true
print(yyy is Coordinate); //true
```

除了继承和接口实现之外，Dart 还提供了另一种机制来实现类的复用，即“混入”（Mixin）。混入鼓励代码重用，可以被视为具有实现方法的接口。这样一来，不仅可以解决 Dart 缺少对多重继承的支持问题，还能够避免由于多重继承可能导致的歧义（菱形问题）。


要使用混入，只需要 with 关键字即可。我们来试着改造 Coordinate 的实现，把类中的变量声明和函数实现全部删掉：

```dart

class Coordinate with Point {
}

var yyy = Coordinate();
print (yyy is Point); //true
print(yyy is Coordinate); //true
```

## 4. 运算符

Dart 和绝大部分编程语言的运算符一样，所以你可以用熟悉的方式去执行程序代码运算。不过，Dart 多了几个额外的运算符，用于简化处理变量实例缺失（即 null）的情况。

- ?. 运算符：假设 Point 类有 printInfo() 方法，p 是 Point 的一个可能为 null 的实例。那么，p 调用成员方法的安全代码，可以简化为 p?.printInfo() ，表示 p 为 null 的时候跳过，避免抛出异常。

- ??= 运算符：如果 a 为 null，则给 a 赋值 value，否则跳过。这种用默认值兜底的赋值语句在 Dart 中我们可以用 a ??= value 表示。

- ?? 运算符：如果 a 不为 null，返回 a 的值，否则返回 b。在 Java 或者 C++ 中，我们需要通过三元表达式 (a != null)? a : b 来实现这种情况。而在 Dart 中，这类代码可以简化为 a ?? b。


```dart

class Vector {
  num x, y;
  Vector(this.x, this.y);
  // 自定义相加运算符，实现向量相加
  Vector operator +(Vector v) =>  Vector(x + v.x, y + v.y);
  // 覆写相等运算符，判断向量相等
  bool operator == (dynamic v) => x == v.x && y == v.y;
}

final x = Vector(3, 3);
final y = Vector(2, 2);
final z = Vector(1, 1);
print(x == (y + z)); //  输出true

```

operator 是 Dart 的关键字，与运算符一起使用，表示一个类成员运算符函数。在理解时，我们应该把 operator 和运算符作为整体，看作是一个成员函数名。

## 5. Async

避免回调地狱,让你的代码更可读的通过使用async和await。

```dart
const oneSecond = Duration(seconds: 1);
// ···
Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print(message);
}

```

等同于以下代码

```dart
Future<void> printWithDelay(String message) {
  return Future.delayed(oneSecond).then((_) {
    print(message);
  });
}
```

async 和 await 使异步代码容易阅读.

```dart
Future<void> createDescriptions(Iterable<String> objects) async {
  for (var object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print(
            'File for $object already exists. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}
```

还可以使用async* , 一个不错的方式来构建streams。  

```dart
Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (var object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} flies by $object';
  }
}
```

## 6. Exceptions

引发一个异常,使用 throw:  

```dart
if (astronauts == 0) {
  throw StateError('No astronauts.');
}
```

捕获到一个异常,使用 a try statement with on or catch (or both):  

```dart
try {
  for (var object in flybyObjects) {
    var description = await File('$object.txt').readAsString();
    print(description);
  }
} on IOException catch (e) {
  print('Could not describe object: $e');
} finally {
  flybyObjects.clear();
}
```

