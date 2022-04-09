import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject with ChangeNotifier {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  bool isCheck;

  Todo({this.title, this.description, this.isCheck = false});
}
