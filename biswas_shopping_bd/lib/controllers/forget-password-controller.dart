
import 'package:biswas_shopping_bd/screens/auth-ui/sigin-in-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> forgetPasswordMethod(
      String userEmail,
      )async{

    try{
      EasyLoading.show(status: "Please wait");
      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar("Request sent successfully", "Password reset link sent to $userEmail");
      Get.offAll(()=> SignInScreen());
      EasyLoading.dismiss();
    }on FirebaseException catch(e){
      EasyLoading.dismiss();
      print("$e");
      // Get.snackbar("Error", "$e");
    }
  }

}