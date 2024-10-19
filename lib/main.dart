// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do apk',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const todo(),
    );
  }
}

class todo extends StatefulWidget {
  const todo({super.key});

  @override
  State<todo> createState() => _todoState();
}

class _todoState extends State<todo> {
  final TextEditingController _textController = TextEditingController();
  final List<Task> _tasks = [];

  void _addtile() {
    if (_textController.text.trim().isEmpty) return;
    setState(() {
      _tasks.add(Task(title: _textController.text));
      _textController.clear();
    });
  }

  void _checking(int index) {
    setState(() {
      _tasks[index].iscompleted = !_tasks[index].iscompleted;
    });
  }

  void _deletebtn(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  void dispose() {
    _textController.dispose(); // Dispose of the controller
    super.dispose();
  }

  void _dismisskeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To_Do apk"),
      ),
      body: GestureDetector(
        onTap: _dismisskeyboard,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        borderSide: BorderSide(color: Colors.red, width: 1.0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    hintText: 'add anything u wanna do',
                    suffixIcon: IconButton(
                      onPressed: _addtile,
                      icon: Icon(Icons.add),
                    )),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          _tasks[index].title,
                          style: TextStyle(
                            decoration: _tasks[index].iscompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        leading: Checkbox(
                          value: _tasks[index].iscompleted,
                          onChanged: (value) => {_checking(index)},
                        ),
                        trailing: IconButton(
                            onPressed: () => {_deletebtn(index)},
                            icon: Icon(Icons.delete)),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Task {
  String title;
  bool iscompleted;

  Task({required this.title, this.iscompleted = false});
}
