
import 'package:biswas_shopping_bd/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget{
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to BiswasShoppingBD',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: AppConstant.appSecondaryColor,

      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: Get.height /2 ,
              width: Get.width * 0.85,
              child: Lottie.asset('assets/images/splash-screen.json'),
            ),
            SizedBox(
              height: Get.height / 12,
            ),
            Material(
              child: Container(
                width: Get.width * 0.65,
                height: Get.height /16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: AppConstant.appSecondaryColor,
                ),
                child: TextButton.icon(
                  icon: Image.asset('assets/images/google-icon-logo.png',
                    height: Get.height/12,
                    width: Get.width /12,),
                  label: const Text("Sign In with google",style: TextStyle(color: Colors.black),),
                  onPressed: (){},
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Material(
              child: Container(
                width: Get.width * 0.65,
                height: Get.height /16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: AppConstant.appSecondaryColor,
                ),
                child: TextButton.icon(
                  icon: Icon(Icons.email,
                  color: Colors.white,
                  size: Get.width/12,),
                  label: const Text("Sign In with Mail",style: TextStyle(color: Colors.black),),
                  onPressed: (){},
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

}