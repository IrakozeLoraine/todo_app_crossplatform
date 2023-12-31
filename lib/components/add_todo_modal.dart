import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_crossplatform/models/todo.dart';
import 'package:todo_app_crossplatform/providers/todo_provider.dart';
import 'package:uuid/uuid.dart';

class AddTaskModel extends StatefulWidget {
  const AddTaskModel({super.key});

  @override
  State<AddTaskModel> createState() =>
      _AddTaskModelState();
}

class _AddTaskModelState extends State<AddTaskModel> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    final snackBar = SnackBar(
      content: const Text('Todo added successfully!'),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final failedSnackBar = SnackBar(
      content: const Text('Failed!'),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 40, left: 40),
      child: Column(children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: "Title",
          ),
          style: const TextStyle(fontSize: 12),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: "Description"),
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () async {
              final String title = titleController.text.trim();
              final String description = descriptionController.text.trim();

              if (title.isNotEmpty && description.isNotEmpty) {
                final Todo newTodo = Todo(
                  id: Uuid().v4(),
                  title: title,
                  description: description,
                  completed: false,
                  created: DateTime.now().toString(),
                  lastUpdated: DateTime.now().toString(),
                );
                
                titleController.clear();
                descriptionController.clear();

                int response = await Provider.of<TodoProvider>(context, listen: false).addTodo(newTodo);
               
                if (response == 201) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(failedSnackBar);
                }

    

                Navigator.of(context).pop();
              }
            },
            child: const Text("Add"),
          ),
        ),
      ]),
    );
  }
}
