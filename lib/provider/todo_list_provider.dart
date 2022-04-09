import 'package:flutter/cupertino.dart';
import 'package:todo_list/models/boxes.dart';
import '../models/todo_model.dart';

class TodoListProvider with ChangeNotifier {
  final box = Boxes.getTodos();

  List<Todo> _todoList = Boxes.getTodos().values.toList();

  List<Todo> get todoList => [..._todoList];

  addTodo(Todo todo) {
    _todoList.add(todo);
    box.add(todo);
    notifyListeners();
  }

  void updateTodo(Todo? todoOld, Todo newTodo) {
    int index;
    _todoList.forEach((element) {
      if (element.title == todoOld?.title &&
          element.description == todoOld?.description) {
        index = _todoList.indexOf(element);
        element.title = newTodo.title;
        element.description = newTodo.description;
        box.putAt(index, newTodo);
      }
    });
    notifyListeners();
  }

  deleteTodo(int index) {
    _todoList.removeAt(index);
    box.deleteAt(index);
    notifyListeners();
  }
}
