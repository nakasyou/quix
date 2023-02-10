import 'dart:convert';
import 'dart:io';

class StdoutColors {
  static final dynamic Function(dynamic) _selectColor =
      (col) => (text) => '\u001b[${col}m${text}\u001b[0m';

  static final dynamic black = _selectColor('30');
  static final dynamic red = _selectColor('31');
  static final dynamic green = _selectColor('32');
  static final dynamic yellow = _selectColor('33');
  static final dynamic blue = _selectColor('34');
  static final dynamic magenta = _selectColor('35');
  static final dynamic cyan = _selectColor('36');
  static final dynamic white = _selectColor('37');
}

void main(List<String> args) async {
  final projectUrl = stdin.readLineSync() as String;
  final String? projectId = new RegExp(r'\d+').firstMatch(projectUrl)?.group(0);
}
