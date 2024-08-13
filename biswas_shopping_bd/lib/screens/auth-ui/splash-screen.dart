
import 'dart:async';

import 'package:biswas_shopping_bd/screens/user-panel/main-screen.dart';
import 'package:biswas_shopping_bd/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
      Timer(Duration( seconds: 3),(){
        Get.offAll(()=> MainScreen());
      });
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