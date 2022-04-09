import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/todo_form.dart';
import 'package:todo_list/components/todo_item.dart';
import 'package:todo_list/provider/todo_list_provider.dart';
import '../models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todoController = TextEditingController();

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
    final List<Todo> todos = Provider.of<TodoListProvider>(context).todoList;
    return Scaffold(
      appBar: appBar,
      body: Consumer(
        builder: (_, todoList, __) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
              value: todos[index],
              child: TodoItem(
                todo: todos[index],
                index: index,
                openModal: openModalBottomSheet,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModalBottomSheet(null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  final appBar = AppBar(
    title: const Text('Lista de Tarefas'),
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
