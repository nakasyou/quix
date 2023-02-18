import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;

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

dynamic getProjectData({required String? id}) async {
  final Client client = new Client();

  Map<dynamic, dynamic> decode({required List<int> body}) {
    return jsonDecode(utf8.decode(body)) as Map;
  }

  Future<dynamic> getToken() async {
    final response =
        await client.get(Uri.https('api.scratch.mit.edu', '/projects/${id}'));

    return decode(body: response.bodyBytes)['project_token'];
  }

  final response = await client.get(Uri.https(
      'projects.scratch.mit.edu', '/${id}', {'token': await getToken()}));
  client.close();

  return decode(body: response.bodyBytes);
}

void main(List<String> args) async {
  final projectUrl = stdin.readLineSync() as String;
  final String? projectId = new RegExp(r'\d+').firstMatch(projectUrl)?.group(0);

  print(await getProjectData(id: projectId));
}
