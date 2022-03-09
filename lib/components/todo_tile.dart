import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
      {required this.title,
      required this.subtitle,
      required this.editTodo,
      required this.deleteTodo,
      Key? key})
      : super(key: key);

  final String title;
  final String subtitle;
  final void Function(int index) deleteTodo;
  final void Function(int index) editTodo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200, //availableHeight,
            child: ListView.builder(
              itemCount: 10, //tarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(title),
                  subtitle: Text(subtitle),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => deleteTodo(index),
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => editTodo,
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
