// // io 文件操作

// import 'dart:io';

// void main(){
//   fun1();
//   fun2();
//   fun3();
// }

// void fun1() {
//   var directory = new Directory("temp1");
//   directory.createSync();
//   //absolute返回path为绝对路径的Directory对象
//   print(directory.absolute.path); // /Users/tangting006/tt/summary/dart-demo/temp1
// }

// void fun2() {
//   new Directory("temp2").create().then(
//       (dir) => print(dir.absolute.path) // /Users/tangting006/tt/summary/dart-demo/temp2
//   );
// }

// //Dart中变量的类型可以省略，包括函数
// fun3() async {
//   var directory = await new Directory("temp3").create();
//   print(directory.absolute.path); // /Users/tangting006/tt/summary/dart-demo/temp3
// }




// // 1、目录
// 创建指定目录
// 重命名目录
// 删除目录
// 创建临时文件夹
// 获取父目录
// 列出目录的内容
// import 'dart:io';
// import 'dart:async';

// void main() {
//   handleDir();
// }

// handleDir() async {
//   //可以用Platform.pathSeparator代替路径中的分隔符"/"
//   //效果和"dir/subdir"一样
//   //如果有子文件夹，需要设置recursive: true
//   var directory = await new Directory("dir${Platform.pathSeparator}one").create(recursive: true);

//   assert(await directory.exists() == true);
//   //输出绝对路径
//   print("Path: ${directory.absolute.path}");

//   //重命名文件夹
//   directory = await directory.rename("dir/subdir");
//   print("Path: ${directory.absolute.path}\n");

//   //创建临时文件夹
//   //参数是文件夹的前缀，后面会自动添加随机字符串
//   //参数可以是空参数
//   var tempDir = await Directory.systemTemp.createTemp('temp_dir');
//   assert(await tempDir.exists() == true);
//   print("Temp Path: ${tempDir.path}");

//   //返回上一级文件夹
//   var parentDir = tempDir.parent;
//   print("Parent Path: ${parentDir.path}");

//   //列出所有文件，不包括链接和子文件夹
//   Stream<FileSystemEntity> entityList = parentDir .list(recursive: false, followLinks: false);
//   await for(FileSystemEntity entity in entityList) {

//     //文件、目录和链接都继承自FileSystemEntity
//     //FileSystemEntity.type静态函数返回值为FileSystemEntityType
//     //FileSystemEntityType有三个常量：
//     //Directory、FILE、LINK、NOT_FOUND
//     //FileSystemEntity.isFile .isLink .isDerectory可用于判断类型
//     print(entity.path);
//   }

//   //删除目录
//   await tempDir.delete();
//   assert(await tempDir.exists() == false);
// }




// 2、文件
// 概要：

// 创建文件
// 将string写入文件
// 读取文件到String
// 以行为单位读取文件到List<String>
// 将bytes写入文件
// 读取文件到bytes
// 数据流Stream写入文件
// 数据流Stream读取文件
// 删除文件

// import 'dart:io';
// import 'dart:convert';
// import 'dart:async';

// void main() {
//   //文件操作演示
//   handleFile();
// }

// handleFile() async {
//   //提示：pub中有ini库可以方便的对ini文件进行解析
//   File file = new File("default.ini");

//   //如果文件存在，删除
//   if(!await file.exists()) {
//     //创建文件
//     file = await file.create();
//   }

//   print(file);

//   //直接调用File的writeAs函数时
//   //默认文件打开方式为WRITE:如果文件存在，会将原来的内容覆盖
//   //如果不存在，则创建文件

//   //写入String，默认将字符串以UTF8进行编码
//   file = await file.writeAsString("[General]\nCode=UTF8");
//   //readAsString读取文件，并返回字符串
//   //默认返回的String编码为UTF8
//   //相关的编解码器在dart:convert包中
//   //包括以下编解码器：ASCII、LANTI1、BASE64、UTF8、SYSTEM_ENCODING
//   //SYSTEM_ENCODING可以自动检测并返回当前系统编码
//   print("\nRead Strings:\n${await file.readAsString()}");

//   //以行为单位读取文件到List<String>，默认为UTF8编码
//   print("\nRead Lines:");
//   List<String> lines = await file.readAsLines();
//   lines.forEach(
//       (String line) => print(line)
//   );

//   //如果是以字节方式写入文件
//   //建议设置好编码，避免汉字、特殊符号等字符出现乱码、或无法读取
//   //将字符串编码为Utf8格式，然后写入字节
//   file = await file.writeAsBytes(UTF8.encode("编码=UTF8"));
//   //读取字节，并用Utf8解码
//   print("\nRead Bytes:");
//   print(UTF8.decode(await file.readAsBytes()));

// //  //删除文件
// //  await file.delete();
// }





// 3、链接
// 概要：

// 创建链接
// 获取链接文件的路径
// 获取链接指向的目标
// 重命名链接
// 删除链接

// import 'dart:io';
// import 'dart:async';

// void main() {
//   handleLink();
// }

// handleLink() async {
//   //创建文件夹
//   var dir = await new Directory("linkDir").create();
//   //创建链接
//   //Link的参数为该链接的Path，create的参数为链接的目标文件夹
//   var link = await new Link("shortcut").create("linkDir");

//   //输出链接文件的路径
//   print(link.path);
//   //输出链接目标的路径
//   print(await link.target());

//   //重命名链接
//   link = await link.rename("link");
//   print(link.path);

//   //删除链接
//   //link.delete();
// }




// 4、数据流（读写文件实例：复制文件）

