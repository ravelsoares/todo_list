import 'package:flutter/material.dart';
import 'package:todo_list/components/todo_form.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import '../models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoRepository todoRepository = TodoRepository();
  List<Todo> todos = [];
  final todoController = TextEditingController();

  void addTodo(String title, String description) {
    final todo = Todo(title: title, description: description);
    setState(() {
      todos.add(todo);
      todoRepository.saveTodos(todos);
      todoController.clear();
    });
    Navigator.of(context).pop();
  }

  void deleteTodo(index) {
    setState(() {
      todos.removeAt(index);
    });
    todoRepository.saveTodos(todos);
  }

  void updateTodo(Todo? todoOld, String title, String description) {
    todos.forEach((element) {
      if (element.title == todoOld?.title &&
          element.description == todoOld?.description) {
        setState(() {
          element.title = title;
          element.description = description;
        });
      }
    });
    todoRepository.saveTodos(todos);
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
    todoRepository.getTodos().then((value) {
      setState(() {
        todos = value;
      });
    });
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
                          todoRepository.saveTodos(todos);
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
