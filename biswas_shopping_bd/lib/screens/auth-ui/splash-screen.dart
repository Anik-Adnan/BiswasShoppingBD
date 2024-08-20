
import 'dart:async';

import 'package:biswas_shopping_bd/controllers/get-user-data-controller.dart';
import 'package:biswas_shopping_bd/screens/admin-panel/admin-main-screen.dart';
import 'package:biswas_shopping_bd/screens/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/screens/auth-ui/welcome-screen.dart';
import '/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  User? user = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    super.initState();
      Timer(const Duration( seconds: 3),(){
        islogedIn(context);
      });
    }

    Future<void> islogedIn(BuildContext context) async {
      if(user != null){
        final GetUserDataController getUserDataController= Get.put(GetUserDataController());
        var userDate =await  getUserDataController.getUserData(user!.uid);
        if(userDate[0]['isAdmin'] == true){
          Get.offAll(()=> AdminMainScreen());
        }else{
          Get.offAll(()=>MainScreen());
        }
      }else{
        Get.to(()=> WelcomeScreen());
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appSecondaryColor,
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: Get.width*0.7,
              child: Lottie.asset('assets/images/splash-screen.json'),
            ),
          ),
          Container(
            width: Get.width,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Text(AppConstant.appPoweredBy,style: const TextStyle(fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }


}