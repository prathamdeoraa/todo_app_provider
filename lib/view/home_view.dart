import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/custom_widgets.dart';
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

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<TodoViewModel>(
                builder: (context, provider, child) {
                  return provider.todos.isEmpty
                      ? Text(
                          'Empty Todos List',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : Expanded(
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
                                    onPressed: () =>
                                        provider.deleteTodos(todo.id),
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Widgets.customDialog(context, _title, _desc);
        },
        child: Icon(Icons.add, color: Colors.purpleAccent.shade200),
      ),
    );
  }
}
