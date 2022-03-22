import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';
import '../models/boxes.dart';

class TodoListController extends ValueNotifier<List<Todo>> {
  TodoListController() : super([]);
  List<Todo> todos = [];
  final box = Boxes.getTodos();

  addTodo(String title, String description, context) {
    final todo = Todo(title: title, description: description);
    final newList = [...value, todo];
    value = List.of(newList);
    notifyListeners();
    box.add(todo);
    Navigator.of(context).pop();
  }

  updateTodo(Todo? todoOld, String title, String description) {
    final newTodo = Todo(title: title, description: description);
    int index;
    value.forEach((element) {
      if (element.title == todoOld?.title &&
          element.description == todoOld?.description) {
        index = value.indexOf(element);
        element.title = title;
        element.description = description;
        box.putAt(index, newTodo);
      }
    });
  }

  deleteTodo(index) {
    value.removeAt(index);
    box.deleteAt(index);
  }
}
