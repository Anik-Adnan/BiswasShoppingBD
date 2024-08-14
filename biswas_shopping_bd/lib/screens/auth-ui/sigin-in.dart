
import 'package:biswas_shopping_bd/utils/app-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget{
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();

}
class _SignInScreenState extends State<SignInScreen>{
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context,isKeyboardVisible){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondaryColor,
            centerTitle: true,
            title: Text('Sign In',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: Container(
            child: Column(
              children: [
                isKeyboardVisible ?  Text(''): Column(
                  children:[
                    Lottie.asset('assets/images/splash-screen.json')
                  ],
                ),
                SizedBox(height: Get.height/80),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      cursorColor: AppConstant.appSecondaryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.only(top:2.0,left: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height/80),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      cursorColor: AppConstant.appSecondaryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: Icon(Icons.visibility_off),
                          contentPadding: EdgeInsets.only(top:2.0,left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerRight,
                  child: Text("Forget Password?",
                  style: TextStyle(
                    color: Colors.red,fontWeight: FontWeight.bold,),
                  ),
                ),
                SizedBox(height: Get.height/20),
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
                      onPressed: (){},
                    ),
                  ),
                ),
                SizedBox(height: Get.height/40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?" ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    Text(" SignUp",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),)
                  ],
                )

              ],
            ),
          ),

        );
      },
    );
  }

}