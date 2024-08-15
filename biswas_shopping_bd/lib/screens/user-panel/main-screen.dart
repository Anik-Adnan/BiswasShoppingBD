
import 'package:biswas_shopping_bd/screens/auth-ui/welcome-screen.dart';
import 'package:biswas_shopping_bd/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
class MainScreen extends StatelessWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appName,style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async{
              GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.signOut();
              Get.offAll(()=> WelcomeScreen());
            },
            child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.logout)),
          ),
        ],
      ),

    );
  }

}