
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/app-constant.dart';
import '../auth-ui/welcome-screen.dart';

class AdminMainScreen extends StatefulWidget{
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();


}
class _AdminMainScreenState extends State<AdminMainScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Admin Screen",style: const TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async{
              GoogleSignIn googleSignIn = GoogleSignIn();
              FirebaseAuth auth = FirebaseAuth.instance;
              await auth.signOut();
              await googleSignIn.signOut();
              Get.offAll(()=> WelcomeScreen());
            },
            child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.logout)),
          ),
        ],
      ),

    );
  }

}