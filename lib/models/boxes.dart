import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/models/todo_model.dart';

class Boxes{
  static Box<Todo> getTodos () => Hive.box('todos'); 
}