import 'package:flutter/material.dart';
import 'package:todo_app/util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text editing controller
  final _controller = TextEditingController();

  // list of todo tasks
  List toDoList = [
    ['Do Dishes', false],
    ['Make ToDo App', false],
  ];

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //save New Task
  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  // create new task
  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          mycontroller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: saveNewTask,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bgcolor
      backgroundColor: Colors.blue[200],

      //appBar
      appBar: AppBar(
        title: const Text(
          'TO-DO',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      // plus button
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        shape: CircleBorder(eccentricity: 0.0),
        child: Icon(Icons.add),
      ),

      // body
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}
