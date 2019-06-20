import 'package:flutter/material.dart';

class Attendance extends StatelessWidget {
  String batch_id;
  Attendance(String batch) {
    batch_id = batch;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(batch_id),),
      body: Center(
        child: Text("NO STUDENT FOUND"),
      ),
    );
  }
}