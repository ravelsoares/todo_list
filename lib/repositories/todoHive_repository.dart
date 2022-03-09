import 'package:hive/hive.dart';
import '../adapters/todo_hive_adapter.dart';
import '../models/todo_model.dart';

class TodoRepository {
  List<Todo> _todos = [];
  get todos => _todos;
  late LazyBox box;

  TodoRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readTodos();
  }

  _openBox() async {
    Hive.registerAdapter(TodoHiveAdapter());
    box = await Hive.openLazyBox<Todo>('todo_list');
  }

  _readTodos() {
    box.keys.forEach((todo) async {
      Todo t = await box.get(Todo);
      todos.add(t);
    });
  }
}
