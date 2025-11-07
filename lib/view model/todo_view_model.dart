import 'package:flutter/material.dart';
import 'package:todo_app_provider/model/todo_model.dart';
import 'package:todo_app_provider/services/local_storage.dart';
import 'package:uuid/uuid.dart';

class TodoViewModel with ChangeNotifier {
  List<TodoModel> todos = [];

  TodoViewModel() {
    loadTodos();
  }

  void loadTodos() async {
    todos = await LocalStorage.loadTodos();
    notifyListeners();
  }

  void addTodos(String title, String desc) {
    var newTodo = TodoModel(id: const Uuid().v4(), title: title, desc: desc);
    todos.add(newTodo);
    save();
  }

  void deleteTodos(String id) {
    todos.removeWhere((todo) => todo.id == id);
    save();
  }

  void toogleTodos(String id) {
    var index = todos.indexWhere((todo) => todo.id == id);
    todos[index].isDone = !todos[index].isDone;
    save();
  }

  void save() {
    LocalStorage.saveTodos(todos);
    notifyListeners();
  }
}
