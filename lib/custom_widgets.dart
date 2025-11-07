import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/view%20model/todo_view_model.dart';

class Widgets {
  static void customCard(
    BuildContext context,
    String title,
    String description,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('TODO:'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(title),
              SizedBox(height: 10),
              Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(description),
              SizedBox(height: 10),
            ],
          ),
          actions: [
            ElevatedButton(onPressed: () {}, child: Text("BACK")),
            ElevatedButton(onPressed: () {}, child: Text("EDIT")),
          ],
          actionsAlignment: MainAxisAlignment.center,
          constraints: BoxConstraints(minHeight: 300, minWidth: 300),
        );
      },
    );
  }

  static void customDialog(
    BuildContext context,
    TextEditingController title,
    TextEditingController description,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Add Todo and Description'),
          content: Column(
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'Enter Title (_)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: description,
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            Consumer<TodoViewModel>(
              builder: (context, provider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('BACK'),
                    ),

                    SizedBox(width: 10),

                    ElevatedButton(
                      onPressed: () {
                        if (title.text.isNotEmpty &&
                            description.text.isNotEmpty) {
                          provider.addTodos(title.text, description.text);
                        }
                        if (title.text.isEmpty && description.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Title and Description were Empty'),
                            ),
                          );
                        }

                        title.clear();
                        description.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('ADD'),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
