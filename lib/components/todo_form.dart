import 'package:flutter/material.dart';
import 'package:todo_list/controllers/todo_list_controller.dart';
import '../models/todo_model.dart';

class TodoForm extends StatefulWidget {
  const TodoForm(this.todo, {Key? key})
      : super(key: key);
  final Todo? todo;
  //final Function(String title, String description) addTodo;
  //final Function(Todo todoOld, String title, String description) updateTodo;

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final todoListController = TodoListController();

  late Todo? todoEdited;
  late bool isEditted;

  _submitForm() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    if (title.isEmpty) return;
    isEditted
        ? todoListController.updateTodo(todoEdited!, title, description)
        : todoListController.addTodo(title, description, context);
  }

  @override
  void initState() {
    super.initState();

    if (widget.todo == null) {
      todoEdited = Todo();
      isEditted = false;
    } else {
      isEditted = true;
      todoEdited = Todo(
          title: widget.todo?.title!, description: widget.todo?.description!);

      _titleController.text = todoEdited?.title ?? "";
      _descriptionController.text = todoEdited?.description ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                onSubmitted: (_) => _submitForm(),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                onSubmitted: (_) => _submitForm(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _submitForm,
                    child: Text(
                      'Salvar',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
