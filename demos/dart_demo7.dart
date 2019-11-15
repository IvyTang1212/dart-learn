// 容器

// // 1、StringBuffer
// // 先声明一下，StringBuffer并不是容器
// // 但还是放到了这一章
// // 按照官方的说法，StringBuffer可以特别高效的构建多个字符串
// // 另外，以前的书中用的add方法已经改为write
// void main() {
//   StringBuffer sb = new StringBuffer();

//   sb.write("Use a StringBuffer ");
//   sb.writeAll(['for ', 'efficient ', 'string ', 'creation ']);
//   sb..write('if you are ')..write('building lots of string.');

//   print(sb.toString()); // Use a StringBuffer for efficient string creation if you are building lots of string.
// }

// sb.clear();

// // 2、List
// // 列表，也就是常说的数组
// // 常见的添加、索引、删除等方法如下

// // 使用List的构造函数，也可以添加int参数，表示List固定长度
// void main(List<String> args) {
//   var vegetables = new List();

// // 或者简单的用List来赋值
//   var fruits = ['apples', 'oranges'];

// // 添加元素
//   fruits.add('kiwis');

// // 添加多个元素
//   fruits.addAll(['grapes', 'bananas']);

// // 获取List的长度
//   print(fruits.length); // 5

// // 利用索引获取元素
//   print(fruits[0]); // apples

// // 查找某个元素的索引号
//   print(fruits.indexOf('apples')); // 0

// // 利用索引号删除某个元素
//   var appleIndex = fruits.indexOf('apples');
//   fruits.removeAt(appleIndex);
//   print(fruits.length); // 4

// // 删除所有的元素
//   fruits.clear();
//   print(fruits.length); // 0
// }

// // sort 排序
// void main() {
//   var fruits = ['bananas', 'apples', 'oranges'];

//   fruits.sort((a, b) => a.compareTo(b));
//   print(fruits[0]); // apples
// }

// 3、Set
// 集合在Dart中无序，并且每个元素具有唯一性
// 因为它是无序的，因此你不能像List那样用索引来访问元素

// void main() {
//   var ingredients = new Set();

//   ingredients.addAll(['gold', 'titanium', 'xenon']);
//   assert(ingredients.length == 3);

// // 添加已存在的元素无效
//   ingredients.add('gold');
//   assert(ingredients.length == 3);

// // 删除元素
//   ingredients.remove('gold');
//   assert(ingredients.length == 2);

// // 检查在Set中是否包含某个元素
//   assert(ingredients.contains('titanium'));

// // 检查在Set中是否包含多个元素
//   assert(ingredients.containsAll(['titanium', 'xenon']));
//   ingredients.addAll(['gold', 'titanium', 'xenon']);

// // 获取两个集合的交集
//   var nobleGases = new Set.from(['xenon', 'argon']);
//   var intersection = ingredients.intersection(nobleGases);
//   assert(intersection.length == 1);
//   assert(intersection.contains('xenon'));

// // 检查一个Set是否是另一个Set的子集
//   var allElements = [
//     'hydrogen',
//     'helium',
//     'lithium',
//     'beryllium',
//     'gold',
//     'titanium',
//     'xenon'
//   ];
//   // assert(ingredients.isSubsetOf(allElements)); // isSubsetOf这个方法没有？？？The method 'isSubsetOf' isn't defined for the class 'dart.core::Set<dynamic>'.

// }

// 4、Map 无序的键值对容器
// void main(){
//   // 指定键值对的参数类型
//   var nobleGases = new Map<int, String>();

//   // Map的赋值，中括号中是Key，这里可不是数组
//   nobleGases[54] = 'dart';

//   //Map中的键值对是唯一的
//   //同Set不同，第二次输入的Key如果存在，Value会覆盖之前的数据
//   nobleGases[54] = 'xenon';
// assert(nobleGases[54] == 'xenon');

// // 检索Map是否含有某Key
// assert(nobleGases.containsKey(54));

// //删除某个键值对
// // nobleGases.remove(54);
// // assert(!nobleGases.containsKey(54));
// print(nobleGases); //{54: xenon}
// }

//你可以用getKeys和getValues获取所有Key或者所有Values的迭代器

// 5、迭代
// Set、List、Map都继承自Iterable，是可以迭代的

// //如果迭代的对象是容器，那么可以使用forEach或者for-in
void main() {
  var collection = [0, 1, 2];

  collection.forEach((x) => print(x)); //forEach的参数为Function // 0 1 2 

  for (var x in collection) { // 0 1 2 
    print(x);
  }
}
