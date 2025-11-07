import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_provider/model/todo_model.dart';

class LocalStorage {
  static const String key = 'todos_key';

  static Future<void> saveTodos(List<TodoModel> todos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = todos
        .map(
          (e) => jsonEncode({
            "id": e.id,
            "title": e.title,
            "desc": e.desc,
            "bool": e.isDone,
          }),
        )
        .toList();

    await prefs.setStringList(key, jsonList);
  }

  static Future<List<TodoModel>> loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(key);

    if (jsonList == null) return [];

    return jsonList.map((e) {
      final json = jsonDecode(e);
      return TodoModel(
        id: json['id'],
        title: json['title'] ?? '',
        desc: json['desc'] ?? '',
        isDone: json['isDone'] ?? false,
      );
    }).toList();
  }
}
