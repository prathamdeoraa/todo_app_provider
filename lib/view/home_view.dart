import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/view%20model/darklight_mode_provider.dart';
import 'package:todo_app_provider/view%20model/todo_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _desc.dispose();
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TODO APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            // color: Colors.white,
          ),
        ),

        actions: [
          Consumer<DarklightModeProvider>(
            builder: (context, provider, child) {
              return Switch(
                value: provider.isDark,
                activeThumbColor: Colors.black,
                activeTrackColor: Colors.lightBlue,
                onChanged: (bool? newval) {
                  provider.setTheme();
                },
              );
            },
          ),
          SizedBox(width: 10),
        ],
        centerTitle: true,
        // backgroundColor: provider.isDark
        //     ? Colors.teal.shade800
        //     : Colors.teal.shade200,
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/image2.jpg', fit: BoxFit.fitHeight),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<TodoViewModel>(
                    builder: (context, provider, child) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: provider.todos.length,
                          itemBuilder: (context, index) {
                            final todo = provider.todos[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: ListTile(
                                leading: Checkbox(
                                  value: todo.isDone,
                                  onChanged: (newval) =>
                                      provider.toogleTodos(todo.id),
                                ),
                                title: Text(todo.title.toUpperCase()),
                                subtitle: Text(todo.desc),
                                trailing: IconButton(
                                  onPressed: () => provider.deleteTodos(todo.id),
                                  icon: Icon(Icons.delete),
                                ),
                                onTap: () => Widgets.customCard(
                                  context,
                                  todo.title,
                                  todo.desc,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Widgets.customDialog(context, _title, _desc);
        },
        child: Icon(Icons.add, color: Colors.purpleAccent.shade200),
      ),
    );
  }
}

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
              Text('Title',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text(title),
              SizedBox(height: 10,),
              Text('Description',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(description),
              SizedBox(height: 10,),
            ],
          ),
          actions: [
            ElevatedButton(onPressed: (){}, child: Text("EDIT")),
            ElevatedButton(onPressed: (){}, child: Text("BACK")),
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
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('BACK'),
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
