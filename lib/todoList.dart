// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

// Class for every list item
class TodoItem {
  String task;
  bool isDone;

  TodoItem(this.task, [this.isDone = false]);
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // Stores todos
  List<TodoItem> _todoItems = [];

  // Adds todo to the list
  void _addTodoItem(TodoItem todoItem) {
    setState(() {
      _todoItems.add(todoItem);
    });
  }

  // Builds one todo as ListTile
  Widget _buildListItem(TodoItem todoItem) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 25),
      title: Text(
        todoItem.task,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      tileColor: Colors.blue[100],
    );
  }

  // Builds whole list of todos with dividers
  Widget _buildList() {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: _todoItems.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildListItem(_todoItems[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 10,
        thickness: 2,
      ),
    );
  }

  // Adding item screen using Navigator
  final _controller = TextEditingController();
  void _addTodoItemScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Add new item"),
            ),
            body: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    onSubmitted: (value) {
                      _addTodoItem(TodoItem(value));
                      Navigator.pop(context);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        labelText: "What should you do?",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _controller.clear,
                        )),
                  ),
                )
              ],
            ));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List (${_todoItems.length} items)"),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoItemScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
