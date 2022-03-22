import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/components/todo_form.dart';
import 'package:todo_list/controllers/todo_list_controller.dart';
import 'package:todo_list/models/boxes.dart';
import '../models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = [];
  final box = Boxes.getTodos();
  final todoController = TextEditingController();
  final todoListController = TodoListController();

  /*void addTodo(String title, String description) {
    final todo = Todo(title: title, description: description);
    setState(() {
      todos.add(todo);
      todoController.clear();
    });
    box.add(todo);
    Navigator.of(context).pop();
  }

  void deleteTodo(index) {
    setState(() {
      todos.removeAt(index);
    });
    box.deleteAt(index);
  }

  void updateTodo(Todo? todoOld, String title, String description) {
    final newTodo = Todo(title: title, description: description);
    int index;
    todos.forEach((element) {
      if (element.title == todoOld?.title &&
          element.description == todoOld?.description) {
        index = todos.indexOf(element);
        setState(() {
          element.title = title;
          element.description = description;
        });
        box.putAt(index, newTodo);
      }
    });
    Navigator.of(context).pop();
  }*/

  @override
  void initState() {
    super.initState();
    todos = box.values.toList();
    todoListController.value = [...todos];
    todoListController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: ValueListenableBuilder(
        valueListenable: todoListController,
        builder: (_, List<Todo> value, child) {
          return ListView.builder(
            itemCount: todoListController.value.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  title: Text(value[index].title!),
                  subtitle: Text(value[index].description!),
                  leading: GestureDetector(
                    onTap: () {
                      box.putAt(index, value[index]);
                      value = [...value];
                      /*setState(() {
                        value[index].isCheck = !value[index].isCheck;
                      });*/
                    },
                    child: CircleAvatar(
                      backgroundColor:
                          value[index].isCheck ? Colors.green : Colors.red,
                      child: Icon(
                          value[index].isCheck ? Icons.check : Icons.dangerous),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => openModalBottomSheet(value[index]),
                          icon: Icon(Icons.edit, color: Colors.orange),
                        ),
                        IconButton(
                          onPressed: () => todoListController.deleteTodo(index),
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModalBottomSheet(null);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  final appBar = AppBar(
    title: Text('Lista de Tarefas'),
    centerTitle: true,
  );

  void openModalBottomSheet(Todo? todo) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return TodoForm(todo);
      },
    );
  }
}
