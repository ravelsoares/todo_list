import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart';

class TodoRepository { 
  late SharedPreferences prefs;

  Future<List<Todo>> getTodos() async {
    prefs = await SharedPreferences.getInstance();
    final String jsonString = prefs.getString('todos') ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    List<Todo> todos = jsonDecoded.map((e) => Todo.fromJson(e)).toList();
    return todos;
  }

  void saveTodos(List<Todo> todos) {
    final jsonString = json.encode(todos);
    prefs.setString('todos', jsonString);
  }
}
