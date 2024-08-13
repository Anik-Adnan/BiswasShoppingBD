
import 'package:biswas_shopping_bd/utils/app-constant.dart';
import 'package:flutter/material.dart';
class MainScreen extends StatelessWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appName,style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),

    );
  }

}