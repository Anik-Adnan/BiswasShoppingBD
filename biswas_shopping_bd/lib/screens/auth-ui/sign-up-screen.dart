
import 'package:biswas_shopping_bd/controllers/sign-up-controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '/screens/auth-ui/sigin-in.dart';

import '/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/route_manager.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();

}
class _SignUpScreenState extends State<SignUpScreen>{

  final SignUpController signUpController = Get.put(SignUpController());
  TextEditingController userName = TextEditingController();
  TextEditingController userPhoneNumber = TextEditingController();
  TextEditingController userCity = TextEditingController();
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
            title: const Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          body: SingleChildScrollView(
            child: ConstrainedBox(  // Ensure it takes full height
            constraints: BoxConstraints(
            minHeight: Get.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height/22,
                  ),
                  const Text('Welcome to BiswasShoppingBD',style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),),
                  SizedBox(
                    height: Get.height/22,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: userName,
                        cursorColor: AppConstant.appSecondaryColor,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: 'UserName',
                            prefixIcon: const Icon(Icons.person),
                            contentPadding: const EdgeInsets.only(top:2.0,left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: userPhoneNumber,
                        cursorColor: AppConstant.appSecondaryColor,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: 'PhoneNumber',
                            prefixIcon: const Icon(Icons.phone),
                            contentPadding: const EdgeInsets.only(top:2.0,left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: userCity,
                        cursorColor: AppConstant.appSecondaryColor,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                            hintText: 'City',
                            prefixIcon: const Icon(Icons.location_city),
                            contentPadding: const EdgeInsets.only(top:2.0,left: 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                        ),
                      ),
                    ),
                  ),
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
                        () => TextFormField(
                          controller: userPassword,
                          cursorColor: AppConstant.appSecondaryColor,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: signUpController.isPasswordVisible.value,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: GestureDetector(

                                onTap: (){
                                    signUpController.isPasswordVisible.toggle();
                                },
                                child: signUpController.isPasswordVisible.value ?  const Icon(Icons.visibility_off) : const Icon(Icons.visibility),

                              ),
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
                        child: const Text("SIGN UP",style: TextStyle(color: Colors.black),),
                        onPressed: () async {
                          String name = userName.text.trim();
                          String phone = userPhoneNumber.text.trim();
                          String city = userCity.text.trim();
                          String mail = userEmail.text.trim();
                          String password = userPassword.text.trim();
                          String deviceToken = '';

                          if(name.isEmpty || mail.isEmpty || city.isEmpty || password.isEmpty || phone.isEmpty){
                            Get.snackbar("Error", "Please enter all details");
                          }
                          else{
                            UserCredential? userCredential = await signUpController.signUpMethod(name, mail, phone, city, password, deviceToken);

                            if(userCredential != null){
                              Get.snackbar("Verification email sent .", "Please check your email.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondaryColor,
                              colorText: AppConstant.apptextColor
                              );
                              FirebaseAuth.instance.signOut();
                              Get.offAll(()=> SignInScreen());
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
                        const Text("Already have an account?" ,style: TextStyle(color: Colors.black,fontSize: 18.0),),
                        GestureDetector(
                          onTap: () => Get.offAll( ()=> const SignInScreen()),
                            child: const Text(" SignIn",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18.0),),
                        ),
                      ],
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