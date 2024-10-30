
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget{
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();

}
class _NotificationScreenState extends State<NotificationScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
    );
  }

}