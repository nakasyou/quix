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

dynamic getProjectData({required String id}) async {
  final Client client = new Client();

  Map<String, dynamic> _decode({required List<int> body}) {
    return jsonDecode(utf8.decode(body)) as Map<String, dynamic>;
  }

  try {
    final tokenResponse =
        await client.get(Uri.https('api.scratch.mit.edu', '/projects/${id}'));
    final projectToken =
        _decode(body: tokenResponse.bodyBytes)['project_token'];
    final projectResponse = await client.get(Uri.https(
        'projects.scratch.mit.edu', '/${id}', {'token': projectToken}));

    return _decode(body: projectResponse.bodyBytes);
  } finally {
    client.close();
  }
}

void main(List<String> args) async {
  final projectUrl = stdin.readLineSync()?.trim();
  final String? projectId = projectUrl != null &&
          projectUrl.startsWith('https://scratch.mit.edu/projects/')
      ? new RegExp(r'\d+').firstMatch(projectUrl)?.group(0)
      : null;

  if (projectId != null) {
    print(await getProjectData(id: projectId));
  } else {
    print('[${StdoutColors.red('Exception')}]: 無効なプロジェクト URL');
  }
}

const opcode = {
  "motion":[
    "motion_movesteps",
    "motion_turnright",
    "motion_turnleft",
    "motion_goto",
    "motion_goto_menu",
    "motion_gotoxy",
    "motion_glideto",
    "motion_glideto_menu",
    "motion_glidesecstoxy",
    "motion_pointindirection",
    "motion_pointtowards",
    "motion_pointtowards_menu",
    "motion_changexby",
    "motion_setx",
    "motion_changeyby",
    "motion_sety",
    "motion_ifonedgebounce",
    "motion_setrotationstyle",
    "motion_xposition",
    "motion_yposition",
    "motion_direction"
  ],
  "looks": [
    "looks_sayforsecs",
    "looks_say",
    "looks_thinkforsecs",
    "looks_think",
    "looks_switchcostumeto",
    "looks_costume",
    "looks_nextcostume",
    "looks_switchbackdropto",
    "looks_backdrops",
    "looks_nextbackdrop",
    "looks_changesizeby",
    "looks_setsizeto",
    "looks_changeeffectby",
    "looks_seteffectto",
    "looks_cleargraphiceffects",
    "looks_show",
    "looks_hide",
    "looks_gotofrontback",
    "looks_goforwardbackwardlayers",
    "looks_costumenumbername",
    "looks_backdropnumbername",
    "looks_size"
  ],
  "sound": [
    "sound_playuntildone",
    "sound_sounds_menu",
    "sound_play",
    "sound_sounds_menu",
    "sound_stopallsounds",
    "sound_changeeffectby",
    "sound_seteffectto",
    "sound_cleareffects",
    "sound_changevolumeby",
    "sound_setvolumeto",
    "sound_volume"
  ],
  "event": [
    "event_whenflagclicked",
    "event_whenkeypressed",
    "event_whenthisspriteclicked",
    "event_whenbackdropswitchesto",
    "event_whengreaterthan",
    "event_whenbroadcastreceived",
    "event_broadcast",
    "event_broadcastandwait"
  ],
  "control": [
    "control_wait",
    "control_repeat",
    "control_forever",
    "control_if",
    "control_if_else",
    "control_wait_until",
    "control_repeat_until",
    "control_while",
    "control_for_each",
    "control_stop",
    "control_start_as_clone",
    "control_create_clone_of",
    "control_create_clone_of_menu",
    "control_delete_this_clone"
  ],
  "sensing": [
    "sensing_touchingobject",
    "sensing_touchingobjectmenu",
    "sensing_touchingcolor",
    "sensing_coloristouchingcolor",
    "sensing_distanceto",
    "sensing_distancetomenu",
    "sensing_askandwait",
    "sensing_answer",
    "sensing_keypressed",
    "sensing_keyoptions",
    "sensing_mousedown",
    "sensing_mousex",
    "sensing_mousey",
    "sensing_setdragmode",
    "sensing_loudness",
    "sensing_timer",
    "sensing_resettimer",
    "sensing_of",
    "sensing_of_object_menu",
    "sensing_current",
    "sensing_dayssince2000",
    "sensing_username"
  ],
  "operator": [
    "operator_add",
    "operator_subtract",
    "operator_multiply",
    "operator_divide",
    "operator_random",
    "operator_gt",
    "operator_lt",
    "operator_equals",
    "operator_and",
    "operator_or",
    "operator_not",
    "operator_join",
    "operator_letter_of",
    "operator_length",
    "operator_contains",
    "operator_mod",
    "operator_round",
    "operator_mathop"
  ],
  "data": [
    "data_setvariableto",
    "data_changevariableby",
    "data_showvariable",
    "data_hidevariable"
  ]
};
