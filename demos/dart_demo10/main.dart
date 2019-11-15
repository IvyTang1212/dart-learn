import "dart:html";

void main() {
    var text = querySelector("#textId");
    text
    ..text = "Welcome to Dart!"
    ..style.backgroundColor = '#f87c45'
    ..lang = 'EN'
    ..attributes.forEach((k, v) => print('$k: $v'));
}