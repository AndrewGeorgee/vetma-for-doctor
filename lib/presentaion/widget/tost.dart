import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      webShowClose: true,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green[300],
      textColor: Colors.white,
      fontSize: 16.0);
}

void toast2(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

class Time extends StatefulWidget {
  const Time({super.key});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  late final DateTime now;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    day = DateFormat('EEEE').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Text(day!);
  }
}

 String? day ;
