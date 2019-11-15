// // 正则
// // 1、基本
// String str = '010-88888888';

// void main(){
//   print("${new RegExp(r"^0[1-9]\d-\d{8}$").hasMatch(str)}");
// }


// // 2.1、提取中文字符
// void main() {
//   String str = "Dart中文社区";
//   RegExp reg = new RegExp(r"[\u4e00-\u9fa5]+");
//   Iterable<Match> matches = reg.allMatches(str);

//   for (Match m in matches) {
//     print(m.group(0)); // 中文社区
//   }
// }



// // 2.2 网络小说内容页采集（提取）
// import 'dart:io';

// void main() {
//   new HttpClient().getUrl(Uri.parse("http://www.biquge.la/book/32/24387.html"))
//   .then((HttpClientRequest request) => request.close())
//   .then((HttpClientResponse response) {
//       response.transform(new SystemEncoding().decoder).listen((requestText) {
//         //此时已经请求到HTML格式网页数据
//         //print(requestText);

//         //不区分大小写，匹配在<div class="con_top">标签中的标题
//         //因为匹配的的数据中有需要转义的""双引号，所以字符串没有用"r"修饰符
//         //提取的是书名，定位唯一位置，因此没有使用allMatches函数
//         Match match = new RegExp("booktitle\\s+=\\s+"(.*)".*readtitle\\s+=\\s+"\\s+(.*)"").firstMatch(requestText);

//         if(match != null) {
//           //分组1为书名，分组2为章节名
//           print("书名：${match.group(1)}\n章节：${match.group(2)}");
//         }
//       });
//   });
// }


// 3、替换

void main() {
  String str = "dart and flutter(sky)";
  print(str.replaceAllMapped(new RegExp(r"\b\w"), (match)=>match.group(0).toUpperCase())); // Dart And Flutter(Sky)
}