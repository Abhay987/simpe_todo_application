import 'package:flutter/material.dart';
import 'package:simple_todo_application/add_edit_item.dart';

import 'list_names.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Application',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (context) => const TodoApp(),
        '/add_edit_item': (context) => const AddEditItemInfo(),
      },
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Map<String, dynamic> data = {
            "isEditOrNot": false,
          };
          Navigator.pushNamed(context, '/add_edit_item', arguments: data);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Todo App'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [..._getFriendList()],
      ),
    );
  }

  List<Widget> _getFriendList() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < todoList.length; i++) {
      friendsTextFields.add(
        Row(
          children: [
            Expanded(flex: 8, child: Text(todoList[i])),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Map<String, dynamic> data = {"isEditOrNot": true, "index": i};
                  Navigator.pushNamed(context, '/add_edit_item',
                      arguments: data);
                },
              ),
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    todoList.removeAt(i);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete),
                )),
          ],
        ),
      );
    }
    return friendsTextFields;
  }
}
