import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the box
  final _myBox = Hive.box('mybox');

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      // first time ever
      db.createInitialData();
    } else {
      // opened before
      db.loadData();
    }
  }

  // text editing controller
  final _controller = TextEditingController();

  // list of todo tasks
  ToDoDatabase db = ToDoDatabase();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  //save New Task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
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
    db.updateDatabase();
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
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
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
