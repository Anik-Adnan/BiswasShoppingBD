
import 'package:biswas_shopping_bd/controllers/sign-in-controller.dart';
import 'package:biswas_shopping_bd/screens/auth-ui/sign-up-screen.dart';
import 'package:biswas_shopping_bd/screens/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget{
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();

}
class _SignInScreenState extends State<SignInScreen>{
  final SignInController signInController = Get.put(SignInController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context,isKeyboardVisible){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondaryColor,
            centerTitle: true,
            title: const Text('Sign In',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: Column(
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Obx(
                    ()=> TextFormField(
                      controller: userPassword,
                      cursorColor: AppConstant.appSecondaryColor,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: signInController.isPasswordVisible.value,
                      decoration: InputDecoration(
                          hintText: 'Password',

                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: GestureDetector(
                              child: signInController.isPasswordVisible.value ?  const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                          onTap: (){
                            signInController.isPasswordVisible.toggle();
                          },),

                          contentPadding: const EdgeInsets.only(top:2.0,left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.centerRight,
                child: const Text("Forget Password?",
                style: TextStyle(
                  color: Colors.red,fontWeight: FontWeight.bold,),
                ),
              ),
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
                    child: const Text("SIGN IN",style: TextStyle(color: Colors.black),),
                    onPressed: () async {
                      String email = userEmail.text.trim();
                      String password = userPassword.text.trim();
                      if(email.isEmpty || password.isEmpty){
                        Get.snackbar("SignIn Failed", "Enter correct email and password.");
                      }else{
                        UserCredential? userCredential = await signInController.signInMethod(email, password);
                        if(userCredential != null){
                          if(userCredential.user!.emailVerified){
                            Get.snackbar("Log In successfully ", "Welcome to BiswasShoppingBD." );
                            Get.offAll(()=> const MainScreen());

                          }else{
                            Get.snackbar("SignIn Failded", "Please verify your email");
                          }
                        }else{
                          Get.snackbar("Error", "Please try again.", );
                        }
                      }
                      

                    },
                  ),
                ),
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?" ,style: TextStyle(color: Colors.black,fontSize: 18.0),),
                      GestureDetector(
                        onTap: () => Get.offAll( ()=> const SignUpScreen()),
                          child: const Text(" SignUp",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18.0),),
                      ),
                    ],
                ),
              ),
            ],
          ),

        );
      },
    );
  }

}