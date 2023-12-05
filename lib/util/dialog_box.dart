// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final mycontroller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.mycontroller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.blue[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

        // content
        content: Container(
          height: 120,
          //
          child: Column(children: [
            // get user input
            TextField(
              controller: mycontroller,

              // decoration
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),

            SizedBox(
              height: 10,
            ),

            // buttons- save & cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButton(text: "Save", onPressed: onSave),

                // gap
                const SizedBox(
                  width: 7,
                ),

                // cancel button
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            )
          ]),
        ));
  }
}
