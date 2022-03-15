import 'package:hive_flutter/hive_flutter.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  bool isCheck;

  Todo({this.title, this.description, this.isCheck = false});

  /*Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        isCheck = json['isCheck'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCheck' : isCheck,
    };
  }*/

}
