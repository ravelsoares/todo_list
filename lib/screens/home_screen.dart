import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/components/todo_form.dart';
import 'package:todo_list/models/boxes.dart';
import '../models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final box = Boxes.getTodos();
  List<Todo> todos = [];
  final todoController = TextEditingController();

  void addTodo(String title, String description) {
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
  }

  void openModalBottomSheet(Todo? todo, Function(Todo, String, String) update,
      Function(String, String) add) {
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
        return TodoForm(todo, add, update);
      },
    );
  }

  final appBar = AppBar(
    title: Text('Lista de Tarefas'),
    centerTitle: true,
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      todos = box.values.toList();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: availableHeight,
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text(todos[index].title!),
                      subtitle: Text(todos[index].description!),
                      leading: GestureDetector(
                        onTap: () {
                          setState(() {
                            todos[index].isCheck = !todos[index].isCheck;
                          });
                          box.putAt(index, todos[index]);
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              todos[index].isCheck ? Colors.green : Colors.red,
                          child: Icon(todos[index].isCheck
                              ? Icons.check
                              : Icons.dangerous),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => openModalBottomSheet(
                                  todos[index], updateTodo, addTodo),
                              icon: Icon(Icons.edit, color: Colors.orange),
                            ),
                            IconButton(
                              onPressed: () => deleteTodo(index),
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModalBottomSheet(null, updateTodo, addTodo);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
