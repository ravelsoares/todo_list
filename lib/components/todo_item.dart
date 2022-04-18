import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/provider/todo_list_provider.dart';

class TodoItem extends StatelessWidget {
  final Function(Todo todo) openModal;
  final Todo todo;
  final int index;
  const TodoItem(
      {required this.todo,
      required this.index,
      required this.openModal,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(todo.title!),
        subtitle: Text(todo.description!),
        leading: GestureDetector(
          onTap: () {
            Provider.of<TodoListProvider>(context, listen: false)
                .todoCheck(todo);
          },
          child: Consumer<Todo>(
            builder: (_, todoItem, __) => CircleAvatar(
              backgroundColor: todoItem.isCheck ? Colors.green : Colors.red,
              child: Icon(todoItem.isCheck ? Icons.check : Icons.dangerous),
              foregroundColor: Colors.white,
            ),
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  openModal(todo);
                },
                icon: const Icon(Icons.edit, color: Colors.orange),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Tem Certeza ?'),
                        content: const Text(
                            'Se você excluir não terá como recuperar!'),
                        actions: [
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Excluir'),
                            onPressed: () {
                              Provider.of<TodoListProvider>(context,
                                      listen: false)
                                  .deleteTodo(index);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
