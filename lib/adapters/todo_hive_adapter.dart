import 'package:hive/hive.dart';
import 'package:todo_list/models/todo_model.dart';

class TodoHiveAdapter extends TypeAdapter<Todo> {
  @override
  Todo read(BinaryReader reader) {
    return Todo(
      title: reader.readString(),
      description: reader.readString(),
      isCheck: reader.readBool(),
    );
  }

  @override
  final typeId = 0;

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer.writeString(obj.title!);
    writer.writeString(obj.description!);
    writer.writeBool(obj.isCheck);
  }
}
