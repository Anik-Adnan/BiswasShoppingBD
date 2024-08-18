
import 'package:biswas_shopping_bd/controllers/forget-password-controller.dart';
import 'package:get/get.dart';

import '/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';

class ForgetPasswordScreen extends StatefulWidget{
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();

}
class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>{
  final ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());
  TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context,isKeyboardVisible){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondaryColor,
            centerTitle: true,
            title: const Text('Forget Password',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: SingleChildScrollView(
            child: ConstrainedBox(  // Ensure it takes full height
              constraints: BoxConstraints(
                minHeight: Get.height,
              ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  isKeyboardVisible ?  const Text(''):
                  SizedBox(
                    width: Get.width,
                    height: Get.height/4,
                    child:Lottie.asset('assets/images/splash-screen.json'),
                  ),
                  SizedBox(height: Get.height/85),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: userEmail,
                        cursorColor: AppConstant.appSecondaryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            contentPadding: const EdgeInsets.only(top:2.0,left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height/90),
                  SizedBox(height: Get.height/90),
                  Material(
                    child: Container(
                      width: Get.width * 0.35,
                      height: Get.height / 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: AppConstant.appSecondaryColor,
                      ),
                      child: TextButton(
                        child: const Text("Forgot",style: TextStyle(color: Colors.black),),
                        onPressed: () async {
                          String email = userEmail.text.trim();
                          if(email.isEmpty){
                            Get.snackbar("Error mail", "Enter your correct email.");
                          }else{
                            String email = userEmail.text.trim();
                            forgetPasswordController.forgetPasswordMethod(email);

                          }


                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        );
      },
    );
  }

}